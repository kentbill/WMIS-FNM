inherited CPBDirectForm: TCPBDirectForm
  Left = 71
  Top = 112
  Width = 1018
  Height = 627
  Caption = #37197#26041#24405#20837#30452#36890
  OldCreateOrder = True
  Position = poDefault
  ShowHint = True
  WindowState = wsMaximized
  OnKeyPress = nil
  PixelsPerInch = 96
  TextHeight = 12
  object TPanel
    Left = 0
    Top = 0
    Width = 1010
    Height = 3
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
  end
  object TPanel
    Left = 177
    Top = 3
    Width = 833
    Height = 567
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object pnlTop: TPanel
      Left = 0
      Top = 0
      Width = 833
      Height = 346
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object GroupBox4: TGroupBox
        Left = 0
        Top = 0
        Width = 375
        Height = 346
        Align = alClient
        Caption = #21487#36873#21270#24037#26009'(&C)'
        TabOrder = 0
        object TPanel
          Left = 2
          Top = 319
          Width = 371
          Height = 25
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 0
          object btnAdd: TSpeedButton
            Left = 36
            Top = 0
            Width = 23
            Height = 23
            Hint = #36873#20013
            Flat = True
            OnClick = btnAddClick
          end
          object btnDel: TSpeedButton
            Left = 84
            Top = 0
            Width = 23
            Height = 23
            Hint = #21024#38500
            Flat = True
            OnClick = btnDelClick
          end
          object Label4: TLabel
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
          Width = 371
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
              Width = 363
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
              363
              275)
            object cbbChemicalName: TComboBox
              Left = 4
              Top = 0
              Width = 357
              Height = 270
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
      object gbRight: TGroupBox
        Left = 383
        Top = 0
        Width = 450
        Height = 346
        Align = alRight
        Caption = #37197#26041#20027#35201#20449#24687
        TabOrder = 1
        object Panel1: TPanel
          Left = 2
          Top = 14
          Width = 195
          Height = 330
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
          object Label2: TLabel
            Left = 7
            Top = 8
            Width = 42
            Height = 12
            Caption = #37197#26041#21495':'
          end
          object Label5: TLabel
            Left = 8
            Top = 118
            Width = 30
            Height = 12
            Caption = #21697#21517':'
          end
          object Label6: TLabel
            Left = 8
            Top = 140
            Width = 54
            Height = 12
            Caption = #30721#38271'(cm):'
          end
          object Label8: TLabel
            Left = 9
            Top = 162
            Width = 42
            Height = 12
            Caption = 'FN'#33394#21495':'
          end
          object Label11: TLabel
            Left = 8
            Top = 30
            Width = 30
            Height = 12
            Caption = #23458#25143':'
          end
          object lblFNColorCode: TLabel
            Left = 8
            Top = 179
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
            Top = 52
            Width = 54
            Height = 12
            Caption = #26469#26679#21333#21495':'
          end
          object Label9: TLabel
            Left = 7
            Top = 74
            Width = 54
            Height = 12
            Caption = #26469#26679#33457#22411':'
          end
          object Label10: TLabel
            Left = 7
            Top = 96
            Width = 54
            Height = 12
            Caption = #26469#26679#27454#24335':'
          end
          object edtRecipeNO: TEdit
            Left = 63
            Top = 0
            Width = 121
            Height = 20
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
          object edtQuantity: TEdit
            Left = 63
            Top = 132
            Width = 121
            Height = 20
            TabOrder = 1
          end
          object edtFNColorCode: TEdit
            Left = 63
            Top = 154
            Width = 121
            Height = 20
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentColor = True
            ParentFont = False
            TabOrder = 2
          end
          object edtGFNO: TEdit
            Left = 63
            Top = 110
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
            TabOrder = 3
          end
          object edtCustomer: TEdit
            Left = 63
            Top = 22
            Width = 121
            Height = 20
            CharCase = ecUpperCase
            ParentColor = True
            ReadOnly = True
            TabOrder = 4
          end
          object plShowColor: TPanel
            Left = 6
            Top = 216
            Width = 180
            Height = 106
            Cursor = crArrow
            BevelInner = bvRaised
            BevelOuter = bvLowered
            BevelWidth = 2
            TabOrder = 5
            object edtFabColorName: TEdit
              Left = 23
              Top = 22
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
              Visible = False
            end
            object edtPatternID: TEdit
              Left = 27
              Top = 54
              Width = 121
              Height = 20
              Ctl3D = True
              ParentColor = True
              ParentCtl3D = False
              TabOrder = 1
              Visible = False
            end
          end
          object edtLBNO: TEdit
            Left = 63
            Top = 44
            Width = 121
            Height = 20
            CharCase = ecUpperCase
            ParentColor = True
            ReadOnly = True
            TabOrder = 6
          end
          object edtPatternName: TEdit
            Left = 63
            Top = 66
            Width = 121
            Height = 20
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentColor = True
            ParentFont = False
            TabOrder = 7
          end
          object edtStyleName: TEdit
            Left = 63
            Top = 88
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
            TabOrder = 8
          end
        end
        object vlePDParam: TValueListEditor
          Left = 197
          Top = 14
          Width = 251
          Height = 330
          Align = alClient
          Ctl3D = False
          DefaultRowHeight = 17
          ParentCtl3D = False
          TabOrder = 1
          TitleCaptions.Strings = (
            #21442#25968#21517
            #21442#25968#20540)
          OnGetPickList = vlePDParamGetPickList
          ColWidths = (
            167
            80)
        end
      end
      object cxSplitter4: TcxSplitter
        Left = 375
        Top = 0
        Width = 8
        Height = 346
        HotZoneClassName = 'TcxXPTaskBarStyle'
        AlignSplitter = salRight
        DragThreshold = 2
        Control = gbRight
      end
    end
    object cxSplitter3: TcxSplitter
      Left = 0
      Top = 346
      Width = 833
      Height = 8
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salTop
      DragThreshold = 2
      Control = pnlTop
    end
    object gbLeft: TGroupBox
      Left = 0
      Top = 354
      Width = 375
      Height = 213
      Align = alClient
      Caption = #26579#26009#32452#21512
      TabOrder = 2
      object vleChemicallist: TValueListEditor
        Left = 33
        Top = 14
        Width = 340
        Height = 197
        Align = alClient
        Ctl3D = False
        DefaultRowHeight = 17
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing, goThumbTracking]
        ParentCtl3D = False
        TabOrder = 1
        TitleCaptions.Strings = (
          #21270#24037#26009#21517
          #29992#37327'(g/l)')
        OnValidate = vleChemicallistValidate
        ColWidths = (
          249
          87)
      end
      object TPanel
        Left = 2
        Top = 14
        Width = 31
        Height = 197
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object btnDown: TSpeedButton
          Left = 4
          Top = 104
          Width = 23
          Height = 23
          Hint = #21521#19979
          Flat = True
          OnClick = btnDownClick
        end
        object btnUp: TSpeedButton
          Left = 4
          Top = 54
          Width = 23
          Height = 23
          Hint = #21521#19978
          Flat = True
          OnClick = btnUpClick
        end
        object btnCalc: TSpeedButton
          Left = 4
          Top = 3
          Width = 23
          Height = 23
          Hint = #35745#31639
          Flat = True
          OnClick = btnCalcClick
        end
      end
    end
    object cxSplitter2: TcxSplitter
      Left = 375
      Top = 354
      Width = 8
      Height = 213
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salRight
      DragThreshold = 2
      Control = gbClient
    end
    object gbClient: TGroupBox
      Left = 383
      Top = 354
      Width = 450
      Height = 213
      Align = alRight
      Caption = #21382#21490#37197#26041
      TabOrder = 4
      object cxGrid1: TcxGrid
        Left = 48
        Top = 14
        Width = 400
        Height = 197
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
        Width = 46
        Height = 197
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
  end
  object pn1: TPanel
    Left = 0
    Top = 3
    Width = 169
    Height = 567
    Align = alLeft
    BevelInner = bvLowered
    TabOrder = 1
    object TPanel
      Left = 2
      Top = 2
      Width = 165
      Height = 63
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 6
        Top = 12
        Width = 30
        Height = 12
        Caption = #21697#21517':'
      end
      object btnQuery: TSpeedButton
        Left = 84
        Top = 28
        Width = 73
        Height = 22
        Caption = #26597#35810'(&Q)'
        Flat = True
        OnClick = btnQueryClick
      end
      object btnRefresh: TSpeedButton
        Left = 7
        Top = 27
        Width = 73
        Height = 22
        Caption = #21047#26032'(&R)'
        Flat = True
        OnClick = btnRefreshClick
      end
      object edtSampleGFNO: TEdit
        Left = 40
        Top = 4
        Width = 120
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 0
        OnChange = edtSampleGFNOChange
        OnKeyDown = edtSampleGFNOKeyDown
      end
    end
    object grp2: TGroupBox
      Left = 2
      Top = 65
      Width = 165
      Height = 500
      Align = alClient
      Caption = #20219#21153#21015#34920
      TabOrder = 1
      object cxGrid2: TcxGrid
        Left = 2
        Top = 14
        Width = 161
        Height = 484
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
    Top = 570
    Width = 1010
    Height = 30
    Align = alBottom
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 3
    object TPanel
      Left = 0
      Top = 0
      Width = 1010
      Height = 30
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        1010
        30)
      object btnSave: TSpeedButton
        Left = 849
        Top = 3
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        Flat = True
        OnClick = btnSaveClick
      end
      object btnExit: TSpeedButton
        Left = 930
        Top = 3
        Width = 75
        Height = 25
        Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
        Anchors = [akRight, akBottom]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btnExitClick
      end
      object cbExport: TCheckBox
        Left = 712
        Top = 8
        Width = 129
        Height = 17
        Anchors = [akRight, akBottom]
        Caption = #20445#23384#26102#23548#21040#21560#26009#26426
        TabOrder = 0
      end
    end
  end
  object cxSplitter1: TcxSplitter
    Left = 169
    Top = 3
    Width = 8
    Height = 567
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
    Left = 496
    Top = 112
  end
  object dsCPBRecipeDtl: TDataSource
    DataSet = cdsCPBRecipeDtl
    Left = 496
    Top = 144
  end
end

inherited CPBCheckForm: TCPBCheckForm
  Left = 203
  Top = 41
  Width = 1024
  Height = 532
  Caption = #37197#26041'CHECK'
  KeyPreview = False
  OldCreateOrder = True
  Position = poDefault
  ShowHint = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object TPanel
    Left = 0
    Top = 0
    Width = 1016
    Height = 3
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object cxSplitter1: TcxSplitter
      Left = 0
      Top = 0
      Width = 8
      Height = 3
      HotZoneClassName = 'TcxXPTaskBarStyle'
      DragThreshold = 2
    end
  end
  object TPanel
    Left = 214
    Top = 44
    Width = 802
    Height = 420
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object pnl_Only1: TPanel
      Left = 0
      Top = 0
      Width = 802
      Height = 420
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object TPanel
        Left = 0
        Top = 0
        Width = 802
        Height = 3
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 181
        Width = 802
        Height = 239
        Align = alBottom
        Caption = #37197#26041#21442#25968
        TabOrder = 2
        object Panel1: TPanel
          Left = 2
          Top = 14
          Width = 798
          Height = 223
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object Panel2: TPanel
            Left = 0
            Top = 0
            Width = 233
            Height = 223
            Align = alLeft
            BevelOuter = bvNone
            Caption = 'Panel2'
            TabOrder = 0
            Visible = False
            object vlePDParam: TValueListEditor
              Left = 0
              Top = 0
              Width = 224
              Height = 223
              TabStop = False
              Align = alLeft
              Ctl3D = False
              DefaultRowHeight = 17
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goAlwaysShowEditor, goThumbTracking]
              ParentCtl3D = False
              TabOrder = 0
              TitleCaptions.Strings = (
                #21442#25968#21517
                #21442#25968#20540)
              ColWidths = (
                144
                76)
            end
          end
          object Panel3: TPanel
            Left = 233
            Top = 0
            Width = 565
            Height = 223
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            object lbOKType: TLabel
              Left = 256
              Top = 113
              Width = 42
              Height = 12
              Caption = 'OK'#31867#22411':'
            end
            object lblFNColorCode: TLabel
              Left = 251
              Top = 6
              Width = 177
              Height = 35
              Alignment = taCenter
              AutoSize = False
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlue
              Font.Height = -32
              Font.Name = #23435#20307
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbFaultReason: TLabel
              Left = 276
              Top = 147
              Width = 30
              Height = 12
              Caption = #22791#27880':'
              Visible = False
            end
            object Label9: TLabel
              Left = 7
              Top = 115
              Width = 30
              Height = 12
              Caption = #33394#21517':'
              Visible = False
            end
            object Label8: TLabel
              Left = 7
              Top = 181
              Width = 42
              Height = 12
              Caption = 'FN'#33394#21495':'
              Visible = False
            end
            object Label7: TLabel
              Left = 7
              Top = 159
              Width = 54
              Height = 12
              Caption = #30721#38271'(cm):'
              Visible = False
            end
            object Label6: TLabel
              Left = 7
              Top = 137
              Width = 30
              Height = 12
              Caption = #21697#21517':'
              Visible = False
            end
            object Label5: TLabel
              Left = 7
              Top = 94
              Width = 54
              Height = 12
              Caption = #26469#26679#27454#24335':'
              Visible = False
            end
            object Label4: TLabel
              Left = 17
              Top = 28
              Width = 30
              Height = 12
              Caption = #33394#32423':'
            end
            object Label3: TLabel
              Left = 7
              Top = 72
              Width = 54
              Height = 12
              Caption = #26469#26679#33457#22411':'
              Visible = False
            end
            object Label2: TLabel
              Left = 7
              Top = 8
              Width = 42
              Height = 12
              Caption = #37197#26041#21495':'
            end
            object Label14: TLabel
              Left = 466
              Top = 84
              Width = 54
              Height = 12
              Caption = #36755#20154#26102#38388':'
              Visible = False
            end
            object Label13: TLabel
              Left = 466
              Top = 68
              Width = 54
              Height = 12
              Caption = #36755#35780#35821#20154':'
              Visible = False
            end
            object Label12: TLabel
              Left = 450
              Top = 20
              Width = 54
              Height = 12
              Caption = #37325#25171#35780#35821':'
              Visible = False
            end
            object Label11: TLabel
              Left = 8
              Top = 203
              Width = 30
              Height = 12
              Caption = #23458#25143':'
              Visible = False
            end
            object Label1: TLabel
              Left = 7
              Top = 50
              Width = 54
              Height = 12
              Caption = #26469#26679#21333#21495':'
              Visible = False
            end
            object Label15: TLabel
              Left = 450
              Top = 44
              Width = 54
              Height = 12
              Caption = #37325#25171#27425#25968':'
              Visible = False
            end
            object mmoFaultReason: TMemo
              Left = 256
              Top = 164
              Width = 172
              Height = 53
              ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
              TabOrder = 0
            end
            object edtStyleName: TEdit
              Left = 62
              Top = 88
              Width = 179
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
              TabOrder = 1
              Visible = False
            end
            object edtRecipeNO: TEdit
              Left = 62
              Top = 0
              Width = 179
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
              TabOrder = 2
            end
            object edtQuantity: TEdit
              Left = 61
              Top = 154
              Width = 179
              Height = 20
              TabStop = False
              ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
              ParentColor = True
              ReadOnly = True
              TabOrder = 3
              Visible = False
            end
            object edtPatternName: TEdit
              Left = 62
              Top = 66
              Width = 179
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
            object edtLBNO: TEdit
              Left = 62
              Top = 44
              Width = 179
              Height = 20
              TabStop = False
              CharCase = ecUpperCase
              ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
              ParentColor = True
              ReadOnly = True
              TabOrder = 5
              Visible = False
            end
            object edtFNColorCode: TEdit
              Left = 62
              Top = 176
              Width = 179
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
              ReadOnly = True
              TabOrder = 6
              Visible = False
            end
            object edtFabColorName: TEdit
              Left = 62
              Top = 110
              Width = 179
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
              Visible = False
            end
            object edtCustomer: TEdit
              Left = 62
              Top = 198
              Width = 179
              Height = 20
              TabStop = False
              CharCase = ecUpperCase
              ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
              ParentColor = True
              ReadOnly = True
              TabOrder = 8
              Visible = False
            end
            object edtCPBGFNO: TEdit
              Left = 62
              Top = 132
              Width = 179
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
            object edtCommentTime: TEdit
              Left = 447
              Top = 72
              Width = 179
              Height = 20
              ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
              ReadOnly = True
              TabOrder = 10
              Visible = False
            end
            object cbShade: TComboBox
              Left = 63
              Top = 22
              Width = 179
              Height = 20
              ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
              ItemHeight = 12
              TabOrder = 11
            end
            object cbOKType: TComboBox
              Left = 299
              Top = 110
              Width = 126
              Height = 20
              Style = csDropDownList
              ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
              ItemHeight = 12
              TabOrder = 12
              Items.Strings = (
                #23458#25143'OK'
                #20869#37096'OK')
            end
            object cbCommentPeople: TComboBox
              Left = 447
              Top = 49
              Width = 179
              Height = 20
              ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
              ItemHeight = 12
              TabOrder = 13
              Visible = False
              OnChange = cbCommentPeopleChange
            end
            object plShowColor: TPanel
              Left = 251
              Top = 45
              Width = 177
              Height = 61
              Cursor = crArrow
              BevelInner = bvRaised
              BevelOuter = bvLowered
              BevelWidth = 2
              TabOrder = 14
              object edtPatternID: TEdit
                Left = 16
                Top = 20
                Width = 121
                Height = 20
                TabStop = False
                ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
                ParentColor = True
                TabOrder = 0
                Visible = False
              end
            end
            object rgType: TRadioGroup
              Left = 255
              Top = 131
              Width = 172
              Height = 29
              Columns = 2
              Ctl3D = False
              ItemIndex = 0
              Items.Strings = (
                'OK'
                #19981'OK')
              ParentCtl3D = False
              TabOrder = 15
              OnClick = rgTypeClick
            end
            object cbComment: TMemo
              Left = 445
              Top = 0
              Width = 179
              Height = 49
              ScrollBars = ssVertical
              TabOrder = 16
              Visible = False
            end
            object edtPrintCount: TComboBox
              Left = 448
              Top = 99
              Width = 179
              Height = 20
              ItemHeight = 12
              TabOrder = 17
              Visible = False
              OnChange = edtPrintCountChange
            end
          end
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 3
        Width = 802
        Height = 178
        Align = alClient
        Caption = #37197#26041#26126#32454
        TabOrder = 1
        object cxGrid1: TcxGrid
          Left = 50
          Top = 14
          Width = 750
          Height = 162
          Align = alClient
          TabOrder = 1
          object cxGridTVCPBDtl: TcxGridDBTableView
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
            OptionsView.GroupByBox = False
            OptionsView.IndicatorWidth = 21
            OnCustomDrawIndicatorCell = cxGridTVCPBDtlCustomDrawIndicatorCell
          end
          object cxGridLevel1: TcxGridLevel
            GridView = cxGridTVCPBDtl
          end
        end
        object lvChemicalGroup: TListView
          Left = 2
          Top = 14
          Width = 48
          Height = 162
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
          TabOrder = 0
          ViewStyle = vsReport
          Visible = False
          OnDblClick = lvChemicalGroupDblClick
        end
      end
    end
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 44
    Width = 206
    Height = 420
    Align = alLeft
    BevelInner = bvLowered
    Caption = 'pnlLeft'
    TabOrder = 2
    Visible = False
    object grp2: TGroupBox
      Left = 2
      Top = 54
      Width = 202
      Height = 364
      Align = alClient
      Caption = #20219#21153#21015#34920
      TabOrder = 1
      Visible = False
      object cxGrid2: TcxGrid
        Left = 2
        Top = 14
        Width = 198
        Height = 348
        Align = alClient
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = False
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
    object TPanel
      Left = 2
      Top = 2
      Width = 202
      Height = 52
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object btnRefresh: TSpeedButton
        Left = 22
        Top = 28
        Width = 73
        Height = 22
        Caption = #21047#26032'(&R)'
        Flat = True
        Visible = False
        OnClick = btnRefreshClick
      end
    end
  end
  object TPanel
    Left = 0
    Top = 464
    Width = 1016
    Height = 34
    Align = alBottom
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 5
    object TPanel
      Left = 0
      Top = 0
      Width = 1016
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        1016
        34)
      object Label10: TLabel
        Left = 568
        Top = 13
        Width = 42
        Height = 12
        Anchors = [akLeft, akRight, akBottom]
        Caption = #30830#35748#20154':'
      end
      object lbParam: TLabel
        Left = 305
        Top = 13
        Width = 30
        Height = 12
        Caption = #33394#21495':'
      end
      object btnQuery: TSpeedButton
        Left = 477
        Top = 9
        Width = 73
        Height = 22
        Caption = #26597#35810'(&Q)'
        Flat = True
        OnClick = btnQueryClick
      end
      object btnSave: TBitBtn
        Left = 744
        Top = 6
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = btnSaveClick
      end
      object btnExit: TBitBtn
        Left = 826
        Top = 7
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = #36864#20986'(&X)'
        TabOrder = 2
        OnClick = btnExitClick
      end
      object cbbOperator: TComboBox
        Left = 620
        Top = 10
        Width = 121
        Height = 20
        Style = csDropDownList
        Anchors = [akLeft, akBottom]
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
        TabOrder = 3
      end
      object gbDeleteShade: TGroupBox
        Left = 0
        Top = 0
        Width = 287
        Height = 34
        Align = alLeft
        Caption = #21024#38500#33394#32423
        Color = clBtnFace
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        Visible = False
        object btnDelete: TSpeedButton
          Left = 202
          Top = 6
          Width = 75
          Height = 25
          Caption = #21024#38500'(&D)'
          Flat = True
          OnClick = btnDeleteClick
        end
        object lblDeleteNO: TLabel
          Left = 12
          Top = 13
          Width = 42
          Height = 12
          Caption = #37197#26041#21495':'
        end
        object edtDeleteNO: TEdit
          Left = 64
          Top = 9
          Width = 131
          Height = 20
          CharCase = ecUpperCase
          ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
          TabOrder = 0
        end
      end
      object edtParam: TEdit
        Left = 344
        Top = 9
        Width = 129
        Height = 20
        CharCase = ecUpperCase
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        TabOrder = 4
        OnKeyDown = edtParamKeyDown
      end
    end
  end
  object cxSplitter2: TcxSplitter
    Left = 206
    Top = 44
    Width = 8
    Height = 420
    HotZoneClassName = 'TcxXPTaskBarStyle'
    DragThreshold = 2
    Control = pnlLeft
    Visible = False
  end
  object pnlCaption: TPanel
    Left = 0
    Top = 3
    Width = 1016
    Height = 41
    Align = alTop
    BevelOuter = bvLowered
    Caption = '  Panel2'
    Color = clMedGray
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlue
    Font.Height = -29
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object cdsTask: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 72
    Top = 224
  end
  object dsTask: TDataSource
    DataSet = cdsTask
    Left = 64
    Top = 256
  end
  object dsCPBRecipeDtl: TDataSource
    DataSet = cdsCPBRecipeDtl
    Left = 360
    Top = 128
  end
  object cdsCPBRecipeDtl: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 368
    Top = 96
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 258
    Top = 88
    object cxStyle1: TcxStyle
      AssignedValues = [svTextColor]
      TextColor = clRed
    end
  end
  object cdsHistory: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 744
    Top = 232
  end
end

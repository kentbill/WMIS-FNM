inherited ManageSampleForm: TManageSampleForm
  Left = 74
  Top = 152
  Width = 800
  Height = 534
  Caption = #21462#26679#25490#21345
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 792
    Height = 507
    ActivePage = TabSheet1
    Align = alClient
    TabIndex = 1
    TabOrder = 0
    object TabSheet2: TTabSheet
      Caption = #29289#27979#25490#21345
      ImageIndex = 1
      object grp4: TGroupBox
        Left = 0
        Top = 0
        Width = 784
        Height = 305
        Align = alTop
        Caption = #24453#25490#21345#21015#34920
        TabOrder = 0
        object lvSrc: TListView
          Left = 2
          Top = 14
          Width = 486
          Height = 260
          Align = alClient
          Columns = <
            item
              Caption = #24067#21495
              Width = 80
            end
            item
              Caption = #24037#24207
            end
            item
              Caption = #23458#25143
              Width = 90
            end
            item
              Caption = #21697#21517
              Width = 120
            end
            item
              Caption = #27979#35797#20195#30721
              Width = 60
            end
            item
              Caption = #27979#35797#39033#30446
              Width = 150
            end
            item
              Caption = #27979#35797#26631#20934
              Width = 0
            end
            item
              Caption = #26465#20214'ID'
              Width = 0
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnClick = lvSrcClick
          OnCustomDrawItem = lvSrcCustomDrawItem
        end
        object pnl2: TPanel
          Left = 2
          Top = 274
          Width = 780
          Height = 29
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          DesignSize = (
            780
            29)
          object btnSelect: TSpeedButton
            Left = 344
            Top = 3
            Width = 75
            Height = 25
            Caption = #36873#20013
            Enabled = False
            Flat = True
            OnClick = btnSelectClick
          end
          object btnDelete: TSpeedButton
            Left = 20
            Top = 3
            Width = 75
            Height = 25
            Caption = #21024#38500
            Enabled = False
            Flat = True
            OnClick = btnDeleteClick
          end
          object btn_Save: TSpeedButton
            Left = 602
            Top = 3
            Width = 75
            Height = 25
            Anchors = [akRight, akBottom]
            Caption = #20445#23384'(&S)'
            Enabled = False
            Flat = True
            OnClick = btn_SaveClick
          end
          object btn_Exit: TSpeedButton
            Left = 684
            Top = 3
            Width = 75
            Height = 25
            Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
            Anchors = [akRight, akBottom]
            Caption = #36864#20986'(&X)'
            Flat = True
            OnClick = btn_ExitClick
          end
          object btnRefresh: TSpeedButton
            Left = 519
            Top = 3
            Width = 75
            Height = 25
            Anchors = [akRight, akBottom]
            Caption = #21047#26032'(&R)'
            Flat = True
            OnClick = btnRefreshClick
          end
          object Label1: TLabel
            Left = 136
            Top = 8
            Width = 30
            Height = 12
            Caption = #22791#27880':'
          end
          object cbRemark: TComboBox
            Left = 176
            Top = 5
            Width = 102
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ItemHeight = 13
            ParentFont = False
            TabOrder = 0
            Items.Strings = (
              #36864#27974
              #23450#22411
              #39044#32553
              #19997#20809
              #32451#28418
              #36711#20809
              #27700#27927
              #30952#27611#21069
              #36215#27611#21518
              #36820#24037)
          end
        end
        object clbItemList: TCheckListBox
          Left = 496
          Top = 14
          Width = 286
          Height = 260
          Align = alRight
          Columns = 1
          ItemHeight = 12
          TabOrder = 2
        end
        object cxSplitter1: TcxSplitter
          Left = 488
          Top = 14
          Width = 8
          Height = 260
          HotZoneClassName = 'TcxXPTaskBarStyle'
          AlignSplitter = salRight
          DragThreshold = 2
          Control = clbItemList
        end
      end
      object grp3: TGroupBox
        Left = 0
        Top = 305
        Width = 488
        Height = 175
        Align = alClient
        Caption = #24453#20445#23384#21345#21015#34920
        TabOrder = 1
        object lvDes: TListView
          Left = 2
          Top = 14
          Width = 484
          Height = 159
          Align = alClient
          Columns = <
            item
              Caption = #24067#21495
              Width = 130
            end
            item
              Caption = #24037#24207
            end
            item
              Caption = #23458#25143
              Width = 90
            end
            item
              Caption = #21697#21517
              Width = 120
            end
            item
              Caption = #27979#35797#39033#30446
              Width = 210
            end
            item
              Caption = #22791#27880
            end
            item
              Caption = #27979#35797#26631#20934
              Width = 0
            end
            item
              Caption = #26465#20214'ID'
              Width = 0
            end>
          GridLines = True
          MultiSelect = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
        end
      end
      object gbRight: TGroupBox
        Left = 496
        Top = 305
        Width = 288
        Height = 175
        Align = alRight
        Caption = #24067#21495#21644#27979#35797#21495#23545#24212#20851#31995
        TabOrder = 2
        object lvResult: TListView
          Left = 2
          Top = 14
          Width = 284
          Height = 159
          Align = alClient
          Columns = <
            item
              Caption = #24067#21495
              Width = 130
            end
            item
              Caption = #27979#35797#21495
              Width = 150
            end>
          GridLines = True
          MultiSelect = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
        end
      end
      object cxSpResult: TcxSplitter
        Left = 488
        Top = 305
        Width = 8
        Height = 175
        HotZoneClassName = 'TcxXPTaskBarStyle'
        AlignSplitter = salRight
        DragThreshold = 2
        Control = gbRight
      end
    end
    object TabSheet1: TTabSheet
      Caption = #25163#24037#21462#26679
      ImageIndex = 1
      object pnl1: TPanel
        Left = 0
        Top = 0
        Width = 784
        Height = 132
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object btnQuery: TSpeedButton
          Left = 273
          Top = 11
          Width = 75
          Height = 25
          Caption = #26597#35810'(&Q)'
          Flat = True
          OnClick = btnQueryClick
        end
        object btnSave: TSpeedButton
          Left = 474
          Top = 64
          Width = 75
          Height = 25
          Caption = #20445#23384'(&S)'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          OnClick = btnSaveClick
        end
        object btnClose: TSpeedButton
          Left = 474
          Top = 98
          Width = 75
          Height = 25
          Caption = #36864#20986'(&X)'
          Flat = True
          OnClick = btnCloseClick
        end
        object lblFabricNO: TLabel
          Left = 56
          Top = 50
          Width = 30
          Height = 12
          Caption = #24067#21495':'
        end
        object btnAdd: TSpeedButton
          Left = 474
          Top = 32
          Width = 75
          Height = 25
          Caption = #26032#22686'(&A)'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          OnClick = btnAddClick
        end
        object lblOperationCode: TLabel
          Left = 56
          Top = 77
          Width = 42
          Height = 12
          Caption = #24037#24207#21517':'
        end
        object lblActSampleQty: TLabel
          Left = 256
          Top = 104
          Width = 54
          Height = 12
          Caption = #21462#26679#30721#38271':'
        end
        object lblSampleCode: TLabel
          Left = 56
          Top = 104
          Width = 54
          Height = 12
          Caption = #21462#26679#20195#30721':'
        end
        object lblFNCard: TLabel
          Left = 56
          Top = 24
          Width = 30
          Height = 12
          Caption = #21345#21495':'
        end
        object cbbFabricNOList: TComboBox
          Left = 120
          Top = 42
          Width = 145
          Height = 20
          ItemHeight = 12
          TabOrder = 1
        end
        object cbbOperationCodeList: TComboBox
          Left = 120
          Top = 69
          Width = 321
          Height = 20
          ItemHeight = 12
          TabOrder = 2
        end
        object edtActSampleQty: TEdit
          Left = 321
          Top = 96
          Width = 121
          Height = 20
          TabOrder = 3
          Text = '0'
        end
        object edtFNCard: TEdit
          Left = 120
          Top = 16
          Width = 142
          Height = 20
          TabOrder = 0
        end
        object cxbeSampleCode: TcxButtonEdit
          Left = 120
          Top = 96
          Width = 121
          Height = 20
          Properties.Buttons = <
            item
              Default = True
              Kind = bkGlyph
            end>
          Properties.CharCase = ecUpperCase
          Properties.OnButtonClick = cxbeSampleCodePropertiesButtonClick
          Style.LookAndFeel.Kind = lfStandard
          TabOrder = 4
          OnKeyDown = cxbeSampleCodeKeyDown
        end
      end
      object lvSampleInfo: TListView
        Left = 0
        Top = 132
        Width = 784
        Height = 348
        Align = alClient
        Columns = <
          item
            Caption = #21345#21495
            Width = 70
          end
          item
            Alignment = taCenter
            Caption = #24067#21495
            Width = 150
          end
          item
            Alignment = taCenter
            Caption = #21152#24037#27493#39588
            Width = 60
          end
          item
            Alignment = taCenter
            Caption = #24037#24207
            Width = 100
          end
          item
            Caption = #26426#21488
          end
          item
            Alignment = taCenter
            Caption = #21462#26679#20195#21495
            Width = 70
          end
          item
            Alignment = taCenter
            Caption = #21462#26679#38271#24230
            Width = 70
          end
          item
            Caption = #21697#21517'ID'
            Width = 0
          end
          item
            Caption = #25490#21333#21495
          end>
        FlatScrollBars = True
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
      end
    end
  end
end

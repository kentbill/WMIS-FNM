inherited ManageSCForm: TManageSCForm
  Left = 87
  Top = 21
  Width = 1075
  Height = 499
  Caption = #25509#25910#22806#21457
  OldCreateOrder = True
  Position = poDefault
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object TPanel
    Left = 0
    Top = 462
    Width = 1067
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
  end
  object pgcMain: TPageControl
    Left = 0
    Top = 0
    Width = 1067
    Height = 462
    ActivePage = tsRjtApr
    Align = alClient
    TabIndex = 2
    TabOrder = 1
    object tsReceive: TTabSheet
      Caption = #27491#24120#25910#24067
      object pnlLeft: TPanel
        Left = 0
        Top = 0
        Width = 396
        Height = 401
        Align = alLeft
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object cxSplitter1: TcxSplitter
          Left = 2
          Top = 260
          Width = 392
          Height = 8
          HotZoneClassName = 'TcxXPTaskBarStyle'
          AlignSplitter = salTop
          Control = cxdbgUnSelect
        end
        object cxdbgUnSelect: TcxGrid
          Left = 2
          Top = 2
          Width = 392
          Height = 258
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object cxdbgtvUnSelect: TcxGridDBTableView
            OnKeyDown = cxdbgtvUnSelectKeyDown
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NavigatorButtons.ConfirmDelete = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.MultiSelect = True
            OptionsView.GroupByBox = False
          end
          object cxGridlUnSelect: TcxGridLevel
            GridView = cxdbgtvUnSelect
          end
        end
        object lstFNCard: TListBox
          Left = 7
          Top = 132
          Width = 106
          Height = 122
          ItemHeight = 12
          TabOrder = 2
          Visible = False
        end
        object pnlCard: TPanel
          Left = 2
          Top = 268
          Width = 392
          Height = 131
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 3
          object pnl2: TPanel
            Left = 0
            Top = 0
            Width = 392
            Height = 35
            Align = alTop
            BevelOuter = bvNone
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            object btnAdd: TSpeedButton
              Left = 25
              Top = 5
              Width = 75
              Height = 25
              Caption = #28155#21152'(&A)'
              Flat = True
              OnClick = btnAddClick
            end
            object btnUp: TSpeedButton
              Left = 287
              Top = 5
              Width = 75
              Height = 25
              Caption = #20840#37096'(&U)'
              Flat = True
              OnClick = btnUpClick
            end
            object btnCancel: TSpeedButton
              Left = 199
              Top = 5
              Width = 75
              Height = 25
              Caption = #25764#28040'(&C)'
              Flat = True
              OnClick = btnCancelClick
            end
            object btnDown: TSpeedButton
              Left = 112
              Top = 6
              Width = 75
              Height = 25
              Caption = #20840#37096'(&D)'
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              OnClick = btnDownClick
            end
          end
          object cxdbgSelect: TcxGrid
            Left = 0
            Top = 35
            Width = 392
            Height = 96
            Align = alClient
            TabOrder = 1
            object cxdbgtvSelect: TcxGridDBTableView
              OnKeyDown = cxdbgtvSelectKeyDown
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              NavigatorButtons.ConfirmDelete = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.MultiSelect = True
              OptionsView.GroupByBox = False
            end
            object cxGridlSelect: TcxGridLevel
              GridView = cxdbgtvSelect
            end
          end
        end
      end
      object cxspl1: TcxSplitter
        Left = 396
        Top = 0
        Width = 8
        Height = 401
        HotZoneClassName = 'TcxXPTaskBarStyle'
        Control = pnlLeft
      end
      object cxgridSendInfo: TcxGrid
        Left = 404
        Top = 0
        Width = 655
        Height = 401
        Align = alClient
        TabOrder = 2
        object cxgridtvSendInfo: TcxGridDBTableView
          DataController.DataSource = dsSendInfo
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
        end
        object cxGridlcxgrid2Level1: TcxGridLevel
          GridView = cxgridtvSendInfo
        end
      end
      object pnlTop: TPanel
        Left = 0
        Top = 401
        Width = 1059
        Height = 34
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 3
        DesignSize = (
          1059
          34)
        object lblContractNO: TLabel
          Left = 13
          Top = 14
          Width = 42
          Height = 12
          Caption = #21512#21516#21495':'
        end
        object btnRefresh: TSpeedButton
          Left = 785
          Top = 5
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = #21047#26032'(&R)'
          Flat = True
          OnClick = btnRefreshClick
        end
        object btnSave: TSpeedButton
          Left = 881
          Top = 5
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = #20445#23384'(&S)'
          Flat = True
          OnClick = btnSaveClick
        end
        object btnClose: TSpeedButton
          Left = 974
          Top = 5
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = #36864#20986'(&X)'
          Flat = True
          OnClick = btnCloseClick
        end
        object cbbContractNO: TComboBox
          Left = 59
          Top = 10
          Width = 158
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 0
          OnSelect = cbbContractNOSelect
        end
      end
    end
    object tsReject: TTabSheet
      Caption = #36864#24067#32500#25252
      ImageIndex = 1
      object pnlRejectBottom: TPanel
        Left = 0
        Top = 402
        Width = 1059
        Height = 33
        Align = alBottom
        TabOrder = 0
        object pnl1: TPanel
          Left = 352
          Top = 1
          Width = 706
          Height = 31
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 0
          object btnRejectExit: TSpeedButton
            Left = 609
            Top = 3
            Width = 73
            Height = 25
            Caption = #36864#20986
            Flat = True
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              08000000000000010000232E0000232E0000000100000001000000000000E6AD
              4E00DAA54B00CD984500C28E3D00B6843700AF7B2F00CC953E00DDA74B00E7B5
              5C00E1AA4E00EAA84B00301F1B00231F20006E5A44009E866300BBA77C00DDC1
              8C00F1D39900FEEBBA00E2AF6000E4A24800180D0E00C4995700FFF2AF00FFE0
              9D00FFE4A000F8DB9A00F3D49500F5DEA300DCA75500F5A930001D121200B989
              4900FDD99100EAC68100EAC58100F0D08F00D79F4F001C12EE000000FF00F5A8
              2A001C101400B2803F00F8D28400E6BF7300E7C07400E7BF7300ECCB8000D399
              4A003B40F0002F3EFF00E38F190022180B00A8793A00F5CA7700E2B76800E3B8
              6900E4B86A00EAC37700CF934400585FEF00656FF100636DF1006670F000495F
              F100638AFF008667B4000D030000AA762800F2C46D00E0B05D00E0B25E00E2B4
              6200E2B26100E1AE4B00C88635006677F4004565F7004A67F6004E69F600425C
              F3001F3CF2005E7FFF001F28B900A4682000F0BA4D00DEAE5600DFAF5800DBA7
              4900D59A3600DB9F3100C38334005C69EF00152EF400223AF4002137F4002338
              F200273AEF00213CFF002B3FFF0089564500FAD27300D29A3D00D6982E00D392
              2900D4932B00DA9C2D00BF7C2F002E37E7001D2AE800232CE800222EEB002430
              EF002032FF001B25F90000002F00AA6F0600E4EAF100BC741800D6932400D292
              2700D2912700D8992500BB772C001614D9000E14F300A45C2A00251A00008E53
              0E00D8922000CF8C1F00D08F2300D08F2200CF8E2200D7962000B7722900130F
              CB000D0DC600CD78130014111B008A530B00E69E2200CE8C1F00CF8D1F00D694
              1D00B36D2500C16E170013111A00864F0900E49A2100CD8A1D00CF8B1D00CE8A
              1D00D8941B00B0692100B0601B0012101900804A0900E39C2000CB891C00CD8A
              1C00CC891C00D6941C00AC641D00A85A1C000C0E1A008F4F0800DF9C1F00CC89
              1B00CD8A1B00D6951B00AA621B009E500700DD992200CC881A00000000000000
              00000000000000000000000000000000000000000000000000008CCF23008FD0
              22008FD022008ECF200096D71B0011140B00538AF0008703020000000000E6AD
              4E00DAA54B00CD984500C28E3D00B6843700AF7B2F00CC953E00DDA74B00E7B5
              5C00E1AA4E00EAA84B00E2AF6000E4A24800DCA75500F5A93000D79F4F001C12
              EE000000FF00F5A82A00D3994A002F3EFF00E38F1900CF934400585FEF00C886
              35006677F400C38334005C69EF00BF7C2F002E37E700BB772C000E14F300A45C
              2A00B7722900130FCB000D0DC600CD781300B36D2500C16E1700B0692100B060
              1B00A85A1C000C0E1A008F4F0800CC891B00D6951B00AA621B009E500700DD99
              2200CC881A00CD8A1B00CD8A1B00301F1B00231F20006E5A44009E866300BBA7
              7C00DDC18C00F1D39900FEEBBA00180D0E00C4995700FFF2AF00000000000000
              0000ADAEAFAAAA000000000000000000A5A6A7A8A9AAAAA9ABAC000000000000
              9C9D9E9FA0A1A1A2A3A400000000000093949596979898999A9B000000898A00
              8B8C8D8E8F90908F9192000000007D7E7F8081828384858687886D6E6F707172
              737475767778797A7B7C5D5E5F606162636465666768696A6B6C4D4E4F505152
              535455565758595A5B5C3D3E3F404142434445464748494A4B4C000000003233
              343536373839393A3B3C000000272800292A2B2C2D2E2E2F3031000000000000
              1F20212223242424252600000000000015161718191A1B1C1D1E000000000000
              0B0C0D0E0F10111213140000000000000102030405060708090A}
            OnClick = btnRejectExitClick
          end
          object btnRejectSave: TSpeedButton
            Left = 273
            Top = 3
            Width = 73
            Height = 25
            Caption = #20445#23384
            Flat = True
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              20000000000000040000232E0000232E000000000000010000000000000F0000
              001F0000001F0000001F0000001F0000001F0000001F0000001F0000001F0000
              001F0000001F0000001F0000001F0000001F0000000FFFFFFF00000000B50707
              07FF070707FF070707FF070707FF070707FF070707FF070707FF070707FF0707
              07FF070707FF070707FF070707FF070707FF000000B5FFFFFF002C2C2CFF2323
              23FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFF202020FF292929FFFFFFFF00292929FF2626
              26FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFF202020FF292929FFFFFFFF00292929FF2A2A
              2AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFF202020FF292929FFFFFFFF00292929FF2F2F
              2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFF202020FF292929FFFFFFFF00292929FF3434
              34FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFF202020FF292929FFFFFFFF00292929FF3939
              39FFCACACAFFCACACAFFCACACAFFCACACAFFCACACAFFCACACAFFCACACAFFCACA
              CAFFCACACAFFCACACAFFCACACAFF202020FF292929FFFFFFFF00292929FF3F3F
              3FFF232323FF2C2C2CFF2C2C2CFF2C2C2CFF2C2C2CFF2C2C2CFF2C2C2CFF2C2C
              2CFF2C2C2CFF2C2C2CFF232323FF202020FF292929FFFFFFFF00292929FF4C4C
              4CFF434343FF434343FF313131FF202020FF202020FF202020FF202020FF2020
              20FF202020FF202020FF434243FF434343FF292929FFFFFFFF00292929FF5353
              53FF474747FF474748FF313131FFDAD9D9FFDADADAFFDADAD9FFD9DAD9FFD9DA
              DAFFD9D9D9FFDADAD9FF474747FF474747FF292929FFFFFFFF00292929FF5555
              55FF4C4C4CFF4C4C4CFF333333FFE3E4E4FFE4E3E4FFE4E4E4FFE4E4E4FF4A4A
              4AFF4A4A4AFFE4E3E4FF4C4B4BFF4C4C4CFF292929FFFFFFFF00292929FF5757
              57FF505050FF505050FF343434FFEEEFEEFFEFEEEFFFEEEFEFFFEFEFEFFF4E4E
              4EFF4E4E4EFFEFEFEFFF505050FF505050FF2C2C2CFFFFFFFF00292929FF5858
              58FF535353FF535353FF363636FFF8F8F8FFF8F8F9FFF8F8F8FFF8F8F8FF2F2F
              2FFF2F2F2FFFF8F8F8FF535353FF292929FF0000004FFFFFFF00292929FF6666
              66FF888888FF888888FF383838FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFF2D2D2DFF0000004FFFFFFF00FFFFFF000000003D3D3D
              3DFF3D3D3DFF3D3D3DFF3D3D3DFF3D3D3DFF3D3D3DFF3D3D3DFF3C3C3CFF3C3C
              3CFF3B3B3BFF3A3A3AFF0000004FFFFFFF00FFFFFF00FFFFFF00}
            OnClick = btnRejectSaveClick
          end
        end
      end
      object pnlRejectClient: TPanel
        Left = 0
        Top = 0
        Width = 1059
        Height = 402
        Align = alClient
        TabOrder = 1
        object pnlRejectFnCardDetail: TPanel
          Left = 1
          Top = 34
          Width = 1057
          Height = 367
          Align = alClient
          TabOrder = 0
          object cxgrdFnCardDetl: TcxGrid
            Left = 1
            Top = 1
            Width = 1055
            Height = 365
            Align = alClient
            TabOrder = 0
            LookAndFeel.Kind = lfStandard
            object cxgrdbndtblvwFnCardDetl: TcxGridDBBandedTableView
              DataController.DataSource = dsReject
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              NavigatorButtons.ConfirmDelete = False
              OptionsView.Footer = True
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              OptionsView.BandHeaders = False
              OptionsView.FixedBandSeparatorWidth = 0
              Bands = <
                item
                  FixedKind = fkLeft
                end
                item
                end>
              object cxgrdbndclmnRejectChecked: TcxGridDBBandedColumn
                Caption = #21246#36873
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.DisplayUnchecked = 'False'
                Properties.ImmediatePost = True
                Options.Filtering = False
                Options.Sorting = False
                Width = 38
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
                DataBinding.FieldName = 'Is_Select'
              end
              object cxgrdbndclmnRejectFN_Card: TcxGridDBBandedColumn
                Position.BandIndex = 1
                Position.ColIndex = 0
                Position.RowIndex = 0
                DataBinding.FieldName = 'FN_Card'
              end
              object cxgrdbndclmnRejectFabric_NO: TcxGridDBBandedColumn
                Position.BandIndex = 1
                Position.ColIndex = 1
                Position.RowIndex = 0
                DataBinding.FieldName = 'Fabric_NO'
              end
              object cxgrdbndclmnRejectGF_ID: TcxGridDBBandedColumn
                Position.BandIndex = 1
                Position.ColIndex = 2
                Position.RowIndex = 0
                DataBinding.FieldName = 'GF_ID'
              end
              object cxgrdbndclmnRejectGF_NO: TcxGridDBBandedColumn
                Position.BandIndex = 1
                Position.ColIndex = 3
                Position.RowIndex = 0
                DataBinding.FieldName = 'GF_NO'
              end
              object cxgrdbndclmnRejectJob_NO: TcxGridDBBandedColumn
                Position.BandIndex = 1
                Position.ColIndex = 4
                Position.RowIndex = 0
                DataBinding.FieldName = 'Job_NO'
              end
              object cxgrdbndclmnRejectQuantity: TcxGridDBBandedColumn
                Position.BandIndex = 1
                Position.ColIndex = 5
                Position.RowIndex = 0
                DataBinding.FieldName = 'Quantity'
              end
              object cxgrdbndclmnSC_Contract_NO: TcxGridDBBandedColumn
                Width = 111
                Position.BandIndex = 1
                Position.ColIndex = 6
                Position.RowIndex = 0
                DataBinding.FieldName = 'SC_Contract_NO'
              end
              object cxgrdbndclmnIS_BACK_FABRIC: TcxGridDBBandedColumn
                PropertiesClassName = 'TcxComboBoxProperties'
                Properties.ImmediatePost = True
                Properties.ImmediateUpdateText = True
                Properties.Items.Strings = (
                  'Y'
                  'N')
                Position.BandIndex = 1
                Position.ColIndex = 7
                Position.RowIndex = 0
                DataBinding.FieldName = 'IS_BACK_FABRIC'
              end
            end
            object cxgrdlvlFnCardDetl: TcxGridLevel
              GridView = cxgrdbndtblvwFnCardDetl
            end
          end
        end
        object pnlRejectFncardTop: TPanel
          Left = 1
          Top = 1
          Width = 1057
          Height = 33
          Align = alTop
          TabOrder = 1
          object btnSearch: TSpeedButton
            Left = 508
            Top = 4
            Width = 59
            Height = 25
            Caption = #26597#35810
            Flat = True
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              08000000000000010000130B0000130B00000001000000010000FFFFFF00EEEE
              EE0099999900CCCCCC00FFF6E100FFF7E100FFF4DE00FFF1DB00FFEDD600FFE9
              D100FFF4DF00FFEED600FFE9D200FFE5CC00FFEAD200FFE1C800FFE6CC00FFE1
              C700FFDDC3002A83BE005599CC002D86C200C2DCEE002F88C300116FB0001672
              B200ACCDE600136FB100096BAD000D6DAF000066AA0000579100000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000001A1E1F00000000000000
              00000000001A1D1C1C0000000000000000000000161B1C1D1A00000000000000
              000000001718191A000000000000000000000014131516000000000003020202
              02011413140000000000000302030303030213140000000000000302030E100F
              120302010000000000000203070B091011120302000000000000020306070B0E
              0D0F03020000000000000203040A070B0C0D0302000000000000020304040607
              0809030200000000000001020304050607030203000000000000000102030303
              0302030000000000000000000102020202030000000000000000}
            OnClick = btnSearchClick
          end
          object lblFnCard: TLabel
            Left = 102
            Top = 11
            Width = 54
            Height = 12
            Caption = #21518#25972#21345#21495':'
          end
          object lblFabricNo: TLabel
            Left = 318
            Top = 11
            Width = 30
            Height = 12
            Caption = #24067#21495':'
          end
          object edtFnCard: TEdit
            Left = 160
            Top = 7
            Width = 142
            Height = 20
            TabOrder = 0
          end
          object edtFabricNo: TEdit
            Left = 353
            Top = 7
            Width = 142
            Height = 20
            TabOrder = 1
          end
          object cbbOpType: TComboBox
            Left = 5
            Top = 6
            Width = 84
            Height = 20
            Style = csDropDownList
            ItemHeight = 12
            ItemIndex = 0
            TabOrder = 2
            Text = #36864#24067
            OnChange = cbbOpTypeChange
            Items.Strings = (
              #36864#24067
              #36864#24067#32534#36753)
          end
        end
      end
    end
    object tsRjtApr: TTabSheet
      Caption = #36864#24067#23457#26680
      ImageIndex = 2
      object pnlAprBottom: TPanel
        Left = 0
        Top = 402
        Width = 1059
        Height = 33
        Align = alBottom
        TabOrder = 0
        object pnlAprBottomRight: TPanel
          Left = 352
          Top = 1
          Width = 706
          Height = 31
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 0
          object btnAprExit: TSpeedButton
            Left = 609
            Top = 3
            Width = 73
            Height = 25
            Caption = #36864#20986
            Flat = True
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              08000000000000010000232E0000232E0000000100000001000000000000E6AD
              4E00DAA54B00CD984500C28E3D00B6843700AF7B2F00CC953E00DDA74B00E7B5
              5C00E1AA4E00EAA84B00301F1B00231F20006E5A44009E866300BBA77C00DDC1
              8C00F1D39900FEEBBA00E2AF6000E4A24800180D0E00C4995700FFF2AF00FFE0
              9D00FFE4A000F8DB9A00F3D49500F5DEA300DCA75500F5A930001D121200B989
              4900FDD99100EAC68100EAC58100F0D08F00D79F4F001C12EE000000FF00F5A8
              2A001C101400B2803F00F8D28400E6BF7300E7C07400E7BF7300ECCB8000D399
              4A003B40F0002F3EFF00E38F190022180B00A8793A00F5CA7700E2B76800E3B8
              6900E4B86A00EAC37700CF934400585FEF00656FF100636DF1006670F000495F
              F100638AFF008667B4000D030000AA762800F2C46D00E0B05D00E0B25E00E2B4
              6200E2B26100E1AE4B00C88635006677F4004565F7004A67F6004E69F600425C
              F3001F3CF2005E7FFF001F28B900A4682000F0BA4D00DEAE5600DFAF5800DBA7
              4900D59A3600DB9F3100C38334005C69EF00152EF400223AF4002137F4002338
              F200273AEF00213CFF002B3FFF0089564500FAD27300D29A3D00D6982E00D392
              2900D4932B00DA9C2D00BF7C2F002E37E7001D2AE800232CE800222EEB002430
              EF002032FF001B25F90000002F00AA6F0600E4EAF100BC741800D6932400D292
              2700D2912700D8992500BB772C001614D9000E14F300A45C2A00251A00008E53
              0E00D8922000CF8C1F00D08F2300D08F2200CF8E2200D7962000B7722900130F
              CB000D0DC600CD78130014111B008A530B00E69E2200CE8C1F00CF8D1F00D694
              1D00B36D2500C16E170013111A00864F0900E49A2100CD8A1D00CF8B1D00CE8A
              1D00D8941B00B0692100B0601B0012101900804A0900E39C2000CB891C00CD8A
              1C00CC891C00D6941C00AC641D00A85A1C000C0E1A008F4F0800DF9C1F00CC89
              1B00CD8A1B00D6951B00AA621B009E500700DD992200CC881A00000000000000
              00000000000000000000000000000000000000000000000000008CCF23008FD0
              22008FD022008ECF200096D71B0011140B00538AF0008703020000000000E6AD
              4E00DAA54B00CD984500C28E3D00B6843700AF7B2F00CC953E00DDA74B00E7B5
              5C00E1AA4E00EAA84B00E2AF6000E4A24800DCA75500F5A93000D79F4F001C12
              EE000000FF00F5A82A00D3994A002F3EFF00E38F1900CF934400585FEF00C886
              35006677F400C38334005C69EF00BF7C2F002E37E700BB772C000E14F300A45C
              2A00B7722900130FCB000D0DC600CD781300B36D2500C16E1700B0692100B060
              1B00A85A1C000C0E1A008F4F0800CC891B00D6951B00AA621B009E500700DD99
              2200CC881A00CD8A1B00CD8A1B00301F1B00231F20006E5A44009E866300BBA7
              7C00DDC18C00F1D39900FEEBBA00180D0E00C4995700FFF2AF00000000000000
              0000ADAEAFAAAA000000000000000000A5A6A7A8A9AAAAA9ABAC000000000000
              9C9D9E9FA0A1A1A2A3A400000000000093949596979898999A9B000000898A00
              8B8C8D8E8F90908F9192000000007D7E7F8081828384858687886D6E6F707172
              737475767778797A7B7C5D5E5F606162636465666768696A6B6C4D4E4F505152
              535455565758595A5B5C3D3E3F404142434445464748494A4B4C000000003233
              343536373839393A3B3C000000272800292A2B2C2D2E2E2F3031000000000000
              1F20212223242424252600000000000015161718191A1B1C1D1E000000000000
              0B0C0D0E0F10111213140000000000000102030405060708090A}
            OnClick = btnRejectExitClick
          end
          object btnAprSave: TSpeedButton
            Left = 273
            Top = 3
            Width = 73
            Height = 25
            Caption = #20445#23384
            Flat = True
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              20000000000000040000232E0000232E000000000000010000000000000F0000
              001F0000001F0000001F0000001F0000001F0000001F0000001F0000001F0000
              001F0000001F0000001F0000001F0000001F0000000FFFFFFF00000000B50707
              07FF070707FF070707FF070707FF070707FF070707FF070707FF070707FF0707
              07FF070707FF070707FF070707FF070707FF000000B5FFFFFF002C2C2CFF2323
              23FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFF202020FF292929FFFFFFFF00292929FF2626
              26FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFF202020FF292929FFFFFFFF00292929FF2A2A
              2AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFF202020FF292929FFFFFFFF00292929FF2F2F
              2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFF202020FF292929FFFFFFFF00292929FF3434
              34FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFF202020FF292929FFFFFFFF00292929FF3939
              39FFCACACAFFCACACAFFCACACAFFCACACAFFCACACAFFCACACAFFCACACAFFCACA
              CAFFCACACAFFCACACAFFCACACAFF202020FF292929FFFFFFFF00292929FF3F3F
              3FFF232323FF2C2C2CFF2C2C2CFF2C2C2CFF2C2C2CFF2C2C2CFF2C2C2CFF2C2C
              2CFF2C2C2CFF2C2C2CFF232323FF202020FF292929FFFFFFFF00292929FF4C4C
              4CFF434343FF434343FF313131FF202020FF202020FF202020FF202020FF2020
              20FF202020FF202020FF434243FF434343FF292929FFFFFFFF00292929FF5353
              53FF474747FF474748FF313131FFDAD9D9FFDADADAFFDADAD9FFD9DAD9FFD9DA
              DAFFD9D9D9FFDADAD9FF474747FF474747FF292929FFFFFFFF00292929FF5555
              55FF4C4C4CFF4C4C4CFF333333FFE3E4E4FFE4E3E4FFE4E4E4FFE4E4E4FF4A4A
              4AFF4A4A4AFFE4E3E4FF4C4B4BFF4C4C4CFF292929FFFFFFFF00292929FF5757
              57FF505050FF505050FF343434FFEEEFEEFFEFEEEFFFEEEFEFFFEFEFEFFF4E4E
              4EFF4E4E4EFFEFEFEFFF505050FF505050FF2C2C2CFFFFFFFF00292929FF5858
              58FF535353FF535353FF363636FFF8F8F8FFF8F8F9FFF8F8F8FFF8F8F8FF2F2F
              2FFF2F2F2FFFF8F8F8FF535353FF292929FF0000004FFFFFFF00292929FF6666
              66FF888888FF888888FF383838FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFF2D2D2DFF0000004FFFFFFF00FFFFFF000000003D3D3D
              3DFF3D3D3DFF3D3D3DFF3D3D3DFF3D3D3DFF3D3D3DFF3D3D3DFF3C3C3CFF3C3C
              3CFF3B3B3BFF3A3A3AFF0000004FFFFFFF00FFFFFF00FFFFFF00}
            OnClick = btnAprSaveClick
          end
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1059
        Height = 402
        Align = alClient
        TabOrder = 1
        object Panel2: TPanel
          Left = 1
          Top = 34
          Width = 1057
          Height = 367
          Align = alClient
          TabOrder = 0
          object cxgrdAprFnCardDetl: TcxGrid
            Left = 1
            Top = 1
            Width = 1055
            Height = 365
            Align = alClient
            TabOrder = 0
            LookAndFeel.Kind = lfStandard
            object cxgrdbndtblvwAprFnCardDetl: TcxGridDBBandedTableView
              DataController.DataSource = dsApr
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              NavigatorButtons.ConfirmDelete = False
              OptionsView.Footer = True
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              OptionsView.BandHeaders = False
              OptionsView.FixedBandSeparatorWidth = 0
              Bands = <
                item
                  FixedKind = fkLeft
                end
                item
                end>
              object cxgrdbndclmnAprIs_Select: TcxGridDBBandedColumn
                Caption = #21246#36873
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.DisplayUnchecked = 'False'
                Properties.ImmediatePost = True
                Options.Filtering = False
                Options.Sorting = False
                Width = 38
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
                DataBinding.FieldName = 'Is_Select'
              end
              object cxGridDBBandedColumn2: TcxGridDBBandedColumn
                Position.BandIndex = 1
                Position.ColIndex = 0
                Position.RowIndex = 0
                DataBinding.FieldName = 'FN_Card'
              end
              object cxGridDBBandedColumn3: TcxGridDBBandedColumn
                Position.BandIndex = 1
                Position.ColIndex = 1
                Position.RowIndex = 0
                DataBinding.FieldName = 'Fabric_NO'
              end
              object cxGridDBBandedColumn4: TcxGridDBBandedColumn
                Position.BandIndex = 1
                Position.ColIndex = 2
                Position.RowIndex = 0
                DataBinding.FieldName = 'GF_ID'
              end
              object cxGridDBBandedColumn5: TcxGridDBBandedColumn
                Position.BandIndex = 1
                Position.ColIndex = 3
                Position.RowIndex = 0
                DataBinding.FieldName = 'GF_NO'
              end
              object cxGridDBBandedColumn6: TcxGridDBBandedColumn
                Position.BandIndex = 1
                Position.ColIndex = 4
                Position.RowIndex = 0
                DataBinding.FieldName = 'Job_NO'
              end
              object cxGridDBBandedColumn7: TcxGridDBBandedColumn
                Position.BandIndex = 1
                Position.ColIndex = 5
                Position.RowIndex = 0
                DataBinding.FieldName = 'Quantity'
              end
              object cxgrdbndclmnIden: TcxGridDBBandedColumn
                Position.BandIndex = 1
                Position.ColIndex = 6
                Position.RowIndex = 0
                DataBinding.FieldName = 'Iden'
              end
            end
            object cxgrdlvlAprFnCardDetl: TcxGridLevel
              GridView = cxgrdbndtblvwAprFnCardDetl
            end
          end
        end
        object Panel3: TPanel
          Left = 1
          Top = 1
          Width = 1057
          Height = 33
          Align = alTop
          TabOrder = 1
          object btnAprSearch: TSpeedButton
            Left = 408
            Top = 4
            Width = 59
            Height = 25
            Caption = #26597#35810
            Flat = True
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              08000000000000010000130B0000130B00000001000000010000FFFFFF00EEEE
              EE0099999900CCCCCC00FFF6E100FFF7E100FFF4DE00FFF1DB00FFEDD600FFE9
              D100FFF4DF00FFEED600FFE9D200FFE5CC00FFEAD200FFE1C800FFE6CC00FFE1
              C700FFDDC3002A83BE005599CC002D86C200C2DCEE002F88C300116FB0001672
              B200ACCDE600136FB100096BAD000D6DAF000066AA0000579100000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000001A1E1F00000000000000
              00000000001A1D1C1C0000000000000000000000161B1C1D1A00000000000000
              000000001718191A000000000000000000000014131516000000000003020202
              02011413140000000000000302030303030213140000000000000302030E100F
              120302010000000000000203070B091011120302000000000000020306070B0E
              0D0F03020000000000000203040A070B0C0D0302000000000000020304040607
              0809030200000000000001020304050607030203000000000000000102030303
              0302030000000000000000000102020202030000000000000000}
            OnClick = btnAprSearchClick
          end
          object Label1: TLabel
            Left = 8
            Top = 11
            Width = 54
            Height = 12
            Caption = #21518#25972#21345#21495':'
          end
          object Label2: TLabel
            Left = 224
            Top = 11
            Width = 30
            Height = 12
            Caption = #24067#21495':'
          end
          object edtAprFnCard: TEdit
            Left = 66
            Top = 7
            Width = 142
            Height = 20
            TabOrder = 0
          end
          object edtAprFabricNo: TEdit
            Left = 258
            Top = 7
            Width = 142
            Height = 20
            TabOrder = 1
          end
        end
      end
    end
  end
  object cdsSendInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 429
    Top = 328
  end
  object dsSendInfo: TDataSource
    DataSet = cdsSendInfo
    Left = 495
    Top = 330
  end
  object cdsUnSelect: TClientDataSet
    Aggregates = <>
    Params = <>
    OnFilterRecord = cdsUnSelectFilterRecord
    Left = 44
    Top = 101
  end
  object dsUnSelect: TDataSource
    DataSet = cdsUnSelect
    Left = 90
    Top = 101
  end
  object cdsSelect: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    OnFilterRecord = cdsSelectFilterRecord
    Left = 48
    Top = 335
  end
  object dsSelect: TDataSource
    DataSet = cdsSelect
    Left = 97
    Top = 335
  end
  object dsReject: TDataSource
    DataSet = cdsReject
    Left = 520
    Top = 128
  end
  object cdsReject: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 464
    Top = 128
  end
  object cxgrdpmnReject: TcxGridPopupMenu
    Grid = cxgrdFnCardDetl
    PopupMenus = <>
    Left = 584
    Top = 128
  end
  object cdsApr: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 704
    Top = 80
  end
  object dsApr: TDataSource
    DataSet = cdsApr
    Left = 736
    Top = 80
  end
end

inherited CSStateForm: TCSStateForm
  Left = 78
  Top = 117
  Width = 780
  Height = 540
  Caption = #33258#21160#21270#26009#29366#24577
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object pnl1: TPanel
    Left = 137
    Top = 0
    Width = 635
    Height = 513
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object cxgridBatch: TcxGrid
      Left = 0
      Top = 346
      Width = 635
      Height = 167
      Hint = #26426#21488#24453#23433#25490#32568
      Align = alClient
      TabOrder = 0
      object cxgridtvBatch: TcxGridDBTableView
        DataController.DataSource = dsBatch
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
      end
      object cxGridlBatch: TcxGridLevel
        GridView = cxgridtvBatch
      end
    end
    object pnl2: TPanel
      Left = 0
      Top = 305
      Width = 635
      Height = 41
      Align = alTop
      TabOrder = 1
      DesignSize = (
        635
        41)
      object btnDelete: TSpeedButton
        Left = 124
        Top = 10
        Width = 80
        Height = 25
        Hint = #21024#38500#24050#32463#33258#21160#21270#26009#31995#32479#20013#30340#32568#21495
        Anchors = [akRight, akBottom]
        Caption = #21024#38500'(&D)'
        Enabled = False
        Flat = True
        Glyph.Data = {
          DE000000424DDE0000000000000076000000280000000D0000000D0000000100
          0400000000006800000000000000000000001000000010000000000000000000
          BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7000777777777777700077777707777770007777706077777000777706660777
          7000777066666077700077066666660770007000066600007000777706660777
          7000777706660777700077770666077770007777000007777000777777777777
          7000}
        OnClick = btnDeleteClick
      end
      object btnAdd: TSpeedButton
        Left = 31
        Top = 10
        Width = 80
        Height = 25
        Hint = #23558#25968#25454#23548#20837#21040#33258#21160#21270#26009#31995#32479
        Anchors = [akRight, akBottom]
        Caption = #26032#22686'(&N)'
        Enabled = False
        Flat = True
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          0800000000000001000000000000000000000001000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A6000020400000206000002080000020A0000020C0000020E000004000000040
          20000040400000406000004080000040A0000040C0000040E000006000000060
          20000060400000606000006080000060A0000060C0000060E000008000000080
          20000080400000806000008080000080A0000080C0000080E00000A0000000A0
          200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
          200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
          200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
          20004000400040006000400080004000A0004000C0004000E000402000004020
          20004020400040206000402080004020A0004020C0004020E000404000004040
          20004040400040406000404080004040A0004040C0004040E000406000004060
          20004060400040606000406080004060A0004060C0004060E000408000004080
          20004080400040806000408080004080A0004080C0004080E00040A0000040A0
          200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
          200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
          200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
          20008000400080006000800080008000A0008000C0008000E000802000008020
          20008020400080206000802080008020A0008020C0008020E000804000008040
          20008040400080406000804080008040A0008040C0008040E000806000008060
          20008060400080606000806080008060A0008060C0008060E000808000008080
          20008080400080806000808080008080A0008080C0008080E00080A0000080A0
          200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
          200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
          200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
          2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
          2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
          2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
          2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
          2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
          2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
          2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00070707070707
          0707070707070707070707070707070707070707070707070707070707070707
          0707070707070707070707070707070707070707070707070707070707070700
          00000000070707070707070707070700F0F0F000070707070707070707070700
          F0F0F000070707070707070707070700F0F0F000070707070707070700000000
          F0F0F00000000007070707070700F0F0F0F0F0F0F000070707070707070700F0
          F0F0F0F0000707070707070707070700F0F0F000070707070707070707070707
          00F0000707070707070707070707070707000707070707070707070707070707
          0707070707070707070707070707070707070707070707070707}
        OnClick = btnAddClick
      end
      object btnExit: TSpeedButton
        Left = 364
        Top = 10
        Width = 80
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #36864#20986'(&X)'
        Flat = True
        Glyph.Data = {
          42020000424D4202000000000000420000002800000010000000100000000100
          1000030000000002000000000000000000000000000000000000007C0000E003
          00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C0000004200001F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C00000042004200001F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C0000000000420042004200000000000000000000000000000000
          1F7C1F7C1F7C1F7C000000420042004200001F7C1F7C00001F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C000000420042000000001F7C1F7C00001F7C1F7C1F7C1F7C
          10001F7C1F7C1F7C000000420042004200001F7C1F7C00001F7C1F7C1F7C1000
          10001F7C1F7C1F7C000000420042004200001F7C1F7C00001F7C1F7C10001000
          1000100010001F7C000000420042004200001F7C1F7C00001F7C100010001000
          1000100010001F7C000000420042004200001F7C1F7C00001F7C1F7C10001000
          1000100010001F7C00000042004200001F7C1F7C1F7C00001F7C1F7C1F7C1000
          10001F7C1F7C1F7C0000004200001F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C
          10001F7C1F7C1F7C000000001F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C000000000000000000000000000000001F7C1F7C1F7C1F7C
          1F7C1F7C1F7C}
        OnClick = btnExitClick
      end
      object cxcbFilter: TcxCheckBox
        Left = 224
        Top = 14
        Width = 73
        Height = 21
        Hint = #36807#28388#24050#23548'CS'#30340#32568#21495
        Anchors = [akRight, akBottom]
        Properties.DisplayUnchecked = 'False'
        Properties.OnChange = cxcbFilterPropertiesChange
        Properties.Caption = #36807#28388
        TabOrder = 0
      end
    end
    object cxspl1: TcxSplitter
      Left = 0
      Top = 297
      Width = 635
      Height = 8
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salTop
      Control = pnl3
    end
    object pnl3: TPanel
      Left = 0
      Top = 0
      Width = 635
      Height = 297
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      object cxgridTank: TcxGrid
        Left = 0
        Top = 0
        Width = 336
        Height = 297
        Hint = #26426#21488#24453#21270#32568#21015#34920
        Align = alClient
        TabOrder = 0
        object cxgridtvTank: TcxGridDBTableView
          DataController.DataSource = dsTank
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
        end
        object cxGridlTank: TcxGridLevel
          GridView = cxgridtvTank
        end
      end
      object pnl4: TPanel
        Left = 344
        Top = 0
        Width = 291
        Height = 297
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        object cxgridGF: TcxGrid
          Left = 0
          Top = 169
          Width = 291
          Height = 128
          Hint = #32568#21495#23545#24212#21697#21517#21345#21495#20449#24687
          Align = alClient
          TabOrder = 0
          object cxgridtvGF: TcxGridDBTableView
            DataController.DataSource = dsGF
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NavigatorButtons.ConfirmDelete = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.Footer = True
            OptionsView.GroupByBox = False
          end
          object cxGridlGF: TcxGridLevel
            GridView = cxgridtvGF
          end
        end
        object cxgridCS: TcxGrid
          Left = 0
          Top = 0
          Width = 291
          Height = 169
          Hint = #32568#21495#23545#24212#21270#24037#26009#20449#24687
          Align = alTop
          TabOrder = 1
          object cxgridtvCS: TcxGridDBTableView
            DataController.DataSource = dsCS
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NavigatorButtons.ConfirmDelete = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.Footer = True
            OptionsView.GroupByBox = False
          end
          object cxGridlCS: TcxGridLevel
            GridView = cxgridtvCS
          end
        end
      end
      object cxsplTank: TcxSplitter
        Left = 336
        Top = 0
        Width = 8
        Height = 297
        HotZoneClassName = 'TcxXPTaskBarStyle'
        AlignSplitter = salRight
        Control = pnl4
      end
    end
  end
  object cxspl3: TcxSplitter
    Left = 129
    Top = 0
    Width = 8
    Height = 513
    HotZoneClassName = 'TcxXPTaskBarStyle'
    Control = pnlVat
  end
  object pnlVat: TPanel
    Left = 0
    Top = 0
    Width = 129
    Height = 513
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
    object sclbVat: TScrollBox
      Left = 0
      Top = 0
      Width = 129
      Height = 513
      Align = alClient
      BevelKind = bkFlat
      TabOrder = 0
    end
  end
  object cdsTank: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdsTankAfterScroll
    Left = 128
    Top = 64
  end
  object dsTank: TDataSource
    DataSet = cdsTank
    Left = 168
    Top = 64
  end
  object dsGF: TDataSource
    DataSet = cdsGF
    Left = 424
    Top = 224
  end
  object cdsGF: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 384
    Top = 224
  end
  object dsCS: TDataSource
    DataSet = cdsCS
    Left = 464
    Top = 56
  end
  object cdsCS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 424
    Top = 56
  end
  object dsBatch: TDataSource
    DataSet = cdsBatch
    Left = 184
    Top = 384
  end
  object cdsBatch: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 144
    Top = 384
  end
  object cdsVat: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 80
    Top = 64
  end
end

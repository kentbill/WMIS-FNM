inherited AnalysisOTDForm: TAnalysisOTDForm
  Left = 160
  Top = 126
  Caption = #20998#26512'OTD'
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object TPanel
    Left = 0
    Top = 415
    Width = 688
    Height = 38
    Align = alBottom
    AutoSize = True
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object pnl_Only: TPanel
      Left = 2
      Top = 2
      Width = 684
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object btn_Help: TSpeedButton
        Left = 8
        Top = 5
        Width = 75
        Height = 25
        Caption = #24110#21161'(&H)'
        Enabled = False
        Flat = True
        Visible = False
      end
      object btn_Query: TSpeedButton
        Left = 229
        Top = 5
        Width = 75
        Height = 25
        Caption = #26597#35810'(&Q)'
        Flat = True
        OnClick = btn_QueryClick
      end
      object btn_Save: TSpeedButton
        Left = 533
        Top = 5
        Width = 75
        Height = 25
        Caption = #20445#23384'(&S)'
        Flat = True
        OnClick = btn_SaveClick
      end
      object btn_Exit: TSpeedButton
        Left = 614
        Top = 5
        Width = 75
        Height = 25
        Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
        Caption = #36864#20986'(&X)'
        Flat = True
      end
      object btn_Delete: TSpeedButton
        Left = 453
        Top = 5
        Width = 75
        Height = 25
        Caption = #21024#38500'(&D)'
        Flat = True
        Visible = False
      end
      object txt_Only: TStaticText
        Left = 91
        Top = 16
        Width = 34
        Height = 16
        Caption = #26085#26399':'
        TabOrder = 0
      end
      object dtpDate: TDateTimePicker
        Left = 120
        Top = 8
        Width = 105
        Height = 20
        CalAlignment = dtaLeft
        Date = 40066.4370261574
        Time = 40066.4370261574
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 1
      end
      object cxcbPD: TcxCheckBox
        Left = 312
        Top = 9
        Width = 121
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.Caption = #21482#26174#31034#65328#65316#21333
        TabOrder = 2
      end
    end
  end
  object TPanel
    Left = 0
    Top = 412
    Width = 688
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
  end
  object TPanel
    Left = 0
    Top = 0
    Width = 688
    Height = 412
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object pnl_Only1: TPanel
      Left = 0
      Top = 266
      Width = 688
      Height = 146
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object cxgridOTDDtl: TcxGrid
        Left = 26
        Top = 16
        Width = 662
        Height = 130
        Align = alClient
        TabOrder = 0
        object cxgridtvOTDDtl: TcxGridDBTableView
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          NavigatorButtons.First.Visible = True
          NavigatorButtons.PriorPage.Visible = True
          NavigatorButtons.Prior.Visible = True
          NavigatorButtons.Next.Visible = True
          NavigatorButtons.NextPage.Visible = True
          NavigatorButtons.Last.Visible = True
          NavigatorButtons.Insert.Visible = True
          NavigatorButtons.Delete.Visible = True
          NavigatorButtons.Edit.Visible = True
          NavigatorButtons.Post.Visible = True
          NavigatorButtons.Cancel.Visible = True
          NavigatorButtons.Refresh.Visible = True
          NavigatorButtons.SaveBookmark.Visible = True
          NavigatorButtons.GotoBookmark.Visible = True
          NavigatorButtons.Filter.Visible = True
          OptionsSelection.MultiSelect = True
          OptionsView.GroupByBox = False
          OptionsView.GroupFooters = gfAlwaysVisible
        end
        object cxGridlOTDDtl: TcxGridLevel
          GridView = cxgridtvOTDDtl
        end
      end
      object txt2: TStaticText
        Left = 0
        Top = 0
        Width = 688
        Height = 16
        Align = alTop
        Caption = #36131#20219#20154':'
        TabOrder = 1
      end
      object pnl2: TPanel
        Left = 0
        Top = 16
        Width = 26
        Height = 130
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 2
        object btnAddItem: TSpeedButton
          Left = 1
          Top = 8
          Width = 23
          Height = 15
          Hint = #22686#21152'ITEM'#26126#32454
          Flat = True
          Glyph.Data = {
            66010000424D6601000000000000760000002800000015000000140000000100
            040000000000F0000000130B0000130B00001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            8888888880008888888888888888888880008888888888888888888880008888
            88888888888888888000888880000000000088888000888880FFFFFFFFF08888
            8000888880FFFFFFFFF088888000888880FFFFFFFFF088888000888880FFFFFF
            FFF088888000888880FFFFFFFFF088888000888880FFFFFFFFF0888880008888
            80FFFFFFFFF088888000888880FFFFFFFFF088888000888880FFFFFF00008888
            8000888880FFFFFF0F0888888000888880FFFFFF008888888000888880000000
            0888888880008888888888888888888880008888888888888888888880008888
            88888888888888888000}
          ParentShowHint = False
          ShowHint = True
          OnClick = btnAddItemClick
        end
        object btnDeleteItem: TSpeedButton
          Left = 1
          Top = 89
          Width = 23
          Height = 22
          Hint = #21024#38500'ITEM'#26126#32454
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
            0707070707070707070707070707070707070707070707070707070707000707
            0707070707070707000707070000000707070707070707070707070700000000
            0707070707070700070707070700000007070707070700070707070707070000
            0007070707000007070707070707070000000707000007070707070707070707
            0000000000070707070707070707070707000000070707070707070707070707
            0000000000070707070707070707070000000707000007070707070707000000
            0007070707000007070707070000000007070707070700000707070700000007
            0707070707070707000707070707070707070707070707070707}
          ParentShowHint = False
          ShowHint = True
          OnClick = btnDeleteItemClick
        end
        object btnCopyClipData: TSpeedButton
          Left = 1
          Top = 23
          Width = 23
          Height = 22
          Hint = #25335#36125'ITEM'#26126#32454
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
            0707070707070707070707070707070707000000000000000000070707070707
            0700FFFFFFFFFFFFFF000707070707070700FFFCFCFCFCFCFF00070000000000
            0000FFFFFFFFFFFFFF000700FFFFFFFFFF00FFFCFCFCFCFCFF000700FFFCFCFC
            FC00FFFFFFFFFFFFFF000700FFFFFFFFFF00FFFCFCFF000000000700FFFCFCFC
            FC00FFFFFFFF00FF00070700FFFFFFFFFF00FFFFFFFF000007070700FFFCFCFF
            000000000000000707070700FFFFFFFF00FF00070707070707070700FFFFFFFF
            0000070707070707070707000000000000070707070707070707070707070707
            0707070707070707070707070707070707070707070707070707}
          ParentShowHint = False
          ShowHint = True
          OnClick = btnCopyClipDataClick
        end
        object btnPasteClipData: TSpeedButton
          Left = 1
          Top = 45
          Width = 23
          Height = 22
          Hint = #31896#36148'ITEM'#26126#32454
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
            0707070707070707070707070707070704040404040404040404070000000000
            0407070707070707070400000300030004070404040404040704000300030003
            0407070707070707070400000300030004070404040704040404000300030003
            0407070707070407040700000300030004070707070704040707000300030003
            0404040404040400070700000300030003000300030003000707000300000000
            00000000000000000707000000000707070707070000030007070003000300FB
            0000FB00000300000707070000000000FBFB0000000000070707070707070700
            0000000707070707070707070707070707070707070707070707}
          ParentShowHint = False
          ShowHint = True
          OnClick = btnPasteClipDataClick
        end
        object btnClearClipData: TSpeedButton
          Left = 1
          Top = 67
          Width = 23
          Height = 22
          Hint = #28165#31354#21098#36148#26495#25968#25454' '
          Enabled = False
          Flat = True
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008484
            8400848484008484840084848400848484008484840084848400848484008484
            840084848400848484008484840084848400FFFFFF00FFFFFF00848484008484
            8400848484008484840084848400848484008484840084848400848484008484
            840084848400848484008484840000000000FFFFFF00FFFFFF0084848400CED6
            D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF0084848400CED6
            D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED6D600CED6
            D600CED6D600FFFFFF008484840000000000FFFFFF00FFFFFF0084848400CED6
            D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF0084848400CED6
            D600FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
            000000000000FFFFFF008484840000000000FFFFFF00FFFFFF0084848400CED6
            D600FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF0000FFFF0000FFFF0000FF
            FF0000848400000000008484840000000000FFFFFF00FFFFFF0084848400CED6
            D600FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF0000FFFF0000FFFF0000FF
            FF0000848400008484000000000000000000FFFFFF00FFFFFF0084848400CED6
            D600848484008484840084848400000000008484840000848400008484000084
            840000848400008484000084840000000000FFFFFF00FFFFFF0084848400CED6
            D600FF000000FF000000FF000000FF00000000000000FFFFFF0000FFFF0000FF
            FF0000FFFF0000848400008484000084840084848400FFFFFF0084848400CED6
            D600CED6D600CED6D600CED6D600CED6D600CED6D60000000000FFFFFF0000FF
            FF0000FFFF0000FFFF0000848400008484008484840084848400848484008484
            840084848400848484008484840084848400848484008484840084848400FFFF
            FF0000FFFF0000FFFF0000FFFF00008484000084840084848400FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
            8400FFFFFF0000FFFF0000FFFF0000FFFF008484840084848400FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF008484840084848400848484008484840084848400FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
          ParentShowHint = False
          ShowHint = True
          OnClick = btnClearClipDataClick
        end
      end
    end
    object TPanel
      Left = 0
      Top = 0
      Width = 688
      Height = 258
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object cxgridOTDHdr: TcxGrid
        Left = 0
        Top = 16
        Width = 688
        Height = 242
        Align = alClient
        TabOrder = 0
        object cxgridtvOTDHdr: TcxGridDBTableView
          DataController.DataSource = dsOTDHdr
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
        end
        object cxGridlOTDHdr: TcxGridLevel
          GridView = cxgridtvOTDHdr
        end
      end
      object txt1: TStaticText
        Left = 0
        Top = 0
        Width = 688
        Height = 16
        Align = alTop
        Caption = #20998#26512#25968#25454':'
        TabOrder = 1
      end
    end
    object cxspl1: TcxSplitter
      Left = 0
      Top = 258
      Width = 688
      Height = 8
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salBottom
      Control = pnl_Only1
    end
  end
  object cdsOTDDtl: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterEdit = cdsOTDDtlAfterEdit
    Left = 339
    Top = 292
  end
  object dsOTDDtl: TDataSource
    DataSet = cdsOTDDtl
    Left = 339
    Top = 340
  end
  object cdsOTDHdr: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterEdit = cdsOTDDtlAfterEdit
    AfterScroll = cdsOTDHdrAfterScroll
    Left = 179
    Top = 116
  end
  object dsOTDHdr: TDataSource
    DataSet = cdsOTDHdr
    Left = 179
    Top = 180
  end
  object cds_JobTrance: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 147
    Top = 324
  end
  object cdsClipData: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 75
    Top = 324
  end
end

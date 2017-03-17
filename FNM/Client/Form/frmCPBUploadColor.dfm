inherited CPBUploadColorForm: TCPBUploadColorForm
  Left = 51
  Top = 107
  Width = 943
  Height = 574
  Caption = #19978#20256#23545#33394#25968#25454#21450#26597#35810#12304#33258#21160#19978#20256#39057#29575#65306'30 Min'#12305
  Font.Charset = ANSI_CHARSET
  Font.Name = #26032#23435#20307
  OldCreateOrder = True
  Position = poDefault
  WindowState = wsMaximized
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 189
    Height = 547
    ActivePage = TabSheet1
    Align = alLeft
    Style = tsFlatButtons
    TabIndex = 0
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = #29233#33394#20029#12304'xRite'#12305
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 173
        Height = 517
        Align = alLeft
        Caption = 'xRite'#33394#21495#21015#34920
        TabOrder = 0
        object cbbxRiteList: TComboBox
          Left = 13
          Top = 95
          Width = 145
          Height = 273
          Style = csSimple
          ItemHeight = 12
          TabOrder = 1
          OnClick = cbbxRiteListClick
        end
        object Panel6: TPanel
          Left = 2
          Top = 14
          Width = 169
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object btnRefreshxRite: TBitBtn
            Left = 10
            Top = 7
            Width = 75
            Height = 25
            Caption = #21047#26032'(&R)'
            TabOrder = 1
            OnClick = btnRefreshxRiteClick
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
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00070700000000
              00000000000000000007070700FFFFFFFFFFFFFFFFFFFFFF0007070700FFFFFF
              FFFF02FFFFFFFFFF0007070700FFFFFFFF0202FFFFFFFFFF0007070700FFFFFF
              0202020202FFFFFF0007070700FFFFFFFF0202FFFF02FFFF0007070700FFFFFF
              FFFF02FFFF02FFFF0007070700FFFF02FFFFFFFFFF02FFFF0007070700FFFF02
              FFFF02FFFFFFFFFF0007070700FFFF02FFFF0202FFFFFFFF0007070700FFFFFF
              0202020202FFFFFF0007070700FFFFFFFFFF0202FFFFFFFF0007070700FFFFFF
              FFFF02FFFF0000000007070700FFFFFFFFFFFFFFFF00FF000707070700FFFFFF
              FFFFFFFFFF000007070707070000000000000000000007070707}
          end
          object btnUploadxRite: TBitBtn
            Left = 90
            Top = 7
            Width = 75
            Height = 25
            Caption = #19978#20256'(&U)'
            TabOrder = 0
            OnClick = btnUploadxRiteClick
            Glyph.Data = {
              DE000000424DDE0000000000000076000000280000000D0000000D0000000100
              04000000000068000000C40E0000C40E00001000000000000000000000000000
              BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777700000777
              7000777706660777700077770666077770007777066607777000700006660000
              7000770666666607700077706666607770007000066600007000770660606607
              7000777066066077700077770666077770007777706077777000777777077777
              7000}
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'DataColor'
      ImageIndex = 1
      object GroupBox5: TGroupBox
        Left = 0
        Top = 0
        Width = 173
        Height = 517
        Align = alLeft
        Caption = 'DataColor'#33394#21495#21015#34920
        TabOrder = 0
        object cbbDataColorList: TComboBox
          Left = 14
          Top = 97
          Width = 145
          Height = 270
          Style = csSimple
          ItemHeight = 12
          TabOrder = 1
          OnChange = cbbDataColorListChange
        end
        object Panel7: TPanel
          Left = 2
          Top = 14
          Width = 169
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object btnRefreshDataColor: TBitBtn
            Left = 10
            Top = 7
            Width = 75
            Height = 25
            Caption = #21047#26032'(&R)'
            TabOrder = 1
            OnClick = btnRefreshDataColorClick
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
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00070700000000
              00000000000000000007070700FFFFFFFFFFFFFFFFFFFFFF0007070700FFFFFF
              FFFF02FFFFFFFFFF0007070700FFFFFFFF0202FFFFFFFFFF0007070700FFFFFF
              0202020202FFFFFF0007070700FFFFFFFF0202FFFF02FFFF0007070700FFFFFF
              FFFF02FFFF02FFFF0007070700FFFF02FFFFFFFFFF02FFFF0007070700FFFF02
              FFFF02FFFFFFFFFF0007070700FFFF02FFFF0202FFFFFFFF0007070700FFFFFF
              0202020202FFFFFF0007070700FFFFFFFFFF0202FFFFFFFF0007070700FFFFFF
              FFFF02FFFF0000000007070700FFFFFFFFFFFFFFFF00FF000707070700FFFFFF
              FFFFFFFFFF000007070707070000000000000000000007070707}
          end
          object btnUploadDataColor: TBitBtn
            Left = 90
            Top = 7
            Width = 75
            Height = 25
            Caption = #19978#20256'(&U)'
            TabOrder = 0
            OnClick = btnUploadDataColorClick
            Glyph.Data = {
              DE000000424DDE0000000000000076000000280000000D0000000D0000000100
              04000000000068000000C40E0000C40E00001000000000000000000000000000
              BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777700000777
              7000777706660777700077770666077770007777066607777000700006660000
              7000770666666607700077706666607770007000066600007000770660606607
              7000777066066077700077770666077770007777706077777000777777077777
              7000}
          end
        end
      end
    end
  end
  object Panel5: TPanel
    Left = 197
    Top = 0
    Width = 738
    Height = 547
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 738
      Height = 45
      Align = alTop
      BevelOuter = bvNone
      Caption = #12304#33258#21160#19978#20256#39057#29575#65306'30 Min'#12305
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #26032#23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label2: TLabel
        Left = 7
        Top = 20
        Width = 60
        Height = 12
        Caption = #32568#21495'/'#33394#21495':'
      end
      object edtItemNO: TEdit
        Left = 67
        Top = 12
        Width = 130
        Height = 20
        CharCase = ecUpperCase
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
      end
      object btnQuery: TBitBtn
        Left = 204
        Top = 7
        Width = 75
        Height = 25
        Caption = #26597#35810'(&Q)'
        TabOrder = 1
        OnClick = btnQueryClick
        Glyph.Data = {
          EE000000424DEE000000000000007600000028000000100000000F0000000100
          0400000000007800000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          888800000888880000080F000888880F00080F000888880F0008000000080000
          000800F000000F00000800F000F00F00000800F000F00F000008800000000000
          0088880F00080F000888880000080000088888800088800088888880F08880F0
          888888800088800088888888888888888888}
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 45
      Width = 511
      Height = 502
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Panel1'
      TabOrder = 1
      object pnlxRite: TPanel
        Left = 0
        Top = 0
        Width = 511
        Height = 120
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object gbColor: TGroupBox
          Left = 0
          Top = 0
          Width = 511
          Height = 120
          Align = alClient
          Caption = 'xRite'#23545#33394#20449#24687
          TabOrder = 0
          object cxGrid2: TcxGrid
            Left = 2
            Top = 14
            Width = 507
            Height = 104
            Align = alClient
            TabOrder = 0
            object cxGridtvColor: TcxGridDBTableView
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              NavigatorButtons.ConfirmDelete = False
              OptionsView.GroupByBox = False
            end
            object cxGridLevel1: TcxGridLevel
              GridView = cxGridtvColor
            end
          end
        end
      end
      object cxSpxRite: TcxSplitter
        Left = 0
        Top = 120
        Width = 511
        Height = 8
        HotZoneClassName = 'TcxXPTaskBarStyle'
        AlignSplitter = salTop
        Control = pnlxRite
      end
      object Panel3: TPanel
        Left = 0
        Top = 128
        Width = 511
        Height = 374
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Panel3'
        TabOrder = 2
        object gbLab: TGroupBox
          Left = 0
          Top = 138
          Width = 511
          Height = 120
          Align = alTop
          Caption = #23545#33394#20449#24687
          TabOrder = 1
          object cxGrid3: TcxGrid
            Left = 2
            Top = 14
            Width = 507
            Height = 104
            Align = alClient
            TabOrder = 0
            object cxGridtvLab: TcxGridDBTableView
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              NavigatorButtons.ConfirmDelete = False
              OptionsView.GroupByBox = False
            end
            object cxGridLevel2: TcxGridLevel
              GridView = cxGridtvLab
            end
          end
        end
        object gbStock: TGroupBox
          Left = 0
          Top = 266
          Width = 511
          Height = 108
          Align = alClient
          Caption = #33394#32433#24211#23384#20449#24687
          TabOrder = 4
          object cxGrid4: TcxGrid
            Left = 2
            Top = 14
            Width = 507
            Height = 92
            Align = alClient
            TabOrder = 0
            object cxGridtvStock: TcxGridDBTableView
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              NavigatorButtons.ConfirmDelete = False
              OptionsView.GroupByBox = False
            end
            object cxGridLevel3: TcxGridLevel
              GridView = cxGridtvStock
            end
          end
        end
        object gbRecipe: TGroupBox
          Left = 0
          Top = 0
          Width = 511
          Height = 130
          Align = alTop
          Caption = 'xRite'#37197#26041#20449#24687
          TabOrder = 0
          object cxGrid1: TcxGrid
            Left = 2
            Top = 14
            Width = 507
            Height = 114
            Align = alClient
            TabOrder = 0
            object cxGridtvRecipe: TcxGridDBTableView
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              NavigatorButtons.ConfirmDelete = False
              OptionsView.GroupByBox = False
            end
            object cxGrid1Level1: TcxGridLevel
              GridView = cxGridtvRecipe
            end
          end
        end
        object cxSplitter3: TcxSplitter
          Left = 0
          Top = 130
          Width = 511
          Height = 8
          HotZoneClassName = 'TcxXPTaskBarStyle'
          AlignSplitter = salTop
          Control = gbRecipe
        end
        object cxSplitter4: TcxSplitter
          Left = 0
          Top = 258
          Width = 511
          Height = 8
          HotZoneClassName = 'TcxXPTaskBarStyle'
          AlignSplitter = salTop
          Control = gbLab
        end
      end
    end
    object pnRight: TPanel
      Left = 519
      Top = 45
      Width = 219
      Height = 502
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 3
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 219
        Height = 83
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 10
          Width = 60
          Height = 12
          Caption = #32568#21495'/'#33394#21495':'
        end
        object Label3: TLabel
          Left = 16
          Top = 35
          Width = 60
          Height = 12
          Caption = #32568#21495'/'#33394#21495':'
        end
        object edtColorCode1: TEdit
          Left = 75
          Top = 5
          Width = 121
          Height = 20
          Hint = #20026#31354#26102#20026#22797#21512#26597#35810
          CharCase = ecUpperCase
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object btnDiff: TBitBtn
          Left = 17
          Top = 55
          Width = 182
          Height = 25
          Caption = #27604#36739'(&C)'
          TabOrder = 2
          OnClick = btnDiffClick
          Glyph.Data = {
            B6040000424DB604000000000000360000002800000015000000120000000100
            1800000000008004000000000000000000000000000000000000C8D0D4C8D0D4
            C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
            D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D400C8D0D4C8D0D4
            C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4AEB2CF3F37A83E37A83E37
            A83E37A83E37A83E37A83E37A83E37A82D259BC8D0D4C8D0D400C8D0D4C8D0D4
            C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D49899CCA19FCC9C99CC9C99
            CC9793CB9793CB928ECA9590CB9692CB3E37A8C8D0D4C8D0D400C8D0D4C8D0D4
            C8D0D4C8D0D4A2A6A89CA0A29CA0A29CA0A29CA0A28281B3A7A5CD5B569A4F4B
            8E8B87B88782B8847FB78782B88E89C13E37A8C8D0D4C8D0D400C8D0D4C8D0D4
            C8D0D459A83F35971035970F35970F35970F35970F52806AABA9CD5C47845705
            2755041C55041C55041C55041C6461883F37A8C8D0D4C8D0D400C8D0D4C8D0D4
            C8D0D46EB551A9D898A9D898A7D795A5D792A3D68F8BA3AAB0AECE5D54959801
            0EA10109A10109A10109A101097975A43F37A8C8D0D4C8D0D400C8D0D4C8D0D4
            C8D0D46EB55186B2746BA15788B97688B37781AA72859CA4B6B4CF615D9C622D
            629E010A850B153F2C474B4681938EC83F37A8C8D0D4C8D0D400C8D0D4C8D0D4
            C8D0D471B45886B274689A546A7B416E0F084D2A15657A84BAB8D06A65C06762
            BF63328599021396050D4925417E7BAB3F37A8C8D0D4C8D0D400C8D0D4C8D0D4
            C8D0D477B45E88B276689A547075418B01075C23156B7F85B8B6CF6D68BF5D57
            985647725A3D859802118D06106563863F37A8C8D0D4C8D0D400C8D0D4C8D0D4
            C8D0D47AB5618CB37C6697536E713F8B01075D24166E8187C0BED17266B99F01
            0B8E0911492C41960D179C010A7371993F37A8C8D0D4C8D0D400C8D0D4C8D0D4
            C8D0D47DB66594B97C6D794B635F378B0107602B1879968BC2C0D26F69C58F3F
            6A9F010BA10109A0030B9550669895C43E37A8C8D0D4C8D0D400C8D0D4C8D0D4
            C8D0D47DB46899AF798B01077612138B0107612B197B978BC2C0D2564FC16F69
            C57366BA5F4781887DA97772C65750C23129A7C8D0D4C8D0D400C8D0D4C8D0D4
            C8D0D481B56D9DC8896F6F278410098B01075E24177C8F8BC2C0D2C2C0D2C2C0
            D2BEBCD1BBB9D0B7B5CF7670C6342BB19DA1C2C8D0D4C8D0D400C8D0D4C8D0D4
            C8D0D484B4728ACB71AED89D78A1488713116641239CAAB0AAA7CEA5A2CDA5A2
            CD9F9BCD9895CB9591CB6760C49DA1C2C8D0D4C8D0D4C8D0D400C8D0D4C8D0D4
            C8D0D486B4738ACB7185CF686CC4498FB4806C9B599AC88873C55465C242709C
            64C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D400C8D0D4C8D0D4
            C8D0D489B378B8D0AEB8D0AEB8D0AEB3CEA7B2CEA798C7856DC64B63AA4BC8D0
            D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D400C8D0D4C8D0D4
            C8D0D46DA65882B46F84B4717EB6677DB66679B6616CB25174BB5DC8D0D4C8D0
            D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D400C8D0D4C8D0D4
            C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0
            D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D400}
        end
        object edtColorCode2: TEdit
          Left = 75
          Top = 30
          Width = 121
          Height = 20
          Hint = #20026#31354#26102#20026#22797#21512#26597#35810
          CharCase = ecUpperCase
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
      end
      object GroupBox7: TGroupBox
        Left = 0
        Top = 83
        Width = 219
        Height = 419
        Align = alClient
        Caption = ' '#27604#36739#20540
        TabOrder = 1
        object cxGrid5: TcxGrid
          Left = 2
          Top = 14
          Width = 215
          Height = 403
          Align = alClient
          TabOrder = 0
          object cxGridtvDiff: TcxGridDBTableView
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NavigatorButtons.ConfirmDelete = False
            OptionsView.GroupByBox = False
          end
          object cxGridLevel4: TcxGridLevel
            GridView = cxGridtvDiff
          end
        end
      end
    end
    object cxSplitter1: TcxSplitter
      Left = 511
      Top = 45
      Width = 8
      Height = 502
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salRight
      Control = pnRight
    end
  end
  object cxSplitter2: TcxSplitter
    Left = 189
    Top = 0
    Width = 8
    Height = 547
    HotZoneClassName = 'TcxXPTaskBarStyle'
    Control = PageControl1
  end
  object cdsPub: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 54
    Top = 155
  end
  object msDataColor: TMakeSQL
    Caption = #26597#35810#26465#20214#32534#36753
    ItemNames = <
      item
        ParaCaption = #33394#21495
        ParaName = 'Item_NO'
        SelectPoint.Strings = (
          '='
          '<>'
          '>'
          '<'
          '>='
          '<='
          'like'
          'is Null'
          'is Not Null')
      end>
    Left = 501
    Top = 11
  end
  object TimerUpload: TTimer
    Interval = 1800000
    OnTimer = TimerUploadTimer
    Left = 124
    Top = 79
  end
  object cdsStock: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 431
    Top = 514
  end
  object cdsRecipe: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 410
    Top = 219
  end
  object cdsColor: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 316
    Top = 106
  end
  object cdsLab: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 342
    Top = 365
  end
  object dsRecipe: TDataSource
    DataSet = cdsRecipe
    Left = 470
    Top = 220
  end
  object dsColor: TDataSource
    DataSet = cdsColor
    Left = 375
    Top = 108
  end
  object dsLab: TDataSource
    DataSet = cdsLab
    Left = 396
    Top = 368
  end
  object dsStock: TDataSource
    DataSet = cdsStock
    Left = 493
    Top = 512
  end
  object cdsDiff: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 851
    Top = 259
  end
  object dsDiff: TDataSource
    DataSet = cdsDiff
    Left = 897
    Top = 265
  end
end

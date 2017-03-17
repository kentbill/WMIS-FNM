object DisposeAccidentForm: TDisposeAccidentForm
  Left = 280
  Top = 75
  Width = 868
  Height = 513
  Caption = #22788#29702#22788#29702#21333
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object pnl1: TPanel
    Left = 0
    Top = 472
    Width = 852
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
  end
  object cxSplitter1: TcxSplitter
    Left = 388
    Top = 0
    Width = 8
    Height = 472
    HotZoneClassName = 'TcxXPTaskBarStyle'
    AlignSplitter = salRight
    Control = pnlRight
  end
  object pnlRight: TPanel
    Left = 396
    Top = 0
    Width = 456
    Height = 472
    Align = alRight
    BevelInner = bvLowered
    Caption = 'pnlRight'
    TabOrder = 2
    object TPanel
      Left = 2
      Top = 2
      Width = 452
      Height = 371
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        452
        371)
      object Label1: TLabel
        Left = 9
        Top = 14
        Width = 30
        Height = 12
        Caption = #21333#21495':'
      end
      object Label2: TLabel
        Left = 9
        Top = 36
        Width = 30
        Height = 12
        Caption = #24037#24207':'
      end
      object Label3: TLabel
        Left = 9
        Top = 58
        Width = 42
        Height = 12
        Caption = #30133#28857#21517':'
      end
      object Label4: TLabel
        Left = 371
        Top = 12
        Width = 54
        Height = 12
        Caption = #30133#28857#23646#24615':'
      end
      object Label6: TLabel
        Left = 9
        Top = 80
        Width = 42
        Height = 12
        Caption = #21457#29616#28857':'
      end
      object Label7: TLabel
        Left = 9
        Top = 100
        Width = 30
        Height = 12
        Caption = #30721#38271':'
      end
      object Label8: TLabel
        Left = 9
        Top = 120
        Width = 30
        Height = 12
        Caption = #31867#22411':'
      end
      object Label9: TLabel
        Left = 9
        Top = 145
        Width = 54
        Height = 12
        Caption = #36131#20219#24037#24207':'
      end
      object Label10: TLabel
        Left = 229
        Top = 146
        Width = 54
        Height = 12
        Caption = #22788#29702#32467#26524':'
      end
      object Label5: TLabel
        Left = 9
        Top = 166
        Width = 30
        Height = 12
        Caption = #31867#22411':'
      end
      object Label11: TLabel
        Left = 232
        Top = 169
        Width = 30
        Height = 12
        Caption = #21407#22240':'
      end
      object Label12: TLabel
        Left = 9
        Top = 189
        Width = 54
        Height = 12
        Caption = #22788#29702#22791#27880':'
      end
      object edt_BeforeAfter: TEdit
        Left = 64
        Top = 72
        Width = 155
        Height = 20
        TabStop = False
        ParentColor = True
        ReadOnly = True
        TabOrder = 6
      end
      object edt_DefectName: TEdit
        Left = 64
        Top = 50
        Width = 155
        Height = 20
        TabStop = False
        ParentColor = True
        ReadOnly = True
        TabOrder = 3
      end
      object edt_Quantity: TEdit
        Left = 64
        Top = 94
        Width = 155
        Height = 20
        TabStop = False
        ParentColor = True
        ReadOnly = True
        TabOrder = 2
      end
      object edt_Operation_Name: TEdit
        Left = 64
        Top = 28
        Width = 155
        Height = 20
        TabStop = False
        ParentColor = True
        ReadOnly = True
        TabOrder = 1
      end
      object edt_AccidentNO: TEdit
        Left = 64
        Top = 6
        Width = 155
        Height = 20
        TabStop = False
        ParentColor = True
        ReadOnly = True
        TabOrder = 0
      end
      object cbb_QualityOperation: TComboBox
        Left = 65
        Top = 142
        Width = 155
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 4
      end
      object vle_RepairReasonList: TValueListEditor
        Left = 229
        Top = 28
        Width = 216
        Height = 108
        Color = clMenu
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goAlwaysShowEditor, goThumbTracking]
        TabOrder = 5
        TitleCaptions.Strings = (
          #23646#24615#21517
          #23646#24615#20540)
        ColWidths = (
          89
          121)
      end
      object cbb_ReasonType: TComboBox
        Left = 65
        Top = 164
        Width = 155
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 7
        OnSelect = cbb_ReasonTypeSelect
      end
      object cbb_ReasonName: TComboBox
        Left = 290
        Top = 162
        Width = 155
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 8
      end
      object cbb_Idea: TComboBox
        Left = 290
        Top = 140
        Width = 155
        Height = 20
        Style = csDropDownList
        BiDiMode = bdLeftToRight
        ItemHeight = 12
        ParentBiDiMode = False
        TabOrder = 9
        OnSelect = cbb_IdeaSelect
      end
      object gbOperation: TGroupBox
        Left = 0
        Top = 208
        Width = 452
        Height = 163
        Align = alBottom
        Caption = #22238#20462#24037#24207
        TabOrder = 10
        object lbOperation: TListBox
          Left = 121
          Top = 14
          Width = 128
          Height = 147
          Align = alLeft
          ItemHeight = 12
          TabOrder = 0
          OnDrawItem = lbOperationDrawItem
        end
        object TPanel
          Left = 249
          Top = 14
          Width = 30
          Height = 147
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 1
          object btnMoveUpOperation: TSpeedButton
            Left = 4
            Top = 55
            Width = 24
            Height = 24
            Hint = #19978#31227'|'#23558#24403#21069#21152#24037#24037#24207#19978#31227#19968#27493
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
            OnClick = btnMoveUpOperationClick
          end
          object btnMoveDownOperation: TSpeedButton
            Left = 4
            Top = 82
            Width = 24
            Height = 24
            Hint = #19979#31227'|'#23558#24403#21069#21152#24037#24037#24207#19979#31227#19968#27493
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
            OnClick = btnMoveDownOperationClick
          end
          object btnDelOperation: TSpeedButton
            Left = 3
            Top = 26
            Width = 24
            Height = 24
            Hint = #21024#38500'|'#21024#38500#24403#21069#24037#24207
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
            OnClick = btnDelOperationClick
          end
          object btnAddOperation: TSpeedButton
            Left = 3
            Top = 0
            Width = 24
            Height = 24
            Hint = #28155#21152'|'#28155#21152#36873#25321#30340#24037#24207
            Flat = True
            Glyph.Data = {
              DE000000424DDE0000000000000076000000280000000D0000000D0000000100
              0400000000006800000000000000000000001000000000000000000000000000
              BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
              7000777777077777700077777007777770007777060777777000777066000007
              7000770666666607700070666666660770007706666666077000777066000007
              7000777706077777700077777007777770007777770777777000777777777777
              7000}
            OnClick = btnAddOperationClick
          end
        end
        object cbbOperation: TComboBox
          Left = 278
          Top = 8
          Width = 167
          Height = 113
          Style = csSimple
          ItemHeight = 12
          TabOrder = 2
          OnKeyDown = cbbOperationKeyDown
        end
        object clbCardList: TCheckListBox
          Left = 2
          Top = 14
          Width = 119
          Height = 147
          Align = alLeft
          ItemHeight = 12
          TabOrder = 3
        end
      end
      object edtRemark: TEdit
        Left = 64
        Top = 186
        Width = 380
        Height = 20
        TabOrder = 11
      end
      object btnSaveRemark: TBitBtn
        Left = 229
        Top = 3
        Width = 76
        Height = 25
        Hint = #22686#21152#36136#37327#25805#20316#22788#29702#26041#26696
        Anchors = [akRight, akBottom]
        Caption = #22788#29702#24847#35265'(&A)'
        Default = True
        ParentShowHint = False
        ShowHint = True
        TabOrder = 12
        OnClick = btnSaveRemarkClick
      end
      object btQueryRemark: TBitBtn
        Left = 309
        Top = 3
        Width = 52
        Height = 25
        Hint = #22686#21152#36136#37327#25805#20316#22788#29702#26041#26696
        Anchors = [akRight, akBottom]
        Caption = #26597#35810
        Default = True
        ParentShowHint = False
        ShowHint = True
        TabOrder = 13
        OnClick = btQueryRemarkClick
      end
      object cbb_Class: TComboBox
        Left = 64
        Top = 117
        Width = 155
        Height = 20
        Style = csDropDownList
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ItemHeight = 12
        TabOrder = 14
        Items.Strings = (
          #25805#20316
          #24037#33402
          #35774#22791
          #22383#24067
          #20854#20182)
      end
    end
    object TPanel
      Left = 2
      Top = 441
      Width = 452
      Height = 29
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        452
        29)
      object btn_Save: TBitBtn
        Left = 293
        Top = 3
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        Default = True
        TabOrder = 0
        OnClick = btn_SaveClick
      end
      object btn_Exit: TBitBtn
        Left = 381
        Top = 3
        Width = 75
        Height = 25
        Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
        Anchors = [akRight, akBottom]
        Cancel = True
        Caption = #36864#20986'(&X)'
        TabOrder = 1
        OnClick = btn_ExitClick
      end
      object cbHold: TCheckBox
        Left = 6
        Top = 9
        Width = 132
        Height = 16
        Caption = #20840#36873'/'#21462#28040' (HOLD)'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = cbHoldClick
      end
      object btn_Refresh: TBitBtn
        Left = 125
        Top = 4
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #21047#26032'(&R)'
        Default = True
        TabOrder = 3
        OnClick = btn_RefreshClick
      end
      object btnSubmit: TBitBtn
        Left = 205
        Top = 4
        Width = 75
        Height = 25
        Hint = #26412#32423#20154#21592#26080#26435#22788#29702#65292#21521#19978#19968#32423#31649#29702#20154#21592#25552#20132
        Anchors = [akRight, akBottom]
        Caption = #25552#20132#22788#29702'(&B)'
        Default = True
        TabOrder = 4
        OnClick = btnSubmitClick
      end
    end
    object GroupBox1: TGroupBox
      Left = 2
      Top = 373
      Width = 452
      Height = 68
      Align = alClient
      Caption = #21253#21547#30340#21345#21495'('#35299#38500'HOLD'#35831#25171#21246'):'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object lv_Card: TListView
        Left = 2
        Top = 14
        Width = 448
        Height = 52
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            Caption = #21345#21495
            Width = 100
          end
          item
            Caption = #21697#21517
            Width = 150
          end
          item
            Caption = #35299#38500#20154
            Width = 150
          end>
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        GridLines = True
        ReadOnly = True
        RowSelect = True
        ParentFont = False
        TabOrder = 0
        ViewStyle = vsReport
        OnCustomDrawItem = lv_CardCustomDrawItem
      end
    end
  end
  object tbcAccident: TTabControl
    Left = 0
    Top = 0
    Width = 388
    Height = 472
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 3
    Tabs.Strings = (
      #25805#20316#29677#38271'(&0)'
      #26426#21488#31649#29702#21592'(&1)'
      #25805#20316#20027#20219'(&2)'
      #37096#38376#32463#29702'(&3)')
    TabIndex = 0
    OnChange = tbcAccidentChange
    object gbLeft: TGroupBox
      Left = 4
      Top = 26
      Width = 380
      Height = 442
      Align = alClient
      Caption = #24453#22788#29702#21333#21495
      TabOrder = 0
      object cxgrid_AccidentList: TcxGrid
        Left = 2
        Top = 14
        Width = 376
        Height = 426
        Align = alClient
        TabOrder = 0
        object cxgtv_AccidentList: TcxGridTableView
          OnKeyDown = KeyDownAControl
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
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
        end
        object cxGridl_AccidentList: TcxGridLevel
          GridView = cxgtv_AccidentList
        end
      end
    end
  end
  object cdsAccident: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 240
    Top = 264
  end
  object dsAccident: TDataSource
    DataSet = cdsAccident
    Left = 216
    Top = 232
  end
end

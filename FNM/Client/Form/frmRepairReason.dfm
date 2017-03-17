object RepairReasonFrm: TRepairReasonFrm
  Left = 61
  Top = 131
  BorderStyle = bsDialog
  Caption = #22238#20462#21407#22240#32500#25252
  ClientHeight = 501
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 800
    Height = 305
    Align = alTop
    TabOrder = 0
    DesignSize = (
      800
      305)
    object btnAdd: TSpeedButton
      Left = 463
      Top = 275
      Width = 80
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #26032#22686
      Flat = True
      Glyph.Data = {
        66010000424D6601000000000000760000002800000015000000140000000100
        040000000000F0000000130B0000130B00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFF000FFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFF000FFFF
        FFFFFFFFFFFFFFFFF000FFFFF00000000000FFFFF000FFFFF0FFFFFFFFF0FFFF
        F000FFFFF0FFFFFFFFF0FFFFF000FFFFF0FFFFFFFFF0FFFFF000FFFFF0FFFFFF
        FFF0FFFFF000FFFFF0FFFFFFFFF0FFFFF000FFFFF0FFFFFFFFF0FFFFF000FFFF
        F0FFFFFFFFF0FFFFF000FFFFF0FFFFFFFFF0FFFFF000FFFFF0FFFFFF0000FFFF
        F000FFFFF0FFFFFF0F0FFFFFF000FFFFF0FFFFFF00FFFFFFF000FFFFF0000000
        0FFFFFFFF000FFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFF000FFFF
        FFFFFFFFFFFFFFFFF000}
      OnClick = btnAddClick
    end
    object btnEdit: TSpeedButton
      Left = 547
      Top = 275
      Width = 80
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #32534#36753
      Flat = True
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F0000000130B0000130B00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFC0C0FFFFFFFFFFFFFFFFFFFFC0C0FFFFFFFFFFFFFFFFFFFFC0C0FFFF
        F0F0F0F0FFFFFFFFC0C0FFFFFFFFFFF00FFFFFFFC0C0FFFFFFFFFFF000FFFFFF
        C0C0FFF000000000B70FFFFFC0C0FFF0FFFFFFF0B80FFFFFC0C0FFF0F00F00F0
        0B70FFFFC0C0FFF0FFFFFFFF0B80FFFFC0C0FFF0CCCCCCCCC0B70FFFC0C0FFFF
        CFFFFFFFF0B00FFFC0C0FFFFCF00F00F000110FFC0C0FFFFCFFFFFFFFF000FFF
        C0C0FFFFCCCCCCCCCCCCFFFFC0C0FFFFC8CC8CC8CC8CFFFFC0C0FFFFCCCCCCCC
        CCCCFFFFC0C0FFFFFFFFFFFFFFFFFFFFC0C0FFFFFFFFFFFFFFFFFFFFC0C0FFFF
        FFFFFFFFFFFFFFFFC0C0}
      OnClick = btnEditClick
    end
    object btnDelete: TSpeedButton
      Left = 631
      Top = 275
      Width = 80
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #21024#38500
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
        FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00
        FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00
        FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000000000000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      OnClick = btnDeleteClick
    end
    object btnSave: TSpeedButton
      Left = 714
      Top = 275
      Width = 80
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #20445#23384
      Enabled = False
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FF00FF00FF00FF000000
        0000FFFF0000FFFF000000000000000000000000000000000000000000000000
        0000C6C6C600C6C6C60000000000FFFF000000000000FF00FF00FF00FF000000
        0000FFFF0000FFFF000000000000000000000000000000000000000000000000
        0000C6C6C600C6C6C60000000000FFFF000000000000FF00FF00FF00FF000000
        0000FFFF0000FFFF000000000000000000000000000000000000000000000000
        0000C6C6C600C6C6C60000000000FFFF000000000000FF00FF00FF00FF000000
        0000FFFF0000FFFF000000000000000000000000000000000000000000000000
        0000000000000000000000000000FFFF000000000000FF00FF00FF00FF000000
        0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
        0000FFFF0000FFFF0000FFFF0000FFFF000000000000FF00FF00FF00FF000000
        0000FFFF0000FFFF000000000000000000000000000000000000000000000000
        00000000000000000000FFFF0000FFFF000000000000FF00FF00FF00FF000000
        0000FFFF000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
        C600C6C6C600C6C6C60000000000FFFF000000000000FF00FF00FF00FF000000
        0000FFFF000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
        C600C6C6C600C6C6C60000000000FFFF000000000000FF00FF00FF00FF000000
        0000FFFF000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
        C600C6C6C600C6C6C60000000000FFFF000000000000FF00FF00FF00FF000000
        0000FFFF000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
        C600C6C6C600C6C6C60000000000FFFF000000000000FF00FF00FF00FF000000
        0000FFFF000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
        C600C6C6C600C6C6C600000000000000000000000000FF00FF00FF00FF000000
        0000FFFF000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
        C600C6C6C600C6C6C60000000000FF00FF0000000000FF00FF00FF00FF000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      OnClick = btnSaveClick
    end
    object Label4: TLabel
      Left = 466
      Top = 162
      Width = 54
      Height = 12
      Caption = #21407#22240#32534#21495':'
    end
    object Label5: TLabel
      Left = 466
      Top = 186
      Width = 54
      Height = 12
      Caption = #22238#20462#31867#22411':'
    end
    object Label6: TLabel
      Left = 466
      Top = 210
      Width = 54
      Height = 12
      Caption = #22238#20462#21407#22240':'
    end
    object Label7: TLabel
      Left = 635
      Top = 210
      Width = 42
      Height = 12
      Caption = #20027#24037#24207':'
    end
    object Label8: TLabel
      Left = 635
      Top = 162
      Width = 30
      Height = 12
      Caption = #31867#22411':'
    end
    object Label9: TLabel
      Left = 635
      Top = 186
      Width = 54
      Height = 12
      Caption = #36131#20219#37096#38376':'
    end
    object Label10: TLabel
      Left = 466
      Top = 232
      Width = 30
      Height = 12
      Caption = #22791#27880':'
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 456
      Height = 303
      Align = alLeft
      Caption = #22238#23487#21407#22240#21015#34920
      TabOrder = 0
      object lvMaster: TListView
        Left = 2
        Top = 14
        Width = 452
        Height = 283
        Align = alTop
        Columns = <
          item
            Caption = #21407#22240#32534#21495
            Width = 60
          end
          item
            Caption = #22238#20462#31867#22411
            Width = 60
          end
          item
            Caption = #22238#20462#21407#22240
            Width = 60
          end
          item
            Caption = #31867#22411
          end
          item
            Caption = #36131#20219#37096#38376
            Width = 60
          end
          item
            Caption = #20027#24037#24207
          end
          item
            Caption = #22791#27880
          end
          item
            Caption = #26159#21542#26377#25928
            Width = 60
          end
          item
            Caption = #22238#20462#24037#24207
          end>
        ColumnClick = False
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnChange = lvMasterChange
      end
    end
    object edtReasonCode: TEdit
      Left = 521
      Top = 154
      Width = 103
      Height = 20
      ParentColor = True
      ReadOnly = True
      TabOrder = 1
    end
    object cbReasonType: TComboBox
      Left = 521
      Top = 178
      Width = 103
      Height = 20
      ItemHeight = 12
      TabOrder = 2
    end
    object edtReasonInfo: TEdit
      Left = 521
      Top = 202
      Width = 103
      Height = 20
      TabOrder = 3
    end
    object cbOperationCode: TComboBox
      Left = 689
      Top = 202
      Width = 103
      Height = 20
      ItemHeight = 12
      TabOrder = 4
    end
    object cbQualityType: TComboBox
      Left = 689
      Top = 154
      Width = 103
      Height = 20
      ItemHeight = 12
      TabOrder = 5
    end
    object moRemark: TMemo
      Left = 521
      Top = 226
      Width = 272
      Height = 27
      TabOrder = 6
    end
    object chbIsActive: TCheckBox
      Left = 521
      Top = 256
      Width = 97
      Height = 17
      Caption = #26159#21542#26377#25928
      Checked = True
      State = cbChecked
      TabOrder = 7
    end
    object gbOperation: TGroupBox
      Left = 465
      Top = 3
      Width = 327
      Height = 145
      Caption = #22238#20462#24037#24207
      TabOrder = 8
      object lbOperation: TListBox
        Left = 2
        Top = 14
        Width = 143
        Height = 129
        Align = alLeft
        ItemHeight = 12
        TabOrder = 0
        OnDrawItem = lbOperationDrawItem
      end
      object TPanel
        Left = 145
        Top = 14
        Width = 30
        Height = 129
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object btnMoveUpOperation: TSpeedButton
          Left = 4
          Top = 61
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
          Top = 88
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
          Top = 32
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
          Top = 6
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
        Left = 174
        Top = 8
        Width = 151
        Height = 129
        Style = csSimple
        ItemHeight = 12
        TabOrder = 2
        OnKeyDown = cbbOperationKeyDown
      end
    end
    object edtDepartment: TComboBox
      Left = 689
      Top = 178
      Width = 103
      Height = 20
      ItemHeight = 12
      MaxLength = 2
      TabOrder = 9
      Items.Strings = (
        '  '
        'FN'
        'OT'
        'QI')
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 305
    Width = 800
    Height = 196
    Align = alClient
    TabOrder = 1
    object GroupBox2: TGroupBox
      Left = 1
      Top = 1
      Width = 798
      Height = 194
      Align = alClient
      Caption = #26126#32454#21015#34920
      TabOrder = 0
      DesignSize = (
        798
        194)
      object sbAdd: TSpeedButton
        Left = 462
        Top = 164
        Width = 80
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #26032#22686
        Flat = True
        Glyph.Data = {
          66010000424D6601000000000000760000002800000015000000140000000100
          040000000000F0000000130B0000130B00001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
          FFFFFFFFF000FFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFF000FFFF
          FFFFFFFFFFFFFFFFF000FFFFF00000000000FFFFF000FFFFF0FFFFFFFFF0FFFF
          F000FFFFF0FFFFFFFFF0FFFFF000FFFFF0FFFFFFFFF0FFFFF000FFFFF0FFFFFF
          FFF0FFFFF000FFFFF0FFFFFFFFF0FFFFF000FFFFF0FFFFFFFFF0FFFFF000FFFF
          F0FFFFFFFFF0FFFFF000FFFFF0FFFFFFFFF0FFFFF000FFFFF0FFFFFF0000FFFF
          F000FFFFF0FFFFFF0F0FFFFFF000FFFFF0FFFFFF00FFFFFFF000FFFFF0000000
          0FFFFFFFF000FFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFF000FFFF
          FFFFFFFFFFFFFFFFF000}
        OnClick = sbAddClick
      end
      object sbEdit: TSpeedButton
        Left = 546
        Top = 164
        Width = 80
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #32534#36753
        Flat = True
        Glyph.Data = {
          66010000424D6601000000000000760000002800000014000000140000000100
          040000000000F0000000130B0000130B00001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
          FFFFFFFFC0C0FFFFFFFFFFFFFFFFFFFFC0C0FFFFFFFFFFFFFFFFFFFFC0C0FFFF
          F0F0F0F0FFFFFFFFC0C0FFFFFFFFFFF00FFFFFFFC0C0FFFFFFFFFFF000FFFFFF
          C0C0FFF000000000B70FFFFFC0C0FFF0FFFFFFF0B80FFFFFC0C0FFF0F00F00F0
          0B70FFFFC0C0FFF0FFFFFFFF0B80FFFFC0C0FFF0CCCCCCCCC0B70FFFC0C0FFFF
          CFFFFFFFF0B00FFFC0C0FFFFCF00F00F000110FFC0C0FFFFCFFFFFFFFF000FFF
          C0C0FFFFCCCCCCCCCCCCFFFFC0C0FFFFC8CC8CC8CC8CFFFFC0C0FFFFCCCCCCCC
          CCCCFFFFC0C0FFFFFFFFFFFFFFFFFFFFC0C0FFFFFFFFFFFFFFFFFFFFC0C0FFFF
          FFFFFFFFFFFFFFFFC0C0}
        OnClick = sbEditClick
      end
      object sbDelete: TSpeedButton
        Left = 630
        Top = 164
        Width = 80
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #21024#38500
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
          FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF0000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00
          FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00
          FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00
          FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000000000000000000000000000FF00FF00FF00FF00FF00
          FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF0000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00
          FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        OnClick = sbDeleteClick
      end
      object sbSave: TSpeedButton
        Left = 713
        Top = 164
        Width = 80
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384
        Enabled = False
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000FF00FF00FF00FF000000
          0000FFFF0000FFFF000000000000000000000000000000000000000000000000
          0000C6C6C600C6C6C60000000000FFFF000000000000FF00FF00FF00FF000000
          0000FFFF0000FFFF000000000000000000000000000000000000000000000000
          0000C6C6C600C6C6C60000000000FFFF000000000000FF00FF00FF00FF000000
          0000FFFF0000FFFF000000000000000000000000000000000000000000000000
          0000C6C6C600C6C6C60000000000FFFF000000000000FF00FF00FF00FF000000
          0000FFFF0000FFFF000000000000000000000000000000000000000000000000
          0000000000000000000000000000FFFF000000000000FF00FF00FF00FF000000
          0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
          0000FFFF0000FFFF0000FFFF0000FFFF000000000000FF00FF00FF00FF000000
          0000FFFF0000FFFF000000000000000000000000000000000000000000000000
          00000000000000000000FFFF0000FFFF000000000000FF00FF00FF00FF000000
          0000FFFF000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
          C600C6C6C600C6C6C60000000000FFFF000000000000FF00FF00FF00FF000000
          0000FFFF000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
          C600C6C6C600C6C6C60000000000FFFF000000000000FF00FF00FF00FF000000
          0000FFFF000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
          C600C6C6C600C6C6C60000000000FFFF000000000000FF00FF00FF00FF000000
          0000FFFF000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
          C600C6C6C600C6C6C60000000000FFFF000000000000FF00FF00FF00FF000000
          0000FFFF000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
          C600C6C6C600C6C6C600000000000000000000000000FF00FF00FF00FF000000
          0000FFFF000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
          C600C6C6C600C6C6C60000000000FF00FF0000000000FF00FF00FF00FF000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        OnClick = sbSaveClick
      end
      object Label1: TLabel
        Left = 7
        Top = 145
        Width = 30
        Height = 12
        Caption = #21517#31216':'
      end
      object Label2: TLabel
        Left = 151
        Top = 145
        Width = 18
        Height = 12
        Caption = #20540':'
      end
      object Label3: TLabel
        Left = 176
        Top = 164
        Width = 140
        Height = 13
        Caption = '('#20540#20026#26522#20030#21464#37327#26102#29992' /  '#38548#24320')'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object sbPreview: TSpeedButton
        Left = 768
        Top = 135
        Width = 24
        Height = 24
        Hint = #19979#31227'|'#23558#24403#21069#21152#24037#24037#24207#19979#31227#19968#27493
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
          07070707070707070707070000000000000000000000070700000700FFFFFFFF
          FFFF00000000A40000070700FFFFFFFFFFFFA40707A400A407070700FFFFFFFF
          FF000707FEA4A40007070700FFFFFFFFFF00070707A4070007070700FFFFFFFF
          FF00FE0707A4070007070700FFFFFFFFFF00FEFE07A4A40007070700FFFFFFFF
          FFFFA40707A4000707070700FFFFFFFFFFFF00000000070707070700FFFFFFFF
          FFFF00000000070707070700FFFFFFFFFFFF00070007070707070700FFFFFFFF
          FFFF000007070707070707000000000000000007070707070707}
        OnClick = sbPreviewClick
      end
      object lvDetail: TListView
        Left = 2
        Top = 14
        Width = 794
        Height = 115
        Align = alTop
        Columns = <
          item
            Caption = #32534#21495
            Width = 0
          end
          item
            Caption = #21517#31216
            Width = 100
          end
          item
            Caption = #20540
            Width = 690
          end>
        ColumnClick = False
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnChange = lvDetailChange
      end
      object edtItemName: TEdit
        Left = 40
        Top = 137
        Width = 97
        Height = 20
        Enabled = False
        TabOrder = 1
      end
      object edtItemValue: TEdit
        Left = 176
        Top = 137
        Width = 589
        Height = 20
        Enabled = False
        TabOrder = 2
      end
    end
  end
end

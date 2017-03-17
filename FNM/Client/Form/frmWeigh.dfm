inherited WeighForm: TWeighForm
  Left = 83
  Top = 139
  Width = 1280
  Height = 633
  Caption = #21270#26009#31216#37325
  OldCreateOrder = True
  Scaled = False
  WindowState = wsMaximized
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object nbWeigh: TNotebook
    Left = 0
    Top = 0
    Width = 1272
    Height = 599
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object TPage
      Left = 0
      Top = 0
      Caption = 'Main'
      object lvChemical: TListView
        Left = 0
        Top = 257
        Width = 1272
        Height = 183
        Align = alClient
        Columns = <
          item
            Caption = #21270#26009'ID'
            Width = 100
          end
          item
            Caption = #21270#26009#21517#31216
            Width = 300
          end
          item
            Caption = #37325'  '#37327
            Width = 120
          end
          item
            Caption = #23454#38469#31216#37325
            Width = 120
          end
          item
            Caption = #21333#20301
            Width = 80
          end
          item
            Caption = 'Barcode'
            Width = 150
          end>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = #23435#20307
        Font.Style = []
        GridLines = True
        HideSelection = False
        HotTrack = True
        ReadOnly = True
        RowSelect = True
        ParentFont = False
        TabOrder = 1
        ViewStyle = vsReport
        OnChange = lvChemicalChange
        OnClick = lvChemicalClick
        OnDblClick = lvChemicalDblClick
        OnKeyDown = lvChemicalKeyDown
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1272
        Height = 67
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label12: TLabel
          Left = 16
          Top = 6
          Width = 68
          Height = 27
          Caption = #21333#21495':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object edtBillNO: TEdit
          Left = 90
          Top = 3
          Width = 279
          Height = 35
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object btnQuery: TBitBtn
          Left = 385
          Top = 1
          Width = 119
          Height = 32
          Caption = #26597#35810'(&Q)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = btnQueryClick
        end
        object btnExit: TBitBtn
          Left = 650
          Top = 1
          Width = 119
          Height = 34
          Caption = #36864#20986'(&X)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = btnExitClick
        end
        object btnOption: TBitBtn
          Left = 781
          Top = 1
          Width = 119
          Height = 34
          Caption = #37197#32622'(&O)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = btnOptionClick
        end
        object btnPrint: TBitBtn
          Left = 519
          Top = 1
          Width = 119
          Height = 35
          Hint = #25353'Ctrl'#38190#28857#20987#26102#39044#35272#25253#34920
          Caption = #20445#23384'(F1)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = btnPrintClick
        end
        object msComm: TMSComm
          Left = 1088
          Top = 16
          Width = 32
          Height = 32
          ControlData = {
            2143341208000000ED030000ED03000001568A64000006000000010000040000
            00020000802500000000080000000000000000003F00000001000000}
        end
        object cboINI: TComboBox
          Left = 920
          Top = 16
          Width = 121
          Height = 20
          Enabled = False
          ItemHeight = 12
          TabOrder = 6
          OnChange = cboINIChange
        end
        object BitBtn1: TBitBtn
          Left = 1
          Top = 40
          Width = 96
          Height = 25
          Caption = #21047#26032'(&Q)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          OnClick = BitBtn1Click
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 440
        Width = 1272
        Height = 159
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        object Label13: TLabel
          Left = 23
          Top = 35
          Width = 68
          Height = 27
          Caption = #32568#21495':'
        end
        object Label14: TLabel
          Left = 272
          Top = 35
          Width = 68
          Height = 27
          Caption = #26426#21488':'
        end
        object Label15: TLabel
          Left = 20
          Top = 81
          Width = 96
          Height = 27
          Caption = #21270#26009'ID:'
        end
        object Label16: TLabel
          Left = 21
          Top = 126
          Width = 122
          Height = 27
          Caption = #21270#26009#21517#31216':'
        end
        object Label17: TLabel
          Left = 471
          Top = 31
          Width = 124
          Height = 27
          Caption = #37325'    '#37327':'
        end
        object Label18: TLabel
          Left = 473
          Top = 81
          Width = 122
          Height = 27
          Caption = #23454#38469#31216#37327':'
        end
        object edtBatchNO: TEdit
          Left = 145
          Top = 27
          Width = 115
          Height = 35
          CharCase = ecUpperCase
          TabOrder = 2
        end
        object edtMachineID: TEdit
          Left = 351
          Top = 27
          Width = 79
          Height = 35
          CharCase = ecUpperCase
          TabOrder = 3
        end
        object edtWeight: TEdit
          Left = 595
          Top = 23
          Width = 183
          Height = 35
          CharCase = ecUpperCase
          Color = clInfoBk
          TabOrder = 0
        end
        object edtFactWeight: TEdit
          Left = 595
          Top = 73
          Width = 183
          Height = 35
          CharCase = ecUpperCase
          Color = clLime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -27
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object edtUnit: TEdit
          Left = 784
          Top = 23
          Width = 60
          Height = 35
          Color = clInfoBk
          TabOrder = 1
        end
        object DateTimePicker1: TDateTimePicker
          Left = 597
          Top = 120
          Width = 186
          Height = 35
          CalAlignment = dtaLeft
          Date = 40945.4681853009
          Time = 40945.4681853009
          Color = clInfoBk
          DateFormat = dfShort
          DateMode = dmComboBox
          Kind = dtkDate
          ParseInput = False
          TabOrder = 5
        end
        object edtChemicalID: TEdit
          Left = 144
          Top = 80
          Width = 297
          Height = 35
          TabOrder = 6
        end
        object edtChemicalName: TEdit
          Left = 144
          Top = 123
          Width = 441
          Height = 35
          TabOrder = 7
        end
      end
      object btnWeigh: TBitBtn
        Left = 872
        Top = 295
        Width = 164
        Height = 138
        Caption = #31216#37325'(F4)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Visible = False
        OnClick = btnWeighClick
      end
      object cxgridOnline: TcxGrid
        Left = 0
        Top = 67
        Width = 1272
        Height = 190
        Align = alTop
        TabOrder = 4
        object cxGridVOnline: TcxGridDBTableView
          OnDblClick = cxGridVOnlineDblClick
          DataController.DataSource = dsOnline
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OnCustomDrawCell = cxGridVOnlineCustomDrawCell
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.GroupByBox = False
        end
        object cxGridlOnline: TcxGridLevel
          GridView = cxGridVOnline
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Barcode'
      object Label19: TLabel
        Left = 214
        Top = 99
        Width = 196
        Height = 56
        Caption = #21270#26009'ID:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -56
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label20: TLabel
        Left = 214
        Top = 192
        Width = 252
        Height = 56
        Caption = #21270#26009#21517#31216':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -56
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label21: TLabel
        Left = 214
        Top = 292
        Width = 252
        Height = 56
        Caption = #25195#25551#26465#30721':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -56
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object lbbarChemicalID: TLabel
        Left = 496
        Top = 99
        Width = 420
        Height = 56
        Caption = 'lbbarChemicalID'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -56
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object lbbarChemicalName: TLabel
        Left = 496
        Top = 192
        Width = 476
        Height = 56
        Caption = 'lbbarChemicalName'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -56
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object sbCancel: TSpeedButton
        Left = 497
        Top = 364
        Width = 213
        Height = 66
        Caption = #36820#22238'(F2)'
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
          0707070707070707070707070707070707070707070707070707070707070707
          0707070707070707070707070707070707070707070704070707070704040404
          0407070707070407070707070404040407070707070707040707070704040407
          0707070707070704070707070404070407070707070707040707070704070707
          0404070707070407070707070707070707070404040407070707070707070707
          0707070707070707070707070707070707070707070707070707070707070707
          0707070707070707070707070707070707070707070707070707}
        OnClick = sbCancelClick
      end
      object lbBarcode: TLabel
        Left = 499
        Top = 103
        Width = 28
        Height = 56
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -56
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object edtbarcode: TEdit
        Left = 496
        Top = 284
        Width = 211
        Height = 64
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -56
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnKeyDown = edtbarcodeKeyDown
        OnKeyPress = edtbarcodeKeyPress
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Weigh'
      object Gauge1: TGauge
        Left = 0
        Top = 499
        Width = 1272
        Height = 100
        Align = alClient
        BackColor = clBtnFace
        ForeColor = clLime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clFuchsia
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        Progress = 0
      end
      object pnlChemical: TPanel
        Left = 0
        Top = 97
        Width = 1272
        Height = 69
        Align = alTop
        BevelInner = bvLowered
        Color = clYellow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -56
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object pnlCaption: TPanel
        Left = 0
        Top = 0
        Width = 1272
        Height = 97
        Align = alTop
        Anchors = [akRight, akBottom]
        BevelOuter = bvNone
        Caption = #32568#21495':T1031013   '#26426#21488':N409'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -56
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object Panel5: TPanel
        Left = 0
        Top = 166
        Width = 1272
        Height = 186
        Align = alTop
        TabOrder = 2
        object Label10: TLabel
          Left = 121
          Top = 112
          Width = 140
          Height = 56
          Caption = #35774#23450':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -56
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 121
          Top = 35
          Width = 140
          Height = 56
          Caption = #31216#37325':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -56
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbUnit: TLabel
          Left = 905
          Top = 111
          Width = 28
          Height = 56
          Alignment = taCenter
          Caption = 'g'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -56
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbFactUnit: TLabel
          Left = 901
          Top = 26
          Width = 28
          Height = 56
          Alignment = taCenter
          Caption = 'g'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -56
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object pnlWeight: TPanel
          Left = 288
          Top = 96
          Width = 600
          Height = 80
          BevelInner = bvLowered
          Caption = '0.0'
          Color = clDefault
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clAqua
          Font.Height = -56
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object pnlFactWeight: TPanel
          Left = 288
          Top = 11
          Width = 600
          Height = 80
          BevelInner = bvLowered
          Caption = '0.0'
          Color = clDefault
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -56
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 352
        Width = 1272
        Height = 147
        Align = alTop
        TabOrder = 3
        object btnOK: TBitBtn
          Left = 444
          Top = 0
          Width = 370
          Height = 150
          Caption = #30830#23450'(F5)'
          Default = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -56
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = btnOKClick
          Layout = blGlyphTop
        end
        object btnHandle: TBitBtn
          Left = 70
          Top = 2
          Width = 370
          Height = 150
          Caption = #25163#21160#31216#37325'(F4)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -56
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = btnHandleClick
          Layout = blGlyphTop
        end
        object btnCancel: TBitBtn
          Left = 821
          Top = -1
          Width = 370
          Height = 150
          Caption = #21462#28040'(&F2)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -56
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = btnCancelClick
          Layout = blGlyphTop
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Option'
      object lvOption: TListView
        Left = 0
        Top = 0
        Width = 455
        Height = 599
        Align = alLeft
        Columns = <
          item
            Caption = #31216#31181
          end
          item
            Alignment = taCenter
            Caption = #31471#21475
          end
          item
            Alignment = taCenter
            Caption = #27874#29305#29575
          end
          item
            Alignment = taCenter
            Caption = #25968#25454#20301
          end
          item
            Alignment = taCenter
            Caption = #26657#39564#20301
          end
          item
            Alignment = taCenter
            Caption = #20572#27490#20301
          end
          item
            Alignment = taCenter
            Caption = #26368#23567#20540
          end
          item
            Alignment = taCenter
            Caption = #26368#22823#20540
          end
          item
            Alignment = taCenter
            Caption = #35823#24046'g'
          end>
        GridLines = True
        HideSelection = False
        HotTrack = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnChange = lvOptionChange
      end
      object GroupBox1: TGroupBox
        Left = 455
        Top = 0
        Width = 817
        Height = 599
        Align = alClient
        Caption = #31216#23646#24615
        TabOrder = 1
        object Label1: TLabel
          Left = 11
          Top = 27
          Width = 30
          Height = 12
          Caption = #21517#31216':'
        end
        object Label4: TLabel
          Left = 11
          Top = 57
          Width = 42
          Height = 12
          Caption = #31471#21475#21495':'
        end
        object Label5: TLabel
          Left = 11
          Top = 86
          Width = 42
          Height = 12
          Caption = #27874#29305#29575':'
        end
        object Label2: TLabel
          Left = 11
          Top = 112
          Width = 42
          Height = 12
          Caption = #25968#25454#20301':'
        end
        object Label3: TLabel
          Left = 11
          Top = 139
          Width = 42
          Height = 12
          Caption = #26657#39564#20301':'
        end
        object Label6: TLabel
          Left = 11
          Top = 165
          Width = 42
          Height = 12
          Caption = #20572#27490#20301':'
        end
        object Label7: TLabel
          Left = 11
          Top = 195
          Width = 60
          Height = 12
          Caption = #26368#23567#20540'(g):'
        end
        object Label8: TLabel
          Left = 11
          Top = 216
          Width = 60
          Height = 12
          Caption = #26368#22823#20540'(g):'
        end
        object Label9: TLabel
          Left = 12
          Top = 251
          Width = 48
          Height = 12
          Caption = #35823#24046'(g):'
        end
        object Label22: TLabel
          Left = 208
          Top = 400
          Width = 42
          Height = 12
          Caption = 'Label22'
        end
        object edtName: TEdit
          Left = 75
          Top = 22
          Width = 121
          Height = 20
          TabOrder = 0
        end
        object cbbPort: TComboBox
          Left = 75
          Top = 50
          Width = 121
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 1
          Items.Strings = (
            'Com1'
            'Com2'
            'Com3'
            'Com4'
            'Com5'
            'Com6')
        end
        object cbbTransSpeed: TComboBox
          Left = 76
          Top = 79
          Width = 121
          Height = 20
          ItemHeight = 12
          TabOrder = 2
          Items.Strings = (
            '9600'
            '2400')
        end
        object cbbDataBit: TComboBox
          Left = 75
          Top = 105
          Width = 121
          Height = 20
          ItemHeight = 12
          TabOrder = 3
          Items.Strings = (
            '7'
            '8')
        end
        object cbbParity: TComboBox
          Left = 75
          Top = 132
          Width = 121
          Height = 20
          ItemHeight = 12
          TabOrder = 4
          Items.Strings = (
            'Even'
            'Ord')
        end
        object cbbStopBit: TComboBox
          Left = 75
          Top = 158
          Width = 121
          Height = 20
          ItemHeight = 12
          TabOrder = 5
          Items.Strings = (
            '1')
        end
        object edtMinValue: TEdit
          Left = 75
          Top = 186
          Width = 121
          Height = 20
          TabOrder = 6
        end
        object edtmaxValue: TEdit
          Left = 75
          Top = 214
          Width = 121
          Height = 20
          TabOrder = 7
        end
        object edtPrecent: TEdit
          Left = 76
          Top = 241
          Width = 121
          Height = 20
          TabOrder = 8
        end
        object btnAdd: TBitBtn
          Left = 25
          Top = 309
          Width = 75
          Height = 25
          Caption = #26032#22686'(&A)'
          TabOrder = 9
          OnClick = btnAddClick
        end
        object btnSave: TBitBtn
          Left = 109
          Top = 348
          Width = 75
          Height = 25
          Caption = #20445#23384'(&S)'
          TabOrder = 12
          OnClick = btnSaveClick
        end
        object btnBack: TBitBtn
          Left = 25
          Top = 379
          Width = 160
          Height = 58
          Caption = #36820#22238'(&B)'
          Default = True
          TabOrder = 13
          OnClick = btnBackClick
        end
        object btnTest: TBitBtn
          Left = 25
          Top = 348
          Width = 75
          Height = 25
          Caption = #27979#35797'(&T)'
          TabOrder = 11
          OnClick = btnTestClick
        end
        object btnDel: TBitBtn
          Left = 109
          Top = 309
          Width = 75
          Height = 25
          Caption = #21024#38500'(&D)'
          TabOrder = 10
          OnClick = btnDelClick
        end
        object cbCanBarcode: TCheckBox
          Left = 12
          Top = 280
          Width = 161
          Height = 17
          Caption = #20801#35768#25163#24037#36755#20837#26465#30721
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 14
        end
        object Edit1: TEdit
          Left = 120
          Top = 472
          Width = 473
          Height = 20
          TabOrder = 15
          Text = 'Edit1'
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Report'
      object rptWeigh: TQuickRep
        Left = 40
        Top = 36
        Width = 378
        Height = 284
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        DataSet = cdsWeigh
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Functions.Strings = (
          'PAGENUMBER'
          'COLUMNNUMBER'
          'REPORTTITLE')
        Functions.DATA = (
          '0'
          '0'
          #39#39)
        Options = [FirstPageHeader, LastPageFooter]
        Page.Columns = 1
        Page.Orientation = poPortrait
        Page.PaperSize = Custom
        Page.Values = (
          100
          751.4
          100
          1000
          30
          30
          0)
        PrinterSettings.Copies = 1
        PrinterSettings.OutputBin = Auto
        PrinterSettings.Duplex = False
        PrinterSettings.FirstPage = 0
        PrinterSettings.LastPage = 0
        PrinterSettings.UseStandardprinter = False
        PrinterSettings.UseCustomBinCode = False
        PrinterSettings.CustomBinCode = 0
        PrinterSettings.ExtendedDuplex = 0
        PrinterSettings.UseCustomPaperCode = False
        PrinterSettings.CustomPaperCode = 0
        PrinterSettings.PrintMetaFile = False
        PrinterSettings.PrintQuality = 0
        PrinterSettings.Collate = 0
        PrinterSettings.ColorOption = 0
        PrintIfEmpty = True
        SnapToGrid = True
        Units = MM
        Zoom = 100
        PrevFormStyle = fsNormal
        PreviewInitialState = wsNormal
        PrevInitialZoom = qrZoomToFit
        object TitleBand1: TQRBand
          Left = 11
          Top = 38
          Width = 355
          Height = 39
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = True
          Frame.DrawLeft = False
          Frame.DrawRight = False
          AlignToBottom = False
          Color = clWhite
          TransparentBand = False
          ForceNewColumn = False
          ForceNewPage = False
          Size.Values = (
            103.1875
            939.270833333333)
          PreCaluculateBandHeight = False
          KeepOnOnePage = False
          BandType = rbTitle
          object QRDBText2: TQRDBText
            Left = 6
            Top = 15
            Width = 42
            Height = 17
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              44.9791666666667
              15.875
              39.6875
              111.125)
            Alignment = taLeftJustify
            AlignToBand = False
            AutoSize = False
            AutoStretch = False
            Color = clWhite
            DataSet = cdsWeigh
            DataField = 'Machine_ID'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            WordWrap = True
            FontSize = 10
          end
          object QRDBText3: TQRDBText
            Left = 86
            Top = 15
            Width = 61
            Height = 17
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              44.9791666666667
              227.541666666667
              39.6875
              161.395833333333)
            Alignment = taLeftJustify
            AlignToBand = False
            AutoSize = True
            AutoStretch = False
            Color = clWhite
            DataSet = cdsWeigh
            DataField = 'Batch_NO'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            WordWrap = True
            FontSize = 10
          end
          object QRSysData1: TQRSysData
            Left = 212
            Top = 15
            Width = 68
            Height = 17
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              44.9791666666667
              560.916666666667
              39.6875
              179.916666666667)
            Alignment = taLeftJustify
            AlignToBand = False
            AutoSize = True
            Color = clWhite
            Data = qrsDateTime
            Transparent = False
            FontSize = 10
          end
        end
        object DetailBand1: TQRBand
          Left = 11
          Top = 77
          Width = 355
          Height = 28
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = True
          Frame.DrawLeft = False
          Frame.DrawRight = False
          AlignToBottom = False
          Color = clWhite
          TransparentBand = False
          ForceNewColumn = False
          ForceNewPage = False
          Size.Values = (
            74.0833333333333
            939.270833333333)
          PreCaluculateBandHeight = False
          KeepOnOnePage = False
          BandType = rbDetail
          object QRShape2: TQRShape
            Left = 311
            Top = 0
            Width = 2
            Height = 28
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              74.0833333333333
              822.854166666667
              0
              5.29166666666667)
            Shape = qrsVertLine
            VertAdjust = 0
          end
          object QRShape1: TQRShape
            Left = 197
            Top = -1
            Width = 57
            Height = 28
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              74.0833333333333
              521.229166666667
              -2.64583333333333
              150.8125)
            Shape = qrsRightAndLeft
            VertAdjust = 0
          end
          object qrdbt8: TQRDBText
            Left = 6
            Top = 7
            Width = 38
            Height = 17
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              44.9791666666667
              15.875
              18.5208333333333
              100.541666666667)
            Alignment = taLeftJustify
            AlignToBand = False
            AutoSize = False
            AutoStretch = False
            Color = clWhite
            DataSet = cdsWeigh
            DataField = 'Chemical_ID'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            WordWrap = True
            FontSize = 10
          end
          object QRDBText1: TQRDBText
            Left = 616
            Top = 98
            Width = 96
            Height = 17
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              44.9791666666667
              1629.83333333333
              259.291666666667
              254)
            Alignment = taLeftJustify
            AlignToBand = False
            AutoSize = True
            AutoStretch = False
            Color = clWhite
            DataSet = cdsWeigh
            DataField = 'Chemical_Name'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            WordWrap = True
            FontSize = 10
          end
          object QRDBText4: TQRDBText
            Left = 199
            Top = 7
            Width = 48
            Height = 17
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              44.9791666666667
              526.520833333333
              18.5208333333333
              127)
            Alignment = taRightJustify
            AlignToBand = False
            AutoSize = False
            AutoStretch = False
            Color = clWhite
            DataSet = cdsWeigh
            DataField = 'Weight'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            WordWrap = True
            FontSize = 10
          end
          object QRDBText5: TQRDBText
            Left = 258
            Top = 7
            Width = 50
            Height = 17
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              44.9791666666667
              682.625
              18.5208333333333
              132.291666666667)
            Alignment = taRightJustify
            AlignToBand = False
            AutoSize = False
            AutoStretch = False
            Color = clWhite
            DataSet = cdsWeigh
            DataField = 'Fact_Weight'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            WordWrap = True
            FontSize = 10
          end
          object QRDBText6: TQRDBText
            Left = 316
            Top = 7
            Width = 26
            Height = 17
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              44.9791666666667
              836.083333333333
              18.5208333333333
              68.7916666666667)
            Alignment = taLeftJustify
            AlignToBand = False
            AutoSize = False
            AutoStretch = False
            Color = clWhite
            DataSet = cdsWeigh
            DataField = 'Unit'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            WordWrap = True
            FontSize = 10
          end
          object QRDBText7: TQRDBText
            Left = 41
            Top = 7
            Width = 96
            Height = 17
            Frame.Color = clBlack
            Frame.DrawTop = False
            Frame.DrawBottom = False
            Frame.DrawLeft = False
            Frame.DrawRight = False
            Size.Values = (
              44.9791666666667
              108.479166666667
              18.5208333333333
              254)
            Alignment = taLeftJustify
            AlignToBand = False
            AutoSize = True
            AutoStretch = False
            Color = clWhite
            DataSet = cdsWeigh
            DataField = 'Chemical_Name'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            WordWrap = True
            FontSize = 10
          end
        end
      end
    end
  end
  object cdsWeigh: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 545
    Top = 20
  end
  object TimerWeigh: TTimer
    OnTimer = TimerWeighTimer
    Left = 510
    Top = 19
  end
  object cdsOnline: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 328
    Top = 120
  end
  object dsOnline: TDataSource
    DataSet = cdsOnline
    Left = 368
    Top = 120
  end
  object dsWeigh: TDataSource
    DataSet = cdsWeigh
    Left = 592
    Top = 24
  end
end

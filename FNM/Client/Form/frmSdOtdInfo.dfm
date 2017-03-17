object SdOtdInfo: TSdOtdInfo
  Left = 178
  Top = 19
  Width = 1127
  Height = 702
  Caption = #35797#26679'OTD'#36319#36394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgcSdOtdInfo: TPageControl
    Left = 0
    Top = 0
    Width = 1119
    Height = 671
    ActivePage = SdOtdEdit
    Align = alClient
    TabIndex = 1
    TabOrder = 0
    object SdOtdInput: TTabSheet
      Caption = #25509#25910#26032#20449#24687
      object pnl1: TPanel
        Left = 0
        Top = 0
        Width = 1111
        Height = 65
        Align = alTop
        TabOrder = 0
        object btnInput: TSpeedButton
          Left = 571
          Top = 16
          Width = 80
          Height = 30
          Caption = #26032#22686'(&A)'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00000000000000000000000000
            0000000000000000000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
            00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
            00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
            00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000
            00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF000000FFFFFF000000FF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00000000000000000000000000
            0000000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          OnClick = btnInputClick
        end
        object btnDelete: TSpeedButton
          Left = 663
          Top = 16
          Width = 80
          Height = 30
          Caption = #21024#38500'(&D)'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF241CEDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FF241CEDFF00FFFF00FFFF00FF241CED241CED241CEDFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            241CED241CED241CED241CEDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FF241CEDFF00FFFF00FFFF00FFFF00FFFF00FF241CED241CED241CEDFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FF241CEDFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FF241CED241CED241CEDFF00FFFF00FFFF00FFFF00FF241CED241C
            EDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF241CED241CED24
            1CEDFF00FFFF00FF241CED241CEDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF241CED241CED241CED241CED241CEDFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF24
            1CED241CED241CEDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF241CED241CED241CED241CED241CEDFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF241CED241CED24
            1CEDFF00FFFF00FF241CED241CEDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF241CED241CED241CED241CEDFF00FFFF00FFFF00FFFF00FF241CED241C
            EDFF00FFFF00FFFF00FFFF00FFFF00FF241CED241CED241CED241CEDFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FF241CED241CEDFF00FFFF00FFFF00FFFF00FF
            241CED241CED241CEDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FF241CEDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          OnClick = btnDeleteClick
        end
        object btnSave: TSpeedButton
          Left = 759
          Top = 16
          Width = 80
          Height = 30
          Caption = #20445#23384'(&S)'
          Glyph.Data = {
            66030000424D6603000000000000360000002800000010000000110000000100
            1800000000003003000000000000000000000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000FF00FFFF00FF00000000808000808000000000000000000000
            0000000000000000C6C6C6C6C6C6000000008080000000FF00FFFF00FF000000
            008080008080000000000000000000000000000000000000C6C6C6C6C6C60000
            00008080000000FF00FFFF00FF00000000808000808000000000000000000000
            0000000000000000C6C6C6C6C6C6000000008080000000FF00FFFF00FF000000
            0080800080800000000000000000000000000000000000000000000000000000
            00008080000000FF00FFFF00FF00000000808000808000808000808000808000
            8080008080008080008080008080008080008080000000FF00FFFF00FF000000
            0080800080800000000000000000000000000000000000000000000000000080
            80008080000000FF00FFFF00FF000000008080000000C6C6C6C6C6C6C6C6C6C6
            C6C6C6C6C6C6C6C6C6C6C6C6C6C6000000008080000000FF00FFFF00FF000000
            008080000000C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C60000
            00008080000000FF00FFFF00FF000000008080000000C6C6C6C6C6C6C6C6C6C6
            C6C6C6C6C6C6C6C6C6C6C6C6C6C6000000008080000000FF00FFFF00FF000000
            008080000000C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C60000
            00008080000000FF00FFFF00FF000000008080000000C6C6C6C6C6C6C6C6C6C6
            C6C6C6C6C6C6C6C6C6C6C6C6C6C6000000000000000000FF00FFFF00FF000000
            008080000000C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C60000
            00FF00FF000000FF00FFFF00FF00000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000FF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FF}
          OnClick = btnSaveClick
        end
        object Machineid1: TLabel
          Left = 4
          Top = 22
          Width = 93
          Height = 13
          Caption = #20102#26426#24320#22987#26102#38388':'
        end
        object Machineid2: TLabel
          Left = 209
          Top = 23
          Width = 94
          Height = 13
          Caption = #20102#26426#32467#26463#26102#38388':'
        end
        object Machineid3: TLabel
          Left = 406
          Top = 23
          Width = 60
          Height = 13
          Caption = #21518#25972#36710#38388#65306
          Visible = False
        end
        object btnClose: TSpeedButton
          Left = 860
          Top = 16
          Width = 80
          Height = 30
          Caption = #36864#20986'(&C)'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000008484000000FF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            000000008484008484000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FF00000000000000848400848400848400000000000000
            0000000000000000000000000000000000FF00FFFF00FFFF00FFFF00FF000000
            008484008484008484000000FF00FFFF00FF000000FF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF000000008484008484000000000000FF00FFFF
            00FF000000FF00FFFF00FFFF00FFFF00FF840000FF00FFFF00FFFF00FF000000
            008484008484008484000000FF00FFFF00FF000000FF00FFFF00FFFF00FF8400
            00840000FF00FFFF00FFFF00FF000000008484008484008484000000FF00FFFF
            00FF000000FF00FFFF00FF840000840000840000840000840000FF00FF000000
            008484008484008484000000FF00FFFF00FF000000FF00FF8400008400008400
            00840000840000840000FF00FF000000008484008484008484000000FF00FFFF
            00FF000000FF00FFFF00FF840000840000840000840000840000FF00FF000000
            008484008484000000FF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FF8400
            00840000FF00FFFF00FFFF00FF000000008484000000FF00FFFF00FFFF00FFFF
            00FF000000FF00FFFF00FFFF00FFFF00FF840000FF00FFFF00FFFF00FF000000
            000000FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF00000000000000000000000000000000000000
            0000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          OnClick = btnCloseClick
        end
        object cbbCurrentDepartment: TComboBox
          Left = 476
          Top = 20
          Width = 65
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          Text = 'FA'
          Visible = False
          Items.Strings = (
            'FA'
            'FG')
        end
        object dtpOperateTimBegin: TDateTimePicker
          Left = 101
          Top = 20
          Width = 89
          Height = 21
          CalAlignment = dtaLeft
          Date = 42363.432176875
          Time = 42363.432176875
          DateFormat = dfShort
          DateMode = dmComboBox
          Kind = dtkDate
          ParseInput = False
          TabOrder = 1
        end
        object dtpOperateTimEnd: TDateTimePicker
          Left = 308
          Top = 20
          Width = 89
          Height = 21
          CalAlignment = dtaLeft
          Date = 42363.4325141204
          Time = 42363.4325141204
          DateFormat = dfShort
          DateMode = dmComboBox
          Kind = dtkDate
          ParseInput = False
          TabOrder = 2
        end
      end
      object grp1: TGroupBox
        Left = 0
        Top = 65
        Width = 1111
        Height = 578
        Align = alClient
        Caption = #20449#24687
        TabOrder = 1
        object pnl2: TPanel
          Left = 2
          Top = 534
          Width = 1107
          Height = 42
          Align = alBottom
          TabOrder = 0
          object btnQuery: TSpeedButton
            Left = 561
            Top = 10
            Width = 80
            Height = 30
            Caption = #26597#35810'(Q)'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              1800000000000003000000000000000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FF00000000000000000000000000000000000000
              0000000000000000000000000000FF00FFFF00FF000000000000FF00FF000000
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000008484
              84000000000000FF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFF848484C6C6C6C6C6C6848484000000848484FF00FFFF00FFFF00FF000000
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000C6C6C6C6C6C6FFFF008484848484
              84000000FF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
              0000C6C6C6C6C6C6C6C6C6848484C6C6C6000000FF00FFFF00FFFF00FF000000
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00C6C6C6C6C6C6848484C6C6
              C6000000FF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
              0000FFFF00FFFF00C6C6C6848484848484000000FF00FFFF00FFFF00FF000000
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484C6C6C6C6C6C68484840000
              00FF00FFFF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFF000000000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FF000000
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000FF00
              FFFF00FFFF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFF000000C6C6C6000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FF00000000000000000000000000000000000000
              0000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            Visible = False
          end
          object btnEdit: TSpeedButton
            Left = 658
            Top = 10
            Width = 80
            Height = 30
            Caption = #20462#25913'(&E)'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              1800000000000003000000000000000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
              0000000000000000000000000000000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
              0000FFFFFFFF0000FF0000FF0000FF0000FF0000FFFFFF000000FF00FF000000
              000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFF000000FF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
              0000FFFFFFFF0000FF0000FF0000FF0000FF0000FFFFFF000000FF00FF000000
              FFFFFFFF0000FF0000FF0000FF0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFF000000FF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
              0000FFFFFFFF0000FF0000FFFFFF000000000000000000000000FF00FF000000
              FFFFFFFF0000FF0000FF0000FF0000000000FFFFFFFFFFFFFFFFFFFFFFFF0000
              00FFFFFF000000FF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
              0000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FF00FFFF00FFFF00FF000000
              FFFFFFFF0000FF0000FFFFFF0000000000000000000000000000000000000000
              00FF00FFFF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFF000000FF
              FFFF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000
              FFFFFFFFFFFFFFFFFFFFFFFF000000000000FF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FF000000000000000000000000000000000000FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            Visible = False
          end
          object Machineid4: TLabel
            Left = 103
            Top = 16
            Width = 60
            Height = 13
            Caption = #36755#20837#21407#22240#65306
            Visible = False
          end
          object edtInputCause: TEdit
            Left = 168
            Top = 12
            Width = 369
            Height = 21
            TabOrder = 0
            Visible = False
          end
          object dbedtOldInputCause: TDBEdit
            Left = 752
            Top = 16
            Width = 121
            Height = 21
            DataField = 'Input_Cause'
            DataSource = dsSdOtdInput
            TabOrder = 1
            Visible = False
          end
        end
        object cxgrd1: TcxGrid
          Left = 2
          Top = 15
          Width = 1107
          Height = 519
          Align = alClient
          TabOrder = 1
          object cxgridGrid1DBTableView1: TcxGridDBTableView
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NavigatorButtons.ConfirmDelete = False
          end
          object cxgridSdOtdInput: TcxGridDBBandedTableView
            DataController.DataSource = dsSdOtdInput
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NavigatorButtons.ConfirmDelete = False
            OnCellClick = cxgridSdOtdInputCellClick
            Bands = <
              item
              end>
            object cxgrdbndclmnSdOtdInputDBBandedColumn1: TcxGridDBBandedColumn
              Caption = #25490#21333#21495
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 0
              Position.RowIndex = 0
              DataBinding.FieldName = 'Job_No'
            end
            object cxgrdbndclmnSdOtdInputDBBandedColumn2: TcxGridDBBandedColumn
              Caption = #21697#31181
              Options.Editing = False
              Width = 130
              Position.BandIndex = 0
              Position.ColIndex = 1
              Position.RowIndex = 0
              DataBinding.FieldName = 'Gf_No'
            end
            object cxgrdbndclmnSdOtdInputDBBandedColumn3: TcxGridDBBandedColumn
              Caption = 'GFID'
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 2
              Position.RowIndex = 0
              DataBinding.FieldName = 'Gf_Id'
            end
            object cxgrdbndclmnSdOtdInputDBBandedColumn4: TcxGridDBBandedColumn
              Caption = #32455#24067#36710#38388
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 3
              Position.RowIndex = 0
              DataBinding.FieldName = 'Wv_Factory'
            end
            object cxgrdbndclmnSdOtdInputDBBandedColumn5: TcxGridDBBandedColumn
              Caption = #21518#25972#36710#38388
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 4
              Position.RowIndex = 0
              DataBinding.FieldName = 'Current_Department'
            end
            object cxgrdbndclmnSdOtdInputDBBandedColumn6: TcxGridDBBandedColumn
              Caption = #28418#29305#30333
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 5
              Position.RowIndex = 0
              DataBinding.FieldName = 'White_Type'
            end
            object cxgrdbndclmnSdOtdInputDBBandedColumn7: TcxGridDBBandedColumn
              Caption = #22823#36135#20132#26399
              Options.Editing = False
              Width = 90
              Position.BandIndex = 0
              Position.ColIndex = 6
              Position.RowIndex = 0
              DataBinding.FieldName = 'Delivery_Date'
            end
            object cxgrdbndclmnSdOtdInputDBBandedColumn8: TcxGridDBBandedColumn
              Caption = #20102#26426#26102#38388
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 7
              Position.RowIndex = 0
              DataBinding.FieldName = 'WV_Actual_Finish_Date'
            end
            object cxgrdbndclmnSdOtdInputDBBandedColumn9: TcxGridDBBandedColumn
              Caption = #21487#20986#24067#26102#38388
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 8
              Position.RowIndex = 0
              DataBinding.FieldName = 'CanBeOutToFn_Time'
            end
            object cxgrdbndclmnSdOtdInputDBBandedColumn10: TcxGridDBBandedColumn
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 9
              Position.RowIndex = 0
              DataBinding.FieldName = 'CT'
            end
            object cxgrdbndclmnSdOtdInputDBBandedColumn11: TcxGridDBBandedColumn
              Caption = #22686#21152#23567#26102
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Items.Strings = (
                '1'
                '2'
                '3'
                '4'
                '6'
                '7'
                '8'
                '9'
                '10'
                '11'
                '12'
                '13'
                '14'
                '15'
                '16'
                '17'
                '18'
                '19'
                '20'
                '21'
                '22'
                '23'
                '24')
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 10
              Position.RowIndex = 0
              DataBinding.FieldName = 'Add_Hour'
            end
            object cxgrdbndclmnSdOtdInputDBBandedColumn12: TcxGridDBBandedColumn
              Caption = #26631#20934#24037#33402
              Width = 300
              Position.BandIndex = 0
              Position.ColIndex = 11
              Position.RowIndex = 0
              DataBinding.FieldName = 'Operation_CHN'
            end
            object cxgrdbndclmnSdOtdInputDBBandedColumn13: TcxGridDBBandedColumn
              Caption = #36865#26679#24773#20917
              Width = 70
              Position.BandIndex = 0
              Position.ColIndex = 12
              Position.RowIndex = 0
              DataBinding.FieldName = 'Send_Sample_Condition'
            end
            object cxgrdbndclmnSdOtdInputDBBandedColumn14: TcxGridDBBandedColumn
              Caption = #35201#27714#36865#26679#20154
              Width = 70
              Position.BandIndex = 0
              Position.ColIndex = 13
              Position.RowIndex = 0
              DataBinding.FieldName = 'Require_Send_Sample_Name'
            end
            object cxgrdbndclmnSdOtdInputDBBandedColumn15: TcxGridDBBandedColumn
              Caption = #31532#19968#36131#20219
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Items.Strings = (
                #36136#37327
                #35745#21010
                #25805#20316
                #24037#33402
                #22383#24067
                #22806#37096
                #35774#22791)
              Width = 70
              Position.BandIndex = 0
              Position.ColIndex = 14
              Position.RowIndex = 0
              DataBinding.FieldName = 'One_Duty'
            end
            object cxgrdbndclmnSdOtdInputDBBandedColumn16: TcxGridDBBandedColumn
              Caption = #31532#20108#36131#20219
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Items.Strings = (
                #36136#37327
                #35745#21010
                #25805#20316
                #24037#33402
                #22383#24067
                #22806#37096
                #35774#22791)
              Width = 70
              Position.BandIndex = 0
              Position.ColIndex = 15
              Position.RowIndex = 0
              DataBinding.FieldName = 'Two_Duty'
            end
            object cxgrdbndclmnSdOtdInputDBBandedColumn17: TcxGridDBBandedColumn
              Caption = #31532#19977#36131#20219
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Items.Strings = (
                #36136#37327
                #35745#21010
                #25805#20316
                #24037#33402
                #22383#24067
                #22806#37096
                #35774#22791)
              Width = 70
              Position.BandIndex = 0
              Position.ColIndex = 16
              Position.RowIndex = 0
              DataBinding.FieldName = 'Three_Duty'
            end
            object cxgrdbndclmnSdOtdInputDBBandedColumn19: TcxGridDBBandedColumn
              Caption = #24405#20837#26102#38388
              Position.BandIndex = 0
              Position.ColIndex = 18
              Position.RowIndex = 0
              DataBinding.FieldName = 'Insert_Time'
            end
            object cxgrdbndclmnSdOtdInputDBBandedColumn18: TcxGridDBBandedColumn
              Caption = #36755#20837#21407#22240
              Width = 70
              Position.BandIndex = 0
              Position.ColIndex = 17
              Position.RowIndex = 0
              DataBinding.FieldName = 'Input_Cause'
            end
          end
          object cxgrdlvlGrid1Level1: TcxGridLevel
            GridView = cxgridSdOtdInput
          end
        end
      end
    end
    object SdOtdEdit: TTabSheet
      Caption = #20449#24687#20462#25913
      ImageIndex = 1
      object pnl3: TPanel
        Left = 0
        Top = 0
        Width = 1111
        Height = 65
        Align = alTop
        TabOrder = 0
        object Machineid5: TLabel
          Left = 7
          Top = 22
          Width = 86
          Height = 13
          Caption = 'OTD'#24320#22987#26102#38388':'
        end
        object Machineid6: TLabel
          Left = 206
          Top = 23
          Width = 91
          Height = 13
          Caption = 'OTD'#32467#26463#26102#38388':'
        end
        object Machineid7: TLabel
          Left = 411
          Top = 23
          Width = 60
          Height = 13
          Caption = #21518#25972#36710#38388#65306
        end
        object btnQueryEdit: TSpeedButton
          Left = 595
          Top = 16
          Width = 80
          Height = 30
          Caption = #26597#35810'(Q)'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF00000000000000000000000000000000000000
            0000000000000000000000000000FF00FFFF00FF000000000000FF00FF000000
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000008484
            84000000000000FF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF848484C6C6C6C6C6C6848484000000848484FF00FFFF00FFFF00FF000000
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000C6C6C6C6C6C6FFFF008484848484
            84000000FF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
            0000C6C6C6C6C6C6C6C6C6848484C6C6C6000000FF00FFFF00FFFF00FF000000
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF00C6C6C6C6C6C6848484C6C6
            C6000000FF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
            0000FFFF00FFFF00C6C6C6848484848484000000FF00FFFF00FFFF00FF000000
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484C6C6C6C6C6C68484840000
            00FF00FFFF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF000000000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FF000000
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000FF00
            FFFF00FFFF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF000000C6C6C6000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF00000000000000000000000000000000000000
            0000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          OnClick = btnQueryEditClick
        end
        object btnExit: TSpeedButton
          Left = 705
          Top = 16
          Width = 80
          Height = 30
          Caption = #36864#20986'(&C)'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000008484000000FF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            000000008484008484000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FF00000000000000848400848400848400000000000000
            0000000000000000000000000000000000FF00FFFF00FFFF00FFFF00FF000000
            008484008484008484000000FF00FFFF00FF000000FF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF000000008484008484000000000000FF00FFFF
            00FF000000FF00FFFF00FFFF00FFFF00FF840000FF00FFFF00FFFF00FF000000
            008484008484008484000000FF00FFFF00FF000000FF00FFFF00FFFF00FF8400
            00840000FF00FFFF00FFFF00FF000000008484008484008484000000FF00FFFF
            00FF000000FF00FFFF00FF840000840000840000840000840000FF00FF000000
            008484008484008484000000FF00FFFF00FF000000FF00FF8400008400008400
            00840000840000840000FF00FF000000008484008484008484000000FF00FFFF
            00FF000000FF00FFFF00FF840000840000840000840000840000FF00FF000000
            008484008484000000FF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FF8400
            00840000FF00FFFF00FFFF00FF000000008484000000FF00FFFF00FFFF00FFFF
            00FF000000FF00FFFF00FFFF00FFFF00FF840000FF00FFFF00FFFF00FF000000
            000000FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF00000000000000000000000000000000000000
            0000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          OnClick = btnExitClick
        end
        object dtpOperateTimBeginEdit: TDateTimePicker
          Left = 97
          Top = 20
          Width = 89
          Height = 21
          CalAlignment = dtaLeft
          Date = 42363.432176875
          Time = 42363.432176875
          DateFormat = dfShort
          DateMode = dmComboBox
          Kind = dtkDate
          ParseInput = False
          TabOrder = 0
        end
        object dtpOperateTimEndEdit: TDateTimePicker
          Left = 306
          Top = 20
          Width = 89
          Height = 21
          CalAlignment = dtaLeft
          Date = 42363.4325141204
          Time = 42363.4325141204
          DateFormat = dfShort
          DateMode = dmComboBox
          Kind = dtkDate
          ParseInput = False
          TabOrder = 1
        end
        object cbbCurrentDepartmentEdit: TComboBox
          Left = 482
          Top = 20
          Width = 65
          Height = 21
          ItemHeight = 13
          TabOrder = 2
          Text = 'FA'
          Items.Strings = (
            'FA'
            'FG'
            'ALL')
        end
      end
      object grp2: TGroupBox
        Left = 0
        Top = 65
        Width = 1111
        Height = 505
        Align = alClient
        Caption = #20449#24687
        TabOrder = 1
        object cxgrd2: TcxGrid
          Left = 2
          Top = 15
          Width = 1107
          Height = 488
          Align = alClient
          TabOrder = 0
          object cxgridGrid1DBTableView2: TcxGridDBTableView
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NavigatorButtons.ConfirmDelete = False
          end
          object cxgridSdOtdInputEdit: TcxGridDBBandedTableView
            DataController.DataSource = dsSdOtdInputEdit
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NavigatorButtons.ConfirmDelete = False
            Bands = <
              item
              end>
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn34: TcxGridDBBandedColumn
              Caption = #26159#21542#25302#21333
              Width = 50
              Position.BandIndex = 0
              Position.ColIndex = 33
              Position.RowIndex = 0
              DataBinding.FieldName = 'Otd_delay'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn20: TcxGridDBBandedColumn
              Caption = 'PPO'#31867#22411
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 19
              Position.RowIndex = 0
              DataBinding.FieldName = 'Ppo_Type'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn21: TcxGridDBBandedColumn
              Caption = #24067#31181
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 20
              Position.RowIndex = 0
              DataBinding.FieldName = 'Cloth_Type'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn6: TcxGridDBBandedColumn
              Caption = #28418#29305#30333
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 5
              Position.RowIndex = 0
              DataBinding.FieldName = 'White_Type'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn30: TcxGridDBBandedColumn
              Caption = #24403#37327
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 29
              Position.RowIndex = 0
              DataBinding.FieldName = 'dosage_factor'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn31: TcxGridDBBandedColumn
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 30
              Position.RowIndex = 0
              DataBinding.FieldName = 'ORTQ'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn32: TcxGridDBBandedColumn
              Caption = #30897#27987
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 31
              Position.RowIndex = 0
              DataBinding.FieldName = 'JND'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn1: TcxGridDBBandedColumn
              Caption = #25490#21333
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 0
              Position.RowIndex = 0
              DataBinding.FieldName = 'Job_no'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn2: TcxGridDBBandedColumn
              Caption = #21697#31181
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 1
              Position.RowIndex = 0
              DataBinding.FieldName = 'gf_no'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn4: TcxGridDBBandedColumn
              Caption = #32455#24067#36710#38388
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 3
              Position.RowIndex = 0
              DataBinding.FieldName = 'Wv_Factory'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn23: TcxGridDBBandedColumn
              Caption = #21518#25972#29366#24577
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 22
              Position.RowIndex = 0
              DataBinding.FieldName = 'FN_Status'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn5: TcxGridDBBandedColumn
              Caption = #21518#25972#36710#38388
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 4
              Position.RowIndex = 0
              DataBinding.FieldName = 'Current_Department'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn10: TcxGridDBBandedColumn
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 9
              Position.RowIndex = 0
              DataBinding.FieldName = 'CT'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn11: TcxGridDBBandedColumn
              Caption = #22686#21152#23567#26102
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Items.Strings = (
                '1'
                '2'
                '3'
                '4'
                '5'
                '6'
                '7'
                '8'
                '9'
                '10'
                '11'
                '12'
                '13'
                '14'
                '15'
                '16'
                '17'
                '18'
                '19'
                '20'
                '21'
                '22'
                '23'
                '24'
                '36'
                '48'
                '60'
                '72'
                '84'
                '96'
                '108')
              Position.BandIndex = 0
              Position.ColIndex = 10
              Position.RowIndex = 0
              DataBinding.FieldName = 'Add_Hour'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn7: TcxGridDBBandedColumn
              Caption = #22823#36135#20132#26399
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 6
              Position.RowIndex = 0
              DataBinding.FieldName = 'Delivery_Date'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn8: TcxGridDBBandedColumn
              Caption = #20102#26426#26102#38388
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 7
              Position.RowIndex = 0
              DataBinding.FieldName = 'WV_Actual_Finish_Date'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn12: TcxGridDBBandedColumn
              Caption = #26631#20934#24037#33402
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 11
              Position.RowIndex = 0
              DataBinding.FieldName = 'Operation_CHN'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn13: TcxGridDBBandedColumn
              Caption = #36865#26679#24773#20917
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 12
              Position.RowIndex = 0
              DataBinding.FieldName = 'Send_Sample_Condition'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn14: TcxGridDBBandedColumn
              Caption = #35201#27714#36865#26679#20154
              Position.BandIndex = 0
              Position.ColIndex = 13
              Position.RowIndex = 0
              DataBinding.FieldName = 'Require_Send_Sample_Name'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn15: TcxGridDBBandedColumn
              Caption = #31532#19968#36131#20219
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Items.Strings = (
                #36136#37327
                #35745#21010
                #25805#20316
                #24037#33402
                #22383#24067
                #22806#37096
                #35774#22791)
              Position.BandIndex = 0
              Position.ColIndex = 14
              Position.RowIndex = 0
              DataBinding.FieldName = 'One_Duty'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn16: TcxGridDBBandedColumn
              Caption = #31532#20108#36131#20219
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Items.Strings = (
                #36136#37327
                #35745#21010
                #25805#20316
                #24037#33402
                #22383#24067
                #22806#37096
                #35774#22791)
              Position.BandIndex = 0
              Position.ColIndex = 15
              Position.RowIndex = 0
              DataBinding.FieldName = 'Two_Duty'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn17: TcxGridDBBandedColumn
              Caption = #31532#19977#36131#20219
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Items.Strings = (
                #36136#37327
                #35745#21010
                #25805#20316
                #24037#33402
                #22383#24067
                #22806#37096
                #35774#22791)
              Position.BandIndex = 0
              Position.ColIndex = 16
              Position.RowIndex = 0
              DataBinding.FieldName = 'Three_Duty'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn18: TcxGridDBBandedColumn
              Caption = #36755#20837#21407#22240
              Position.BandIndex = 0
              Position.ColIndex = 17
              Position.RowIndex = 0
              DataBinding.FieldName = 'Input_Cause'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn22: TcxGridDBBandedColumn
              Caption = #21518#25972#23436#25104#26102#38388
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 21
              Position.RowIndex = 0
              DataBinding.FieldName = 'FN_Actual_Finish_Date'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn9: TcxGridDBBandedColumn
              Caption = #21487#20986#24067#26102#38388
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 8
              Position.RowIndex = 0
              DataBinding.FieldName = 'CanBeOutToFn_Time'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn24: TcxGridDBBandedColumn
              Caption = #20869#22238#20462#27425#25968
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 23
              Position.RowIndex = 0
              DataBinding.FieldName = 'Internal_Repair_Times'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn25: TcxGridDBBandedColumn
              Caption = #22806#22238#20462#27425#25968
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 24
              Position.RowIndex = 0
              DataBinding.FieldName = 'External_Repair_Times'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn26: TcxGridDBBandedColumn
              Caption = #20986#24067'CT'
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 25
              Position.RowIndex = 0
              DataBinding.FieldName = 'Out_Cloth_Ct'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn27: TcxGridDBBandedColumn
              Caption = #24453#35745#21010'CT'
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 26
              Position.RowIndex = 0
              DataBinding.FieldName = 'Wait_Plan_Ct'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn28: TcxGridDBBandedColumn
              Caption = #20986#24067#26159#21542#36229#26102
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 27
              Position.RowIndex = 0
              DataBinding.FieldName = 'Out_Cloth_OverTime'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn29: TcxGridDBBandedColumn
              Caption = 'OTD'#26102#38388
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 28
              Position.RowIndex = 0
              DataBinding.FieldName = 'Otd_Day'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn33: TcxGridDBBandedColumn
              Caption = 'OTD'#23454#38469#26102#38388
              Position.BandIndex = 0
              Position.ColIndex = 32
              Position.RowIndex = 0
              DataBinding.FieldName = 'Otd_Time'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn19: TcxGridDBBandedColumn
              Caption = #36755#20837#26102#38388
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 18
              Position.RowIndex = 0
              DataBinding.FieldName = 'Insert_Time'
            end
            object cxgrdbndclmnSdOtdInputEditDBBandedColumn3: TcxGridDBBandedColumn
              Caption = 'GFID'
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 2
              Position.RowIndex = 0
              DataBinding.FieldName = 'Gf_Id'
            end
          end
          object cxgrdlvlGrid1Level2: TcxGridLevel
            GridView = cxgridSdOtdInputEdit
          end
        end
      end
      object pnl4: TPanel
        Left = 0
        Top = 570
        Width = 1111
        Height = 73
        Align = alBottom
        TabOrder = 2
        object Machineid8: TLabel
          Left = 233
          Top = 32
          Width = 60
          Height = 13
          Caption = #36755#20837#21407#22240#65306
        end
        object btnEditEdit: TSpeedButton
          Left = 701
          Top = 22
          Width = 80
          Height = 30
          Caption = #20462#25913'(&E)'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
            0000000000000000000000000000000000000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
            0000FFFFFFFF0000FF0000FF0000FF0000FF0000FFFFFF000000FF00FF000000
            000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF000000FF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
            0000FFFFFFFF0000FF0000FF0000FF0000FF0000FFFFFF000000FF00FF000000
            FFFFFFFF0000FF0000FF0000FF0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF000000FF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
            0000FFFFFFFF0000FF0000FFFFFF000000000000000000000000FF00FF000000
            FFFFFFFF0000FF0000FF0000FF0000000000FFFFFFFFFFFFFFFFFFFFFFFF0000
            00FFFFFF000000FF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
            0000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FF00FFFF00FFFF00FF000000
            FFFFFFFF0000FF0000FFFFFF0000000000000000000000000000000000000000
            00FF00FFFF00FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFF000000FF
            FFFF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000
            FFFFFFFFFFFFFFFFFFFFFFFF000000000000FF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF000000000000000000000000000000000000FF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          OnClick = btnEditEditClick
        end
        object edtInputCauseEdit: TEdit
          Left = 298
          Top = 28
          Width = 385
          Height = 21
          TabOrder = 0
        end
      end
    end
  end
  object cdsSdOtdInput: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 62
    Top = 214
  end
  object dsSdOtdInput: TDataSource
    DataSet = cdsSdOtdInput
    Left = 60
    Top = 356
  end
  object mksql1: TMakeSQL
    Caption = #26597#35810#26465#20214#32534#36753
    ItemNames = <
      item
        ParaCaption = 'OTD'#26085#26399
        ParaName = 'OTD_DAY'
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
      end
      item
        ParaCaption = #24405#20837#26102#38388
        ParaName = 'Insert_Time'
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
      end
      item
        ParaCaption = #25490#21333#21495
        ParaName = 'Job_No'
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
      end
      item
        ParaCaption = #21697#31181
        ParaName = 'GF_NO'
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
      end
      item
        ParaCaption = #32455#24067#36710#38388
        ParaName = 'Wv_Factory'
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
      end
      item
        ParaCaption = #25910#22383#26102#38388
        ParaName = 'Operate_Time'
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
      end
      item
        ParaCaption = #22823#36135#20132#26399
        ParaName = 'Delivery_Date'
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
      end
      item
        ParaCaption = #21487#20986#24067#26102#38388
        ParaName = 'Out_Cloth_Time'
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
      end
      item
        ParaCaption = #36865#24067#26102#38388
        ParaName = 'Send_Cloth_Time'
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
      end
      item
        ParaCaption = #20102#26426#26102#38388
        ParaName = 'Last_Received_Date'
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
    Left = 328
    Top = 192
  end
  object cdsSdOtdInputTemp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 57
    Top = 287
  end
  object cdsSdOtdInputEdit: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 194
    Top = 220
  end
  object dsSdOtdInputEdit: TDataSource
    DataSet = cdsSdOtdInputEdit
    Left = 192
    Top = 294
  end
end

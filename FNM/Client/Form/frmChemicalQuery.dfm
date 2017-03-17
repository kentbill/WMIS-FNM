inherited ChemicalQueryForm: TChemicalQueryForm
  Left = 65
  Top = 93
  Width = 894
  Height = 601
  Caption = #21270#24037#26009#26085#25253#26597#35810
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object Notebook1: TNotebook
    Left = 0
    Top = 0
    Width = 886
    Height = 574
    Align = alClient
    TabOrder = 0
    object TPage
      Left = 0
      Top = 0
      Caption = 'Default'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 886
        Height = 55
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object lbl1: TLabel
          Left = 24
          Top = 26
          Width = 54
          Height = 12
          Caption = #26597#35810#26085#26399':'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object dtpQueryDate: TDateTimePicker
          Left = 80
          Top = 18
          Width = 125
          Height = 20
          CalAlignment = dtaLeft
          Date = 38924
          Time = 38924
          DateFormat = dfShort
          DateMode = dmComboBox
          Kind = dtkDate
          ParseInput = False
          TabOrder = 0
        end
        object btnQuery: TBitBtn
          Left = 212
          Top = 13
          Width = 75
          Height = 25
          Caption = #26597#35810'(&Q)'
          Default = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = btnQueryClick
        end
        object btnClose: TBitBtn
          Left = 296
          Top = 13
          Width = 75
          Height = 25
          Cancel = True
          Caption = #36864#20986'(&X)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = btnCloseClick
        end
      end
      object cxGrid1: TcxGrid
        Left = 0
        Top = 55
        Width = 886
        Height = 519
        Align = alClient
        TabOrder = 1
        object cxGridDBBTV: TcxGridDBBandedTableView
          DataController.DataSource = dsChemical
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
              Column = cxGridDBBTVLast_Remain
            end
            item
              Kind = skSum
              Column = cxGridDBBTVLast_Remain_Money
            end
            item
              Kind = skSum
              Column = cxGridDBBTVIn_Qty
            end
            item
              Kind = skSum
              Column = cxGridDBBTVIn_Money
            end
            item
              Kind = skSum
              Column = cxGridDBBTVIn_Sum
            end
            item
              Kind = skSum
              Column = cxGridDBBTVIn_Sum_Money
            end
            item
              Kind = skSum
              Column = cxGridDBBTVOut_Qty
            end
            item
              Kind = skSum
              Column = cxGridDBBTVOur_Money
            end
            item
              Kind = skSum
              Column = cxGridDBBTVOut_Sum
            end
            item
              Kind = skSum
              Column = cxGridDBBTVOut_Sum_Money
            end
            item
              Kind = skSum
              Column = cxGridDBBTVRemain
            end
            item
              Kind = skSum
              Column = cxGridDBBTVRemain_Money
            end
            item
              Kind = skSum
              Column = cxGridDBBTVOut_Theory_Qty
            end
            item
              Kind = skSum
              Column = cxGridDBBTVOur_Theory_Money
            end
            item
              Kind = skSum
              Column = cxGridDBBTVOut_Theory_Sum
            end
            item
              Kind = skSum
              Column = cxGridDBBTVOur_Theory_Sum_Money
            end
            item
              Kind = skSum
              Column = cxGridDBBTVDiff
            end
            item
              Kind = skSum
              Column = cxGridDBBTDiff_Money
            end>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          Bands = <
            item
              Caption = #29289#26009#21517#31216
              FixedKind = fkLeft
              Width = 207
            end
            item
              Caption = #19978#26085#23384
              Width = 111
            end
            item
              Caption = #26412#26085#25910
              Width = 97
            end
            item
              Caption = #26412#26376#32047#25910
              Width = 106
            end
            item
              Caption = #26412#26085#32791#29992
              Width = 112
            end
            item
              Caption = #26412#26376#32047#29992
              Width = 99
            end
            item
              Caption = #26412#26085#23384
              Width = 98
            end
            item
              Caption = #26412#26085#29702#35770#32791#29992
            end
            item
              Caption = #26412#26376#29702#35770#32047#29992
            end
            item
              Caption = #24046#24322
            end>
          object cxGridDBBTVCreate_Date: TcxGridDBBandedColumn
            Caption = #26085#26399
            Visible = False
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
            DataBinding.FieldName = 'Create_Date'
          end
          object cxGridDBBTVChemical_Type: TcxGridDBBandedColumn
            Caption = #31867#22411
            Width = 50
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
            DataBinding.FieldName = 'Chemical_Type'
          end
          object cxGridDBBTVChemical_ID: TcxGridDBBandedColumn
            Caption = #29289#26009'ID'
            Visible = False
            Position.BandIndex = 0
            Position.ColIndex = 2
            Position.RowIndex = 0
            DataBinding.FieldName = 'Chemical_ID'
          end
          object cxGridDBBTVOracle_Code: TcxGridDBBandedColumn
            Caption = 'Oracle'#32534#30721
            Width = 61
            Position.BandIndex = 0
            Position.ColIndex = 4
            Position.RowIndex = 0
            DataBinding.FieldName = 'Oracle_Code'
          end
          object cxGridDBBTVChemical_Name: TcxGridDBBandedColumn
            Caption = #29289#26009#21517
            Width = 96
            Position.BandIndex = 0
            Position.ColIndex = 3
            Position.RowIndex = 0
            DataBinding.FieldName = 'Chemical_Name'
          end
          object cxGridDBBTVLast_Remain: TcxGridDBBandedColumn
            Caption = #25968#37327'(kg)'
            Width = 68
            Position.BandIndex = 1
            Position.ColIndex = 0
            Position.RowIndex = 0
            DataBinding.FieldName = 'Last_Remain'
          end
          object cxGridDBBTVLast_Remain_Money: TcxGridDBBandedColumn
            Caption = #37329#39069'('#65509')'
            Width = 74
            Position.BandIndex = 1
            Position.ColIndex = 1
            Position.RowIndex = 0
            DataBinding.FieldName = 'Last_Remain_Money'
          end
          object cxGridDBBTVIn_Qty: TcxGridDBBandedColumn
            Caption = #25968#37327'(kg)'
            Width = 70
            Position.BandIndex = 2
            Position.ColIndex = 0
            Position.RowIndex = 0
            DataBinding.FieldName = 'In_Qty'
          end
          object cxGridDBBTVIn_Money: TcxGridDBBandedColumn
            Caption = #37329#39069'('#65509')'
            Width = 83
            Position.BandIndex = 2
            Position.ColIndex = 1
            Position.RowIndex = 0
            DataBinding.FieldName = 'In_Money'
          end
          object cxGridDBBTVIn_Sum: TcxGridDBBandedColumn
            Caption = #25968#37327'(kg)'
            Width = 63
            Position.BandIndex = 3
            Position.ColIndex = 0
            Position.RowIndex = 0
            DataBinding.FieldName = 'In_Sum'
          end
          object cxGridDBBTVIn_Sum_Money: TcxGridDBBandedColumn
            Caption = #37329#39069'('#65509')'
            Width = 47
            Position.BandIndex = 3
            Position.ColIndex = 1
            Position.RowIndex = 0
            DataBinding.FieldName = 'In_Sum_Money'
          end
          object cxGridDBBTVOut_Qty: TcxGridDBBandedColumn
            Caption = #25968#37327'(kg)'
            Width = 59
            Position.BandIndex = 4
            Position.ColIndex = 0
            Position.RowIndex = 0
            DataBinding.FieldName = 'Out_Qty'
          end
          object cxGridDBBTVOur_Money: TcxGridDBBandedColumn
            Caption = #37329#39069'('#65509')'
            Width = 63
            Position.BandIndex = 4
            Position.ColIndex = 1
            Position.RowIndex = 0
            DataBinding.FieldName = 'Our_Money'
          end
          object cxGridDBBTVOut_Sum: TcxGridDBBandedColumn
            Caption = #25968#37327'(kg)'
            Width = 69
            Position.BandIndex = 5
            Position.ColIndex = 0
            Position.RowIndex = 0
            DataBinding.FieldName = 'Out_Sum'
          end
          object cxGridDBBTVOut_Sum_Money: TcxGridDBBandedColumn
            Caption = #37329#39069'('#65509')'
            Width = 58
            Position.BandIndex = 5
            Position.ColIndex = 1
            Position.RowIndex = 0
            DataBinding.FieldName = 'Out_Sum_Money'
          end
          object cxGridDBBTVRemain: TcxGridDBBandedColumn
            Caption = #25968#37327'(kg)'
            Width = 50
            Position.BandIndex = 6
            Position.ColIndex = 0
            Position.RowIndex = 0
            DataBinding.FieldName = 'Remain'
          end
          object cxGridDBBTVRemain_Money: TcxGridDBBandedColumn
            Caption = #37329#39069'('#65509')'
            Width = 62
            Position.BandIndex = 6
            Position.ColIndex = 1
            Position.RowIndex = 0
            DataBinding.FieldName = 'Remain_Money'
          end
          object cxGridDBBTVPrice: TcxGridDBBandedColumn
            Caption = #21333#20215'('#65509')'
            Visible = False
            Position.BandIndex = 6
            Position.ColIndex = 2
            Position.RowIndex = 0
            DataBinding.FieldName = 'Price'
          end
          object cxGridDBBTVOut_Theory_Qty: TcxGridDBBandedColumn
            Caption = #25968#37327'(kg)'
            Position.BandIndex = 7
            Position.ColIndex = 0
            Position.RowIndex = 0
            DataBinding.FieldName = 'Out_Theory_Qty'
          end
          object cxGridDBBTVOur_Theory_Money: TcxGridDBBandedColumn
            Caption = #37329#39069'('#65509')'
            Position.BandIndex = 7
            Position.ColIndex = 1
            Position.RowIndex = 0
            DataBinding.FieldName = 'Our_Theory_Money'
          end
          object cxGridDBBTVOut_Theory_Sum: TcxGridDBBandedColumn
            Caption = #25968#37327'(kg)'
            Position.BandIndex = 8
            Position.ColIndex = 0
            Position.RowIndex = 0
            DataBinding.FieldName = 'Out_Theory_Sum'
          end
          object cxGridDBBTVOur_Theory_Sum_Money: TcxGridDBBandedColumn
            Caption = #37329#39069'('#65509')'
            Position.BandIndex = 8
            Position.ColIndex = 1
            Position.RowIndex = 0
            DataBinding.FieldName = 'Our_Theory_Sum_Money'
          end
          object cxGridDBBTVDiff: TcxGridDBBandedColumn
            Caption = #25968#37327'(kg)'
            Position.BandIndex = 9
            Position.ColIndex = 0
            Position.RowIndex = 0
            DataBinding.FieldName = 'Diff'
          end
          object cxGridDBBTDiff_Money: TcxGridDBBandedColumn
            Caption = #37329#39069'('#65509')'
            Position.BandIndex = 9
            Position.ColIndex = 1
            Position.RowIndex = 0
            DataBinding.FieldName = 'Diff_Money'
          end
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = cxGridDBBTV
        end
      end
    end
  end
  object dsChemical: TDataSource
    DataSet = cdsChemical
    Left = 32
    Top = 168
  end
  object cxGridPopupMenu1: TcxGridPopupMenu
    Grid = cxGrid1
    PopupMenus = <>
    Left = 608
    Top = 240
  end
  object cdsChemical: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 144
    Top = 216
  end
end

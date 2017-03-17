inherited WorkerForm: TWorkerForm
  Left = 198
  Top = 197
  BorderStyle = bsDialog
  Caption = #24037#20154#21450#32452#21035#32500#25252
  ClientHeight = 351
  ClientWidth = 671
  OldCreateOrder = True
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 12
  object pgcDic: TPageControl
    Left = 0
    Top = 0
    Width = 671
    Height = 317
    ActivePage = tsCommon
    Align = alClient
    TabIndex = 0
    TabOrder = 0
    object tsCommon: TTabSheet
      Caption = #24037#20154#32500#25252'(&W)'
      object grpWorker: TGroupBox
        Left = 0
        Top = 0
        Width = 492
        Height = 290
        Align = alClient
        Caption = #24037#20154#21015#34920
        TabOrder = 0
        object cxgridWorker: TcxGrid
          Left = 2
          Top = 14
          Width = 488
          Height = 274
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          TabOrder = 0
          object cxgridtvWorker: TcxGridDBTableView
            DataController.DataSource = dsWorker
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NavigatorButtons.ConfirmDelete = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.GroupByBox = False
            object cxgdbcWorkerWorker_ID1: TcxGridDBColumn
              Caption = #21345#21495
              HeaderAlignmentHorz = taCenter
              Width = 79
              DataBinding.FieldName = 'Worker_ID'
            end
            object cxgdbcWorkerWorker_Name1: TcxGridDBColumn
              Caption = #22995#21517
              HeaderAlignmentHorz = taCenter
              DataBinding.FieldName = 'Worker_Name'
            end
            object cxgdbcWorkerWorker_Group1: TcxGridDBColumn
              Caption = #32452#21035
              PropertiesClassName = 'TcxLookupComboBoxProperties'
              Properties.KeyFieldNames = 'Worker_Group'
              Properties.ListColumns = <
                item
                  FieldName = 'Description'
                end>
              Properties.ListSource = dsWorkerGroup
              HeaderAlignmentHorz = taCenter
              Width = 100
              DataBinding.FieldName = 'Worker_Group'
            end
            object cxgdbcWorkerDepartment1: TcxGridDBColumn
              Caption = #37096#38376
              PropertiesClassName = 'TcxLookupComboBoxProperties'
              Properties.KeyFieldNames = 'Department'
              Properties.ListColumns = <
                item
                  FieldName = 'Description'
                end>
              Properties.ListSource = dsDepartment
              FooterAlignmentHorz = taCenter
              HeaderAlignmentHorz = taCenter
              SortOrder = soAscending
              Width = 138
              DataBinding.FieldName = 'Department'
            end
            object cxgdbcWorkerIs_Active1: TcxGridDBColumn
              Caption = #26159#21542#26377#25928
              HeaderAlignmentHorz = taCenter
              Width = 74
              DataBinding.FieldName = 'Is_Active'
            end
          end
          object cxGridlWorker: TcxGridLevel
            GridView = cxgridtvWorker
          end
        end
      end
      object grpWorkerInfo: TGroupBox
        Left = 500
        Top = 0
        Width = 163
        Height = 290
        Align = alRight
        Caption = #24037#20154#20449#24687
        TabOrder = 2
        OnExit = grpWorkerInfoExit
        object lbl1: TLabel
          Left = 14
          Top = 29
          Width = 30
          Height = 12
          Caption = #21345#21495':'
        end
        object lbl2: TLabel
          Left = 14
          Top = 80
          Width = 30
          Height = 12
          Caption = #22995#21517':'
        end
        object lbl4: TLabel
          Left = 14
          Top = 132
          Width = 30
          Height = 12
          Caption = #32452#21035':'
        end
        object lbl6: TLabel
          Left = 14
          Top = 183
          Width = 30
          Height = 12
          Caption = #37096#38376':'
        end
        object dbedtWorker_ID: TDBEdit
          Left = 32
          Top = 49
          Width = 105
          Height = 20
          DataField = 'Worker_ID'
          DataSource = dsWorker
          TabOrder = 0
        end
        object dbedtWorker_Name: TDBEdit
          Left = 32
          Top = 100
          Width = 105
          Height = 20
          DataField = 'Worker_Name'
          DataSource = dsWorker
          TabOrder = 1
        end
        object dblkcbbDepartment: TDBLookupComboBox
          Left = 32
          Top = 200
          Width = 105
          Height = 20
          DataField = 'Department'
          DataSource = dsWorker
          KeyField = 'Department'
          ListField = 'Description'
          ListSource = dsDepartment
          TabOrder = 3
        end
        object dbchk1: TDBCheckBox
          Left = 18
          Top = 232
          Width = 97
          Height = 17
          Caption = #26159#21542#26377#25928
          DataField = 'Is_Active'
          DataSource = dsWorker
          TabOrder = 4
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object dblkcbbWorkerGroup: TDBLookupComboBox
          Left = 32
          Top = 151
          Width = 105
          Height = 20
          DataField = 'Worker_Group'
          DataSource = dsWorker
          KeyField = 'Worker_Group'
          ListField = 'Description'
          ListSource = dsWorkerGroup
          TabOrder = 2
        end
      end
      object cxspl1: TcxSplitter
        Left = 492
        Top = 0
        Width = 8
        Height = 290
        HotZoneClassName = 'TcxXPTaskBarStyle'
        HotZone.SizePercent = 31
        AlignSplitter = salRight
        Control = grpWorker
      end
    end
    object tsLocation: TTabSheet
      Caption = #32452#21035#32500#25252'(&G)'
      ImageIndex = 1
      object grpWorkerGroupInfo: TGroupBox
        Left = 500
        Top = 0
        Width = 163
        Height = 290
        Align = alRight
        Caption = #24037#20154#32452#21035#20449#24687
        TabOrder = 2
        OnExit = grpWorkerGroupInfoExit
        object lbl3: TLabel
          Left = 14
          Top = 80
          Width = 54
          Height = 12
          Caption = #32452#21035#25551#36848':'
        end
        object lbl8: TLabel
          Left = 14
          Top = 29
          Width = 30
          Height = 12
          Caption = #32452#21035':'
        end
        object lbl5: TLabel
          Left = 14
          Top = 183
          Width = 30
          Height = 12
          Caption = #37096#38376':'
        end
        object dbedtWorkerGroup: TDBEdit
          Left = 32
          Top = 49
          Width = 105
          Height = 20
          DataField = 'Worker_Group'
          DataSource = dsWorkerGroup
          TabOrder = 0
        end
        object dbmmoDescription: TDBMemo
          Left = 32
          Top = 100
          Width = 105
          Height = 73
          DataField = 'Description'
          DataSource = dsWorkerGroup
          TabOrder = 1
        end
        object dblkcbb1: TDBLookupComboBox
          Left = 32
          Top = 200
          Width = 105
          Height = 20
          DataField = 'Department'
          DataSource = dsWorkerGroup
          KeyField = 'Department'
          ListField = 'Description'
          ListSource = dsDepartment
          TabOrder = 2
        end
        object dbchkIsActive: TDBCheckBox
          Left = 18
          Top = 232
          Width = 97
          Height = 17
          Caption = #26159#21542#26377#25928
          DataField = 'Is_Active'
          DataSource = dsWorkerGroup
          TabOrder = 3
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
      end
      object grpWorkerGroup: TGroupBox
        Left = 0
        Top = 0
        Width = 492
        Height = 290
        Align = alClient
        Caption = #24037#20154#32452#21035#21015#34920
        TabOrder = 0
        object cxgridworkerGroup: TcxGrid
          Left = 2
          Top = 14
          Width = 488
          Height = 274
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          TabOrder = 0
          object cxgridtvWorkerGroup: TcxGridDBTableView
            DataController.DataSource = dsWorkerGroup
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NavigatorButtons.ConfirmDelete = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.GroupByBox = False
            object cxgdbcWorkerGroupIden1: TcxGridDBColumn
              Caption = #33258#21160#22686#38271'ID'
              HeaderAlignmentHorz = taCenter
              Width = 81
              DataBinding.FieldName = 'Iden'
            end
            object cxgdbcWorkerGroupWorker_Group1: TcxGridDBColumn
              Caption = #32452#21035
              HeaderAlignmentHorz = taCenter
              Width = 105
              DataBinding.FieldName = 'Worker_Group'
            end
            object cxgdbcWorkerGroupDBColumn1: TcxGridDBColumn
              Caption = #37096#38376
              PropertiesClassName = 'TcxLookupComboBoxProperties'
              Properties.KeyFieldNames = 'Department'
              Properties.ListColumns = <
                item
                  FieldName = 'Description'
                end>
              Properties.ListSource = dsDepartment
              HeaderAlignmentHorz = taCenter
              Width = 77
              DataBinding.FieldName = 'Department'
            end
            object cxgdbcWorkerGroupDescription1: TcxGridDBColumn
              Caption = #25551#36848
              HeaderAlignmentHorz = taCenter
              Width = 121
              DataBinding.FieldName = 'Description'
            end
            object cxgdbcWorkerGroupIs_Active1: TcxGridDBColumn
              Caption = #26159#21542#26377#25928
              HeaderAlignmentHorz = taCenter
              Width = 78
              DataBinding.FieldName = 'Is_Active'
            end
          end
          object cxGridlWorkerGroup: TcxGridLevel
            GridView = cxgridtvWorkerGroup
          end
        end
      end
      object cxspl2: TcxSplitter
        Left = 492
        Top = 0
        Width = 8
        Height = 290
        HotZoneClassName = 'TcxXPTaskBarStyle'
        HotZone.SizePercent = 31
        AlignSplitter = salRight
        Control = grpWorkerGroup
      end
    end
  end
  object pnlTool: TPanel
    Left = 0
    Top = 317
    Width = 671
    Height = 34
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 1
    object pnlTools: TPanel
      Left = 2
      Top = 2
      Width = 667
      Height = 30
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      OnMouseMove = pnlToolsMouseMove
      DesignSize = (
        667
        30)
      object btnAdd: TSpeedButton
        Left = 6
        Top = 3
        Width = 80
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #26032#22686'(&N)'
        Enabled = False
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
      object btnModify: TSpeedButton
        Left = 87
        Top = 3
        Width = 80
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #32534#36753'(&M)'
        Enabled = False
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
        OnClick = btnModifyClick
      end
      object btnDelete: TSpeedButton
        Left = 254
        Top = 4
        Width = 80
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #21024#38500'(&D)'
        Enabled = False
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
      object btnUndo: TSpeedButton
        Left = 338
        Top = 4
        Width = 80
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #21462#28040'(&U)'
        Enabled = False
        Flat = True
        Glyph.Data = {
          66010000424D6601000000000000760000002800000014000000140000000100
          040000000000F0000000130B0000130B00001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
          FFFFFFFFC0C0FFFFFFFFFFFFFFFFFFFFC0C0FFFFFFFFFFFFFFFFFFFFC0C0FFFF
          FFFFFFFFFFFFFFFFC0C0FFFFFFFFFFFFFFFFFFFFC0C0FFFFFFFFFFFFFFFFFFFF
          C0C0FFFFFFFFFFFFF74FFFFFC0C0FFFF44444FFFFF47FFFFC0C0FFFF4444FFFF
          FFF4FFFFC0C0FFFF444FFFFFFFF4FFFFC0C0FFFF44F4FFFFFFF4FFFFC0C0FFFF
          4FFF44FFFF47FFFFC0C0FFFFFFFFFF44447FFFFFC0C0FFFFFFFFFFFFFFFFFFFF
          C0C0FFFFFFFFFFFFFFFFFFFFC0C0FFFFFFFFFFFFFFFFFFFFC0C0FFFFFFFFFFFF
          FFFFFFFFC0C0FFFFFFFFFFFFFFFFFFFFC0C0FFFFFFFFFFFFFFFFFFFFC0C0FFFF
          FFFFFFFFFFFFFFFFC0C0}
        OnClick = btnUndoClick
      end
      object btnExport: TSpeedButton
        Left = 423
        Top = 4
        Width = 80
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #23548#20986'(&E)'
        Enabled = False
        Flat = True
        Glyph.Data = {
          4E010000424D4E01000000000000760000002800000012000000120000000100
          040000000000D800000000000000000000001000000010000000000000000000
          BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777770000007777777777777777770000007777777777770007770000007444
          4400000006007700000074FFFF08880600080700000074F008000060EE070700
          000074FFFFF8060EE0047700000074F0088060EE00F47700000074FFFF060EE0
          00747700000074F00800EE0EE0047700000074FFFF0EE0F0EE047700000074F0
          080000F000047700000074FFFFFFFFFFFFF47700000074444444444444447700
          000074F444F444F444F477000000744444444444444477000000777777777777
          777777000000777777777777777777000000}
        OnClick = btnExportClick
      end
      object btnSave: TSpeedButton
        Left = 503
        Top = 4
        Width = 80
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
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
      object btnClose: TSpeedButton
        Left = 583
        Top = 4
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
        OnClick = btnCloseClick
      end
      object btnRefresh: TSpeedButton
        Left = 171
        Top = 3
        Width = 80
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #21047#26032'(&R)'
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000FF00FF00FF00FF00FF00
          FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
          FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000840000FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
          FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000084000000840000FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
          FF0000000000FFFFFF00FFFFFF00FFFFFF000084000000840000008400000084
          000000840000FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
          FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000084000000840000FFFF
          FF00FFFFFF0000840000FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
          FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000840000FFFF
          FF00FFFFFF0000840000FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
          FF0000000000FFFFFF00FFFFFF0000840000FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF0000840000FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
          FF0000000000FFFFFF00FFFFFF0000840000FFFFFF00FFFFFF0000840000FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
          FF0000000000FFFFFF00FFFFFF0000840000FFFFFF00FFFFFF00008400000084
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
          FF0000000000FFFFFF00FFFFFF00FFFFFF000084000000840000008400000084
          000000840000FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
          FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00008400000084
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
          FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000840000FFFF
          FF00FFFFFF0000000000000000000000000000000000FF00FF00FF00FF00FF00
          FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF0000000000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00
          FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00000000000000000000000000000000000000000000000000000000000000
          00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00}
        OnClick = btnRefreshClick
      end
    end
  end
  object dsWorker: TDataSource
    Left = 32
    Top = 56
  end
  object dsWorkerGroup: TDataSource
    Left = 32
    Top = 96
  end
  object dsDepartment: TDataSource
    Left = 64
    Top = 56
  end
end

object ModifyFactoryForm: TModifyFactoryForm
  Left = 167
  Top = 171
  Width = 1218
  Height = 542
  Caption = #25490#21333#24037#21378#20462#25913#19982#30830#35748
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgc1: TPageControl
    Left = 0
    Top = 0
    Width = 1202
    Height = 503
    ActivePage = ts1
    Align = alClient
    TabIndex = 0
    TabOrder = 0
    object ts1: TTabSheet
      Caption = #25490#21333#24037#21378#20462#25913
      OnShow = ts1Show
      object Panel2: TPanel
        Left = 401
        Top = 0
        Width = 793
        Height = 475
        Align = alClient
        TabOrder = 0
        object Panel3: TPanel
          Left = 1
          Top = 1
          Width = 791
          Height = 208
          Align = alTop
          TabOrder = 0
          object grp4: TGroupBox
            Left = 1
            Top = 1
            Width = 789
            Height = 127
            Align = alClient
            Caption = #25968#25454#36807#28388
            TabOrder = 0
            object rgFactory: TRadioGroup
              Left = 64
              Top = 11
              Width = 121
              Height = 110
              Caption = #24037#21378
              ItemIndex = 0
              Items.Strings = (
                'FA'
                'FG'
                #20840#37096)
              TabOrder = 0
            end
            object rgType_bill: TRadioGroup
              Left = 200
              Top = 11
              Width = 121
              Height = 110
              Caption = #21333#25454#31867#22411
              ItemIndex = 0
              Items.Strings = (
                #26032#21333
                #32763#21333
                #38656#24037#33402#30830#35748
                #24037#33402#24050#30830#35748
                #20840#37096)
              TabOrder = 1
            end
            object rgModify_Times: TRadioGroup
              Left = 340
              Top = 11
              Width = 121
              Height = 110
              Caption = #24050#20462#25913#27425#25968
              ItemIndex = 0
              Items.Strings = (
                '0'
                '1'
                '1'#27425#20197#19978
                #20840#37096)
              TabOrder = 2
            end
            object btnFilter: TBitBtn
              Left = 496
              Top = 40
              Width = 73
              Height = 25
              Caption = #36807#28388#25968#25454
              TabOrder = 3
              OnClick = btnFilterClick
            end
            object grp6: TGroupBox
              Left = 640
              Top = 24
              Width = 193
              Height = 65
              Caption = #25968#25454#30830#35748
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentColor = False
              ParentFont = False
              TabOrder = 4
              object btn8: TBitBtn
                Left = 56
                Top = 24
                Width = 89
                Height = 25
                Caption = #30830#35748#24037#21378
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
                OnClick = btn8Click
              end
            end
          end
          object grp3: TGroupBox
            Left = 1
            Top = 128
            Width = 789
            Height = 79
            Align = alBottom
            Caption = #25968#25454#25805#20316
            TabOrder = 1
            object lbl7: TLabel
              Left = 15
              Top = 28
              Width = 60
              Height = 13
              Caption = #20462#25913#21407#22240#65306
            end
            object dbedtconfirm_reason: TDBEdit
              Left = 240
              Top = 44
              Width = 145
              Height = 21
              DataField = 'confirm_reason'
              DataSource = dsConfirm
              TabOrder = 0
              Visible = False
            end
            object grp5: TGroupBox
              Left = 376
              Top = 8
              Width = 257
              Height = 65
              Caption = #25968#25454#25805#20316
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clDefault
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentColor = False
              ParentFont = False
              TabOrder = 1
              object btnModifyFactory: TBitBtn
                Left = 151
                Top = 21
                Width = 89
                Height = 25
                Caption = #20462#25913#24037#21378
                TabOrder = 0
                OnClick = btnModifyFactoryClick
              end
              object btn7: TBitBtn
                Left = 16
                Top = 21
                Width = 113
                Height = 25
                Caption = #25552#20132#24037#33402#21592#23457#25209
                TabOrder = 1
                OnClick = btn7Click
              end
            end
            object edtReason: TEdit
              Left = 72
              Top = 25
              Width = 297
              Height = 21
              TabOrder = 2
            end
            object btn5: TBitBtn
              Left = 672
              Top = 24
              Width = 57
              Height = 25
              Caption = #20851#38381
              TabOrder = 3
              OnClick = btn5Click
            end
          end
        end
        object cxgrdConfirm: TcxGrid
          Left = 1
          Top = 217
          Width = 791
          Height = 257
          Align = alClient
          TabOrder = 1
          object cxgrdConfirmTV: TcxGridDBTableView
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skCount
                FieldName = 'job_id'
              end>
            DataController.Summary.SummaryGroups = <>
            NavigatorButtons.ConfirmDelete = False
            OnCellClick = cxgrdConfirmTVCellClick
            OptionsView.GroupByBox = False
          end
          object cxgrdConfirmLV: TcxGridLevel
            GridView = cxgrdConfirmTV
          end
        end
        object cxspl_Only: TcxSplitter
          Left = 1
          Top = 209
          Width = 791
          Height = 8
          HotZoneClassName = 'TcxXPTaskBarStyle'
          AlignSplitter = salTop
          Control = Panel3
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 393
        Height = 475
        Align = alLeft
        TabOrder = 1
        object grp1: TGroupBox
          Left = 1
          Top = 1
          Width = 391
          Height = 72
          Align = alTop
          Caption = #21442#25968#35774#32622
          TabOrder = 0
          object lbl3: TLabel
            Left = 8
            Top = 39
            Width = 60
            Height = 13
            Caption = #32771#34385#22825#25968#65306
          end
          object lbl4: TLabel
            Left = 7
            Top = 17
            Width = 72
            Height = 13
            Caption = #35745#21010#26085#20219#21153#65306
          end
          object lbl5: TLabel
            Left = 149
            Top = 15
            Width = 36
            Height = 13
            Caption = #65288#30721#65289
          end
          object edtday: TEdit
            Left = 80
            Top = 36
            Width = 41
            Height = 21
            TabOrder = 0
            Text = '7'
          end
          object btnQuery: TBitBtn
            Left = 207
            Top = 32
            Width = 97
            Height = 25
            Caption = #26597#35810#20135#33021#36127#33655
            TabOrder = 1
            OnClick = btnQueryClick
          end
          object edtCapacity: TEdit
            Left = 75
            Top = 13
            Width = 71
            Height = 21
            TabOrder = 2
          end
        end
        object grp2: TGroupBox
          Left = 1
          Top = 73
          Width = 391
          Height = 401
          Align = alClient
          Caption = #20135#33021#36127#33655#24773#20917
          TabOrder = 1
          object cxGrid1: TcxGrid
            Left = 2
            Top = 15
            Width = 387
            Height = 384
            Align = alClient
            TabOrder = 0
            object cxGridCapacityTV: TcxGridDBTableView
              DataController.DataSource = dsCapacity
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              NavigatorButtons.ConfirmDelete = False
              object cxgrdbclmnGrid1DBTableView1DBColumn1: TcxGridDBColumn
                Caption = #25968#25454#29366#24577
                SortOrder = soAscending
                Width = 60
                DataBinding.FieldName = 'right_type'
              end
              object cxgrdbclmnGrid1DBTableView1DBColumn2: TcxGridDBColumn
                Caption = #26426#21488#24037#21378
                Width = 40
                DataBinding.FieldName = 'factory'
              end
              object cxgrdbclmnGrid1DBTableView1DBColumn3: TcxGridDBColumn
                Caption = #26426#21488
                Width = 40
                DataBinding.FieldName = 'machine_id'
              end
              object cxgrdbclmnGrid1DBTableView1DBColumn4: TcxGridDBColumn
                Caption = #24037#24207#31867#22411
                Width = 40
                DataBinding.FieldName = 'Operation_Type'
              end
              object cxgrdbclmnGrid1DBTableView1DBColumn5: TcxGridDBColumn
                Caption = #35774#23450#20135#33021
                Width = 65
                DataBinding.FieldName = 'machine_capacity'
              end
              object cxgrdbclmnGridCapacityTVDBColumn3: TcxGridDBColumn
                Caption = #20219#21153#21333#25968#37327
                DataBinding.FieldName = 'machine_plan'
              end
              object cxgrdbclmnGrid1DBTableView1DBColumn6: TcxGridDBColumn
                Caption = #25240#31639#21518#20219#21153#37327
                Width = 65
                DataBinding.FieldName = 'machine_plan_convert'
              end
              object cxgrdbclmnGrid1DBTableView1DBColumn7: TcxGridDBColumn
                Caption = #24046#20540
                Width = 65
                DataBinding.FieldName = 'diff'
              end
              object cxgrdbclmnGridCapacityTVDBColumn2: TcxGridDBColumn
                DataBinding.FieldName = 'machine_capacity_oneday'
              end
              object cxgrdbclmnGridCapacityTVDBColumn1: TcxGridDBColumn
                DataBinding.FieldName = 'white_type'
              end
            end
            object cxGridCapacityLV: TcxGridLevel
              GridView = cxGridCapacityTV
            end
          end
        end
      end
      object cxSplitter1: TcxSplitter
        Left = 393
        Top = 0
        Width = 8
        Height = 475
        HotZoneClassName = 'TcxXPTaskBarStyle'
        Control = Panel1
      end
    end
    object ts2: TTabSheet
      Caption = #24037#33402#23457#25209#20449#24687#26597#35810
      ImageIndex = 2
      object pnl1: TPanel
        Left = 0
        Top = 0
        Width = 1194
        Height = 89
        Align = alTop
        TabOrder = 0
        object grp8: TGroupBox
          Left = 1
          Top = 1
          Width = 1192
          Height = 87
          Align = alClient
          Caption = #25552#20132#33402#21592#23457#25209#20449#24687#26597#35810
          TabOrder = 0
          object btn2: TBitBtn
            Left = 56
            Top = 32
            Width = 89
            Height = 33
            Caption = #26597#35810
            TabOrder = 0
            OnClick = btn9Click
          end
        end
      end
      object pnl2: TPanel
        Left = 0
        Top = 89
        Width = 1194
        Height = 386
        Align = alClient
        Caption = 'pnl2'
        TabOrder = 1
        object cxGridArt_Check: TcxGrid
          Left = 1
          Top = 1
          Width = 1192
          Height = 384
          Align = alClient
          TabOrder = 0
          object cxGridArt_CheckTV: TcxGridDBTableView
            DataController.DataSource = dsArt_Check
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NavigatorButtons.ConfirmDelete = False
            OptionsSelection.CellSelect = False
          end
          object cxGridArt_CheckLV: TcxGridLevel
            GridView = cxGridArt_CheckTV
          end
        end
      end
    end
    object ts3: TTabSheet
      Caption = 'View-'#25152#26377#29366#24577#25968#25454#26126#32454
      ImageIndex = 2
      object pnl3: TPanel
        Left = 0
        Top = 0
        Width = 1194
        Height = 475
        Align = alClient
        Caption = 'pnl3'
        TabOrder = 0
        object cxGrid2: TcxGrid
          Left = 1
          Top = 1
          Width = 1192
          Height = 473
          Align = alClient
          TabOrder = 0
          object cxGrid2DBTableView1: TcxGridDBTableView
            DataController.DataSource = dsTest_all
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NavigatorButtons.ConfirmDelete = False
          end
          object cxGrid2Level1: TcxGridLevel
            GridView = cxGrid2DBTableView1
          end
        end
      end
    end
    object ts4: TTabSheet
      Caption = 'View-'#28418#30333#31867#22411#26631#35782
      ImageIndex = 3
      object pnl4: TPanel
        Left = 0
        Top = 0
        Width = 1194
        Height = 475
        Align = alClient
        Caption = 'pnl4'
        TabOrder = 0
        object cxGrid3: TcxGrid
          Left = 1
          Top = 1
          Width = 1192
          Height = 473
          Align = alClient
          TabOrder = 0
          object cxGridDBTableView1: TcxGridDBTableView
            DataController.DataSource = dsTest_White
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NavigatorButtons.ConfirmDelete = False
          end
          object cxGridLevel1: TcxGridLevel
            GridView = cxGridDBTableView1
          end
        end
      end
    end
  end
  object makesql2: TMakeSQL
    Caption = #26597#35810#26465#20214#32534#36753
    ItemNames = <
      item
        ParaCaption = #25552#20132#26102#38388
        ParaName = #25552#20132#26102#38388
        ParaType = SqlDate
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
        ParaCaption = #23457#25209#26102#38388
        ParaName = #23457#25209#26102#38388
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
    Left = 928
    Top = 40
  end
  object dsConfirm: TDataSource
    DataSet = cdsConfirm
    Left = 448
    Top = 344
  end
  object cdsConfirm: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 408
    Top = 344
  end
  object dsArt_Check: TDataSource
    DataSet = cdsArt_Check
    Left = 488
    Top = 200
  end
  object cdsArt_Check: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 448
    Top = 200
  end
  object SQL_Art_check: TMakeSQL
    Caption = #26597#35810#26465#20214#32534#36753
    ItemNames = <
      item
        ParaCaption = #25552#20132#26102#38388
        ParaName = 'a.submit_date'
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
        SelectField = 'submit_date'
      end
      item
        ParaCaption = #23457#25209#29366#24577
        ParaName = 'a.check_status'
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
    Left = 872
    Top = 40
  end
  object cdsCapacity: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 192
    Top = 200
  end
  object dsCapacity: TDataSource
    DataSet = cdsCapacity
    Left = 160
    Top = 200
  end
  object cdsTest_all: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 776
    Top = 120
  end
  object dsTest_all: TDataSource
    DataSet = cdsTest_all
    Left = 816
    Top = 120
  end
  object dsTest_White: TDataSource
    DataSet = cdsTest_White
    Left = 680
    Top = 168
  end
  object cdsTest_White: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 712
    Top = 168
  end
end

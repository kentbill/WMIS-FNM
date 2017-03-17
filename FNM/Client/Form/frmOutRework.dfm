object OutReworkFrom: TOutReworkFrom
  Left = 182
  Top = 134
  Width = 965
  Height = 698
  Caption = #22806#22238#20462#20135#37327#24405#20837
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
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnl9: TPanel
    Left = 0
    Top = 0
    Width = 957
    Height = 671
    Align = alClient
    Caption = 'pnl9'
    TabOrder = 0
    object pgc1: TPageControl
      Left = 1
      Top = 1
      Width = 955
      Height = 669
      ActivePage = pgOutReworkNew
      Align = alClient
      TabIndex = 0
      TabOrder = 0
      object pgOutReworkNew: TTabSheet
        Caption = #22806#22238#20462#20135#37327#24405#20837'-'#26032#22686
        object pnl12: TPanel
          Left = 0
          Top = 0
          Width = 947
          Height = 641
          Align = alClient
          Caption = 'pnl12'
          TabOrder = 0
          object pnl1: TPanel
            Left = 1
            Top = 1
            Width = 945
            Height = 280
            Align = alTop
            TabOrder = 0
            object pnl4: TPanel
              Left = 1
              Top = 49
              Width = 943
              Height = 230
              Align = alClient
              TabOrder = 0
              object cxgrd1: TcxGrid
                Left = 1
                Top = 1
                Width = 941
                Height = 228
                Align = alClient
                TabOrder = 0
                OnDblClick = cxgrd1DblClick
                object FabricTV: TcxGridDBTableView
                  OnDblClick = FabricTVDblClick
                  DataController.DataSource = dsFabric
                  DataController.Summary.DefaultGroupSummaryItems = <>
                  DataController.Summary.FooterSummaryItems = <>
                  DataController.Summary.SummaryGroups = <>
                  NavigatorButtons.ConfirmDelete = False
                  OptionsData.Editing = False
                  OptionsSelection.MultiSelect = True
                end
                object FabricLV: TcxGridLevel
                  GridView = FabricTV
                end
              end
            end
            object pnl5: TPanel
              Left = 1
              Top = 1
              Width = 943
              Height = 48
              Align = alTop
              TabOrder = 1
              object lbl1: TLabel
                Left = 46
                Top = 21
                Width = 65
                Height = 13
                Caption = #24067#21495'/'#21345#21495#65306
                Visible = False
              end
              object btnSave: TSpeedButton
                Left = 451
                Top = 16
                Width = 54
                Height = 25
                Caption = #20445#23384
                Visible = False
                OnClick = btnSaveClick
              end
              object btnSelect: TSpeedButton
                Left = 224
                Top = 16
                Width = 73
                Height = 25
                Caption = #24067#21495#26597#35810
                OnClick = btnSelectClick
              end
              object btnadd: TSpeedButton
                Left = 304
                Top = 16
                Width = 49
                Height = 25
                Caption = #22686#21152
                Visible = False
                OnClick = btnaddClick
              end
              object btnAlter: TSpeedButton
                Left = 376
                Top = 16
                Width = 49
                Height = 25
                Caption = #20462#25913
                Visible = False
                OnClick = btnAlterClick
              end
              object btnDelte: TSpeedButton
                Left = 536
                Top = 16
                Width = 57
                Height = 25
                Caption = #21024#38500
                Visible = False
                OnClick = btnDelteClick
              end
              object btn1: TSpeedButton
                Left = 616
                Top = 16
                Width = 49
                Height = 25
                Caption = #36864#20986
                Visible = False
                OnClick = btn1Click
              end
              object edtFabricNO: TEdit
                Left = 113
                Top = 19
                Width = 88
                Height = 21
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                TabOrder = 0
                Visible = False
              end
            end
          end
          object pnl2: TPanel
            Left = 1
            Top = 412
            Width = 945
            Height = 228
            Align = alBottom
            TabOrder = 1
            object cxgrdOutRemark: TcxGrid
              Left = 1
              Top = 1
              Width = 943
              Height = 226
              Align = alClient
              TabOrder = 0
              object OutRemarkTV: TcxGridDBTableView
                DataController.DataSource = dsOutRemark
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <>
                DataController.Summary.SummaryGroups = <>
                NavigatorButtons.ConfirmDelete = False
                OptionsData.Editing = False
                OptionsSelection.MultiSelect = True
              end
              object OutRemarkLV: TcxGridLevel
                GridView = OutRemarkTV
              end
            end
          end
          object pnl3: TPanel
            Left = 1
            Top = 281
            Width = 945
            Height = 131
            Align = alClient
            TabOrder = 2
            object pnl6: TPanel
              Left = 1
              Top = 1
              Width = 943
              Height = 40
              Align = alTop
              TabOrder = 0
              object btnAdds: TSpeedButton
                Left = 320
                Top = 5
                Width = 65
                Height = 33
                Caption = #28155#21152
                OnClick = btnAddsClick
              end
              object btnAddAll: TSpeedButton
                Left = 409
                Top = 5
                Width = 65
                Height = 33
                Caption = #20840#37096#28155#21152
                OnClick = btnAddAllClick
              end
              object btnCancel: TSpeedButton
                Left = 496
                Top = 5
                Width = 65
                Height = 33
                Caption = #21462#28040
                OnClick = btnCancelClick
              end
              object btn2: TSpeedButton
                Left = 216
                Top = 5
                Width = 73
                Height = 33
                Caption = #25163#24037#26032#22686
                Visible = False
                OnClick = btn2Click
              end
              object btnCancelAll: TSpeedButton
                Left = 581
                Top = 5
                Width = 73
                Height = 33
                Caption = #20840#37096#21462#28040
                OnClick = btnCancelAllClick
              end
              object btnSaves: TSpeedButton
                Left = 688
                Top = 5
                Width = 65
                Height = 33
                Caption = #20445#23384
                OnClick = btnSavesClick
              end
            end
            object pnl7: TPanel
              Left = 1
              Top = 41
              Width = 943
              Height = 89
              Align = alClient
              TabOrder = 1
              object lbl3: TLabel
                Left = 269
                Top = 13
                Width = 60
                Height = 13
                Caption = #22238#20462#21407#22240#65306
              end
              object lbl7: TLabel
                Left = 93
                Top = 40
                Width = 36
                Height = 13
                Caption = #31243#24230#65306
              end
              object lbl6: TLabel
                Left = 500
                Top = 39
                Width = 60
                Height = 13
                Caption = #22788#29702#24773#20917#65306
              end
              object lbl5: TLabel
                Left = 516
                Top = 13
                Width = 48
                Height = 13
                Caption = #22788#29702#20154#65306
              end
              object lbl4: TLabel
                Left = 261
                Top = 40
                Width = 60
                Height = 13
                Caption = #22788#29702#26041#24335#65306
              end
              object lbl2: TLabel
                Left = 40
                Top = 13
                Width = 84
                Height = 13
                Caption = #25240#31639#21518#30340#20135#37327#65306
              end
              object btn3: TSpeedButton
                Left = 754
                Top = 8
                Width = 82
                Height = 26
                Caption = #36873#25321#22788#29702#20154
                OnClick = btn3Click
              end
              object dbedtRework_reason: TDBEdit
                Left = 333
                Top = 11
                Width = 121
                Height = 21
                DataField = 'Rework_reason'
                DataSource = dsOutRemark
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                TabOrder = 0
              end
              object dbedtProduct_count: TDBEdit
                Left = 136
                Top = 13
                Width = 81
                Height = 21
                DataField = 'Product_count'
                DataSource = dsOutRemark
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                TabOrder = 1
              end
              object dbedtlevels: TDBEdit
                Left = 136
                Top = 37
                Width = 81
                Height = 21
                DataField = 'levels'
                DataSource = dsOutRemark
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                TabOrder = 2
              end
              object dbedthandle_situation: TDBEdit
                Left = 569
                Top = 39
                Width = 518
                Height = 21
                DataField = 'handle_situation'
                DataSource = dsOutRemark
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                TabOrder = 3
              end
              object dbedthandle_person: TDBEdit
                Left = 568
                Top = 13
                Width = 180
                Height = 21
                DataField = 'handle_person'
                DataSource = dsOutRemark
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                TabOrder = 4
              end
              object dbcbbhandle_way: TDBComboBox
                Left = 332
                Top = 37
                Width = 125
                Height = 21
                DataField = 'handle_way'
                DataSource = dsOutRemark
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                ItemHeight = 13
                Items.Strings = (
                  #25163#24037#27927#21518#19978#26426#21488
                  #25163#24037#27927#21518#36864#25104#21697
                  #21093#21367#36793
                  #21561#33457#27611
                  #25163#24037#25972#32428
                  #21098#33457
                  #21367#21518#36864#25104#21697)
                TabOrder = 5
                OnExit = dbcbbhandle_wayExit
              end
            end
          end
        end
      end
      object pgOutWorkQuery: TTabSheet
        Caption = #22238#20462#35760#24405#20135#37327'-'#26597#35810
        ImageIndex = 1
        object pnl8: TPanel
          Left = 0
          Top = 0
          Width = 939
          Height = 49
          Align = alTop
          Caption = 'pnl8'
          TabOrder = 0
          object pnl11: TPanel
            Left = 1
            Top = 1
            Width = 937
            Height = 47
            Align = alClient
            TabOrder = 0
            object btn4: TSpeedButton
              Left = 272
              Top = 8
              Width = 65
              Height = 25
              Caption = #26597#35810
              OnClick = btn4Click
            end
          end
        end
        object pnl10: TPanel
          Left = 0
          Top = 49
          Width = 939
          Height = 581
          Align = alClient
          Caption = 'pnl10'
          TabOrder = 1
          object cxgrdOutReworkQuery: TcxGrid
            Left = 1
            Top = 1
            Width = 937
            Height = 579
            Align = alClient
            TabOrder = 0
            object cxgrdbtblvwOutReworkQueryLV: TcxGridDBTableView
              DataController.DataSource = dsOutReworkQuery
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              NavigatorButtons.ConfirmDelete = False
            end
            object cxgrdOutReworkQueryTV: TcxGridLevel
              GridView = cxgrdbtblvwOutReworkQueryLV
            end
          end
        end
      end
    end
  end
  object cdsOutRemark: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 264
    Top = 544
  end
  object dsOutRemark: TDataSource
    DataSet = cdsOutRemark
    Left = 211
    Top = 536
  end
  object cdsFabric: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 336
    Top = 256
  end
  object dsFabric: TDataSource
    DataSet = cdsFabric
    Left = 384
    Top = 256
  end
  object sqmmk1: TMakeSQL
    Caption = #26597#35810#26465#20214#32534#36753
    ItemNames = <
      item
        ParaCaption = #21697#21517
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
        ParaCaption = #24067#21495
        ParaName = 'Fabric_no'
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
        ParaCaption = #30721#38271
        ParaName = 'Quantity'
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
        ParaCaption = #22238#20462#21407#22240
        ParaName = 'Rework_reason'
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
        ParaCaption = #25163#24037#22788#29702#26041#24335
        ParaName = 'handle_way'
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
        ParaCaption = #22788#29702#20154
        ParaName = 'handle_person'
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
        ParaCaption = #30331#35760#26102#38388
        ParaName = 'operate_time'
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
    Left = 152
    Top = 240
  end
  object cdsOutReworkQuery: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 680
    Top = 256
  end
  object dsOutReworkQuery: TDataSource
    DataSet = cdsOutReworkQuery
    Left = 728
    Top = 256
  end
  object cdsWorkers: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 520
    Top = 128
  end
  object dsWorkers: TDataSource
    Left = 464
    Top = 128
  end
end

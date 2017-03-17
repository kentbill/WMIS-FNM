object AddPriceForm: TAddPriceForm
  Left = 178
  Top = 187
  Width = 970
  Height = 507
  Caption = #36755#20837#22870#32602'/'#38169#39033
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object TPanel
    Left = 0
    Top = 0
    Width = 305
    Height = 469
    Align = alLeft
    BevelInner = bvLowered
    TabOrder = 0
    object pnl_Only: TPanel
      Left = 2
      Top = 2
      Width = 301
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lbl1: TLabel
        Left = 8
        Top = 8
        Width = 41
        Height = 13
        Caption = #21697#21517'(&G):'
      end
      object cxbe_GFKeyValue: TcxButtonEdit
        Left = 58
        Top = 5
        Width = 175
        Height = 23
        Properties.Buttons = <
          item
            Default = True
            Glyph.Data = {
              EE000000424DEE000000000000007600000028000000100000000F0000000100
              0400000000007800000000000000000000001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
              888800000888880000080F000888880F00080F000888880F0008000000080000
              000800F000000F00000800F000F00F00000800F000F00F000008800000000000
              0088880F00080F000888880000080000088888800088800088888880F08880F0
              888888800088800088888888888888888888}
            Kind = bkGlyph
          end>
        Properties.OnButtonClick = cxbe_GFKeyValuePropertiesButtonClick
        TabOrder = 0
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        OnKeyDown = cxbe_GFKeyValueKeyDown
      end
    end
    object pnl_Only2: TPanel
      Left = 2
      Top = 32
      Width = 301
      Height = 3
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
    end
    object grp1: TGroupBox
      Left = 2
      Top = 35
      Width = 301
      Height = 432
      Align = alClient
      Caption = #21345#21495#21015#34920'(&D):'
      TabOrder = 2
      object lv_CardList: TListView
        Left = 2
        Top = 15
        Width = 297
        Height = 415
        Align = alClient
        Columns = <
          item
            Caption = #21345#21495
            Width = 100
          end
          item
            Caption = #30721#38271
          end>
        GridLines = True
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnClick = lv_CardListClick
      end
    end
  end
  object TPanel
    Left = 305
    Top = 0
    Width = 649
    Height = 469
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object TPanel
      Left = 0
      Top = 0
      Width = 649
      Height = 105
      Align = alTop
      BevelInner = bvLowered
      TabOrder = 0
      object Label3: TLabel
        Left = 6
        Top = 34
        Width = 51
        Height = 13
        Caption = #21457#29616#26426#21488':'
      end
      object Label4: TLabel
        Left = 6
        Top = 56
        Width = 51
        Height = 13
        Caption = #36131#20219#24037#24207':'
      end
      object Label5: TLabel
        Left = 6
        Top = 77
        Width = 51
        Height = 13
        Caption = #38169#39033#21407#22240':'
      end
      object Label7: TLabel
        Left = 5
        Top = 13
        Width = 39
        Height = 13
        Caption = #21457#29616#20154':'
      end
      object Label8: TLabel
        Left = 256
        Top = 54
        Width = 39
        Height = 13
        Caption = #36131#20219#20154':'
      end
      object Label9: TLabel
        Left = 256
        Top = 33
        Width = 51
        Height = 13
        Caption = #22870#21169#20998#39069':'
      end
      object cbb_Class: TComboBox
        Left = 311
        Top = 30
        Width = 126
        Height = 21
        Style = csDropDownList
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ItemHeight = 13
        TabOrder = 2
        Items.Strings = (
          '2'
          '5'
          '10'
          '15'
          '20'
          '30'
          '50')
      end
      object cbb_ReasonType: TComboBox
        Left = 59
        Top = 52
        Width = 190
        Height = 21
        Style = csDropDownList
        DropDownCount = 30
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ItemHeight = 13
        TabOrder = 0
        OnChange = cbb_ReasonTypeChange
      end
      object cbbReasonName: TComboBox
        Left = 59
        Top = 73
        Width = 574
        Height = 21
        DropDownCount = 30
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ItemHeight = 13
        TabOrder = 1
        OnChange = cbbReasonNameChange
      end
      object cbb_Operator: TComboBox
        Left = 60
        Top = 8
        Width = 189
        Height = 21
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ItemHeight = 13
        TabOrder = 3
      end
      object cbb_Machine: TComboBox
        Left = 59
        Top = 30
        Width = 190
        Height = 21
        Style = csDropDownList
        DropDownCount = 16
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ItemHeight = 13
        TabOrder = 4
        OnChange = cbb_MachineChange
      end
      object cbb_BeforeAfter: TComboBox
        Left = 311
        Top = 52
        Width = 322
        Height = 21
        Style = csDropDownList
        Enabled = False
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ItemHeight = 13
        TabOrder = 5
      end
      object edtRespone: TEdit
        Left = 311
        Top = 52
        Width = 322
        Height = 21
        Enabled = False
        TabOrder = 6
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 442
      Width = 649
      Height = 27
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        649
        27)
      object btn_SaveAccident: TButton
        Left = 496
        Top = 2
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        Default = True
        TabOrder = 0
        OnClick = btn_SaveAccidentClick
      end
      object btn_Cancel: TButton
        Left = 574
        Top = 2
        Width = 75
        Height = 25
        Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
        Anchors = [akRight, akBottom]
        Cancel = True
        Caption = #21462#28040'(&C)'
        ModalResult = 2
        TabOrder = 1
        OnClick = btn_CancelClick
      end
      object Button1: TButton
        Left = 376
        Top = 3
        Width = 73
        Height = 22
        Anchors = [akLeft, akBottom]
        Caption = #21047#26032'(R)'
        TabOrder = 2
        OnClick = Button1Click
      end
    end
    object cxgridPrice: TcxGrid
      Left = 0
      Top = 105
      Width = 649
      Height = 337
      Align = alClient
      TabOrder = 2
      object cxgridtvPrice: TcxGridDBTableView
        DataController.DataSource = dsPrice
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.GroupByBox = False
      end
      object cxgridlPrice: TcxGridLevel
        GridView = cxgridtvPrice
      end
    end
  end
  object dsPrice: TDataSource
    DataSet = cdsprice
    Left = 448
    Top = 264
  end
  object cdsprice: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 488
    Top = 264
  end
  object cdsReasonType: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 400
    Top = 264
  end
end

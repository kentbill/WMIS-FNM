object ChangeDepartmentForm: TChangeDepartmentForm
  Left = 89
  Top = 118
  Width = 651
  Height = 463
  Caption = #24211#23384#24067#36716#37096#38376
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = True
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object pnlClient: TPanel
    Left = 0
    Top = 0
    Width = 643
    Height = 395
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlClient'
    TabOrder = 0
    object pnlCard: TPanel
      Left = 0
      Top = 206
      Width = 643
      Height = 189
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object pnl2: TPanel
        Left = 0
        Top = 0
        Width = 643
        Height = 32
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object btnAdd: TSpeedButton
          Left = 178
          Top = 5
          Width = 78
          Height = 25
          Caption = #28155#21152'(&A)'
          Flat = True
          OnClick = btnAddClick
        end
        object btnUp: TSpeedButton
          Left = 504
          Top = 5
          Width = 78
          Height = 25
          Caption = #20840#37096'(&U)'
          Flat = True
          OnClick = btnUpClick
        end
        object btnCancel: TSpeedButton
          Left = 396
          Top = 5
          Width = 78
          Height = 25
          Caption = #25764#28040'(&C)'
          Flat = True
          OnClick = btnCancelClick
        end
        object btnDown: TSpeedButton
          Left = 287
          Top = 5
          Width = 78
          Height = 25
          Caption = #20840#37096'(&D)'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          OnClick = btnDownClick
        end
      end
      object cxdbgSelect: TcxGrid
        Left = 0
        Top = 32
        Width = 643
        Height = 157
        Align = alClient
        TabOrder = 1
        object cxdbgtvSelect: TcxGridDBTableView
          OnKeyDown = cxdbgtvSelectKeyDown
          DataController.DataSource = dsSelect
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.MultiSelect = True
          OptionsView.GroupByBox = False
        end
        object cxGridlSelect: TcxGridLevel
          GridView = cxdbgtvSelect
        end
      end
    end
    object cxSplitter1: TcxSplitter
      Left = 0
      Top = 198
      Width = 643
      Height = 8
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salBottom
      Control = pnlCard
    end
    object cxdbgUnSelect: TcxGrid
      Left = 0
      Top = 0
      Width = 643
      Height = 198
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object cxdbgtvUnSelect: TcxGridDBTableView
        OnKeyDown = cxdbgtvUnSelectKeyDown
        DataController.DataSource = dsUnSelect
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.MultiSelect = True
      end
      object cxGridlUnSelect: TcxGridLevel
        GridView = cxdbgtvUnSelect
      end
    end
    object lstFabricNO: TListBox
      Left = 3
      Top = 113
      Width = 86
      Height = 80
      ItemHeight = 12
      TabOrder = 3
      Visible = False
    end
  end
  object TPanel
    Left = 0
    Top = 398
    Width = 643
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object TPanel
      Left = 0
      Top = 4
      Width = 643
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        643
        34)
      object btnSave: TSpeedButton
        Left = 467
        Top = 7
        Width = 78
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #20445#23384'(&S)'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        OnClick = btnSaveClick
      end
      object btnClose: TSpeedButton
        Left = 552
        Top = 7
        Width = 78
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btnCloseClick
      end
      object btnRefresh: TSpeedButton
        Left = 297
        Top = 7
        Width = 78
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #21047#26032'(&R)'
        Flat = True
        OnClick = btnRefreshClick
      end
      object lbl2: TLabel
        Left = 66
        Top = 15
        Width = 54
        Height = 12
        Anchors = [akRight, akBottom]
        Caption = #36716#21521#37096#38376':'
      end
      object btnQuery: TSpeedButton
        Left = 382
        Top = 7
        Width = 78
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #26597#35810'(&Q)'
        Flat = True
        OnClick = btnQueryClick
      end
      object cbbCurrentDept: TComboBox
        Left = 123
        Top = 9
        Width = 122
        Height = 20
        Style = csDropDownList
        Anchors = [akRight, akBottom]
        ItemHeight = 12
        TabOrder = 0
      end
    end
  end
  object TPanel
    Left = 0
    Top = 395
    Width = 643
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
  end
  object cdsUnSelect: TClientDataSet
    Aggregates = <>
    Params = <>
    OnFilterRecord = cdsUnSelectFilterRecord
    Left = 65535
    Top = 166
  end
  object dsUnSelect: TDataSource
    DataSet = cdsUnSelect
    Left = 30
    Top = 165
  end
  object cdsSelect: TClientDataSet
    Aggregates = <>
    Params = <>
    OnFilterRecord = cdsSelectFilterRecord
    Left = 3
    Top = 365
  end
  object dsSelect: TDataSource
    DataSet = cdsSelect
    Left = 34
    Top = 365
  end
  object msPublic: TMakeSQL
    Caption = #26597#35810#26465#20214#32534#36753
    ItemNames = <
      item
        ParaCaption = #25910#24067#21333#21495
        ParaName = 'Note_NO'
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
        ParaCaption = #25490#21333#21495
        ParaName = 'Job_NO'
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
        ParaCaption = #36710#29260#21495
        ParaName = 'Car_NO'
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
        ParaName = 'Fabric_NO'
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
        ParaCaption = #21697#21517'ID'
        ParaName = 'GF_ID'
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
        InputSource = SelectInSelectItem
        ParaCaption = #26469#28304
        ParaName = 'Source'
        SelectItem.Strings = (
          'G1'
          'G3')
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
        InputSource = SelectInSelectItem
        ParaCaption = #24067#30340#31867#22411
        ParaName = 'Material_Quality'
        SelectItem.Strings = (
          #27491#24120#24067
          #22788#29702#24067)
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
    Left = 168
    Top = 296
  end
end

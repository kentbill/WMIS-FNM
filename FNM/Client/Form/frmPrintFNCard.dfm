object PrintFNCardForm: TPrintFNCardForm
  Left = 323
  Top = 153
  Width = 867
  Height = 471
  Caption = #25171#21345
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poDefault
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object pnl5: TPanel
    Left = 0
    Top = 400
    Width = 851
    Height = 33
    Align = alBottom
    AutoSize = True
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object pnl3: TPanel
      Left = 0
      Top = 0
      Width = 851
      Height = 33
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
        851
        33)
      object btn_Save: TSpeedButton
        Left = 697
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #25171#21360'(&P)'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        OnClick = btn_SaveClick
      end
      object btnClose: TSpeedButton
        Left = 781
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btnCloseClick
      end
      object lblCar_NO: TLabel
        Left = 577
        Top = 13
        Width = 42
        Height = 12
        Anchors = [akTop, akRight]
        Caption = #36710#29260#21495':'
      end
      object btn_Query: TSpeedButton
        Left = 361
        Top = 5
        Width = 75
        Height = 25
        Caption = #26597#35810'(&Q)'
        Flat = True
        OnClick = btn_RefreshClick
      end
      object btn_Refresh: TSpeedButton
        Left = 279
        Top = 5
        Width = 75
        Height = 25
        Caption = #21047#26032'(&R)'
        Flat = True
        OnClick = btn_RefreshClick
      end
      object edtNormalCar_NO: TEdit
        Left = 621
        Top = 7
        Width = 68
        Height = 20
        Anchors = [akTop, akRight]
        MaxLength = 3
        TabOrder = 0
      end
      object rb_Normal: TRadioButton
        Left = 1
        Top = 11
        Width = 97
        Height = 17
        Caption = #27491#24120#24067' '#26469#28304':'
        Checked = True
        TabOrder = 1
        TabStop = True
        OnClick = rb_NormalClick
      end
      object rb_Repair: TRadioButton
        Left = 218
        Top = 11
        Width = 57
        Height = 17
        Caption = #22238#20462#24067
        TabOrder = 2
        OnClick = rb_NormalClick
      end
      object cbbNormal: TComboBox
        Left = 95
        Top = 7
        Width = 120
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 3
        OnEnter = cbbNormalEnter
      end
    end
  end
  object TPanel
    Left = 0
    Top = 0
    Width = 851
    Height = 397
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pnlCard: TPanel
      Left = 0
      Top = 208
      Width = 851
      Height = 189
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object pnl2: TPanel
        Left = 0
        Top = 0
        Width = 851
        Height = 34
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object btnAdd: TSpeedButton
          Left = 179
          Top = 5
          Width = 75
          Height = 25
          Caption = #28155#21152'(&A)'
          Flat = True
          OnClick = btnAddClick
        end
        object btnUp: TSpeedButton
          Left = 449
          Top = 5
          Width = 75
          Height = 25
          Caption = #20840#37096'(&U)'
          Flat = True
          OnClick = btnCancelClick
        end
        object btnCancel: TSpeedButton
          Left = 359
          Top = 5
          Width = 75
          Height = 25
          Caption = #25764#28040'(&C)'
          Flat = True
          OnClick = btnCancelClick
        end
        object btnDown: TSpeedButton
          Left = 269
          Top = 5
          Width = 75
          Height = 25
          Caption = #20840#37096'(&D)'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          OnClick = btnAddClick
        end
      end
      object cxgridFabricPrintCard: TcxGrid
        Left = 0
        Top = 37
        Width = 851
        Height = 152
        Align = alClient
        TabOrder = 1
        object cxdbgtvFabricPrintCard: TcxGridDBTableView
          OnKeyDown = cxdbgtvFabricPrintCardKeyDown
          DataController.DataSource = dsFabricPrintCard
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
        object cxGridlFabricPrintCard: TcxGridLevel
          GridView = cxdbgtvFabricPrintCard
        end
      end
      object TPanel
        Left = 0
        Top = 34
        Width = 851
        Height = 3
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
      end
    end
    object cxspl1: TcxSplitter
      Left = 0
      Top = 200
      Width = 851
      Height = 8
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salBottom
      Control = pnlCard
    end
    object cxgrid_Fabric_NO: TcxGrid
      Left = 0
      Top = 0
      Width = 851
      Height = 200
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object cxgridtv_Fabric_NO: TcxGridDBTableView
        OnKeyDown = cxgridtv_Fabric_NOKeyDown
        DataController.DataSource = dsNormal
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OnCustomDrawCell = cxgridtv_Fabric_NOCustomDrawCell
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.MultiSelect = True
      end
      object cxGridl_Fabric_NO: TcxGridLevel
        GridView = cxgridtv_Fabric_NO
      end
    end
  end
  object TPanel
    Left = 0
    Top = 397
    Width = 851
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
  end
  object cdsNormal: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 6
    Top = 319
  end
  object dsNormal: TDataSource
    DataSet = cdsNormal
    Left = 37
    Top = 320
  end
  object cdsFabricPrintCard: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 72
    Top = 320
  end
  object dsFabricPrintCard: TDataSource
    DataSet = cdsFabricPrintCard
    Left = 104
    Top = 320
  end
  object sqmmk1: TMakeSQL
    Caption = #26597#35810#26465#20214#32534#36753
    ItemNames = <
      item
        ParaCaption = #21697#21517#32534#21495
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
        ParaCaption = #20132#26399
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
      end>
    Position = poDesktopCenter
    Left = 136
    Top = 320
  end
end

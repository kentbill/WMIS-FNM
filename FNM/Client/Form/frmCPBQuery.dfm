inherited CPBQueryForm: TCPBQueryForm
  Left = 146
  Top = 125
  Caption = 'CPB'#33394#21495#26597#35810
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 680
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
    object btnClose: TSpeedButton
      Left = 267
      Top = 5
      Width = 78
      Height = 25
      Caption = #36864#20986'(&X)'
      Flat = True
      OnClick = btnCloseClick
    end
    object btnQuery: TSpeedButton
      Left = 185
      Top = 5
      Width = 78
      Height = 25
      Caption = #26597#35810'(&Q)'
      Flat = True
      OnClick = btnQueryClick
    end
    object Label1: TLabel
      Left = 11
      Top = 14
      Width = 42
      Height = 12
      Caption = 'FN'#33394#21495':'
    end
    object edtColorCode: TEdit
      Left = 59
      Top = 6
      Width = 121
      Height = 20
      ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
      TabOrder = 0
      OnKeyDown = edtColorCodeKeyDown
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 34
    Width = 680
    Height = 408
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 1
    object cxSplitter2: TcxSplitter
      Left = 352
      Top = 1
      Width = 8
      Height = 406
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salRight
      DragThreshold = 2
      Control = Panel2
    end
    object cxdbgCPB: TcxGrid
      Left = 1
      Top = 1
      Width = 351
      Height = 406
      Align = alClient
      TabOrder = 1
      object cxdbgtvCPBQuery: TcxGridDBTableView
        OnDblClick = cxdbgtvCPBQueryDblClick
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OnCustomDrawCell = cxdbgtvCPBQueryCustomDrawCell
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.GroupByBox = False
      end
      object cxGridlSelect: TcxGridLevel
        GridView = cxdbgtvCPBQuery
      end
    end
    object Panel2: TPanel
      Left = 360
      Top = 1
      Width = 319
      Height = 406
      Align = alRight
      BevelOuter = bvNone
      Caption = 'Panel2'
      TabOrder = 2
      object cxGrid1: TcxGrid
        Left = 0
        Top = 0
        Width = 319
        Height = 209
        Align = alTop
        TabOrder = 0
        object cxGridTVRecipeDtl: TcxGridDBTableView
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
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridTVRecipeDtl
        end
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 209
        Width = 319
        Height = 197
        Align = alClient
        Caption = #22823#36135#21697#21517#21015#34920
        TabOrder = 1
        object lbGFNO: TListBox
          Left = 2
          Top = 14
          Width = 315
          Height = 181
          Hint = #21491#38190#24555#25463#33756#21333#21487#22797#21046#22823#36135#21697#21517
          Align = alClient
          ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
          ItemHeight = 12
          ParentShowHint = False
          PopupMenu = PMCopyGf_No
          ShowHint = True
          TabOrder = 0
        end
      end
    end
  end
  object cdsCPBQuery: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 107
    Top = 349
  end
  object dsCPBQuery: TDataSource
    DataSet = cdsCPBQuery
    Left = 74
    Top = 357
  end
  object msPublic: TMakeSQL
    Caption = #26597#35810#26465#20214#32534#36753
    ItemNames = <
      item
        ParaCaption = #33394#21495
        ParaName = 'a.FN_Color_Code'
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
        ParaCaption = #26469#26679#21333#21495
        ParaName = 'a.LB_NO'
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
        ParaCaption = #33394#21517
        ParaName = 'a.Fab_Color_Name'
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
        ParaCaption = #23458#25143
        ParaName = 'a.Customer'
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
        ParaName = 'b.GF_NO'
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
        ParaCaption = #39068#33394#31616#31216
        ParaName = 'a.Simple_Color_Name'
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
        ParaCaption = #23545#33394#20154#21592
        ParaName = 'a.Color_Matcher'
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
        ParaCaption = #32463#32433#32433#25903
        ParaName = 'b.Warp_Count'
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
        ParaCaption = #32428#32433#32433#25903
        ParaName = 'b.Weft_Count'
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
        ParaCaption = #32463#32433#23494#24230
        ParaName = 'b.Warp_Density'
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
        ParaCaption = #32428#32433#23494#24230
        ParaName = 'b.Weft_Density'
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
  object dsRecipeDtl: TDataSource
    DataSet = cdsRecipeDtl
    Left = 346
    Top = 229
  end
  object cdsRecipeDtl: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 403
    Top = 189
  end
  object PMCopyGf_No: TPopupMenu
    Left = 480
    Top = 312
    object NCopyGf_No: TMenuItem
      Caption = #22797#21046#22823#36135#21697#21517
      OnClick = NCopyGf_NoClick
    end
  end
end

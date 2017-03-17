inherited CPBManageForm: TCPBManageForm
  Left = 196
  Top = 116
  Width = 858
  Height = 487
  Caption = #26679#26495#25910#36865
  OldCreateOrder = True
  Position = poDefault
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object pnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 850
    Height = 427
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object pnlCard: TPanel
      Left = 2
      Top = 268
      Width = 846
      Height = 157
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object pnl2: TPanel
        Left = 0
        Top = 0
        Width = 846
        Height = 35
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
          Left = 145
          Top = 5
          Width = 75
          Height = 25
          Caption = #28155#21152'(&A)'
          Flat = True
          OnClick = btnAddClick
        end
        object btnUp: TSpeedButton
          Left = 407
          Top = 5
          Width = 75
          Height = 25
          Caption = #20840#37096'(&U)'
          Flat = True
          OnClick = btnUpClick
        end
        object btnCancel: TSpeedButton
          Left = 319
          Top = 5
          Width = 75
          Height = 25
          Caption = #25764#28040'(&C)'
          Flat = True
          OnClick = btnCancelClick
        end
        object btnDown: TSpeedButton
          Left = 232
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
          OnClick = btnDownClick
        end
        object pnlSend: TPanel
          Left = 504
          Top = 0
          Width = 233
          Height = 35
          BevelOuter = bvLowered
          TabOrder = 0
          object lbSendCount: TLabel
            Left = 121
            Top = 16
            Width = 48
            Height = 12
            Caption = #36865#26679#20010#25968
          end
          object Label1: TLabel
            Left = 8
            Top = 16
            Width = 54
            Height = 12
            Caption = #25171#26495#25209#27425':'
          end
          object edtSendCount: TEdit
            Left = 176
            Top = 8
            Width = 36
            Height = 20
            TabOrder = 0
            Text = '1'
          end
          object edtPrintTimes: TEdit
            Left = 70
            Top = 8
            Width = 36
            Height = 20
            TabOrder = 1
            Text = '1'
          end
        end
      end
      object cxdbgSelect: TcxGrid
        Left = 0
        Top = 35
        Width = 846
        Height = 122
        Align = alClient
        TabOrder = 1
        object cxdbgtvSelect: TcxGridDBTableView
          OnKeyDown = cxdbgtvSelectKeyDown
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OnCustomDrawCell = cxdbgtvSelectCustomDrawCell
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
      Left = 2
      Top = 260
      Width = 846
      Height = 8
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salTop
      Control = cxdbgUnSelect
    end
    object cxdbgUnSelect: TcxGrid
      Left = 2
      Top = 2
      Width = 846
      Height = 258
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object cxdbgtvUnSelect: TcxGridDBTableView
        OnKeyDown = cxdbgtvUnSelectKeyDown
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OnCustomDrawCell = cxdbgtvUnSelectCustomDrawCell
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.MultiSelect = True
        OptionsView.GroupByBox = False
      end
      object cxGridlUnSelect: TcxGridLevel
        GridView = cxdbgtvUnSelect
      end
    end
  end
  object TPanel
    Left = 0
    Top = 430
    Width = 850
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object pnlTop: TPanel
      Left = 0
      Top = -2
      Width = 850
      Height = 32
      Align = alBottom
      Anchors = [akRight, akBottom]
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        850
        32)
      object btnRefresh: TSpeedButton
        Left = 576
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #21047#26032'(&R)'
        Flat = True
        OnClick = btnRefreshClick
      end
      object btnSave: TSpeedButton
        Left = 672
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        Flat = True
        OnClick = btnSaveClick
      end
      object btnClose: TSpeedButton
        Left = 765
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btnCloseClick
      end
      object lbSigner: TLabel
        Left = 405
        Top = 12
        Width = 42
        Height = 12
        Anchors = [akRight, akBottom]
        Caption = #25509#25910#20154':'
        Visible = False
      end
      object rgType: TRadioGroup
        Left = 290
        Top = -1
        Width = 104
        Height = 30
        Anchors = [akRight, akBottom]
        Columns = 2
        Ctl3D = False
        ItemIndex = 0
        Items.Strings = (
          #25509#25910
          #36865#20986)
        ParentCtl3D = False
        TabOrder = 0
        OnClick = rgTypeClick
      end
      object edtSigner: TEdit
        Left = 447
        Top = 6
        Width = 120
        Height = 20
        Anchors = [akRight, akBottom]
        CharCase = ecUpperCase
        TabOrder = 1
        Visible = False
      end
    end
  end
  object TPanel
    Left = 0
    Top = 427
    Width = 850
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
  end
  object cdsUnSelect: TClientDataSet
    Aggregates = <>
    Params = <>
    OnFilterRecord = cdsUnSelectFilterRecord
    Left = 4
    Top = 229
  end
  object dsUnSelect: TDataSource
    DataSet = cdsUnSelect
    Left = 34
    Top = 229
  end
  object cdsSelect: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    OnFilterRecord = cdsSelectFilterRecord
    Left = 8
    Top = 423
  end
  object dsSelect: TDataSource
    DataSet = cdsSelect
    Left = 41
    Top = 423
  end
end

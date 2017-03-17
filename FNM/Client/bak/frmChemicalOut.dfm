inherited ChemicalOutForm: TChemicalOutForm
  Left = 121
  Top = 138
  Width = 611
  Height = 421
  Caption = #21270#24037#26009#20986#24211
  OldCreateOrder = True
  Position = poDefault
  WindowState = wsMaximized
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 12
  object cxgrid_ChemicalOut1: TcxGrid
    Left = 0
    Top = 0
    Width = 419
    Height = 357
    Align = alClient
    TabOrder = 0
    object cxgridtv_ChemicalOut: TcxGridDBTableView
      DataController.DataSource = ds_ChemicalOut
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NavigatorButtons.ConfirmDelete = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
    end
    object cxGridl_ChemicalOut: TcxGridLevel
      GridView = cxgridtv_ChemicalOut
    end
  end
  object pnl_Only: TPanel
    Left = 427
    Top = 0
    Width = 176
    Height = 357
    Align = alRight
    BevelInner = bvLowered
    TabOrder = 4
    object TPanel
      Left = 2
      Top = 118
      Width = 172
      Height = 89
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        172
        89)
      object cbb_ChemicalName: TComboBox
        Left = 8
        Top = 4
        Width = 161
        Height = 78
        Style = csSimple
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 12
        TabOrder = 0
      end
    end
    object TPanel
      Left = 2
      Top = 352
      Width = 172
      Height = 3
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 4
    end
    object TPanel
      Left = 2
      Top = 349
      Width = 172
      Height = 3
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 3
    end
    object TPanel
      Left = 2
      Top = 2
      Width = 172
      Height = 116
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        172
        116)
      object TStaticText
        Left = 8
        Top = 97
        Width = 70
        Height = 16
        Caption = #21270#24037#26009'(&C):'
        TabOrder = 4
      end
      object cbb_Destination: TComboBox
        Left = 8
        Top = 70
        Width = 161
        Height = 20
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 12
        TabOrder = 3
      end
      object txt_Only: TStaticText
        Left = 8
        Top = 53
        Width = 82
        Height = 16
        Caption = #28040#32791#37096#38376'(&C):'
        TabOrder = 2
      end
      object dtp_ChemicalCheckDate: TDateTimePicker
        Left = 8
        Top = 24
        Width = 161
        Height = 20
        Anchors = [akLeft, akTop, akRight]
        CalAlignment = dtaLeft
        Date = 38273.3875157176
        Time = 38273.3875157176
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 1
      end
      object TStaticText
        Left = 8
        Top = 4
        Width = 82
        Height = 16
        BevelOuter = bvNone
        Caption = #20986#24211#26085#26399'(&I):'
        TabOrder = 0
      end
    end
    object TPanel
      Left = 2
      Top = 207
      Width = 172
      Height = 142
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      DesignSize = (
        172
        142)
      object btn_AppendRecord: TSpeedButton
        Left = 9
        Top = 89
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #28155#21152'(&A)'
        Flat = True
        OnClick = btn_AppendRecordClick
      end
      object btn_EditRecord: TSpeedButton
        Left = 89
        Top = 89
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20462#25913'(&E)'
        Flat = True
        OnClick = btn_EditRecordClick
      end
      object btn_DeleteRecord: TSpeedButton
        Left = 9
        Top = 117
        Width = 155
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #21024#38500'(&D)'
        Flat = True
        OnClick = btn_DeleteRecordClick
      end
      object cxse_OutQuantity: TcxSpinEdit
        Left = 8
        Top = 65
        Width = 161
        Height = 20
        Anchors = [akLeft, akTop, akRight]
        Properties.SpinButtons.ShowFastButtons = True
        Properties.OnChange = ChangeAQuantityControl
        TabOrder = 3
      end
      object rb_OutQuantity: TRadioButton
        Left = 8
        Top = 48
        Width = 64
        Height = 17
        Caption = #20184#20986#25968':'
        TabOrder = 2
        OnClick = ClickRadioButton
      end
      object rb_StockQuantity: TRadioButton
        Left = 8
        Top = 5
        Width = 64
        Height = 17
        Caption = #32467#23384#25968':'
        TabOrder = 0
      end
      object cxce_StockQuantity: TcxCalcEdit
        Left = 8
        Top = 22
        Width = 157
        Height = 20
        EditValue = 0
        Properties.OnChange = ChangeAQuantityControl
        TabOrder = 1
        OnClick = ClickRadioButton
        OnEnter = cxce_StockQuantityEnter
      end
    end
  end
  object TPanel
    Left = 0
    Top = 360
    Width = 603
    Height = 34
    Align = alBottom
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 2
    object TPanel
      Left = 0
      Top = 0
      Width = 603
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        603
        34)
      object btn_Help: TSpeedButton
        Left = 11
        Top = 4
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = #24110#21161'(&H)'
        Enabled = False
        Flat = True
      end
      object btn_Save: TSpeedButton
        Left = 356
        Top = 4
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        Flat = True
        OnClick = btn_SaveClick
      end
      object btn_Query: TSpeedButton
        Left = 439
        Top = 4
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #26597#35810'(&Q)'
        Enabled = False
        Flat = True
        OnClick = btn_QueryClick
      end
      object btn_Exit: TSpeedButton
        Left = 522
        Top = 4
        Width = 75
        Height = 25
        Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
        Anchors = [akRight, akBottom]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btn_ExitClick
      end
    end
  end
  object TPanel
    Left = 0
    Top = 357
    Width = 603
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
  end
  object cxspl1: TcxSplitter
    Left = 419
    Top = 0
    Width = 8
    Height = 357
    HotZoneClassName = 'TcxXPTaskBarStyle'
    AlignSplitter = salRight
    Control = pnl_Only
  end
  object cds_ChemicalOut: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Record_Status'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Chemical_ID'
        DataType = ftInteger
      end
      item
        Name = 'Chemical_Name'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Chemical_Type'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Used_QTY'
        DataType = ftBCD
        Precision = 9
        Size = 2
      end
      item
        Name = 'Keep_Qty'
        DataType = ftBCD
        Precision = 9
        Size = 2
      end
      item
        Name = 'Use_Department'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'Out_Date'
        DataType = ftDateTime
      end
      item
        Name = 'Operator'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Current_Department'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterScroll = cds_ChemicalOutAfterScroll
    Left = 88
    Top = 360
  end
  object ds_ChemicalOut: TDataSource
    DataSet = cds_ChemicalOut
    Left = 120
    Top = 360
  end
end

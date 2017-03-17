inherited ChemicalInForm: TChemicalInForm
  Left = 147
  Top = 159
  Width = 667
  Height = 440
  Caption = #21270#24037#26009#20837#24211
  OldCreateOrder = True
  Position = poDefault
  WindowState = wsMaximized
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 12
  object TPanel
    Left = 0
    Top = 379
    Width = 659
    Height = 34
    Align = alBottom
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 2
    object TPanel
      Left = 0
      Top = 0
      Width = 659
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        659
        34)
      object btn_Save: TSpeedButton
        Left = 397
        Top = 4
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        Flat = True
        OnClick = btn_SaveClick
      end
      object btn_Query: TSpeedButton
        Left = 485
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
        Left = 574
        Top = 4
        Width = 75
        Height = 25
        Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
        Anchors = [akRight, akBottom]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btn_ExitClick
      end
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
      object btn1: TSpeedButton
        Left = 307
        Top = 4
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #21462#39046#26009#25968#25454
        Enabled = False
        Flat = True
      end
    end
  end
  object TPanel
    Left = 0
    Top = 376
    Width = 659
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
  end
  object cxgridGrid_ChemicalInDtl: TcxGrid
    Left = 0
    Top = 0
    Width = 475
    Height = 376
    Align = alClient
    Anchors = [akTop, akRight, akBottom]
    TabOrder = 0
    LookAndFeel.NativeStyle = True
    object cxgridtv_ChemicalInDtl: TcxGridDBTableView
      DataController.DataSource = ds_ChemicalInDtl
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
    object cxGridlGridLevel_ChemicalInDtl: TcxGridLevel
      GridView = cxgridtv_ChemicalInDtl
    end
  end
  object cxspl1: TcxSplitter
    Left = 475
    Top = 0
    Width = 8
    Height = 376
    HotZoneClassName = 'TcxXPTaskBarStyle'
    AlignSplitter = salRight
    Control = pnl_Only
  end
  object pnl_Only: TPanel
    Left = 483
    Top = 0
    Width = 176
    Height = 376
    Align = alRight
    BevelInner = bvLowered
    TabOrder = 4
    object TPanel
      Left = 2
      Top = 169
      Width = 172
      Height = 107
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        172
        107)
      object cbb_ChemicalName: TComboBox
        Left = 8
        Top = 0
        Width = 157
        Height = 106
        Style = csSimple
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 12
        TabOrder = 0
      end
    end
    object TPanel
      Left = 2
      Top = 276
      Width = 172
      Height = 98
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      DesignSize = (
        172
        98)
      object btn_AppendRecord: TSpeedButton
        Left = 9
        Top = 43
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #28155#21152'(&A)'
        Flat = True
        OnClick = btn_AppendRecordClick
      end
      object btn_EditRecord: TSpeedButton
        Left = 89
        Top = 43
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20462#25913'(&E)'
        Flat = True
        OnClick = btn_EditReco1rdClick
      end
      object btn_DeleteRecord: TSpeedButton
        Left = 9
        Top = 71
        Width = 155
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #21024#38500'(&D)'
        Flat = True
        OnClick = btn_EditReco1rdClick
      end
      object TStaticText
        Left = 8
        Top = 2
        Width = 70
        Height = 16
        Caption = #25910#20837#25968'(&C):'
        TabOrder = 1
      end
      object cxse_Quantity: TcxSpinEdit
        Left = 8
        Top = 16
        Width = 157
        Height = 20
        Properties.SpinButtons.ShowFastButtons = True
        TabOrder = 0
      end
    end
    object TPanel
      Left = 2
      Top = 2
      Width = 172
      Height = 167
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        172
        167)
      object TStaticText
        Left = 8
        Top = 145
        Width = 70
        Height = 16
        Caption = #21270#24037#26009'(&C):'
        TabOrder = 6
      end
      object edt_NoteNO: TEdit
        Left = 8
        Top = 116
        Width = 157
        Height = 20
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 5
      end
      object TStaticText
        Left = 8
        Top = 97
        Width = 70
        Height = 16
        Caption = #39046#26009#21333'(&C):'
        TabOrder = 4
      end
      object cbb_Source: TComboBox
        Left = 8
        Top = 70
        Width = 157
        Height = 20
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 12
        TabOrder = 3
      end
      object TStaticText
        Left = 8
        Top = 53
        Width = 58
        Height = 16
        Caption = #26469#28304'(&C):'
        TabOrder = 2
      end
      object dtp_ChemicalInDate: TDateTimePicker
        Left = 8
        Top = 24
        Width = 157
        Height = 20
        Anchors = [akLeft, akTop, akRight]
        CalAlignment = dtaLeft
        Date = 38376.5074239815
        Time = 38376.5074239815
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 1
      end
      object txt_Only: TStaticText
        Left = 8
        Top = 4
        Width = 82
        Height = 16
        Caption = #20837#24211#26085#26399'(&I):'
        TabOrder = 0
      end
    end
  end
  object cds_ChemicalInDtl: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'In_Date'
        DataType = ftDateTime
      end
      item
        Name = 'Note_NO'
        Attributes = [faFixed]
        DataType = ftString
        Size = 14
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
        Name = 'Source'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'In_Quantity'
        DataType = ftBCD
        Precision = 9
        Size = 2
      end
      item
        Name = 'Price'
        DataType = ftBCD
        Size = 4
      end
      item
        Name = 'Current_Department'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'Operator'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterScroll = cds_ChemicalInDtlAfterScroll
    Left = 96
    Top = 376
  end
  object ds_ChemicalInDtl: TDataSource
    DataSet = cds_ChemicalInDtl
    Left = 128
    Top = 376
  end
end

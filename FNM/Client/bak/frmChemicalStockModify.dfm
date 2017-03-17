object ChemicalStockModifyForm: TChemicalStockModifyForm
  Left = 0
  Top = 168
  Width = 800
  Height = 397
  Caption = #21270#24037#26009#24211#23384#20462#25913
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object TPanel
    Left = 0
    Top = 336
    Width = 792
    Height = 34
    Align = alBottom
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 1
    object TPanel
      Left = 0
      Top = 0
      Width = 792
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        792
        34)
      object btn2: TButton
        Left = 620
        Top = 4
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = btn_SaveRecordClick
      end
      object btn_Exit: TButton
        Left = 710
        Top = 4
        Width = 75
        Height = 25
        Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
        Anchors = [akRight, akBottom]
        Cancel = True
        Caption = #36864#20986'(&X)'
        TabOrder = 2
        OnClick = btn_ExitClick
      end
      object btn_Help: TButton
        Left = 8
        Top = 4
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = #24110#21161'(&H)'
        Enabled = False
        TabOrder = 0
      end
    end
  end
  object pgc_Only: TPageControl
    Left = 0
    Top = 0
    Width = 792
    Height = 336
    ActivePage = ts1
    Align = alClient
    Style = tsFlatButtons
    TabHeight = 22
    TabIndex = 0
    TabOrder = 0
    object ts1: TTabSheet
      Caption = #20837#24211#25968#25454#20462#25913
      object pnl_Only: TPanel
        Left = 0
        Top = 239
        Width = 784
        Height = 65
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 2
        object TStaticText
          Left = 18
          Top = 13
          Width = 70
          Height = 16
          Caption = #21270#24037#26009'(&C):'
          TabOrder = 1
        end
        object TStaticText
          Left = 466
          Top = 40
          Width = 70
          Height = 16
          Caption = #25910#20837#25968'(&C):'
          TabOrder = 8
        end
        object cxSE_Quantity: TcxSpinEdit
          Left = 527
          Top = 36
          Width = 145
          Height = 20
          Properties.SpinButtons.ShowFastButtons = True
          Properties.ValueType = vtFloat
          Style.BorderStyle = ebsUltraFlat
          TabOrder = 6
        end
        object TStaticText
          Left = 18
          Top = 40
          Width = 58
          Height = 16
          Caption = #26469#28304'(&C):'
          TabOrder = 4
        end
        object TStaticText
          Left = 250
          Top = 40
          Width = 70
          Height = 16
          Caption = #39046#26009#21333'(&C):'
          TabOrder = 5
        end
        object TStaticText
          Left = 681
          Top = 40
          Width = 58
          Height = 16
          Caption = #21333#20215'(&C):'
          TabOrder = 9
        end
        object cxSE_Price: TcxSpinEdit
          Left = 724
          Top = 36
          Width = 145
          Height = 20
          Properties.SpinButtons.ShowFastButtons = True
          Properties.ValueType = vtFloat
          Style.BorderStyle = ebsUltraFlat
          TabOrder = 7
        end
        object cbb_Source: TComboBox
          Left = 95
          Top = 36
          Width = 145
          Height = 20
          BevelKind = bkFlat
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 2
        end
        object edt_ChemicalNameIn: TEdit
          Left = 95
          Top = 9
          Width = 145
          Height = 18
          Color = clBtnFace
          Ctl3D = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 0
        end
        object edt_NoteNO: TEdit
          Left = 311
          Top = 36
          Width = 145
          Height = 18
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 3
        end
      end
      object Grid_ChemicalInData: TcxGrid
        Left = 0
        Top = 0
        Width = 784
        Height = 236
        Align = alClient
        TabOrder = 0
        object GridView_ChemicalInData: TcxGridDBTableView
          DataController.DataSource = ds_ChemicalInData
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
        end
        object GridLevel_ChemicalInData: TcxGridLevel
          GridView = GridView_ChemicalInData
        end
      end
      object TPanel
        Left = 0
        Top = 236
        Width = 784
        Height = 3
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
      end
    end
    object ts2: TTabSheet
      Caption = #20986#24211#25968#25454#20462#25913
      object pnl2: TPanel
        Left = 0
        Top = 239
        Width = 784
        Height = 65
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 2
        object TStaticText
          Left = 21
          Top = 77
          Width = 70
          Height = 16
          Caption = #25910#20837#25968'(&C):'
          TabOrder = 6
        end
        object TStaticText
          Left = 250
          Top = 40
          Width = 70
          Height = 16
          Caption = #20184#20986#25968'(&O):'
          TabOrder = 5
        end
        object TStaticText
          Left = 18
          Top = 13
          Width = 70
          Height = 16
          Caption = #21270#24037#26009'(&C):'
          TabOrder = 1
        end
        object txt_Only: TStaticText
          Left = 18
          Top = 40
          Width = 82
          Height = 16
          Caption = #28040#32791#37096#38376'(&C):'
          TabOrder = 3
        end
        object edt_ChemicalNameOut: TEdit
          Left = 95
          Top = 9
          Width = 145
          Height = 18
          Color = clBtnFace
          Ctl3D = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 0
        end
        object cxSE_OutQuantity: TcxSpinEdit
          Left = 311
          Top = 36
          Width = 145
          Height = 20
          Properties.SpinButtons.ShowFastButtons = True
          Style.BorderStyle = ebsUltraFlat
          TabOrder = 4
        end
        object cbb_Destination: TComboBox
          Left = 95
          Top = 36
          Width = 145
          Height = 20
          BevelKind = bkFlat
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 2
        end
      end
      object Grid_ChemicalOutData: TcxGrid
        Left = 0
        Top = 0
        Width = 784
        Height = 236
        Align = alClient
        TabOrder = 0
        object GridView_ChemicalOutData: TcxGridDBTableView
          DataController.DataSource = ds_ChemicalOutData
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
        end
        object GridLevel_ChemicalOutData: TcxGridLevel
          GridView = GridView_ChemicalOutData
        end
      end
      object TPanel
        Left = 0
        Top = 236
        Width = 784
        Height = 3
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
      end
    end
  end
  object TStaticText
    Left = 212
    Top = 9
    Width = 34
    Height = 16
    Caption = #26085#26399':'
    TabOrder = 2
  end
  object dtp_ChemicalInDate: TDateTimePicker
    Left = 247
    Top = 3
    Width = 93
    Height = 20
    CalAlignment = dtaLeft
    Date = 38273.3875157176
    Time = 38273.3875157176
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 3
  end
  object btn_Query: TButton
    Left = 348
    Top = 1
    Width = 75
    Height = 25
    Caption = #26597#35810'(&Q)'
    Default = True
    TabOrder = 4
    OnClick = btn_QueryClick
  end
  object cds_ChemicalInData: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = AfterScrollData
    Left = 88
    Top = 340
  end
  object ds_ChemicalInData: TDataSource
    DataSet = cds_ChemicalInData
    Left = 120
    Top = 340
  end
  object cds_ChemicalOutData: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = AfterScrollData
    Left = 152
    Top = 340
  end
  object ds_ChemicalOutData: TDataSource
    DataSet = cds_ChemicalOutData
    Left = 184
    Top = 340
  end
end

inherited ChemicalForm: TChemicalForm
  Left = 40
  Top = 75
  Width = 812
  Caption = #23548#20837#21270#24037#26009
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 804
    Height = 419
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 0
    object cxGrid1: TcxGrid
      Left = 1
      Top = 1
      Width = 609
      Height = 417
      Align = alClient
      TabOrder = 0
      object cxGridDBTV: TcxGridDBTableView
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
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGridDBTV
      end
    end
    object GroupBox1: TGroupBox
      Left = 618
      Top = 1
      Width = 185
      Height = 417
      Align = alRight
      Caption = #20462#25913#21270#24037#26009
      TabOrder = 1
      DesignSize = (
        185
        417)
      object TStaticText
        Left = 2
        Top = 14
        Width = 181
        Height = 16
        Align = alTop
        Caption = #21270#24037#26009'(&C):'
        TabOrder = 0
      end
      object cbbChemicalName: TComboBox
        Left = 12
        Top = 32
        Width = 157
        Height = 260
        Style = csSimple
        Anchors = [akLeft, akTop, akRight, akBottom]
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ItemHeight = 12
        TabOrder = 1
      end
      object Panel3: TPanel
        Left = 2
        Top = 296
        Width = 181
        Height = 119
        Align = alBottom
        BevelOuter = bvLowered
        TabOrder = 2
        DesignSize = (
          181
          119)
        object Label1: TLabel
          Left = 18
          Top = 72
          Width = 30
          Height = 12
          Caption = #25968#37327':'
        end
        object btnUpdate: TSpeedButton
          Left = 18
          Top = 90
          Width = 146
          Height = 25
          Caption = #26356#25913'(&U)'
          Flat = True
          OnClick = btnUpdateClick
        end
        object edtQuantity: TEdit
          Left = 59
          Top = 64
          Width = 105
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
          TabOrder = 0
          Text = '0'
        end
        object RadioGroup1: TRadioGroup
          Left = 18
          Top = 30
          Width = 147
          Height = 30
          Columns = 2
          Ctl3D = False
          ItemIndex = 0
          Items.Strings = (
            #26412#26085#25910
            #26412#26085#23384)
          ParentCtl3D = False
          TabOrder = 1
        end
        object StaticText1: TStaticText
          Left = 18
          Top = 13
          Width = 34
          Height = 16
          Anchors = [akRight, akBottom]
          Caption = #26085#26399':'
          TabOrder = 2
        end
        object dtpChangeDate: TDateTimePicker
          Left = 59
          Top = 9
          Width = 105
          Height = 20
          Anchors = [akRight, akBottom]
          CalAlignment = dtaLeft
          Date = 38845.4370261574
          Time = 38845.4370261574
          DateFormat = dfShort
          DateMode = dmComboBox
          ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
          Kind = dtkDate
          ParseInput = False
          TabOrder = 3
        end
      end
    end
    object cxSplitter1: TcxSplitter
      Left = 610
      Top = 1
      Width = 8
      Height = 417
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salRight
      Control = GroupBox1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 419
    Width = 804
    Height = 34
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      804
      34)
    object btnQuery: TSpeedButton
      Left = 480
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #26597#35810'(&Q)'
      Flat = True
      OnClick = btnQueryClick
    end
    object btnExcel: TSpeedButton
      Left = 562
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #23548#20837'(&I)'
      Flat = True
      OnClick = btnExcelClick
    end
    object btnSave: TSpeedButton
      Left = 642
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #20445#23384'(&S)'
      Flat = True
      OnClick = btnSaveClick
    end
    object btnExit: TSpeedButton
      Left = 723
      Top = 6
      Width = 75
      Height = 25
      Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
      Anchors = [akRight, akBottom]
      Caption = #36864#20986'(&X)'
      Flat = True
      OnClick = btnExitClick
    end
    object txt_Only: TStaticText
      Left = 342
      Top = 17
      Width = 34
      Height = 16
      Anchors = [akRight, akBottom]
      Caption = #26085#26399':'
      TabOrder = 0
    end
    object dtpQueryDate: TDateTimePicker
      Left = 371
      Top = 9
      Width = 105
      Height = 20
      Anchors = [akRight, akBottom]
      CalAlignment = dtaLeft
      Date = 38845
      Time = 38845
      DateFormat = dfShort
      DateMode = dmComboBox
      ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
    end
  end
  object dsChemical: TDataSource
    DataSet = cdsChemical
    Left = 64
    Top = 144
  end
  object adodsImport: TADODataSet
    Parameters = <>
    Left = 64
    Top = 184
  end
  object cdsChemical: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 64
    Top = 112
  end
end

object PrintFNCardAndLabelFrom: TPrintFNCardAndLabelFrom
  Left = 235
  Top = 84
  Width = 1024
  Height = 607
  Caption = #25171#21345','#25171#26631#31614
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxSplitter1: TcxSplitter
    Left = 0
    Top = 456
    Width = 1016
    Height = 8
    HotZoneClassName = 'TcxMediaPlayer8Style'
    AlignSplitter = salBottom
    Control = GroupBox1
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 464
    Width = 1016
    Height = 116
    Align = alBottom
    Caption = #37325#25171#26631#31614
    TabOrder = 1
    object cxGrdPrintLabel: TcxGrid
      Left = 2
      Top = 15
      Width = 782
      Height = 99
      Align = alClient
      TabOrder = 0
      object cxTVPrintLabel: TcxGridDBTableView
        DataController.DataSource = DSRePrintLabel
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
      object cxLevelPrintLabel: TcxGridLevel
        GridView = cxTVPrintLabel
      end
    end
    object Panel6: TPanel
      Left = 784
      Top = 15
      Width = 230
      Height = 99
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object SBtnQueryReLab: TSpeedButton
        Left = 140
        Top = 0
        Width = 75
        Height = 25
        Caption = #26597#35810
        OnClick = SBtnQueryReLabClick
      end
      object SBtnRePrintLabel: TSpeedButton
        Left = 140
        Top = 33
        Width = 77
        Height = 25
        Caption = #37325#25171#26631#31614
        OnClick = SBtnRePrintLabelClick
      end
      object Label1: TLabel
        Left = 8
        Top = 4
        Width = 57
        Height = 13
        AutoSize = False
        Caption = #26469#28304#37096#38376
      end
      object SBtnExit: TSpeedButton
        Left = 140
        Top = 66
        Width = 75
        Height = 25
        Caption = #36864#20986
        OnClick = SBtnExitClick
      end
      object CBBRePSrcDepartment: TComboBox
        Left = 64
        Top = 0
        Width = 65
        Height = 21
        ItemHeight = 13
        TabOrder = 0
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 1016
    Height = 456
    Align = alClient
    Caption = #25171#21345', '#25171#26631#31614
    TabOrder = 2
    object PnlFullCar: TPanel
      Left = 2
      Top = 15
      Width = 1012
      Height = 196
      Align = alClient
      TabOrder = 0
      object cxGrdFullCar: TcxGrid
        Left = 1
        Top = 1
        Width = 1010
        Height = 157
        Align = alClient
        TabOrder = 0
        object cxTVFullCar: TcxGridDBTableView
          OnDblClick = cxTVFullCarDblClick
          DataController.DataSource = DSFullCar
          DataController.Filter.OnBeforeChange = cxTVFullCarDataControllerFilterBeforeChange
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OnCustomDrawCell = cxTVFullCarCustomDrawCell
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.MultiSelect = True
        end
        object cxLevelFullCar: TcxGridLevel
          GridView = cxTVFullCar
        end
      end
      object Panel5: TPanel
        Left = 1
        Top = 158
        Width = 1010
        Height = 37
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object SBtnEmpty: TSpeedButton
          Left = 881
          Top = 6
          Width = 75
          Height = 25
          Caption = #25764#38144
          Visible = False
          OnClick = SBtnEmptyClick
        end
        object SBtnCancel: TSpeedButton
          Left = 590
          Top = 6
          Width = 75
          Height = 25
          Caption = #25764#38144
          OnClick = SBtnCancelClick
        end
        object SBtnAll: TSpeedButton
          Left = 795
          Top = 6
          Width = 75
          Height = 25
          Caption = #28155#21152
          Visible = False
          OnClick = SBtnAllClick
        end
        object SBtnAdd: TSpeedButton
          Left = 504
          Top = 6
          Width = 75
          Height = 25
          Caption = #28155#21152
          OnClick = SBtnAddClick
        end
        object SBtnRefresh: TSpeedButton
          Left = 149
          Top = 6
          Width = 75
          Height = 25
          Caption = #21047#26032
          OnClick = SBtnRefreshClick
        end
        object Label2: TLabel
          Left = 16
          Top = 12
          Width = 57
          Height = 13
          AutoSize = False
          Caption = #26469#28304#37096#38376
        end
        object CBAll: TCheckBox
          Left = 240
          Top = 10
          Width = 73
          Height = 17
          Caption = #38598#20013#25972#29702
          Checked = True
          State = cbChecked
          TabOrder = 0
          Visible = False
        end
        object CBBSrcDepartment: TComboBox
          Left = 72
          Top = 8
          Width = 65
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
        end
      end
    end
    object pnlWaitPrintCard: TPanel
      Left = 2
      Top = 219
      Width = 1012
      Height = 235
      Align = alBottom
      TabOrder = 1
      object cxGrdWaitPrintCard: TcxGrid
        Left = 1
        Top = 1
        Width = 1010
        Height = 196
        Align = alClient
        TabOrder = 0
        object cxTVWaitPrintCard: TcxGridDBTableView
          OnDblClick = cxTVWaitPrintCardDblClick
          DataController.DataSource = DSWaitPrintCard
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OnCustomDrawCell = cxTVFullCarCustomDrawCell
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.MultiSelect = True
          OptionsView.GroupByBox = False
        end
        object cxLevelWaitPrintCard: TcxGridLevel
          GridView = cxTVWaitPrintCard
        end
      end
      object Panel7: TPanel
        Left = 1
        Top = 197
        Width = 1010
        Height = 37
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object Panel1: TPanel
          Left = 184
          Top = 0
          Width = 826
          Height = 37
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 0
          object SBtnPrint: TSpeedButton
            Left = 729
            Top = 6
            Width = 89
            Height = 25
            Caption = #25171#21345#25171#26631#31614
            OnClick = SBtnPrintClick
          end
          object Label4: TLabel
            Left = 16
            Top = 12
            Width = 73
            Height = 13
            AutoSize = False
            Caption = #25171#21345#25171#21360#26426
          end
          object Label3: TLabel
            Left = 368
            Top = 12
            Width = 89
            Height = 13
            AutoSize = False
            Caption = #25171#26631#31614#25171#21360#26426
          end
          object chkPreviewLabel: TCheckBox
            Left = 663
            Top = 10
            Width = 48
            Height = 17
            Caption = #39044#35272
            TabOrder = 0
          end
          object chkPreviewCard: TCheckBox
            Left = 297
            Top = 10
            Width = 56
            Height = 17
            Caption = #39044#35272
            TabOrder = 1
          end
          object CBBCardPrinter: TComboBox
            Left = 88
            Top = 8
            Width = 201
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 2
            OnChange = CBBCardPrinterChange
          end
          object CBBLabelPrinter: TComboBox
            Left = 452
            Top = 8
            Width = 201
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 3
          end
        end
      end
    end
    object cxSplitter2: TcxSplitter
      Left = 2
      Top = 211
      Width = 1012
      Height = 8
      HotZoneClassName = 'TcxMediaPlayer8Style'
      AlignSplitter = salBottom
      Control = pnlWaitPrintCard
    end
  end
  object CDSFullCar: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 176
    Top = 64
  end
  object CDSWaitPrintCard: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 168
    Top = 272
  end
  object DSFullCar: TDataSource
    DataSet = CDSFullCar
    Left = 208
    Top = 64
  end
  object DSWaitPrintCard: TDataSource
    DataSet = CDSWaitPrintCard
    Left = 200
    Top = 272
  end
  object CDSRePrintLabel: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 152
    Top = 488
  end
  object DSRePrintLabel: TDataSource
    DataSet = CDSRePrintLabel
    Left = 192
    Top = 488
  end
  object MSQLRePrint: TMakeSQL
    Caption = #26597#35810#26465#20214#32534#36753
    ItemNames = <
      item
        ParaCaption = #24067#21495
        ParaName = 'A.Fabric_No'
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
        ParaCaption = #21697#21517#21495
        ParaName = 'A.GF_ID'
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
        ParaName = 'B.GF_NO'
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
        ParaName = 'A.Job_No'
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
        ParaCaption = #39564#24067#26426#21488#21495
        ParaName = 'A.Machine_NO'
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
        ParaCaption = #33853#24067#26426#21488#21495
        ParaName = 'A.Machine_ID'
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
        ParaCaption = #39564#24067#26102#38388
        ParaName = 'A.Inspect_Time'
        ParaType = SqlDate
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
    Left = 232
    Top = 488
  end
  object CDSPrintReturn: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 168
    Top = 320
  end
  object CDSFNCard: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 200
    Top = 320
  end
end

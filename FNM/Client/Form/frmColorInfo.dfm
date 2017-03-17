object ColorInfoForm: TColorInfoForm
  Left = 172
  Top = 180
  Width = 1280
  Height = 710
  Caption = #39068#33394#20449#24687
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 1264
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 22
      Top = 17
      Width = 36
      Height = 13
      Caption = #21697#21517#65306
    end
    object btnQuery: TSpeedButton
      Left = 259
      Top = 11
      Width = 78
      Height = 25
      Caption = #26597#35810'(&Q)'
      Flat = True
      OnClick = btnQueryClick
    end
    object edtGFNO: TEdit
      Left = 65
      Top = 13
      Width = 183
      Height = 21
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 41
    Width = 1264
    Height = 631
    Align = alClient
    Caption = #32433#32447#39068#33394
    TabOrder = 1
    object cxgridYarnInfo: TcxGrid
      Left = 2
      Top = 15
      Width = 1260
      Height = 114
      Align = alTop
      TabOrder = 0
      object cxGridYarnColorInfo: TcxGridDBTableView
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
      object cxGridlYarnInfo: TcxGridLevel
        GridView = cxGridYarnColorInfo
      end
    end
    object GroupBox4: TGroupBox
      Left = 2
      Top = 137
      Width = 1260
      Height = 492
      Align = alClient
      Caption = #21518#25972#21442#25968'/'#23457#21333#20449#24687
      TabOrder = 1
      object GroupBox3: TGroupBox
        Left = 2
        Top = 15
        Width = 1256
        Height = 130
        Align = alTop
        TabOrder = 0
        object cxgrid_OnLineCard: TcxGrid
          Left = 928
          Top = 15
          Width = 311
          Height = 113
          Align = alRight
          TabOrder = 0
          object cxgridtv_OnLineCard: TcxGridDBTableView
            DataController.DataSource = dsHdr
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
          object cxgridtv_FactArtDtl: TcxGridDBTableView
            DataController.DataSource = dsDtl
            DataController.DetailKeyFieldNames = 'Fact_Art_ID'
            DataController.MasterKeyFieldNames = 'Fact_Art_ID'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NavigatorButtons.ConfirmDelete = False
            NavigatorButtons.First.Visible = True
            NavigatorButtons.PriorPage.Visible = True
            NavigatorButtons.Prior.Visible = True
            NavigatorButtons.Next.Visible = True
            NavigatorButtons.NextPage.Visible = True
            NavigatorButtons.Last.Visible = True
            NavigatorButtons.Insert.Visible = True
            NavigatorButtons.Delete.Visible = True
            NavigatorButtons.Edit.Visible = True
            NavigatorButtons.Post.Visible = True
            NavigatorButtons.Cancel.Visible = True
            NavigatorButtons.Refresh.Visible = True
            NavigatorButtons.SaveBookmark.Visible = True
            NavigatorButtons.GotoBookmark.Visible = True
            NavigatorButtons.Filter.Visible = True
            OptionsView.GroupByBox = False
            OptionsView.GroupFooters = gfAlwaysVisible
          end
          object cxGridl_OnLineCard: TcxGridLevel
            GridView = cxgridtv_OnLineCard
            object cxGridl_FactArtDtl: TcxGridLevel
              GridView = cxgridtv_FactArtDtl
            end
          end
        end
        object mmoHint: TMemo
          Left = 1239
          Top = 15
          Width = 15
          Height = 113
          Align = alRight
          TabOrder = 1
          Visible = False
        end
        object cxgridPDA: TcxGrid
          Left = 2
          Top = 15
          Width = 926
          Height = 113
          Align = alClient
          TabOrder = 2
          object cxgridtvPDA: TcxGridDBTableView
            DataController.DataSource = dsPDA
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
          object cxgridlPDA: TcxGridLevel
            GridView = cxgridtvPDA
          end
        end
      end
      object GroupBox5: TGroupBox
        Left = 2
        Top = 153
        Width = 1256
        Height = 337
        Align = alClient
        Caption = #25104#21697#20449#24687
        TabOrder = 1
        object cxgridHold: TcxGrid
          Left = 2
          Top = 145
          Width = 1252
          Height = 190
          Align = alClient
          TabOrder = 0
          object cxgridtvHold: TcxGridDBTableView
            DataController.DataSource = dsHold
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
          object cxgridlHold: TcxGridLevel
            GridView = cxgridtvHold
          end
        end
        object cxgridShade: TcxGrid
          Left = 2
          Top = 15
          Width = 1252
          Height = 122
          Align = alTop
          TabOrder = 1
          object cxgridtvShade: TcxGridDBTableView
            DataController.DataSource = dsShade
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
          object cxgridlShade: TcxGridLevel
            GridView = cxgridtvShade
          end
        end
        object cxSplitter1: TcxSplitter
          Left = 2
          Top = 137
          Width = 1252
          Height = 8
          HotZoneClassName = 'TcxXPTaskBarStyle'
          AlignSplitter = salTop
          Control = cxgridShade
        end
      end
      object cxSplitter2: TcxSplitter
        Left = 2
        Top = 145
        Width = 1256
        Height = 8
        HotZoneClassName = 'TcxXPTaskBarStyle'
        AlignSplitter = salTop
        Control = GroupBox3
      end
    end
    object cxspl1: TcxSplitter
      Left = 2
      Top = 129
      Width = 1260
      Height = 8
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salTop
      Control = cxgridYarnInfo
    end
  end
  object dsYarnColor: TDataSource
    DataSet = cdsYarnColor
    Left = 128
    Top = 120
  end
  object cdsYarnColor: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 168
    Top = 120
  end
  object dsHdr: TDataSource
    DataSet = cdsHdr
    Left = 952
    Top = 280
  end
  object cdsHdr: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 992
    Top = 280
  end
  object dsDtl: TDataSource
    DataSet = cdsDtl
    Left = 1040
    Top = 280
  end
  object cdsDtl: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 1080
    Top = 280
  end
  object cdsPDA: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 1280
    Top = 272
  end
  object dsShade: TDataSource
    DataSet = cdsShade
    Left = 120
    Top = 392
  end
  object cdsShade: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 168
    Top = 392
  end
  object dsHold: TDataSource
    DataSet = cdsHold
    Left = 112
    Top = 552
  end
  object cdsHold: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 152
    Top = 552
  end
  object dsPDA: TDataSource
    DataSet = cdsPDAs
    Left = 632
    Top = 248
  end
  object cdsPDAs: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 672
    Top = 248
  end
end

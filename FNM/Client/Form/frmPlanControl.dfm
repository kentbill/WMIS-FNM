object PlanControlForm: TPlanControlForm
  Left = 294
  Top = 175
  Width = 631
  Height = 464
  Caption = #35745#21010#25511#21046
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  ShowHint = True
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = KeyDownAControl
  PixelsPerInch = 96
  TextHeight = 12
  object TPanel
    Left = 0
    Top = 391
    Width = 623
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
  end
  object pnl_Only: TPanel
    Left = 0
    Top = 394
    Width = 623
    Height = 36
    Align = alBottom
    AutoSize = True
    BevelOuter = bvNone
    Caption = 'pnl_Only'
    TabOrder = 1
    object TPanel
      Left = 0
      Top = 0
      Width = 623
      Height = 36
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        623
        36)
      object btn3: TSpeedButton
        Left = 8
        Top = 5
        Width = 75
        Height = 25
        Caption = #24110#21161'(&H)'
        Enabled = False
        Flat = True
      end
      object btn_Exit: TSpeedButton
        Left = 535
        Top = 5
        Width = 75
        Height = 25
        Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
        Anchors = [akRight, akBottom]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btn_ExitClick
      end
      object btn_Save: TSpeedButton
        Left = 450
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        Flat = True
        OnClick = btn_SaveDipClick
      end
    end
  end
  object TPanel
    Left = 0
    Top = 0
    Width = 615
    Height = 391
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object TGroupBox
      Left = 0
      Top = 0
      Width = 615
      Height = 147
      Align = alClient
      Caption = #24453'DIP'
      TabOrder = 0
      object cxgrid_OnLineCard: TcxGrid
        Left = 2
        Top = 14
        Width = 611
        Height = 131
        Align = alClient
        TabOrder = 0
        object cxgridtv_OnLineCard: TcxGridDBTableView
          OnDblClick = cxgridtv_OnLineCardDblClick
          DataController.DataSource = ds_OnLineCardList
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OnCustomDrawCell = cxgridtv_OnLineCardCustomDrawCell
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.MultiSelect = True
        end
        object cxGridl_OnLineCard: TcxGridLevel
          GridView = cxgridtv_OnLineCard
        end
      end
    end
    object pnlBottom: TPanel
      Left = 0
      Top = 155
      Width = 615
      Height = 236
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'pnlBottom'
      TabOrder = 1
      object grp_Only: TGroupBox
        Left = 0
        Top = 33
        Width = 615
        Height = 203
        Align = alClient
        Caption = #24050'DIP'
        TabOrder = 0
        object lv_DipCard: TListView
          Left = 2
          Top = 14
          Width = 611
          Height = 187
          Align = alClient
          Columns = <
            item
              Caption = #21345#21495
              Width = 100
            end
            item
              Caption = #21697#21517'ID'
              Width = 60
            end
            item
              Caption = #21697#21517
              Width = 120
            end
            item
              Caption = #24037#33402#20195#21495
              Width = 80
            end
            item
              Caption = #24037#24207#27493#39588
              Width = 80
            end
            item
              Caption = #30721#38271
            end>
          GridLines = True
          MultiSelect = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
        end
      end
      object TPanel
        Left = 0
        Top = 0
        Width = 615
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          615
          33)
        object btn_AddCard: TSpeedButton
          Left = 176
          Top = 6
          Width = 75
          Height = 25
          Caption = #28155#21152'(&A)'
          Flat = True
          OnClick = Add_ReMove_RefreshCard
        end
        object btn_RemoveCard: TSpeedButton
          Left = 48
          Top = 6
          Width = 75
          Height = 25
          Caption = #21024#38500'(&D)'
          Flat = True
          OnClick = Add_ReMove_RefreshCard
        end
        object btn_RefreshCard: TSpeedButton
          Left = 523
          Top = 6
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = #26597#35810'(&Q)'
          Flat = True
          OnClick = Add_ReMove_RefreshCard
        end
        object txt_Only: TStaticText
          Left = 319
          Top = 15
          Width = 70
          Height = 16
          Anchors = [akTop, akRight]
          Caption = #25511#21046#28857'(&D):'
          TabOrder = 1
        end
        object cbb_DipPoint: TComboBox
          Left = 378
          Top = 11
          Width = 143
          Height = 20
          Style = csDropDownList
          Anchors = [akTop, akRight]
          ItemHeight = 12
          TabOrder = 0
          OnKeyDown = KeyDownAControl
          OnSelect = cbb_DipPointSelect
        end
      end
    end
    object cxSplitter1: TcxSplitter
      Left = 0
      Top = 147
      Width = 615
      Height = 8
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salBottom
      Control = pnlBottom
    end
  end
  object cxspl1: TcxSplitter
    Left = 615
    Top = 0
    Width = 8
    Height = 391
    AlignSplitter = salRight
  end
  object cds_OnLineCardList: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 87
    Top = 537
  end
  object ds_OnLineCardList: TDataSource
    DataSet = cds_OnLineCardList
    Left = 119
    Top = 537
  end
end

object ArtControlForm: TArtControlForm
  Left = 188
  Top = 85
  Width = 1053
  Height = 651
  Caption = #24037#33402#25511#21046
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
    Top = 578
    Width = 1045
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
  end
  object TPanel
    Left = 0
    Top = 581
    Width = 1045
    Height = 36
    Align = alBottom
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 1
    object TPanel
      Left = 0
      Top = 0
      Width = 1045
      Height = 36
      Align = alBottom
      Anchors = [akRight, akBottom]
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        1045
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
        Left = 957
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
        Left = 872
        Top = 6
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        Flat = True
        OnClick = btn_SaveDipClick
      end
      object lbWhite: TLabel
        Left = 650
        Top = 16
        Width = 30
        Height = 12
        Anchors = [akRight, akBottom]
        Caption = #30333#24230':'
      end
      object lbOneMinute: TLabel
        Left = 738
        Top = 16
        Width = 66
        Height = 12
        Anchors = [akRight, akBottom]
        Caption = #19968#20998#31181#27611#25928':'
      end
      object edtWhite: TEdit
        Left = 682
        Top = 8
        Width = 50
        Height = 20
        Anchors = [akRight, akBottom]
        TabOrder = 0
      end
      object edtOneMinute: TEdit
        Left = 810
        Top = 8
        Width = 50
        Height = 20
        Anchors = [akRight, akBottom]
        TabOrder = 1
      end
    end
  end
  object pnl_Only2: TPanel
    Left = 0
    Top = 63
    Width = 1045
    Height = 515
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object TGroupBox
      Left = 0
      Top = 0
      Width = 1045
      Height = 271
      Align = alClient
      Caption = #24453'DIP'
      TabOrder = 0
      object cxgrid_OnLineCard: TcxGrid
        Left = 297
        Top = 14
        Width = 746
        Height = 255
        Align = alClient
        TabOrder = 0
        object cxgridtv_OnLineCard: TcxGridDBTableView
          OnMouseDown = cxgridtv_OnLineCardMouseDown
          DataController.DataSource = ds_OnLineCardList
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OnCustomDrawCell = cxgridtv_OnLineCardCustomDrawCell
          OnFocusedRecordChanged = cxgridtv_OnLineCardFocusedRecordChanged
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.MultiSelect = True
          OptionsView.GroupByBox = False
        end
        object cxgridtv_FactArtDtl: TcxGridDBTableView
          DataController.DataSource = ds_FactArtDtl
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
        Left = 297
        Top = 14
        Width = 0
        Height = 255
        Align = alLeft
        TabOrder = 1
        Visible = False
      end
      object pnl1: TPanel
        Left = 2
        Top = 14
        Width = 287
        Height = 255
        Align = alLeft
        Caption = 'pnl1'
        TabOrder = 2
        object cxGrid1: TcxGrid
          Left = 1
          Top = 1
          Width = 285
          Height = 253
          Align = alClient
          TabOrder = 0
          object cxGrid1DBTableView1: TcxGridDBTableView
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NavigatorButtons.ConfirmDelete = False
          end
          object cxGrid1Level1: TcxGridLevel
            GridView = cxGrid1DBTableView1
          end
        end
      end
      object cxspltrleft: TcxSplitter
        Left = 289
        Top = 14
        Width = 8
        Height = 255
        HotZoneClassName = 'TcxXPTaskBarStyle'
        Control = pnl1
      end
    end
    object pnl_Only3: TPanel
      Left = 0
      Top = 279
      Width = 1045
      Height = 236
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'pnl_Only3'
      TabOrder = 1
      object grp_Only: TGroupBox
        Left = 0
        Top = 33
        Width = 1045
        Height = 203
        Align = alClient
        Caption = #24050'DIP'
        TabOrder = 0
        object lv_DipCard: TListView
          Left = 2
          Top = 14
          Width = 1041
          Height = 187
          Align = alClient
          Columns = <
            item
              Caption = #21345#21495
              Width = 100
            end
            item
              Caption = #21697#21517'ID'
              Width = 0
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
            end
            item
              Caption = #19979#24037#24207
              Width = 0
            end
            item
              Caption = 'PPO_TYPE'
            end>
          GridLines = True
          MultiSelect = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnClick = lv_DipCardClick
          OnKeyDown = KeyDownAControl
        end
      end
      object TPanel
        Left = 0
        Top = 0
        Width = 1045
        Height = 33
        Align = alTop
        Anchors = [akLeft, akRight, akBottom]
        BevelOuter = bvNone
        TabOrder = 1
        object btn_AddCard: TSpeedButton
          Left = 384
          Top = 7
          Width = 75
          Height = 25
          Caption = #28155#21152'(&A)'
          Flat = True
          OnClick = Add_ReMove_RefreshCard
        end
        object btn_RemoveCard: TSpeedButton
          Left = 304
          Top = 7
          Width = 75
          Height = 25
          Caption = #21024#38500'(&D)'
          Flat = True
          OnClick = Add_ReMove_RefreshCard
        end
        object btn_RefreshCard: TSpeedButton
          Left = 702
          Top = 7
          Width = 75
          Height = 25
          Caption = #26597#35810'(&Q)'
          Flat = True
          OnClick = Add_ReMove_RefreshCard
        end
        object sbModifyWidth: TSpeedButton
          Left = 218
          Top = 7
          Width = 75
          Height = 25
          Caption = #20462#25913#38376#24133'(&M)'
          Flat = True
          Visible = False
          OnClick = sbModifyWidthClick
        end
        object cbb_DipPoint: TComboBox
          Left = 549
          Top = 12
          Width = 143
          Height = 20
          AutoComplete = False
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 0
          OnKeyDown = KeyDownAControl
          OnSelect = cbb_DipPointSelect
        end
        object cbRoll: TCheckBox
          Left = 13
          Top = 12
          Width = 88
          Height = 17
          Caption = #21367#35013'/'#19981#21367#35013
          TabOrder = 1
          Visible = False
          OnClick = cbRollClick
        end
        object lbControl: TStaticText
          Left = 474
          Top = 16
          Width = 70
          Height = 16
          Caption = #25511#21046#28857'(&D):'
          TabOrder = 2
        end
        object cbNoWait: TCheckBox
          Left = 107
          Top = 12
          Width = 105
          Height = 17
          Caption = #31561#27979#35797#21367#24067
          TabOrder = 3
          Visible = False
          OnClick = cbRollClick
        end
        object rb1: TRadioButton
          Left = 799
          Top = 12
          Width = 57
          Height = 17
          Caption = #21462#26679
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 4
          Visible = False
        end
        object rb2: TRadioButton
          Left = 859
          Top = 12
          Width = 113
          Height = 17
          Caption = #26410#21462#26679
          TabOrder = 5
          Visible = False
        end
      end
    end
    object cxspl1: TcxSplitter
      Left = 0
      Top = 271
      Width = 1045
      Height = 8
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salBottom
      Control = pnl_Only3
    end
  end
  object pnl_Only: TPanel
    Left = 0
    Top = 0
    Width = 1045
    Height = 63
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 3
    object edtInfo: TcxMemo
      Left = 961
      Top = 2
      Width = 82
      Height = 59
      Align = alClient
      ParentFont = False
      ParentShowHint = False
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      ShowHint = True
      Style.BorderStyle = ebsUltraFlat
      Style.Color = clBtnFace
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clBlue
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      TabOrder = 0
    end
    object pnl2: TPanel
      Left = 2
      Top = 2
      Width = 959
      Height = 59
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object txt1: TStaticText
        Left = 5
        Top = 15
        Width = 34
        Height = 16
        Caption = #21697#21517':'
        TabOrder = 0
      end
      object TStaticText
        Left = 5
        Top = 40
        Width = 34
        Height = 16
        Caption = #23458#25143':'
        TabOrder = 1
      end
      object edt_GFKeyValue: TEdit
        Left = 37
        Top = 7
        Width = 105
        Height = 20
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 2
      end
      object edt_Customer: TEdit
        Left = 37
        Top = 32
        Width = 105
        Height = 20
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 3
      end
      object TStaticText
        Left = 148
        Top = 40
        Width = 58
        Height = 16
        Caption = #25104#21697#24133#23485':'
        TabOrder = 4
      end
      object TStaticText
        Left = 148
        Top = 15
        Width = 58
        Height = 16
        Caption = #22383#24067#24133#23485':'
        TabOrder = 5
      end
      object edt_Grey_Width: TEdit
        Left = 203
        Top = 7
        Width = 105
        Height = 20
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 6
      end
      object edt_Width: TEdit
        Left = 203
        Top = 32
        Width = 105
        Height = 20
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 7
      end
      object TStaticText
        Left = 314
        Top = 40
        Width = 58
        Height = 16
        Caption = #25104#21697#23494#24230':'
        TabOrder = 8
      end
      object TStaticText
        Left = 314
        Top = 15
        Width = 58
        Height = 16
        Caption = #22383#24067#23494#24230':'
        TabOrder = 9
      end
      object edt_GreyDensity: TEdit
        Left = 370
        Top = 7
        Width = 105
        Height = 20
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 10
      end
      object edt_Density: TEdit
        Left = 370
        Top = 32
        Width = 105
        Height = 20
        TabStop = False
        BevelOuter = bvRaised
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 11
      end
      object TStaticText
        Left = 485
        Top = 40
        Width = 46
        Height = 16
        Caption = 'BR'#21547#37327':'
        TabOrder = 12
      end
      object TStaticText
        Left = 500
        Top = 15
        Width = 34
        Height = 16
        Caption = #33639#20809':'
        TabOrder = 13
      end
      object edt_Anti_Fluorescence: TEdit
        Left = 531
        Top = 7
        Width = 105
        Height = 20
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 14
      end
      object edt_BR: TEdit
        Left = 531
        Top = 32
        Width = 105
        Height = 20
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 15
      end
      object pnlColor: TPanel
        Left = 766
        Top = 5
        Width = 191
        Height = 33
        TabOrder = 16
        object btnTempHold: TSpeedButton
          Left = 102
          Top = 4
          Width = 83
          Height = 22
          Caption = #39068#33394'HOLD(&Q)'
          Flat = True
          OnClick = btnTempHoldClick
        end
        object cbbColorHoldInfo: TComboBox
          Left = 7
          Top = 5
          Width = 86
          Height = 20
          ItemHeight = 12
          TabOrder = 0
          Items.Strings = (
            #25163#24863
            #39068#33394
            #38376#24133
            #33394#29282#24230
            #28369#31227)
        end
      end
      object mmo_Remark: TMemo
        Left = 480
        Top = 0
        Width = 281
        Height = 57
        Ctl3D = True
        ParentCtl3D = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 17
      end
    end
  end
  object cds_OnLineCardList: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cds_OnLineCardListAfterScroll
    Left = 167
    Top = 354
  end
  object ds_OnLineCardList: TDataSource
    DataSet = cds_OnLineCardList
    Left = 199
    Top = 354
  end
  object cds_FactArtDtl: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 231
    Top = 354
  end
  object ds_FactArtDtl: TDataSource
    DataSet = cds_FactArtDtl
    Left = 263
    Top = 354
  end
  object cdsCheckCarRollNO: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 672
    Top = 80
  end
  object cdsPDAs: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 120
    Top = 160
  end
  object dsPDA: TDataSource
    DataSet = cdsPDAs
    Left = 120
    Top = 192
  end
  object cdsTemp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 440
    Top = 136
  end
  object cds1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 520
    Top = 152
  end
  object cds2: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 744
    Top = 504
  end
end

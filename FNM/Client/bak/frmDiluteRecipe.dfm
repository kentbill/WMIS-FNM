inherited DiluteRecipeForm: TDiluteRecipeForm
  Left = 61
  Top = 29
  Width = 789
  Height = 532
  Caption = #21270#26009#21333#20914#31232
  OldCreateOrder = True
  Position = poDefault
  ShowHint = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  object spl3: TSplitter
    Left = 132
    Top = 3
    Width = 3
    Height = 472
    Cursor = crHSplit
  end
  object TPanel
    Left = 0
    Top = 0
    Width = 781
    Height = 3
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
  end
  object TPanel
    Left = 135
    Top = 3
    Width = 646
    Height = 472
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object pnl_Only1: TPanel
      Left = 0
      Top = 137
      Width = 646
      Height = 184
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object spl1: TSplitter
        Left = 177
        Top = 3
        Width = 3
        Height = 181
        Cursor = crHSplit
      end
      object TPanel
        Left = 0
        Top = 3
        Width = 177
        Height = 181
        Align = alLeft
        BevelInner = bvLowered
        TabOrder = 1
        object TPanel
          Left = 144
          Top = 18
          Width = 31
          Height = 161
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 2
          object btn_Add_Chemical: TSpeedButton
            Left = 4
            Top = 18
            Width = 23
            Height = 22
            Flat = True
            OnClick = btn_Add_ChemicalClick
          end
          object btn_Del_Chemical: TSpeedButton
            Left = 4
            Top = 67
            Width = 23
            Height = 22
            Flat = True
            OnClick = btn_Del_ChemicalClick
          end
        end
        object txtsedf1: TStaticText
          Left = 2
          Top = 2
          Width = 173
          Height = 16
          Align = alTop
          Caption = #21487#36873#21270#24037#26009'(&C):'
          TabOrder = 0
        end
        object tv_ChemicalName: TTreeView
          Left = 2
          Top = 18
          Width = 142
          Height = 161
          Align = alClient
          HideSelection = False
          Indent = 19
          ReadOnly = True
          TabOrder = 1
          OnDblClick = btn_Add_ChemicalClick
        end
      end
      object TPanel
        Left = 0
        Top = 0
        Width = 646
        Height = 3
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
      end
      object Vle_Chemicallist: TValueListEditor
        Left = 180
        Top = 3
        Width = 466
        Height = 181
        Align = alClient
        TabOrder = 2
        TitleCaptions.Strings = (
          #21270#24037#26009#21517
          #29992#37327'(g/L)')
        OnGetEditMask = Vle_ChemicallistGetEditMask
        OnValidate = Vle_ChemicallistValidate
        ColWidths = (
          152
          308)
      end
    end
    object TPanel
      Left = 0
      Top = 321
      Width = 646
      Height = 151
      Align = alBottom
      BevelInner = bvLowered
      TabOrder = 1
      object pnl1: TPanel
        Left = 360
        Top = 2
        Width = 284
        Height = 147
        Align = alRight
        BevelInner = bvLowered
        BevelOuter = bvNone
        TabOrder = 0
        object lbl1: TLabel
          Left = 8
          Top = 14
          Width = 42
          Height = 12
          Caption = #21407#20307#31215';'
        end
        object lbl2: TLabel
          Left = 11
          Top = 94
          Width = 54
          Height = 12
          Caption = #21152#27700#20307#31215';'
        end
        object lbl3: TLabel
          Left = 142
          Top = 14
          Width = 30
          Height = 12
          Caption = #22791#27880';'
        end
        object lbl4: TLabel
          Left = 9
          Top = 54
          Width = 54
          Height = 12
          Caption = #25918#26009#20307#31215';'
        end
        object dbedtOriVolume: TDBEdit
          Left = 8
          Top = 28
          Width = 121
          Height = 20
          DataField = 'Ori_Volume'
          DataSource = dsBatchHdr
          ReadOnly = True
          TabOrder = 0
        end
        object dbedtDecVolume: TDBEdit
          Left = 9
          Top = 68
          Width = 121
          Height = 20
          DataField = 'Dec_Volume'
          DataSource = dsBatchHdr
          TabOrder = 1
        end
        object dbedtIncVolume: TDBEdit
          Left = 11
          Top = 108
          Width = 121
          Height = 20
          DataField = 'Inc_Volume'
          DataSource = dsBatchHdr
          TabOrder = 2
        end
        object dbmmoRemark: TDBMemo
          Left = 141
          Top = 29
          Width = 136
          Height = 98
          DataField = 'Remark'
          DataSource = dsBatchHdr
          TabOrder = 3
        end
      end
      object grp3: TGroupBox
        Left = 2
        Top = 2
        Width = 358
        Height = 147
        Align = alClient
        Caption = #21345#21495#20449#24687
        TabOrder = 1
        object cxgdFNCard: TcxGrid
          Left = 2
          Top = 14
          Width = 354
          Height = 131
          Align = alClient
          TabOrder = 0
          object cxgdFNCardTV: TcxGridDBTableView
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
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.GroupByBox = False
          end
          object cxGridLevel1: TcxGridLevel
            GridView = cxgdFNCardTV
          end
        end
      end
    end
    object grp1: TGroupBox
      Left = 0
      Top = 0
      Width = 646
      Height = 129
      Align = alTop
      Caption = #31232#37322#26126#32454
      TabOrder = 2
      object cxgdBatchView: TcxGrid
        Left = 2
        Top = 14
        Width = 642
        Height = 113
        Align = alClient
        TabOrder = 0
        object cxgdBatchViewTV: TcxGridDBTableView
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
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
        end
        object cxgdBatchViewLevel1: TcxGridLevel
          GridView = cxgdBatchViewTV
        end
      end
    end
    object cxSplitter1: TcxSplitter
      Left = 0
      Top = 129
      Width = 646
      Height = 8
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salTop
      Control = grp1
    end
  end
  object TPanel
    Left = 0
    Top = 3
    Width = 132
    Height = 472
    Align = alLeft
    BevelInner = bvLowered
    TabOrder = 1
    object TPanel
      Left = 2
      Top = 2
      Width = 128
      Height = 46
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object btn_Query: TSpeedButton
        Left = 104
        Top = 20
        Width = 23
        Height = 22
        Flat = True
        OnClick = btn_QueryClick
      end
      object lbl5: TLabel
        Left = 6
        Top = 5
        Width = 42
        Height = 12
        Caption = #37197#26041#21495';'
      end
      object edt_RecipeNO: TEdit
        Left = 4
        Top = 21
        Width = 99
        Height = 20
        TabOrder = 0
      end
    end
    object grp2: TGroupBox
      Left = 2
      Top = 48
      Width = 128
      Height = 422
      Align = alClient
      Caption = #32568#21495#21015#34920
      TabOrder = 1
      object lst_StepList: TListBox
        Left = 2
        Top = 14
        Width = 124
        Height = 406
        Align = alClient
        ItemHeight = 12
        TabOrder = 0
        OnDblClick = lst_StepListDblClick
      end
    end
  end
  object TPanel
    Left = 0
    Top = 475
    Width = 781
    Height = 30
    Align = alBottom
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 3
    object TPanel
      Left = 0
      Top = 0
      Width = 781
      Height = 30
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        781
        30)
      object btn_SaveRecipe: TSpeedButton
        Left = 620
        Top = 3
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        Flat = True
        OnClick = btn_SaveRecipeClick
      end
      object btn_Exit: TSpeedButton
        Left = 701
        Top = 3
        Width = 75
        Height = 25
        Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
        Anchors = [akRight, akBottom]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btn_ExitClick
      end
      object btnNew: TSpeedButton
        Left = 538
        Top = 3
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #26032#24314'(&N)'
        Flat = True
        OnClick = btnNewClick
      end
      object lbl6: TLabel
        Left = 179
        Top = 13
        Width = 30
        Height = 12
        Caption = #32568#21495';'
      end
      object lbl7: TLabel
        Left = 336
        Top = 13
        Width = 30
        Height = 12
        Caption = #27425#25968':'
      end
      object btnPrint: TSpeedButton
        Left = 457
        Top = 4
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #25171#21360'(&P)'
        Flat = True
        OnClick = btnPrintClick
      end
      object edtBatchNO: TEdit
        Left = 208
        Top = 5
        Width = 121
        Height = 20
        TabOrder = 0
      end
      object edtStepID: TEdit
        Left = 368
        Top = 5
        Width = 49
        Height = 20
        TabOrder = 1
      end
    end
  end
  object cdsBatchDtl: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Assistant_Prescrip_NO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Prescrip_NO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Parent_Prescrip_NO'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 360
    Top = 195
  end
  object cdsBatchHdr: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Assistant_Prescrip_NO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Prescrip_NO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Parent_Prescrip_NO'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 536
    Top = 344
  end
  object cdsBatchView: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Assistant_Prescrip_NO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Prescrip_NO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Parent_Prescrip_NO'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 576
    Top = 89
  end
  object dsBatchView: TDataSource
    DataSet = cdsBatchView
    Left = 536
    Top = 88
  end
  object dsBatchHdr: TDataSource
    DataSet = cdsBatchHdr
    Left = 504
    Top = 344
  end
  object dsFNCardInfo: TDataSource
    DataSet = cdsFNCardInfo
    Left = 312
    Top = 392
  end
  object cdsFNCardInfo: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Assistant_Prescrip_NO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Prescrip_NO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Parent_Prescrip_NO'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 352
    Top = 393
  end
end

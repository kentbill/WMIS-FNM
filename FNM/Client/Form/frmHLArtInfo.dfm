object HLArtForm: THLArtForm
  Left = 148
  Top = 177
  Width = 729
  Height = 470
  Caption = #25163#32455#29256#24037#33402
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = KeyDownAControl
  PixelsPerInch = 96
  TextHeight = 12
  object cxspl_XX: TcxSplitter
    Left = 201
    Top = 3
    Width = 8
    Height = 403
    HotZoneClassName = 'TcxXPTaskBarStyle'
    Control = pnl_Only
  end
  object TPanel
    Left = 0
    Top = 0
    Width = 721
    Height = 3
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
  end
  object pnl_Only: TPanel
    Left = 0
    Top = 3
    Width = 201
    Height = 403
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      201
      403)
    object btn_CreateHLArt: TSpeedButton
      Left = 5
      Top = 4
      Width = 196
      Height = 22
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = #21046#35746#24037#33402'(&K)'
      Flat = True
      OnClick = btn_CreateHLArtClick
    end
    object pnl_Only2: TPanel
      Left = 0
      Top = 32
      Width = 201
      Height = 371
      Align = alBottom
      BevelInner = bvLowered
      TabOrder = 0
      object txt_Only: TStaticText
        Left = 2
        Top = 2
        Width = 197
        Height = 16
        Align = alTop
        Caption = #25163#32455#26495#21495#21015#34920':'
        TabOrder = 0
      end
      object cxgrid_HLFNNO: TcxGrid
        Left = 2
        Top = 18
        Width = 197
        Height = 351
        Align = alClient
        TabOrder = 1
        object cxgtv_HLFNNO: TcxGridTableView
          OnKeyDown = KeyDownAControl
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
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.GroupFooters = gfAlwaysVisible
        end
        object cxGridl_HLFNNO: TcxGridLevel
          GridView = cxgtv_HLFNNO
        end
      end
    end
  end
  object TPanel
    Left = 0
    Top = 409
    Width = 721
    Height = 34
    Align = alBottom
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 4
    object TPanel
      Left = 0
      Top = 0
      Width = 721
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        721
        34)
      object btn_Help: TSpeedButton
        Left = 8
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = #24110#21161'(&H)'
        Enabled = False
        Flat = True
      end
      object btn_Exit: TSpeedButton
        Left = 637
        Top = 5
        Width = 75
        Height = 25
        Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
        Anchors = [akRight, akBottom]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btn_ExitClick
      end
      object btn_SaveArt: TSpeedButton
        Left = 551
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        Flat = True
        OnClick = btn_SaveArtClick
      end
      object btn_ViewArtDtl: TSpeedButton
        Left = 464
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #26597#30475'(&W)'
        Flat = True
        OnClick = btn_ViewArtDtlClick
      end
      object btn_Refresh: TSpeedButton
        Left = 378
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #21047#26032'(F5)'
        Flat = True
        OnClick = btn_RefreshClick
      end
    end
  end
  object TPanel
    Left = 0
    Top = 406
    Width = 721
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
  end
  object TPanel
    Left = 209
    Top = 3
    Width = 512
    Height = 403
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 5
    object spl1: TSplitter
      Left = 225
      Top = 100
      Width = 3
      Height = 237
      Cursor = crHSplit
    end
    object TPanel
      Left = 0
      Top = 100
      Width = 225
      Height = 237
      Align = alLeft
      BevelInner = bvLowered
      TabOrder = 4
      object lst_Operationlist: TListBox
        Left = 2
        Top = 18
        Width = 191
        Height = 217
        Style = lbOwnerDrawFixed
        Align = alClient
        BevelOuter = bvNone
        ItemHeight = 12
        TabOrder = 1
        OnClick = lst_OperationlistClick
        OnKeyDown = KeyDownAControl
      end
      object TPanel
        Left = 193
        Top = 18
        Width = 30
        Height = 217
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 2
        object btn_MoveUP_Operation: TSpeedButton
          Left = 2
          Top = 135
          Width = 24
          Height = 24
          Hint = #19978#31227'|'#23558#24403#21069#21152#24037#24037#24207#19978#31227#19968#27493
          Flat = True
          OnClick = btn_Operation
        end
        object btn_MoveDown_Operation: TSpeedButton
          Left = 2
          Top = 181
          Width = 24
          Height = 24
          Hint = #19979#31227'|'#23558#24403#21069#21152#24037#24037#24207#19979#31227#19968#27493
          Flat = True
          OnClick = btn_Operation
        end
        object btn_Del_Operation: TSpeedButton
          Left = 2
          Top = 67
          Width = 24
          Height = 24
          Hint = #21024#38500'|'#21024#38500#24403#21069#24037#24207
          Flat = True
          OnClick = btn_Operation
        end
        object btn_Add_Operation: TSpeedButton
          Left = 2
          Top = 23
          Width = 24
          Height = 24
          Hint = #28155#21152'|'#28155#21152#36873#25321#30340#24037#24207
          Flat = True
          OnClick = btn_Add_OperationClick
        end
      end
      object TStaticText
        Left = 2
        Top = 2
        Width = 221
        Height = 16
        Align = alTop
        Caption = #24037#24207#21015#34920'(&W):'
        FocusControl = lst_Operationlist
        TabOrder = 0
      end
    end
    object grp_Only: TGroupBox
      Left = 0
      Top = 337
      Width = 512
      Height = 66
      Align = alBottom
      Caption = #22791#27880
      TabOrder = 6
      object mmo_Remark: TMemo
        Left = 2
        Top = 14
        Width = 508
        Height = 50
        Hint = #22791#27880'|'#24037#24207#30340#25972#20307#22791#27880
        Align = alClient
        ImeMode = imHanguel
        MaxLength = 150
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object TPanel
      Left = 228
      Top = 100
      Width = 284
      Height = 237
      Align = alClient
      BevelInner = bvLowered
      TabOrder = 5
      object pgc_Operation: TPageControl
        Left = 2
        Top = 2
        Width = 280
        Height = 233
        ActivePage = ts_Only
        Align = alClient
        Style = tsFlatButtons
        TabIndex = 0
        TabOrder = 0
        object ts_Only: TTabSheet
          Caption = #21487#36873#24037#24207
          ImageIndex = 1
          DesignSize = (
            272
            203)
          object cbb_Operation_Name: TComboBox
            Left = 0
            Top = 8
            Width = 241
            Height = 193
            Style = csSimple
            Anchors = [akLeft, akTop, akRight, akBottom]
            ItemHeight = 12
            TabOrder = 0
            OnKeyDown = KeyDownAControl
          end
        end
        object TTabSheet
          Caption = #24037#24207#21442#25968
          object vle_Operation_Parlist: TValueListEditor
            Left = 0
            Top = 0
            Width = 272
            Height = 203
            Hint = #24037#24207#21442#25968'|'#36873#23450#24037#24207#30340#21442#25968
            Align = alClient
            TabOrder = 0
            TitleCaptions.Strings = (
              #21442#25968#21517
              #21442#25968#20540)
            OnEditButtonClick = vle_Operation_ParlistEditButtonClick
            OnKeyDown = vle_Operation_ParlistKeyDown
            OnKeyPress = vle_Operation_ParlistKeyPress
            OnValidate = vle_Operation_ParlistValidate
            ColWidths = (
              132
              134)
          end
        end
      end
    end
    object TPanel
      Left = 0
      Top = 97
      Width = 512
      Height = 3
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
    end
    object TPanel
      Left = 0
      Top = 0
      Width = 512
      Height = 61
      Align = alTop
      BevelInner = bvLowered
      TabOrder = 0
      object edt_BR: TEdit
        Left = 355
        Top = 32
        Width = 105
        Height = 20
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 6
      end
      object txt1: TStaticText
        Left = 5
        Top = 15
        Width = 34
        Height = 16
        Caption = #21345#21495':'
        TabOrder = 2
      end
      object edt_HL_NO: TEdit
        Left = 37
        Top = 7
        Width = 105
        Height = 20
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 0
      end
      object TStaticText
        Left = 297
        Top = 40
        Width = 58
        Height = 16
        Caption = #26159#21542#21547'BR:'
        TabOrder = 9
      end
      object TStaticText
        Left = 5
        Top = 40
        Width = 34
        Height = 16
        Caption = #33639#20809':'
        TabOrder = 7
      end
      object edt_Anti_Fluorescence: TEdit
        Left = 37
        Top = 32
        Width = 105
        Height = 20
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 4
      end
      object TStaticText
        Left = 149
        Top = 40
        Width = 34
        Height = 16
        Caption = #30897#27987':'
        TabOrder = 8
      end
      object edt_Mercerizing: TEdit
        Left = 181
        Top = 32
        Width = 105
        Height = 20
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 5
      end
      object TStaticText
        Left = 149
        Top = 16
        Width = 34
        Height = 16
        Caption = #31867#22411':'
        TabOrder = 3
      end
      object edt_Class: TEdit
        Left = 181
        Top = 8
        Width = 105
        Height = 20
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 1
      end
    end
    object TPanel
      Left = 0
      Top = 61
      Width = 512
      Height = 3
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
    end
    object TPanel
      Left = 0
      Top = 64
      Width = 512
      Height = 33
      Align = alTop
      BevelInner = bvLowered
      TabOrder = 2
      object TStaticText
        Left = 6
        Top = 12
        Width = 82
        Height = 16
        Caption = #24037#33402#20195#21495'(&C):'
        FocusControl = cbb_FN_Art_NO1
        TabOrder = 1
      end
      object cbb_FN_Art_NO1: TComboBox
        Tag = 1
        Left = 75
        Top = 5
        Width = 219
        Height = 20
        Hint = #24037#33402#20195#21495'|'#21518#25972#29702#26631#20934#24037#33402#20195#21495
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 0
        OnChange = cbb_FN_Art_NO1Change
      end
    end
  end
  object cds_HLBasicInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    ReadOnly = True
    Left = 88
    Top = 540
  end
  object ds_HLBasicInfo: TDataSource
    DataSet = cds_HLBasicInfo
    Left = 120
    Top = 540
  end
end

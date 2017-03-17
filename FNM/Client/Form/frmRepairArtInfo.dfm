object RepairArtInfoForm: TRepairArtInfoForm
  Left = 322
  Top = 138
  Width = 933
  Height = 518
  Caption = #21046#35746#22238#20462#24037#33402
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
    Left = 249
    Top = 88
    Width = 8
    Height = 355
    HotZoneClassName = 'TcxXPTaskBarStyle'
    Control = pnl_Only
  end
  object TPanel
    Left = 0
    Top = 85
    Width = 917
    Height = 3
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
  end
  object pnl_Only: TPanel
    Left = 0
    Top = 88
    Width = 249
    Height = 355
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
    object TPanel
      Left = 0
      Top = 0
      Width = 249
      Height = 355
      Align = alClient
      BevelInner = bvLowered
      TabOrder = 0
      object TPanel
        Left = 2
        Top = 2
        Width = 245
        Height = 25
        Align = alTop
        AutoSize = True
        BevelOuter = bvNone
        TabOrder = 1
        object btn_RefreshRepairFabric: TSpeedButton
          Left = 4
          Top = 0
          Width = 120
          Height = 25
          Caption = #21047#26032'(&R)'
          Flat = True
          OnClick = RefreshRepairFabircNO
        end
        object btn_CreateFactArt: TSpeedButton
          Left = 125
          Top = 0
          Width = 120
          Height = 25
          Caption = #21046#35746#24037#33402'(&K)'
          Flat = True
          OnClick = btn_CreateFactArtClick
        end
      end
      object pnl_Only2: TPanel
        Left = 2
        Top = 30
        Width = 245
        Height = 323
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object txt_Only: TStaticText
          Left = 2
          Top = 2
          Width = 241
          Height = 16
          Align = alTop
          BevelKind = bkSoft
          Caption = #24453#21046#35746#22238#20462#24037#33402#21345#21495':'
          TabOrder = 0
        end
        object lv_RepairCardList: TListView
          Left = 2
          Top = 18
          Width = 241
          Height = 303
          Align = alClient
          Checkboxes = True
          Columns = <
            item
              Caption = #21345#21495
              Width = 100
            end
            item
              Caption = #21697#21517
              Width = 90
            end
            item
              Caption = #30721#38271
            end
            item
              Caption = #22238#20462#21407#22240
            end
            item
              Caption = #21697#21517'ID'
            end
            item
              Caption = #22238#20462'ID'
            end
            item
              Caption = #20869#22238#20462#27425#25968
            end
            item
              Caption = #22806#22238#20462#27425#25968
            end>
          GridLines = True
          HideSelection = False
          MultiSelect = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 1
          ViewStyle = vsReport
          OnColumnClick = lv_RepairCardListColumnClick
          OnCustomDrawItem = lv_RepairCardListCustomDrawItem
          OnDrawItem = lv_RepairCardListDrawItem
          OnKeyDown = KeyDownAControl
        end
      end
      object TPanel
        Left = 2
        Top = 27
        Width = 245
        Height = 3
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
      end
    end
  end
  object pnl_Only1: TPanel
    Left = 257
    Top = 88
    Width = 660
    Height = 355
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    object spl1: TSplitter
      Left = 185
      Top = 78
      Width = 3
      Height = 212
      Cursor = crHSplit
    end
    object TPanel
      Left = 0
      Top = 78
      Width = 185
      Height = 212
      Align = alLeft
      BevelInner = bvLowered
      TabOrder = 0
      object lst_Operationlist: TListBox
        Left = 2
        Top = 18
        Width = 150
        Height = 192
        Style = lbOwnerDrawFixed
        Align = alClient
        BevelOuter = bvNone
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ItemHeight = 12
        TabOrder = 1
        OnClick = lst_OperationlistClick
        OnKeyDown = KeyDownAControl
      end
      object TPanel
        Left = 152
        Top = 18
        Width = 31
        Height = 192
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 2
        object btn_MoveUP_Operation: TSpeedButton
          Left = 4
          Top = 68
          Width = 24
          Height = 24
          Hint = #19978#31227'|'#23558#24403#21069#21152#24037#24037#24207#19978#31227#19968#27493
          Flat = True
          OnClick = btn_Operation
        end
        object btn_MoveDown_Operation: TSpeedButton
          Left = 4
          Top = 102
          Width = 24
          Height = 24
          Hint = #19979#31227'|'#23558#24403#21069#21152#24037#24037#24207#19979#31227#19968#27493
          Flat = True
          OnClick = btn_Operation
        end
        object btn_Del_Operation: TSpeedButton
          Left = 4
          Top = 35
          Width = 24
          Height = 24
          Hint = #21024#38500'|'#21024#38500#24403#21069#24037#24207
          Flat = True
          OnClick = btn_Operation
        end
        object btn_Add_Operation: TSpeedButton
          Left = 4
          Top = 7
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
        Width = 181
        Height = 16
        Align = alTop
        Caption = #24037#24207#21015#34920'(&W):'
        FocusControl = lst_Operationlist
        TabOrder = 0
      end
    end
    object TPanel
      Left = 0
      Top = 75
      Width = 660
      Height = 3
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
    end
    object TPanel
      Left = 188
      Top = 78
      Width = 472
      Height = 212
      Align = alClient
      BevelInner = bvLowered
      TabOrder = 2
      object pgc_Operation: TPageControl
        Left = 2
        Top = 2
        Width = 468
        Height = 208
        ActivePage = ts_Only
        Align = alClient
        Style = tsFlatButtons
        TabIndex = 0
        TabOrder = 0
        OnChange = pgc_OperationChange
        object ts_Only: TTabSheet
          Caption = #21487#36873#24037#24207
          ImageIndex = 1
          object cbb_Operation_Name: TComboBox
            Left = 0
            Top = 8
            Width = 305
            Height = 201
            Style = csSimple
            ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
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
            Width = 327
            Height = 156
            Hint = #24037#24207#21442#25968'|'#36873#23450#24037#24207#30340#21442#25968
            Align = alClient
            TabOrder = 0
            TitleCaptions.Strings = (
              #21442#25968#21517
              #21442#25968#20540)
            OnEditButtonClick = vle_Operation_ParlistEditButtonClick
            OnKeyDown = vle_Operation_ParlistKeyDown
            OnValidate = vle_Operation_ParlistValidate
            ColWidths = (
              132
              189)
          end
        end
      end
    end
    object grp_Only: TGroupBox
      Left = 0
      Top = 290
      Width = 660
      Height = 65
      Align = alBottom
      Caption = #22791#27880
      TabOrder = 3
      object mmo_Remark: TMemo
        Left = 2
        Top = 14
        Width = 656
        Height = 49
        Hint = #22791#27880'|'#24037#24207#30340#25972#20307#22791#27880
        Align = alClient
        ImeMode = imHanguel
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        MaxLength = 150
        ScrollBars = ssVertical
        TabOrder = 0
        OnChange = ChangeAEdit
      end
    end
    object TPanel
      Left = 0
      Top = 0
      Width = 660
      Height = 75
      Align = alTop
      BevelInner = bvLowered
      TabOrder = 4
      object TStaticText
        Left = 198
        Top = 34
        Width = 34
        Height = 16
        Caption = #33457#22411':'
        TabOrder = 4
      end
      object TStaticText
        Left = 198
        Top = 12
        Width = 34
        Height = 16
        Caption = #33639#20809':'
        TabOrder = 1
      end
      object TStaticText
        Left = 5
        Top = 34
        Width = 58
        Height = 16
        Caption = #39068#33394#20195#21495':'
        TabOrder = 3
      end
      object TStaticText
        Left = 5
        Top = 12
        Width = 58
        Height = 16
        Caption = #24037#33402#20195#21495':'
        TabOrder = 0
      end
      object TStaticText
        Left = 367
        Top = 12
        Width = 34
        Height = 16
        Caption = #32553#27700':'
        TabOrder = 2
      end
      object edt_FN_Art_NO1: TEdit
        Tag = 1
        Left = 59
        Top = 5
        Width = 119
        Height = 20
        Hint = #24037#33402#20195#21495'|'#21518#25972#29702#26631#20934#24037#33402#20195#21495
        Color = clBtnFace
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ReadOnly = True
        TabOrder = 5
      end
      object edt_ColorCode: TEdit
        Left = 59
        Top = 27
        Width = 119
        Height = 20
        Hint = #39068#33394#20195#21495
        Color = clBtnFace
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ReadOnly = True
        TabOrder = 6
      end
      object edt_FN_Art_NO4: TEdit
        Tag = 4
        Left = 233
        Top = 27
        Width = 119
        Height = 20
        Hint = #24037#33402#20195#21495'|'#33457#22411
        Color = clBtnFace
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ReadOnly = True
        TabOrder = 7
      end
      object edt_FN_Art_NO2: TEdit
        Tag = 2
        Left = 233
        Top = 5
        Width = 119
        Height = 20
        Hint = #24037#33402#20195#21495'|'#21518#25972#29702#23376#24037#33402#20195#21495
        Color = clBtnFace
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ReadOnly = True
        TabOrder = 8
      end
      object edt_Shrinkage: TEdit
        Tag = 2
        Left = 400
        Top = 5
        Width = 123
        Height = 20
        Hint = #24037#33402#20195#21495'|'#21518#25972#29702#23376#24037#33402#20195#21495
        Color = clBtnFace
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ReadOnly = True
        TabOrder = 9
      end
      object TStaticText
        Left = 367
        Top = 34
        Width = 34
        Height = 16
        Caption = #25163#24863':'
        TabOrder = 10
      end
      object edt_HandFeel: TEdit
        Left = 400
        Top = 27
        Width = 123
        Height = 20
        Hint = #21697#21517'|'#23558#35201#36171#20540#26631#20934#24037#33402#30340#21697#21517
        Color = clBtnFace
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ReadOnly = True
        TabOrder = 11
        OnKeyDown = KeyDownAControl
      end
      object TStaticText
        Left = 29
        Top = 54
        Width = 34
        Height = 16
        Caption = #38376#24133':'
        FocusControl = edt_ProductWidth
        TabOrder = 12
      end
      object edt_ProductWidth: TEdit
        Left = 59
        Top = 50
        Width = 119
        Height = 20
        BevelEdges = [beLeft, beTop]
        Color = clBtnFace
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ReadOnly = True
        TabOrder = 13
        OnKeyDown = KeyDownAControl
      end
      object TStaticText
        Left = 198
        Top = 57
        Width = 34
        Height = 16
        Caption = #31867#22411':'
        TabOrder = 14
      end
      object cbb_ReasonType: TComboBox
        Left = 233
        Top = 50
        Width = 119
        Height = 20
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ItemHeight = 12
        TabOrder = 15
        OnSelect = cbb_ReasonTypeSelect
      end
      object TStaticText
        Left = 367
        Top = 57
        Width = 34
        Height = 16
        Caption = #21407#22240':'
        TabOrder = 16
      end
      object cbb_ReasonName: TComboBox
        Left = 400
        Top = 50
        Width = 119
        Height = 20
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ItemHeight = 12
        TabOrder = 17
        OnSelect = cbb_ReasonNameSelect
      end
    end
  end
  object TPanel
    Left = 0
    Top = 0
    Width = 917
    Height = 85
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object TStaticText
      Left = 315
      Top = 15
      Width = 58
      Height = 16
      Caption = #22383#24067#23494#24230':'
      TabOrder = 5
    end
    object TStaticText
      Left = 315
      Top = 40
      Width = 58
      Height = 16
      Caption = #25104#21697#23494#24230':'
      TabOrder = 12
    end
    object TStaticText
      Left = 621
      Top = 64
      Width = 58
      Height = 16
      Caption = #35774#35745#26102#38388':'
      TabOrder = 21
    end
    object TStaticText
      Left = 157
      Top = 64
      Width = 46
      Height = 16
      Caption = 'BR'#21547#37327':'
      TabOrder = 23
    end
    object edt_GreyDensity: TEdit
      Left = 371
      Top = 7
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
      ReadOnly = True
      TabOrder = 2
    end
    object edt_Density: TEdit
      Left = 371
      Top = 32
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
      ReadOnly = True
      TabOrder = 8
    end
    object TStaticText
      Left = 5
      Top = 40
      Width = 34
      Height = 16
      Caption = #23458#25143':'
      TabOrder = 10
    end
    object txt1: TStaticText
      Left = 5
      Top = 15
      Width = 34
      Height = 16
      Caption = #21697#21517':'
      TabOrder = 3
    end
    object TStaticText
      Left = 148
      Top = 15
      Width = 58
      Height = 16
      Caption = #22383#24067#24133#23485':'
      TabOrder = 4
    end
    object TStaticText
      Left = 148
      Top = 40
      Width = 58
      Height = 16
      Caption = #25104#21697#24133#23485':'
      TabOrder = 11
    end
    object edt_Customer: TEdit
      Left = 37
      Top = 32
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
      ReadOnly = True
      TabOrder = 6
    end
    object edt_Grey_Width: TEdit
      Left = 202
      Top = 7
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
      ReadOnly = True
      TabOrder = 1
    end
    object edt_Width: TEdit
      Left = 202
      Top = 32
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
      ReadOnly = True
      TabOrder = 7
    end
    object edt_GF_NO: TEdit
      Left = 37
      Top = 7
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
      ReadOnly = True
      TabOrder = 0
    end
    object TStaticText
      Left = 315
      Top = 64
      Width = 58
      Height = 16
      Caption = #21518#25972#32553#29575':'
      TabOrder = 19
    end
    object edt_FN_Shrinkage: TEdit
      Left = 371
      Top = 56
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
      ReadOnly = True
      TabOrder = 15
    end
    object TStaticText
      Left = 5
      Top = 64
      Width = 34
      Height = 16
      Caption = #33639#20809':'
      TabOrder = 18
    end
    object edt_Anti_Fluorescence: TEdit
      Left = 37
      Top = 56
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
      ReadOnly = True
      TabOrder = 14
    end
    object TStaticText
      Left = 483
      Top = 64
      Width = 34
      Height = 16
      Caption = #35774#35745':'
      TabOrder = 20
    end
    object edt_Designer: TEdit
      Left = 513
      Top = 56
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
      ReadOnly = True
      TabOrder = 16
    end
    object edt_Designer_Time: TEdit
      Left = 677
      Top = 56
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
      ReadOnly = True
      TabOrder = 17
    end
    object TStaticText
      Left = 483
      Top = 40
      Width = 34
      Height = 16
      Caption = #29256#26412':'
      TabOrder = 13
    end
    object edt_Version: TEdit
      Left = 513
      Top = 32
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
      ReadOnly = True
      TabOrder = 9
    end
    object edt_BR: TEdit
      Left = 202
      Top = 56
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
      ReadOnly = True
      TabOrder = 22
    end
    object TStaticText
      Left = 482
      Top = 15
      Width = 34
      Height = 16
      Caption = #31576#24133':'
      TabOrder = 24
    end
    object edt_ReedWidth: TEdit
      Left = 512
      Top = 8
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
      ReadOnly = True
      TabOrder = 25
    end
  end
  object TPanel
    Left = 0
    Top = 446
    Width = 917
    Height = 34
    Align = alBottom
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 6
    object TPanel
      Left = 0
      Top = 0
      Width = 917
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        917
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
        Left = 842
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
        Left = 669
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        Flat = True
        OnClick = btn_SaveArtClick
      end
      object btn_ViewArtDtl: TSpeedButton
        Left = 583
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #26597#30475'(&W)'
        Flat = True
        OnClick = btn_ViewArtDtlClick
      end
      object btn_CheckRepairArt: TSpeedButton
        Left = 755
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #30830#35748'(&C)'
        Enabled = False
        Flat = True
        OnClick = btn_CheckRepairArtClick
      end
      object btnFIInfo: TSpeedButton
        Left = 496
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #25104#21697#20449#24687'(&I)'
        Flat = True
        OnClick = btnFIInfoClick
      end
      object chkIsQualityOperator: TCheckBox
        Left = 328
        Top = 8
        Width = 97
        Height = 17
        Caption = #26159#36136#37327#21592#65311
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
    end
  end
  object TPanel
    Left = 0
    Top = 443
    Width = 917
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
  end
  object aqry1: TADOQuery
    Parameters = <>
    Left = 136
    Top = 472
  end
  object cdsCheckRecipe: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 96
    Top = 432
  end
  object CDS_StdHdr: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 600
    Top = 440
  end
  object CDS_StdDtl: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 672
    Top = 448
  end
end

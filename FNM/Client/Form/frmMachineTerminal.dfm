object MachineTerminalForm: TMachineTerminalForm
  Left = -78
  Top = 0
  Width = 1376
  Height = 744
  Caption = #26426#21488#25805#20316
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 12
  object pnlClient: TPanel
    Left = 0
    Top = 73
    Width = 1360
    Height = 521
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnlRight: TPanel
      Left = 1192
      Top = 0
      Width = 168
      Height = 521
      Align = alRight
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object pnlPicture: TPanel
        Left = 2
        Top = 2
        Width = 164
        Height = 129
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object gfcadPattern: TGFCAD
          Left = 0
          Top = 0
          Width = 164
          Height = 129
          Align = alClient
          TabOrder = 0
          ControlData = {00000100F3100000550D000000000000}
        end
      end
      object pnlLevelClient: TPanel
        Left = 2
        Top = 131
        Width = 164
        Height = 388
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object mmoRemark: TMemo
          Left = 0
          Top = 352
          Width = 164
          Height = 36
          Align = alBottom
          Color = clMenu
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          ReadOnly = True
          TabOrder = 0
        end
        object grpFNArt: TGroupBox
          Left = 0
          Top = 0
          Width = 164
          Height = 352
          Align = alClient
          Caption = #24037#33402#20449#24687
          TabOrder = 1
          object vleArtParam: TValueListEditor
            Left = 2
            Top = 14
            Width = 160
            Height = 336
            Align = alClient
            Color = clMenu
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goAlwaysShowEditor, goThumbTracking]
            TabOrder = 0
            TitleCaptions.Strings = (
              #21442#25968#21517
              #21442#25968#20540)
            OnDrawCell = vleArtParamDrawCell
            ColWidths = (
              101
              53)
          end
        end
      end
    end
    object cxsplRight: TcxSplitter
      Left = 1184
      Top = 0
      Width = 8
      Height = 521
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salRight
      Control = pnlRight
    end
    object TPanel
      Left = 0
      Top = 0
      Width = 935
      Height = 521
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      object grpMachine: TGroupBox
        Left = 0
        Top = 0
        Width = 935
        Height = 376
        Align = alClient
        Caption = #26426#21488#20219#21153'(&8)'
        TabOrder = 0
        DesignSize = (
          935
          376)
        object cxgridMachineTaskInfo: TcxGrid
          Left = 2
          Top = 14
          Width = 931
          Height = 360
          Align = alClient
          TabOrder = 0
          OnDblClick = cxgridMachineTaskInfoDblClick
          LookAndFeel.Kind = lfFlat
          object cxgridtvMachineTaskInfo: TcxGridDBTableView
            DataController.DataSource = dsMachineTaskInfo
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NavigatorButtons.ConfirmDelete = False
            OnCustomDrawCell = cxgridtvMachineTaskInfoCustomDrawCell
            OptionsCustomize.ColumnFiltering = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsView.GroupByBox = False
            OptionsView.GroupFooters = gfAlwaysVisible
          end
          object cxGridlMachineTaskInfo: TcxGridLevel
            GridView = cxgridtvMachineTaskInfo
          end
        end
        object btnRefresh: TBitBtn
          Left = 854
          Top = 345
          Width = 75
          Height = 22
          Anchors = [akRight, akBottom]
          Caption = #21047#26032'(F5)'
          TabOrder = 1
          OnClick = btnRefreshClick
        end
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 384
        Width = 935
        Height = 137
        Align = alBottom
        Caption = #21270#26009#24773#20917'(&9)'
        TabOrder = 1
        DesignSize = (
          935
          137)
        object cxgridRecipeInfo: TcxGrid
          Left = 2
          Top = 96
          Width = 546
          Height = 22
          TabOrder = 0
          LookAndFeel.Kind = lfFlat
          object cxgridtvRecipeInfo: TcxGridDBTableView
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NavigatorButtons.ConfirmDelete = False
            OnCustomDrawCell = cxgridtvRecipeInfoCustomDrawCell
            OptionsCustomize.ColumnFiltering = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsView.GroupByBox = False
            OptionsView.GroupFooters = gfAlwaysVisible
          end
          object cxGridLevel1: TcxGridLevel
            GridView = cxgridtvRecipeInfo
          end
        end
        object sclbVat: TScrollBox
          Left = 2
          Top = 14
          Width = 931
          Height = 121
          Align = alClient
          TabOrder = 1
        end
        object btnVat: TBitBtn
          Left = 866
          Top = 103
          Width = 75
          Height = 22
          Anchors = [akRight, akBottom]
          Caption = #21047#26032'(F4)'
          TabOrder = 2
          OnClick = btnRefreshClick
        end
      end
      object cxsplBottom: TcxSplitter
        Left = 0
        Top = 376
        Width = 935
        Height = 8
        HotZoneClassName = 'TcxXPTaskBarStyle'
        AlignSplitter = salBottom
        Control = GroupBox1
      end
    end
    object pnlCache: TPanel
      Left = 943
      Top = 0
      Width = 241
      Height = 521
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 3
      object grpCache: TGroupBox
        Left = 0
        Top = 0
        Width = 241
        Height = 521
        Align = alClient
        Caption = #19979#26426#32531#23384
        TabOrder = 0
        object cxgrdCache: TcxGrid
          Left = 2
          Top = 14
          Width = 237
          Height = 474
          Align = alClient
          TabOrder = 0
          LookAndFeel.Kind = lfFlat
          object cxgvCache: TcxGridDBTableView
            DataController.DataSource = dsMachineDownCache
            DataController.KeyFieldNames = 'Iden'
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
            object cxcFN_Card: TcxGridDBColumn
              Caption = #21345#21495
              Options.Editing = False
              Options.Filtering = False
              Options.Focusing = False
              DataBinding.FieldName = 'FN_Card'
            end
            object cxcCar_NO: TcxGridDBColumn
              Caption = #36710'/'#21367#21495
              Options.Editing = False
              Options.Filtering = False
              DataBinding.FieldName = 'Car_NO'
            end
          end
          object cxglGrid1Level1: TcxGridLevel
            GridView = cxgvCache
          end
        end
        object pnlfooter: TPanel
          Left = 2
          Top = 488
          Width = 237
          Height = 31
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object edtCarNO: TcxTextEdit
            Left = 47
            Top = 8
            Width = 101
            Height = 20
            TabOrder = 0
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
            OnKeyPress = edtCarNOKeyPress
          end
          object edtRoll2: TcxTextEdit
            Left = 35
            Top = 32
            Width = 109
            Height = 20
            TabOrder = 1
            Visible = False
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
            OnKeyPress = edtRoll2KeyPress
          end
          object lbl10: TcxLabel
            Left = 2
            Top = 10
            Width = 46
            Height = 16
            Caption = #36710'/'#21367#21495
            TabOrder = 2
          end
          object cxLabel1: TcxLabel
            Left = 3
            Top = 31
            Width = 28
            Height = 16
            Caption = #21367#21495
            TabOrder = 3
            Visible = False
          end
          object btnSetArt: TcxButton
            Left = 152
            Top = 3
            Width = 75
            Height = 25
            BiDiMode = bdLeftToRight
            Caption = #24037#33402#21442#25968'(&P)'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentBiDiMode = False
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            TabOrder = 4
            OnClick = btnSetArtClick
            LookAndFeel.Kind = lfFlat
          end
        end
      end
    end
    object cxsp1: TcxSplitter
      Left = 935
      Top = 0
      Width = 8
      Height = 521
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salRight
      Control = pnlCache
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 597
    Width = 1360
    Height = 109
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    OnDblClick = pnlBottomDblClick
    object lbl1: TLabel
      Left = 5
      Top = 4
      Width = 30
      Height = 12
      Caption = #26426#21488':'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 5
      Top = 44
      Width = 30
      Height = 12
      Caption = #29677#27425':'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 136
      Top = 4
      Width = 30
      Height = 12
      Caption = #20154#21592':'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl6: TLabel
      Left = 310
      Top = 4
      Width = 30
      Height = 12
      Caption = #21345#21495':'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl7: TLabel
      Left = 310
      Top = 44
      Width = 48
      Height = 12
      Caption = #36710#36895'(&5):'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl4: TLabel
      Left = 418
      Top = 4
      Width = 48
      Height = 12
      Caption = #33853#24133'(&6):'
      FocusControl = edtWidth
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl5: TLabel
      Left = 418
      Top = 44
      Width = 66
      Height = 12
      Caption = #36710'/'#21367#21495'(&7):'
      FocusControl = edtCar_NO
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl8: TLabel
      Left = 784
      Top = 4
      Width = 66
      Height = 12
      Caption = #21047#26032#39057#29575'(&*)'
      Visible = False
    end
    object lbl9: TLabel
      Left = 760
      Top = 24
      Width = 24
      Height = 12
      Caption = #20998#38047
      Visible = False
    end
    object Label1: TLabel
      Left = 616
      Top = 7
      Width = 72
      Height = 12
      Caption = #26597#35810#31867#22411'(*):'
    end
    object Label2: TLabel
      Left = 894
      Top = 44
      Width = 48
      Height = 12
      Caption = #21367#21495'(&R):'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label3: TLabel
      Left = 614
      Top = 43
      Width = 66
      Height = 12
      Caption = #27233#33014#27631#21402#24230':'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object lblAlertInfo: TLabel
      Left = 712
      Top = 56
      Width = 6
      Height = 12
    end
    object lblArea: TLabel
      Left = 612
      Top = 43
      Width = 30
      Height = 12
      Caption = #22320#20301':'
    end
    object btnSample: TBitBtn
      Left = 388
      Top = 81
      Width = 47
      Height = 22
      Caption = #21462#26679
      TabOrder = 8
      Visible = False
      OnClick = btnSampleClick
    end
    object btnUp: TBitBtn
      Left = 444
      Top = 81
      Width = 75
      Height = 22
      Caption = #19978#26426'(&1)'
      Enabled = False
      TabOrder = 2
      OnClick = btnUpClick
    end
    object btnCancel: TBitBtn
      Left = 527
      Top = 81
      Width = 75
      Height = 22
      Caption = #21462#28040'(&2)'
      Enabled = False
      TabOrder = 9
      OnClick = btnCancelClick
    end
    object btnDown: TBitBtn
      Left = 610
      Top = 81
      Width = 75
      Height = 22
      Caption = #19979#26426'(&3)'
      Enabled = False
      TabOrder = 5
      OnClick = btnDownClick
    end
    object btnClose: TBitBtn
      Left = 693
      Top = 81
      Width = 75
      Height = 22
      Cancel = True
      Caption = #36864#20986
      TabOrder = 20
      OnClick = btnCloseClick
    end
    object chkShowMsg: TCheckBox
      Left = 521
      Top = 20
      Width = 87
      Height = 19
      Caption = #26174#31034#20449#24687'(&0)'
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 13
      OnClick = chkShowMsgClick
    end
    object chkAutoRefresh: TCheckBox
      Left = 763
      Top = 36
      Width = 90
      Height = 19
      AllowGrayed = True
      Caption = #33258#21160#21047#26032'(&9)'
      Checked = True
      State = cbChecked
      TabOrder = 16
      Visible = False
      OnClick = chkAutoRefreshClick
    end
    object cbbMachine_ID: TComboBox
      Left = 5
      Top = 18
      Width = 127
      Height = 20
      Style = csDropDownList
      Ctl3D = True
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ItemHeight = 12
      ParentCtl3D = False
      TabOrder = 0
      OnCloseUp = cbbMachine_IDCloseUp
      OnExit = cbbMachine_IDExit
    end
    object edtClass: TEdit
      Left = 5
      Top = 57
      Width = 127
      Height = 20
      Color = clBtnFace
      Enabled = False
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ReadOnly = True
      TabOrder = 15
    end
    object lstOperator: TListBox
      Left = 136
      Top = 17
      Width = 171
      Height = 60
      Color = clMenu
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ItemHeight = 12
      TabOrder = 17
    end
    object edtSpeed: TEdit
      Left = 310
      Top = 57
      Width = 105
      Height = 20
      Color = clMenu
      Enabled = False
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 1
      OnKeyDown = edtSpeedKeyDown
    end
    object edtFN_Card: TEdit
      Left = 310
      Top = 18
      Width = 105
      Height = 20
      Color = clMenu
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ReadOnly = True
      TabOrder = 18
    end
    object edtWidth: TEdit
      Left = 418
      Top = 18
      Width = 97
      Height = 20
      Color = clMenu
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 3
      OnKeyDown = edtWidthKeyDown
    end
    object edtCar_NO: TEdit
      Left = 418
      Top = 57
      Width = 191
      Height = 20
      CharCase = ecUpperCase
      Color = clMenu
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 10
      TabOrder = 4
      OnKeyDown = edtCar_NOKeyDown
    end
    object edtInterval: TEdit
      Left = 792
      Top = 17
      Width = 37
      Height = 20
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 14
      Text = '5'
      Visible = False
    end
    object btn_NewAccident: TBitBtn
      Left = 75
      Top = 81
      Width = 62
      Height = 22
      Caption = #20889#21333'(&A)'
      TabOrder = 7
      OnClick = btn_NewAccidentClick
    end
    object btnSuspend: TBitBtn
      Left = 5
      Top = 81
      Width = 68
      Height = 22
      Caption = #26426#21488#20572#26426'(&S)'
      TabOrder = 6
      OnClick = btnSuspendClick
    end
    object btn_ModifyCarNO: TBitBtn
      Left = 251
      Top = 81
      Width = 71
      Height = 22
      Hint = #20462#25913#36710#21495#12289#21367#21495
      Caption = #20462#25913#36710#21495'(&C)'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      OnClick = btn_ModifyCarNOClick
    end
    object btnQuery: TBitBtn
      Left = 684
      Top = 3
      Width = 67
      Height = 20
      Caption = #26597#35810'(&Q)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      OnClick = btnQueryClick
    end
    object cbbType: TComboBox
      Left = 616
      Top = 23
      Width = 137
      Height = 20
      Style = csDropDownList
      DropDownCount = 10
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ItemHeight = 12
      TabOrder = 11
      Items.Strings = (
        #20135#37327#26597#35810
        #20572#26426#26597#35810
        #20135#37327#26597#35810'('#27719#24635')'
        #22788#29702#21333#26597#35810
        #36718#20241#26597#35810
        'OTD'#25302#21333#26597#35810
        'SOP'#38169#39033#26597#35810
        #24403#29677#30133#28857#39044#38450#26597#35810
        #26426#21488#26410#21152#24037#30133#28857#39044#38450#26597#35810
        #25925#38556#26597#35810
        #22870#32602'/'#38169#39033#26597#35810
        #32489#25928'+'#20135#37327'+FPY'#29575#26597#35810)
    end
    object btnLocation: TBitBtn
      Left = 322
      Top = 81
      Width = 62
      Height = 22
      Caption = #36710#20301'(&L)'
      TabOrder = 19
      OnClick = btnLocationClick
    end
    object edtRoll: TEdit
      Left = 890
      Top = 57
      Width = 97
      Height = 20
      CharCase = ecUpperCase
      Color = clMenu
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 10
      TabOrder = 21
      Visible = False
      OnKeyDown = edtRollKeyDown
    end
    object edtXJ: TEdit
      Left = 610
      Top = 57
      Width = 97
      Height = 20
      CharCase = ecUpperCase
      Color = clMenu
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 10
      TabOrder = 22
      Visible = False
      OnKeyDown = edtXJKeyDown
    end
    object btnScrap: TBitBtn
      Left = 200
      Top = 81
      Width = 46
      Height = 22
      Caption = #25253#24223
      TabOrder = 23
      OnClick = btnScrapClick
    end
    object btnMC: TBitBtn
      Left = 779
      Top = 81
      Width = 62
      Height = 22
      Caption = #33021#28304#31995#32479
      TabOrder = 24
      OnClick = btnMCClick
    end
    object edtAutoUpDown: TEdit
      Left = 761
      Top = 22
      Width = 105
      Height = 20
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 25
      OnChange = edtAutoUpDownChange
    end
    object btnPW: TBitBtn
      Left = 139
      Top = 82
      Width = 60
      Height = 22
      Cancel = True
      Caption = #22870#32602'/'#38169#39033
      TabOrder = 26
      OnClick = btnPWClick
    end
    object BtnEditCarNo: TButton
      Left = 712
      Top = 56
      Width = 103
      Height = 22
      Caption = #22383#24067#20462#25913#36710#29260#21495
      TabOrder = 27
      OnClick = BtnEditCarNoClick
    end
    object cbbArea: TcxComboBox
      Left = 609
      Top = 57
      Width = 99
      Height = 20
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      TabOrder = 28
    end
  end
  object pnl_Only2: TPanel
    Left = 0
    Top = 594
    Width = 1360
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
  end
  object pnlMsg: TPanel
    Left = 0
    Top = 0
    Width = 1360
    Height = 65
    Align = alTop
    Ctl3D = True
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBtnFace
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 3
    object cxmMsg: TcxMemo
      Left = 1
      Top = 1
      Width = 1358
      Height = 63
      TabStop = False
      Align = alClient
      DragMode = dmAutomatic
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentFont = False
      Properties.AutoSelect = True
      Properties.ReadOnly = False
      Properties.ScrollBars = ssVertical
      Style.Color = clBtnFace
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clBlue
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.LookAndFeel.Kind = lfUltraFlat
      Style.LookAndFeel.NativeStyle = False
      Style.Shadow = False
      TabOrder = 0
    end
  end
  object cxsplTop: TcxSplitter
    Left = 0
    Top = 65
    Width = 1360
    Height = 8
    HotZoneClassName = 'TcxXPTaskBarStyle'
    AlignSplitter = salTop
    Control = pnlMsg
  end
  object dsMachineTaskInfo: TDataSource
    DataSet = cdsMachineTaskInfo
    Left = 40
    Top = 240
  end
  object cdsMachineTaskInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdsMachineTaskInfoAfterScroll
    Left = 40
    Top = 288
  end
  object tmr1: TTimer
    Interval = 300000
    OnTimer = tmr1Timer
    Left = 344
    Top = 304
  end
  object dsRecipeInfo: TDataSource
    DataSet = cdsRecipeInfo
    Left = 176
    Top = 240
  end
  object cdsRecipeInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 176
    Top = 288
  end
  object cdsVatInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 280
    Top = 296
  end
  object cdsAffirmCardMsg: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 280
    Top = 240
  end
  object dsExportToDS: TADODataSet
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=fnmonitor2011;Persist Security Info' +
      '=True;User ID=fnMonitor;Initial Catalog=fnMonitor;Data Source=GE' +
      'TNT07'
    CursorType = ctDynamic
    Parameters = <>
    Left = 408
    Top = 248
  end
  object cdsExportToDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 488
    Top = 248
  end
  object cdsTrace: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 112
    Top = 120
  end
  object timerMC: TTimer
    Interval = 60000
    OnTimer = timerMCTimer
    Left = 272
    Top = 376
  end
  object cdsAlertInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 192
    Top = 168
  end
  object cdsOneAlertInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 864
    Top = 416
  end
  object cdsMachineDownCache: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 752
    Top = 112
  end
  object dsMachineDownCache: TDataSource
    DataSet = cdsMachineDownCache
    Left = 784
    Top = 112
  end
  object cdsStdArt: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 752
    Top = 152
  end
  object dsArea: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 648
    Top = 400
  end
  object CDSquantityinfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 376
    Top = 32
  end
  object cdssamping: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 528
    Top = 88
  end
  object tmrCompactingSkewing: TTimer
    Interval = 3600000
    OnTimer = tmrCompactingSkewingTimer
    Left = 1144
    Top = 624
  end
  object cdsNewAccident: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 160
    Top = 632
  end
end

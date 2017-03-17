object FabricCardForm: TFabricCardForm
  Left = 142
  Top = 94
  Width = 788
  Height = 521
  Caption = #25286#24067#32452#21345
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object pgcSplitCardFabric: TPageControl
    Left = 0
    Top = 0
    Width = 780
    Height = 494
    ActivePage = tsCard
    Align = alClient
    TabIndex = 1
    TabOrder = 0
    object tsFabric: TTabSheet
      Caption = #25286#20998#24067#21495'(&F)'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 772
        Height = 467
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object grp1: TGroupBox
          Left = 0
          Top = 27
          Width = 772
          Height = 178
          Align = alTop
          Caption = #25286#20998#21069#20449#24687
          TabOrder = 1
          object lbl6: TLabel
            Left = 410
            Top = 25
            Width = 42
            Height = 12
            Caption = #36710#29260#21495':'
          end
          object lbl7: TLabel
            Left = 213
            Top = 143
            Width = 30
            Height = 12
            Caption = #21345#21495':'
          end
          object lbl8: TLabel
            Left = 10
            Top = 27
            Width = 30
            Height = 12
            Caption = #25968#37327':'
          end
          object lbl9: TLabel
            Left = 10
            Top = 54
            Width = 42
            Height = 12
            Caption = #21697#21517'ID:'
          end
          object lbl10: TLabel
            Left = 213
            Top = 53
            Width = 30
            Height = 12
            Caption = #21697#21517':'
          end
          object lbl11: TLabel
            Left = 410
            Top = 55
            Width = 42
            Height = 12
            Caption = #25490#21333#21495':'
          end
          object lbl12: TLabel
            Left = 10
            Top = 81
            Width = 42
            Height = 12
            Caption = #23450#21333#21495':'
          end
          object lbl13: TLabel
            Left = 213
            Top = 83
            Width = 30
            Height = 12
            Caption = #23458#25143':'
          end
          object lbl14: TLabel
            Left = 410
            Top = 85
            Width = 30
            Height = 12
            Caption = #20132#26399':'
          end
          object lbl15: TLabel
            Left = 10
            Top = 109
            Width = 30
            Height = 12
            Caption = #26469#28304':'
          end
          object lbl16: TLabel
            Left = 410
            Top = 144
            Width = 30
            Height = 12
            Caption = #22791#27880':'
          end
          object lbl17: TLabel
            Left = 213
            Top = 23
            Width = 54
            Height = 12
            Caption = #25286#20998#25968#37327':'
          end
          object lbl18: TLabel
            Left = 213
            Top = 113
            Width = 42
            Height = 12
            Caption = #32463#32428#23494':'
          end
          object lbl19: TLabel
            Left = 410
            Top = 114
            Width = 54
            Height = 12
            Caption = #32463#32428#32433#25903':'
          end
          object lbl20: TLabel
            Left = 10
            Top = 136
            Width = 54
            Height = 12
            Caption = #25910#22383#26085#26399':'
          end
          object edtQuantity: TEdit
            Left = 64
            Top = 18
            Width = 121
            Height = 20
            Color = clCream
            ReadOnly = True
            TabOrder = 0
          end
          object edtFN_Card: TEdit
            Left = 271
            Top = 140
            Width = 121
            Height = 20
            Color = clMenu
            ReadOnly = True
            TabOrder = 12
          end
          object edtWarpWeft_Density: TEdit
            Left = 271
            Top = 110
            Width = 121
            Height = 20
            Color = clMenu
            ReadOnly = True
            TabOrder = 10
          end
          object edtGF_ID: TEdit
            Left = 64
            Top = 47
            Width = 121
            Height = 20
            Color = clMenu
            ReadOnly = True
            TabOrder = 3
          end
          object edtGF_NO: TEdit
            Left = 271
            Top = 50
            Width = 121
            Height = 20
            Color = clMenu
            ReadOnly = True
            TabOrder = 4
          end
          object edtJob_NO: TEdit
            Left = 470
            Top = 51
            Width = 121
            Height = 20
            Color = clMenu
            ReadOnly = True
            TabOrder = 5
          end
          object edtPPO_NO: TEdit
            Left = 64
            Top = 77
            Width = 121
            Height = 20
            Color = clMenu
            ReadOnly = True
            TabOrder = 6
          end
          object edtCustomer: TEdit
            Left = 271
            Top = 80
            Width = 121
            Height = 20
            Color = clMenu
            ReadOnly = True
            TabOrder = 7
          end
          object edtDelivery_Date: TEdit
            Left = 470
            Top = 81
            Width = 121
            Height = 20
            Color = clMenu
            ReadOnly = True
            TabOrder = 8
          end
          object edtSource: TEdit
            Left = 64
            Top = 107
            Width = 121
            Height = 20
            Color = clMenu
            ReadOnly = True
            TabOrder = 9
          end
          object edtremark: TEdit
            Left = 470
            Top = 141
            Width = 291
            Height = 20
            Color = clMenu
            ReadOnly = True
            TabOrder = 13
          end
          object edtSplit_Quantity: TEdit
            Tag = 1
            Left = 270
            Top = 20
            Width = 121
            Height = 20
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnKeyUp = edtSplit_QuantityKeyUp
          end
          object edtWarpWeft_Count: TEdit
            Left = 470
            Top = 111
            Width = 121
            Height = 20
            Color = clMenu
            ReadOnly = True
            TabOrder = 11
          end
          object edtCar_NO: TEdit
            Left = 470
            Top = 21
            Width = 121
            Height = 20
            Color = clMenu
            ReadOnly = True
            TabOrder = 2
          end
          object edtReceive_Date: TEdit
            Left = 64
            Top = 136
            Width = 121
            Height = 20
            Color = clMenu
            ReadOnly = True
            TabOrder = 14
          end
        end
        object grp2: TGroupBox
          Left = 0
          Top = 205
          Width = 772
          Height = 85
          Align = alTop
          Caption = #25286#20998#21518#20449#24687
          TabOrder = 3
          object lbl2: TLabel
            Left = 10
            Top = 25
            Width = 42
            Height = 12
            Caption = #21407#24067#21495':'
          end
          object lbl3: TLabel
            Left = 213
            Top = 21
            Width = 42
            Height = 12
            Caption = #21407#30721#38271':'
          end
          object lbl4: TLabel
            Left = 10
            Top = 58
            Width = 42
            Height = 12
            Caption = #26032#24067#21495':'
          end
          object lbl5: TLabel
            Left = 213
            Top = 54
            Width = 42
            Height = 12
            Caption = #26032#30721#38271':'
          end
          object edtOld_Fabric_NO: TEdit
            Left = 57
            Top = 21
            Width = 132
            Height = 20
            Color = clMenu
            ReadOnly = True
            TabOrder = 0
          end
          object edtOld_Quantity: TEdit
            Left = 269
            Top = 21
            Width = 131
            Height = 20
            Color = clMenu
            ReadOnly = True
            TabOrder = 1
          end
          object edtNew_Fabric_NO: TEdit
            Left = 57
            Top = 53
            Width = 132
            Height = 21
            Color = clMenu
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object edtNew_Quantity: TEdit
            Left = 269
            Top = 53
            Width = 131
            Height = 20
            Color = clMenu
            ReadOnly = True
            TabOrder = 3
          end
        end
        object Panel2: TPanel
          Left = 0
          Top = 429
          Width = 772
          Height = 38
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 2
          DesignSize = (
            772
            38)
          object btnSaveFabric: TButton
            Left = 537
            Top = 5
            Width = 75
            Height = 25
            Anchors = [akRight, akBottom]
            Caption = #20445#23384'(&S)'
            Enabled = False
            TabOrder = 0
            OnClick = btnSaveFabricClick
          end
          object btnClose: TButton
            Left = 693
            Top = 5
            Width = 75
            Height = 25
            Anchors = [akRight, akBottom]
            Cancel = True
            Caption = #36864#20986'(&X)'
            TabOrder = 2
            OnClick = btnCloseClick
          end
          object btnCancelFabric: TButton
            Left = 616
            Top = 5
            Width = 75
            Height = 25
            Anchors = [akRight, akBottom]
            Caption = #21462#28040'(&C)'
            TabOrder = 1
            OnClick = btnCancelFabricClick
          end
        end
        object pnl5: TPanel
          Left = 0
          Top = 0
          Width = 772
          Height = 27
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object lbl1: TLabel
            Left = 12
            Top = 10
            Width = 30
            Height = 12
            Caption = #24067#21495':'
          end
          object edtFabric_NO: TEdit
            Left = 45
            Top = 4
            Width = 131
            Height = 20
            CharCase = ecUpperCase
            MaxLength = 19
            TabOrder = 0
            OnEnter = edtFabric_NOEnter
            OnExit = edtFabric_NOExit
          end
          object btnQueryFabric: TBitBtn
            Left = 181
            Top = 2
            Width = 75
            Height = 25
            Caption = #26597#35810'(&Q)'
            TabOrder = 1
            OnClick = btnQueryFabricClick
          end
        end
      end
    end
    object tsCard: TTabSheet
      Caption = #25286#21345#32452#21345'(&K)'
      ImageIndex = 1
      object pnl1: TPanel
        Left = 0
        Top = 0
        Width = 772
        Height = 467
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object spl1: TSplitter
          Left = 0
          Top = 218
          Width = 772
          Height = 3
          Cursor = crVSplit
          Align = alTop
        end
        object grp4: TGroupBox
          Left = 0
          Top = 27
          Width = 772
          Height = 191
          Align = alTop
          Caption = #24453#32452#21345#20449#24687#21015#34920
          TabOrder = 1
          object lvSourceCard: TListView
            Left = 2
            Top = 14
            Width = 606
            Height = 140
            Align = alClient
            Columns = <
              item
                Caption = #24067#21495
                Width = 130
              end
              item
                Caption = #24067#36136#37327
              end
              item
                Alignment = taCenter
                Caption = #30721#38271
                Width = 80
              end
              item
                Alignment = taCenter
                Caption = #24403#21069#24037#24207
                Width = 80
              end
              item
                Alignment = taCenter
                Caption = #24037#33402'ID'
                Width = 0
              end
              item
                Alignment = taCenter
                Caption = #21697#21517'ID'
                Width = 0
              end
              item
                Alignment = taCenter
                Caption = #21697#21517
                Width = 120
              end
              item
                Alignment = taCenter
                Caption = #25490#21333#21495
                Width = 60
              end
              item
                Alignment = taCenter
                Caption = #21345#21495
                Width = 90
              end>
            GridLines = True
            MultiSelect = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
            OnChange = lvSourceCardChange
            OnDblClick = lvSourceCardDblClick
            OnKeyUp = lvSourceCardKeyUp
          end
          object grp5: TGroupBox
            Left = 608
            Top = 14
            Width = 162
            Height = 140
            Align = alRight
            Caption = #24050#25286#21345#21015#34920
            TabOrder = 1
            object lstFNCard: TListBox
              Left = 2
              Top = 14
              Width = 158
              Height = 124
              Align = alClient
              ItemHeight = 12
              TabOrder = 0
            end
          end
          object pnl2: TPanel
            Left = 2
            Top = 154
            Width = 768
            Height = 35
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 2
            object lbl21: TLabel
              Left = 8
              Top = 16
              Width = 30
              Height = 12
              Caption = #30721#38271':'
            end
            object btnDown: TSpeedButton
              Left = 144
              Top = 6
              Width = 23
              Height = 22
              Enabled = False
              Flat = True
              OnClick = btnDownClick
            end
            object btnDownAll: TSpeedButton
              Left = 176
              Top = 6
              Width = 23
              Height = 22
              Enabled = False
              Flat = True
              OnClick = btnDownAllClick
            end
            object btnUp: TSpeedButton
              Left = 208
              Top = 6
              Width = 23
              Height = 22
              Enabled = False
              Flat = True
              OnClick = btnUpClick
            end
            object btnUpAll: TSpeedButton
              Left = 240
              Top = 6
              Width = 23
              Height = 22
              Enabled = False
              Flat = True
              OnClick = btnUpAllClick
            end
            object Label1: TLabel
              Left = 278
              Top = 16
              Width = 51
              Height = 13
              AutoSize = False
              Caption = #21407#22240'(&C):'
              FocusControl = edt_Reason
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
            object edtQuantity_FNCard: TEdit
              Left = 37
              Top = 8
              Width = 76
              Height = 20
              Color = clMenu
              ReadOnly = True
              TabOrder = 0
            end
            object edt_Reason: TEdit
              Left = 333
              Top = 9
              Width = 428
              Height = 20
              CharCase = ecUpperCase
              MaxLength = 11
              TabOrder = 1
            end
          end
        end
        object grp3: TGroupBox
          Left = 0
          Top = 221
          Width = 772
          Height = 211
          Align = alClient
          Caption = #34987#32452#21345#20449#24687#21015#34920
          TabOrder = 2
          object lvDestinate: TListView
            Left = 2
            Top = 14
            Width = 768
            Height = 195
            Align = alClient
            Columns = <
              item
                Caption = #24067#21495
                Width = 130
              end
              item
                Caption = #24067#36136#37327
              end
              item
                Alignment = taCenter
                Caption = #30721#38271
                Width = 80
              end
              item
                Alignment = taCenter
                Caption = #24403#21069#24037#24207
                Width = 80
              end
              item
                Alignment = taCenter
                Caption = #24037#33402'ID'
                Width = 0
              end
              item
                Alignment = taCenter
                Caption = #21697#21517'ID'
                Width = 0
              end
              item
                Alignment = taCenter
                Caption = #21697#21517
                Width = 120
              end
              item
                Alignment = taCenter
                Caption = #25490#21333#21495
                Width = 60
              end
              item
                Alignment = taCenter
                Caption = #21407#21345#21495
                Width = 90
              end>
            GridLines = True
            MultiSelect = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
            OnChange = lvDestinateChange
            OnDblClick = lvDestinateDblClick
            OnKeyUp = lvDestinateKeyUp
          end
        end
        object pnl4: TPanel
          Left = 0
          Top = 0
          Width = 772
          Height = 27
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object lbl24: TLabel
            Left = 12
            Top = 10
            Width = 30
            Height = 12
            Caption = #21345#21495':'
          end
          object btnQueryCard: TBitBtn
            Left = 181
            Top = 2
            Width = 75
            Height = 25
            Caption = #26597#35810'(&Q)'
            TabOrder = 1
            OnClick = btnQueryCardClick
          end
          object edtFN_Card_Layer: TEdit
            Left = 45
            Top = 4
            Width = 131
            Height = 20
            CharCase = ecUpperCase
            MaxLength = 11
            TabOrder = 0
            OnEnter = edtFN_Card_LayerEnter
            OnExit = edtFN_Card_LayerExit
          end
        end
        object pnl3: TPanel
          Left = 0
          Top = 432
          Width = 772
          Height = 35
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 3
          DesignSize = (
            772
            35)
          object lbl22: TLabel
            Left = 10
            Top = 17
            Width = 30
            Height = 12
            Caption = #30721#38271':'
          end
          object lblCar_NO: TLabel
            Left = 132
            Top = 16
            Width = 53
            Height = 13
            AutoSize = False
            Caption = #36710#29260#21495'&T:'
            FocusControl = edtCar
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object lbl23: TLabel
            Left = 238
            Top = 16
            Width = 59
            Height = 13
            AutoSize = False
            Caption = #32452#21512#21345#21495'&C:'
            FocusControl = edtNew_FN_Card_Layer
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object edtQuantity_Fabric: TEdit
            Left = 39
            Top = 9
            Width = 81
            Height = 20
            Color = clMenu
            ReadOnly = True
            TabOrder = 2
          end
          object edtCar: TEdit
            Left = 184
            Top = 9
            Width = 49
            Height = 20
            MaxLength = 11
            TabOrder = 0
          end
          object edtNew_FN_Card_Layer: TEdit
            Left = 300
            Top = 9
            Width = 61
            Height = 20
            CharCase = ecUpperCase
            MaxLength = 11
            TabOrder = 1
          end
          object btnSaveCard: TButton
            Left = 537
            Top = 7
            Width = 75
            Height = 22
            Anchors = [akRight, akBottom]
            Caption = #20445#23384'(&S)'
            TabOrder = 3
            OnClick = btnSaveCardClick
          end
          object btnPrint: TButton
            Left = 616
            Top = 7
            Width = 75
            Height = 22
            Anchors = [akRight, akBottom]
            Caption = #25171#21360'(&P)'
            TabOrder = 4
          end
          object btnExit: TButton
            Left = 693
            Top = 7
            Width = 75
            Height = 22
            Anchors = [akRight, akBottom]
            Cancel = True
            Caption = #36864#20986'(&X)'
            TabOrder = 5
            OnClick = btnExitClick
          end
        end
      end
    end
  end
  object cdsPublic: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 24
    Top = 407
  end
end

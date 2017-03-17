object CreateRecipeForm: TCreateRecipeForm
  Left = 213
  Top = 214
  BorderStyle = bsDialog
  Caption = #21019#24314#21270#26009#21333
  ClientHeight = 333
  ClientWidth = 729
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 729
    Height = 333
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      729
      333)
    object pgcType: TPageControl
      Left = 0
      Top = 0
      Width = 729
      Height = 337
      ActivePage = ts2
      Align = alTop
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      HotTrack = True
      ParentFont = False
      Style = tsFlatButtons
      TabIndex = 0
      TabOrder = 0
      OnChange = pgcTypeChange
      object ts2: TTabSheet
        Caption = #26032#24314#37197#26041
        ImageIndex = 1
        object GroupBox1: TGroupBox
          Left = 152
          Top = 9
          Width = 561
          Height = 258
          Caption = 'grp1'
          TabOrder = 11
          object lvCardNew: TListView
            Left = 2
            Top = 14
            Width = 557
            Height = 242
            Align = alClient
            Checkboxes = True
            Columns = <
              item
                Caption = #21345#21495
                Width = 80
              end
              item
                Caption = #21697#21517
                Width = 130
              end
              item
                Caption = #30721#38271
              end
              item
                Caption = 'HOLD'
                Width = 120
              end
              item
                Caption = #29305#28418#30333
                Width = 80
              end
              item
                Caption = #36710#21495
                Width = 80
              end>
            ColumnClick = False
            FlatScrollBars = True
            GridLines = True
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            TabOrder = 1
            ViewStyle = vsReport
            OnCustomDrawItem = lvCardNewCustomDrawItem
          end
          object chkAllNew: TCheckBox
            Left = 3
            Top = -2
            Width = 182
            Height = 17
            Caption = #20840#36873'/'#21462#28040' ('#32418#33394#21345#21495#24050'HOLD)'
            TabOrder = 0
            OnClick = chkAllNewClick
          end
        end
        object Memo1: TMemo
          Left = 152
          Top = 9
          Width = 561
          Height = 258
          Color = clMenu
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -20
          Font.Name = #23435#20307
          Font.Style = []
          Lines.Strings = (
            ''
            #36864#27974#37197#26041';TJ08,'
            '         '#27599#21333#21270#26009#37327#20026'1000L'
            ''
            #27700#27927#37197#26041':JX01'#12289'JX02'#12289'JX03,'
            '         '#27599#21333#21270#26009#37327#20026'5200L')
          ParentFont = False
          TabOrder = 0
        end
        object rbBase: TRadioButton
          Left = 16
          Top = 203
          Width = 65
          Height = 17
          Caption = #25171#24213#26009
          Checked = True
          TabOrder = 1
          TabStop = True
          OnClick = rbBaseClick
        end
        object rbCard: TRadioButton
          Left = 16
          Top = 232
          Width = 65
          Height = 17
          Caption = #21345#21495#20449#24687
          TabOrder = 2
          OnClick = rbCardClick
        end
        object TStaticText
          Left = 7
          Top = 57
          Width = 58
          Height = 16
          Caption = #37197#26041'(&P):'
          TabOrder = 3
        end
        object txt_Only: TStaticText
          Left = 7
          Top = 10
          Width = 58
          Height = 16
          Caption = #24037#24207'(&O):'
          TabOrder = 4
        end
        object cbbOperationNew: TComboBox
          Left = 7
          Top = 26
          Width = 120
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 5
          OnChange = cbbOperationNewChange
        end
        object cbbStdPrescriptionNew: TComboBox
          Left = 7
          Top = 71
          Width = 120
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 6
          OnChange = cbbStdPrescriptionNewChange
          OnEnter = cbbStdPrescriptionNewEnter
        end
        object TStaticText
          Left = 7
          Top = 100
          Width = 58
          Height = 16
          Caption = #26426#21488'(&M):'
          TabOrder = 7
        end
        object cbbMachineIDNew: TComboBox
          Left = 7
          Top = 119
          Width = 120
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 8
          OnChange = cbbMachineIDNewChange
          OnEnter = cbbMachineIDNewEnter
        end
        object TStaticText
          Left = 7
          Top = 149
          Width = 88
          Height = 16
          Caption = #22522#26412#20307#31215'((&V):'
          TabOrder = 9
        end
        object edtBaseVolumeNew: TEdit
          Left = 7
          Top = 165
          Width = 120
          Height = 20
          TabOrder = 10
        end
      end
      object ts3: TTabSheet
        Caption = #34917#20805#21270#26009
        ImageIndex = 2
        object btn_Query: TSpeedButton
          Left = 52
          Top = 277
          Width = 75
          Height = 25
          Caption = #26597#35810'(&Q)'
          Flat = True
          OnClick = btn_QueryClick
        end
        object TStaticText
          Left = 7
          Top = 192
          Width = 58
          Height = 16
          Caption = #24320#22987#26102#38388':'
          TabOrder = 0
        end
        object TStaticText
          Left = 7
          Top = 234
          Width = 58
          Height = 16
          Caption = #32467#26463#26102#38388':'
          TabOrder = 1
        end
        object edtBeginTimeSupply: TEdit
          Left = 7
          Top = 207
          Width = 120
          Height = 20
          TabOrder = 2
        end
        object edtEndTimeSupply: TEdit
          Left = 7
          Top = 247
          Width = 120
          Height = 20
          TabOrder = 3
        end
        object TStaticText
          Left = 7
          Top = 57
          Width = 58
          Height = 16
          Caption = #37197#26041'(&P):'
          TabOrder = 4
        end
        object StaticText1: TStaticText
          Left = 7
          Top = 10
          Width = 58
          Height = 16
          Caption = #24037#24207'(&O):'
          TabOrder = 5
        end
        object cbbOperationSupply: TComboBox
          Left = 7
          Top = 26
          Width = 120
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 6
          OnChange = cbbOperationSupplyChange
        end
        object cbbStdPrescriptionSupply: TComboBox
          Left = 7
          Top = 71
          Width = 120
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 7
          OnChange = cbbStdPrescriptionSupplyChange
          OnEnter = cbbStdPrescriptionSupplyEnter
        end
        object TStaticText
          Left = 7
          Top = 100
          Width = 58
          Height = 16
          Caption = #26426#21488'(&M):'
          TabOrder = 8
        end
        object cbbMachineIDSupply: TComboBox
          Left = 7
          Top = 119
          Width = 120
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 9
          OnChange = cbbMachineIDSupplyChange
          OnEnter = cbbMachineIDSupplyEnter
        end
        object TStaticText
          Left = 7
          Top = 149
          Width = 88
          Height = 16
          Caption = #22522#26412#20307#31215'((&V):'
          TabOrder = 10
        end
        object edtBaseVolumeSupply: TEdit
          Left = 7
          Top = 165
          Width = 120
          Height = 20
          TabOrder = 11
        end
        object grp1: TGroupBox
          Left = 152
          Top = 9
          Width = 313
          Height = 258
          Caption = 'grp1'
          TabOrder = 12
          object chkAllSupply: TCheckBox
            Left = 3
            Top = -2
            Width = 182
            Height = 17
            Caption = #20840#36873'/'#21462#28040' ('#32418#33394#21345#21495#24050'HOLD)'
            TabOrder = 0
            OnClick = chkAllSupplyClick
          end
          object lvCardSupply: TListView
            Left = 2
            Top = 14
            Width = 309
            Height = 242
            Align = alClient
            Checkboxes = True
            Columns = <
              item
                Width = 20
              end
              item
                Alignment = taCenter
                Caption = #21345#21495
                Width = 70
              end
              item
                Alignment = taCenter
                Caption = #30721#38271
                Width = 40
              end
              item
                Caption = #24320#22987#26102#38388
                Width = 125
              end
              item
                Caption = 'HOLD'
                Width = 45
              end>
            ColumnClick = False
            GridLines = True
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            TabOrder = 1
            ViewStyle = vsReport
            OnCustomDrawItem = lvCardSupplyCustomDrawItem
          end
        end
      end
    end
    object btnCancel: TButton
      Left = 571
      Top = 303
      Width = 75
      Height = 25
      Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
      Anchors = [akRight, akBottom]
      Caption = #21462#28040'(&C)'
      ModalResult = 2
      TabOrder = 1
    end
    object btn_OK: TButton
      Left = 650
      Top = 303
      Width = 75
      Height = 25
      Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
      Anchors = [akRight, akBottom]
      Caption = #30830#23450'(&O)'
      ModalResult = 1
      TabOrder = 2
    end
  end
end

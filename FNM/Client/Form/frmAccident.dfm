object AccidentForm: TAccidentForm
  Left = 495
  Top = 106
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  BorderWidth = 2
  Caption = #36755#20837#22788#29702#21333
  ClientHeight = 468
  ClientWidth = 747
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object TPanel
    Left = 305
    Top = 0
    Width = 442
    Height = 465
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object TPanel
      Left = 0
      Top = 0
      Width = 442
      Height = 121
      Align = alTop
      BevelInner = bvLowered
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 30
        Height = 12
        Caption = #21333#21495':'
      end
      object Label2: TLabel
        Left = 7
        Top = 36
        Width = 30
        Height = 12
        Caption = #24037#24207':'
      end
      object Label3: TLabel
        Left = 6
        Top = 58
        Width = 54
        Height = 12
        Caption = #20889#21333#26426#21488':'
      end
      object Label4: TLabel
        Left = 6
        Top = 80
        Width = 54
        Height = 12
        Caption = #30133#28857#20998#31867':'
      end
      object Label5: TLabel
        Left = 6
        Top = 101
        Width = 42
        Height = 12
        Caption = #30133#28857#21517':'
      end
      object Label6: TLabel
        Left = 257
        Top = 36
        Width = 30
        Height = 12
        Caption = #30721#38271':'
      end
      object Label7: TLabel
        Left = 256
        Top = 58
        Width = 42
        Height = 12
        Caption = #20889#21333#20154':'
      end
      object Label8: TLabel
        Left = 256
        Top = 80
        Width = 42
        Height = 12
        Caption = #21457#29616#28857':'
      end
      object Label9: TLabel
        Left = 256
        Top = 101
        Width = 30
        Height = 12
        Caption = #31867#22411':'
      end
      object edt_AccidentNO: TEdit
        Left = 59
        Top = 5
        Width = 302
        Height = 20
        TabStop = False
        Color = clBtnFace
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ReadOnly = True
        TabOrder = 3
      end
      object cbb_Class: TComboBox
        Left = 307
        Top = 93
        Width = 126
        Height = 20
        Style = csDropDownList
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ItemHeight = 12
        TabOrder = 2
        OnChange = OnAccidentDataChange
        Items.Strings = (
          #25805#20316
          #24037#33402
          #35774#22791
          #22383#24067
          #20854#20182)
      end
      object cbb_ReasonType: TComboBox
        Left = 59
        Top = 72
        Width = 190
        Height = 20
        Style = csDropDownList
        DropDownCount = 30
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ItemHeight = 12
        TabOrder = 0
        OnSelect = AComboBoxSelect
      end
      object edt_SumQuantity: TEdit
        Left = 307
        Top = 28
        Width = 126
        Height = 20
        TabStop = False
        Color = clBtnFace
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ReadOnly = True
        TabOrder = 5
        Text = '0'
      end
      object cbbReasonName: TComboBox
        Left = 59
        Top = 93
        Width = 190
        Height = 20
        Style = csDropDownList
        DropDownCount = 30
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ItemHeight = 12
        TabOrder = 1
        OnSelect = AComboBoxSelect
      end
      object edt_Operation: TEdit
        Left = 59
        Top = 28
        Width = 190
        Height = 20
        TabStop = False
        Color = clBtnFace
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ReadOnly = True
        TabOrder = 4
      end
      object cbb_Operator: TComboBox
        Left = 307
        Top = 50
        Width = 126
        Height = 20
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ItemHeight = 12
        TabOrder = 6
        OnChange = OnAccidentDataChange
      end
      object cbb_Machine: TComboBox
        Left = 59
        Top = 50
        Width = 190
        Height = 20
        Style = csDropDownList
        DropDownCount = 16
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ItemHeight = 12
        TabOrder = 7
        OnSelect = AComboBoxSelect
      end
      object cbb_BeforeAfter: TComboBox
        Left = 307
        Top = 72
        Width = 126
        Height = 20
        Style = csDropDownList
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ItemHeight = 12
        TabOrder = 8
        OnChange = OnAccidentDataChange
        Items.Strings = (
          #36827#24067#21457#29616
          #33853#24067#21457#29616)
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 438
      Width = 442
      Height = 27
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        442
        27)
      object btn_SaveAccident: TButton
        Left = 289
        Top = 2
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        Default = True
        TabOrder = 0
        OnClick = btn_SaveAccidentClick
      end
      object btn_Cancel: TButton
        Left = 367
        Top = 2
        Width = 75
        Height = 25
        Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
        Anchors = [akRight, akBottom]
        Cancel = True
        Caption = #21462#28040'(&C)'
        ModalResult = 2
        TabOrder = 1
        OnClick = btn_CancelClick
      end
      object cbb_PreAccidentNO: TComboBox
        Left = 169
        Top = 5
        Width = 110
        Height = 20
        Style = csDropDownList
        Anchors = [akRight, akBottom]
        Enabled = False
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ItemHeight = 12
        TabOrder = 2
        OnSelect = cbb_PreAccidentNOSelect
      end
      object btn_Query: TButton
        Left = 73
        Top = 2
        Width = 92
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #19978#24037#24207#22788#29702#21333'(&Q)'
        Default = True
        Enabled = False
        TabOrder = 3
        OnClick = btn_QueryClick
      end
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 121
      Width = 442
      Height = 317
      Align = alClient
      Caption = #30133#28857#23646#24615
      TabOrder = 2
      object vle_Par: TValueListEditor
        Left = 2
        Top = 14
        Width = 438
        Height = 301
        Align = alClient
        TabOrder = 0
        TitleCaptions.Strings = (
          #23646#24615#21517
          #23646#24615#20540)
        ColWidths = (
          163
          269)
      end
    end
  end
  object TPanel
    Left = 0
    Top = 0
    Width = 305
    Height = 465
    Align = alLeft
    BevelInner = bvLowered
    TabOrder = 0
    object pnl_Only: TPanel
      Left = 2
      Top = 2
      Width = 301
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lbl1: TLabel
        Left = 8
        Top = 8
        Width = 48
        Height = 12
        Caption = #21697#21517'(&G):'
      end
      object cxbe_GFKeyValue: TcxButtonEdit
        Left = 58
        Top = 5
        Width = 175
        Height = 20
        Properties.Buttons = <
          item
            Default = True
            Kind = bkGlyph
          end>
        Properties.OnButtonClick = cxbe_GFKeyValuePropertiesButtonClick
        TabOrder = 0
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        OnKeyDown = cxbe_GFKeyValueKeyUp
      end
      object cbb_GFKeyValue: TComboBox
        Left = 58
        Top = 5
        Width = 175
        Height = 20
        Style = csDropDownList
        ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
        ItemHeight = 12
        TabOrder = 1
        OnSelect = cbb_GFKeyValueSelect
      end
    end
    object pnl_Only2: TPanel
      Left = 2
      Top = 32
      Width = 301
      Height = 3
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
    end
    object grp1: TGroupBox
      Left = 2
      Top = 35
      Width = 301
      Height = 428
      Align = alClient
      Caption = #21345#21495#21015#34920'(&D):'
      TabOrder = 2
      object lv_CardList: TListView
        Left = 2
        Top = 14
        Width = 297
        Height = 412
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            Caption = #21345#21495
            Width = 100
          end
          item
            Caption = #30721#38271
          end
          item
            Caption = #24067#21495
            Width = 100
          end
          item
            Caption = #30721#38271
          end>
        GridLines = True
        HideSelection = False
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        PopupMenu = PopupMenu1
        TabOrder = 0
        ViewStyle = vsReport
        OnClick = lv_CardListClick
        OnCustomDrawItem = lv_CardListCustomDrawItem
        OnEnter = lv_CardListEnter
        OnKeyDown = lv_CardListKeyDown
        OnMouseDown = lv_CardListMouseDown
      end
    end
  end
  object TPanel
    Left = 0
    Top = 465
    Width = 747
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
  end
  object cdsPreAccidents: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 176
    Top = 248
  end
  object cdsTmp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 248
    Top = 256
  end
  object cds_CardList: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 192
  end
  object PopupMenu1: TPopupMenu
    Left = 152
    Top = 144
    object N1: TMenuItem
      Caption = #20840#36873
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #21462#28040#36873#25321
      OnClick = N2Click
    end
  end
end

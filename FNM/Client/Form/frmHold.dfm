object HoldForm: THoldForm
  Left = 385
  Top = 242
  BorderStyle = bsDialog
  Caption = 'HOLD'#32500#25252
  ClientHeight = 236
  ClientWidth = 503
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object pnl_Only: TPanel
    Left = 0
    Top = 202
    Width = 503
    Height = 34
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      503
      34)
    object btn_Previou: TButton
      Left = 208
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #19978#19968#27493'(&P)'
      TabOrder = 0
      OnClick = btn_Previou_NextClick
    end
    object btn_Next: TButton
      Left = 300
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #19979#19968#27493'(&N)'
      TabOrder = 1
      OnClick = btn_Previou_NextClick
    end
    object btn_Exit: TButton
      Left = 414
      Top = 5
      Width = 75
      Height = 25
      Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
      Anchors = [akRight, akBottom]
      Caption = #21462#28040'(&C)'
      ModalResult = 2
      TabOrder = 2
    end
  end
  object pgc_Only: TPageControl
    Left = 0
    Top = 0
    Width = 503
    Height = 202
    ActivePage = ts1
    Align = alClient
    Style = tsFlatButtons
    TabIndex = 2
    TabOrder = 1
    object ts_Only: TTabSheet
      object TStaticText
        Left = 0
        Top = 0
        Width = 495
        Height = 16
        Align = alTop
        Caption = #35831#36873#25321'HOLD'#32500#25252#31867#22411'.'
        TabOrder = 0
      end
      object rb_UnHold: TRadioButton
        Left = 145
        Top = 55
        Width = 174
        Height = 17
        Caption = #35299#38500'HOLD'
        Checked = True
        TabOrder = 1
        TabStop = True
      end
      object rb_NewHold: TRadioButton
        Left = 145
        Top = 91
        Width = 174
        Height = 17
        Caption = #26032#24314'HOLD'
        TabOrder = 2
      end
    end
    object TTabSheet
      ImageIndex = 1
      object TStaticText
        Left = 221
        Top = 56
        Width = 34
        Height = 16
        Caption = #24037#24207':'
        TabOrder = 6
      end
      object TStaticText
        Left = 0
        Top = 0
        Width = 495
        Height = 16
        Align = alTop
        Caption = #35831#36755#20837#21697#21517','#24182#36873#25321'HOLD'#31867#22411#31561#30456#20851#20449#24687'.'
        TabOrder = 0
      end
      object rb_HoldClass1: TRadioButton
        Left = 305
        Top = 103
        Width = 120
        Height = 17
        Caption = #21697#21517'--'#24037#24207'HOLD'
        Checked = True
        TabOrder = 1
        TabStop = True
        OnClick = rb_HoldClassClick
      end
      object rb_HoldClass2: TRadioButton
        Left = 73
        Top = 103
        Width = 120
        Height = 17
        Caption = #21345#21495'HOLD'
        TabOrder = 2
        OnClick = rb_HoldClassClick
      end
      object TStaticText
        Left = 38
        Top = 58
        Width = 34
        Height = 16
        Caption = #21697#21517':'
        TabOrder = 3
      end
      object edt_GFKeyValue: TEdit
        Left = 73
        Top = 51
        Width = 121
        Height = 20
        TabOrder = 4
        OnChange = edt_GFKeyValueChange
      end
      object cbb_Operation: TComboBox
        Left = 253
        Top = 52
        Width = 145
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 5
        OnDropDown = cbb_OperationDropDown
      end
      object chk_EffectRepair: TCheckBox
        Left = 333
        Top = 133
        Width = 129
        Height = 17
        Caption = #23545#22238#20462#24067#26377#25928
        TabOrder = 7
      end
    end
    object ts1: TTabSheet
      ImageIndex = -1
      object lv_CardList: TListView
        Left = 0
        Top = 16
        Width = 495
        Height = 156
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            Caption = #21345#21495
            Width = 90
          end
          item
            Caption = #21697#21517'ID'
          end
          item
            Caption = #21697#21517
            Width = 100
          end
          item
            Caption = #25490#21333
            Width = 70
          end
          item
            Caption = #24037#24207#20195#21495
            Width = 60
          end
          item
            Caption = #24037#24207
          end
          item
            Caption = #30721#38271
          end>
        GridLines = True
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        TabOrder = 2
        ViewStyle = vsReport
      end
      object lv_HoldList: TListView
        Left = 0
        Top = 16
        Width = 495
        Height = 156
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            Caption = #21697#21517'ID'
            Width = 65
          end
          item
            Caption = #21697#21517
            Width = 100
          end
          item
            Caption = #21345#21495
            Width = 80
          end
          item
            Caption = #24037#24207#20195#21495
            Width = 0
          end
          item
            Caption = #24037#24207
          end
          item
            Caption = 'HOLD'#21407#22240
            Width = 110
          end
          item
            Caption = #23545#22238#20462#24067#26159#21542#26377#25928
            Width = 60
          end
          item
            Caption = #25805#20316#20154
          end
          item
            Caption = #26102#38388
          end>
        GridLines = True
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
        OnColumnClick = lv_HoldListColumnClick
      end
      object txt_HoldListTitle: TStaticText
        Left = 0
        Top = 0
        Width = 495
        Height = 16
        Align = alTop
        Caption = #24050'HOLD;'#21487'HOLD'#21345#21495'.'
        TabOrder = 0
      end
    end
    object TTabSheet
      ImageIndex = 3
      object lblHoldReason: TLabel
        Left = 38
        Top = 41
        Width = 30
        Height = 12
        Caption = #21407#22240':'
      end
      object txt_Reason: TStaticText
        Left = 0
        Top = 0
        Width = 148
        Height = 16
        Align = alTop
        Caption = #35831#36755#20837'HOLD/'#35299#38500'HOLD'#21407#22240'.'
        TabOrder = 0
      end
      object mmo_Reason: TMemo
        Left = 72
        Top = 40
        Width = 409
        Height = 126
        TabOrder = 1
      end
    end
    object TTabSheet
      ImageIndex = 4
      object TStaticText
        Left = 0
        Top = 0
        Width = 262
        Height = 16
        Align = alTop
        Caption = #20851#38190#20449#24687#24050#32463#20934#22791#23436#27605#65292#21333#20987#23436#25104#23436#25104#20445#23384#25968#25454'.'
        TabOrder = 0
      end
      object txt_Only: TStaticText
        Left = 10
        Top = 41
        Width = 58
        Height = 16
        Caption = #30456#20851#20449#24687':'
        TabOrder = 1
      end
      object mmo_Result: TMemo
        Left = 72
        Top = 40
        Width = 409
        Height = 126
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 2
      end
    end
  end
  object edtFilter: TEdit
    Left = 88
    Top = 208
    Width = 105
    Height = 20
    CharCase = ecUpperCase
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Visible = False
    OnKeyDown = edtFilterKeyDown
  end
  object cdsHold: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 86
    Top = 203
  end
end

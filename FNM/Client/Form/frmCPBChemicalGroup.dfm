inherited CPBChemicalGroupForm: TCPBChemicalGroupForm
  Left = 205
  Top = 126
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'CPB'#21270#26009#32452#21512#32500#25252
  ClientHeight = 428
  ClientWidth = 735
  FormStyle = fsNormal
  OldCreateOrder = True
  Visible = False
  PixelsPerInch = 96
  TextHeight = 12
  object pnl_Only: TPanel
    Left = 0
    Top = 394
    Width = 735
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btn_Query: TSpeedButton
      Left = 5
      Top = 5
      Width = 75
      Height = 25
      Caption = #21047#26032'(&R)'
      Flat = True
      OnClick = btn_QueryClick
    end
    object btn_Save: TSpeedButton
      Left = 260
      Top = 5
      Width = 75
      Height = 25
      Caption = #20445#23384'(&S)'
      Flat = True
      OnClick = btn_SaveClick
    end
    object btn_Exit: TSpeedButton
      Left = 430
      Top = 5
      Width = 75
      Height = 25
      Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
      Caption = #36864#20986'(&X)'
      Flat = True
      OnClick = btn_ExitClick
    end
    object btn_Delete: TSpeedButton
      Left = 175
      Top = 5
      Width = 75
      Height = 25
      Hint = #21024#38500#32452#21512
      Caption = #21024#38500'(&D)'
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = btn_DeleteClick
    end
    object btnNew: TSpeedButton
      Left = 90
      Top = 5
      Width = 75
      Height = 25
      Hint = #26032#24314#32452#21512
      Caption = #26032#24314'(&N)'
      Flat = True
      OnClick = btnNewClick
    end
    object btnSaveAS: TSpeedButton
      Left = 345
      Top = 5
      Width = 75
      Height = 25
      Hint = #21478#23384#20026#26032#32452#21512
      Caption = #21478#23384'(&O)'
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSaveASClick
    end
  end
  object pnl2: TPanel
    Left = 0
    Top = 0
    Width = 735
    Height = 394
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object grpLeft1: TGroupBox
      Left = 105
      Top = 0
      Width = 327
      Height = 394
      Align = alClient
      Caption = #26579#26009#32452#21512#26126#32454
      TabOrder = 0
      object vleChemicallist: TValueListEditor
        Left = 33
        Top = 14
        Width = 292
        Height = 378
        Align = alClient
        Ctl3D = False
        DefaultRowHeight = 17
        ParentCtl3D = False
        TabOrder = 0
        TitleCaptions.Strings = (
          #21270#24037#26009#21517
          #29992#37327'(g/l)')
        OnKeyPress = vleChemicallistKeyPress
        OnStringsChange = vleChemicallistStringsChange
        OnValidate = vleChemicallistValidate
        ColWidths = (
          218
          70)
      end
      object pnlGroupEdit: TPanel
        Left = 2
        Top = 14
        Width = 31
        Height = 378
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object btnDown: TSpeedButton
          Left = 4
          Top = 104
          Width = 23
          Height = 23
          Hint = #21521#19979
          Flat = True
          OnClick = btnDownClick
        end
        object btnUp: TSpeedButton
          Left = 4
          Top = 54
          Width = 23
          Height = 23
          Hint = #21521#19978
          Flat = True
          OnClick = btnUpClick
          OnDblClick = btnUpDblClick
        end
      end
    end
    object grpGroup: TGroupBox
      Left = 0
      Top = 0
      Width = 105
      Height = 394
      Align = alLeft
      Caption = #26579#26009#32452#21512
      TabOrder = 1
      object cbbGroup: TComboBox
        Left = 0
        Top = 16
        Width = 105
        Height = 377
        AutoDropDown = True
        Style = csSimple
        CharCase = ecUpperCase
        ItemHeight = 12
        Sorted = True
        TabOrder = 0
        OnClick = cbbGroupClick
        OnDblClick = cbbGroupDblClick
        OnKeyDown = cbbGroupKeyDown
      end
    end
    object pnlChemical: TPanel
      Left = 432
      Top = 0
      Width = 303
      Height = 394
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 2
      object grp1: TGroupBox
        Left = 30
        Top = 0
        Width = 273
        Height = 394
        Align = alLeft
        Caption = #21487#36873#21270#24037#26009'(&C)'
        TabOrder = 0
        object pgc1: TPageControl
          Left = 2
          Top = 14
          Width = 269
          Height = 378
          ActivePage = ts1
          Align = alClient
          Style = tsFlatButtons
          TabIndex = 0
          TabOrder = 0
          object ts1: TTabSheet
            Caption = #26641
            object tvChemical: TTreeView
              Left = 0
              Top = 0
              Width = 261
              Height = 348
              Align = alClient
              HideSelection = False
              Indent = 19
              ReadOnly = True
              TabOrder = 0
              OnDblClick = btnAddClick
              OnKeyDown = tvChemicalKeyDown
            end
          end
          object ts2: TTabSheet
            Caption = #21015#34920
            ImageIndex = 1
            DesignSize = (
              261
              348)
            object cbbChemicalName: TComboBox
              Left = 4
              Top = 0
              Width = 397
              Height = 486
              Style = csSimple
              Anchors = [akLeft, akTop, akRight, akBottom]
              ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
              ItemHeight = 12
              TabOrder = 0
              OnDblClick = cbbChemicalNameDblClick
            end
          end
        end
      end
      object TPanel
        Left = 0
        Top = 0
        Width = 30
        Height = 394
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object btnAdd: TSpeedButton
          Left = 4
          Top = 72
          Width = 23
          Height = 23
          Hint = #36873#20013
          Flat = True
          OnClick = btnAddClick
        end
        object btnDel: TSpeedButton
          Left = 4
          Top = 112
          Width = 23
          Height = 23
          Hint = #21024#38500
          Flat = True
          OnClick = btnDelClick
        end
      end
    end
  end
  object cdsCPB: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 496
    Top = 288
  end
  object cdsGroup: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 32
    Top = 288
  end
end

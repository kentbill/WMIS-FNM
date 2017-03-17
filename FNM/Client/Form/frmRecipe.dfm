inherited RecipeForm: TRecipeForm
  Left = 160
  Top = 114
  Width = 800
  Height = 514
  Caption = #24320#21270#26009#21333
  OldCreateOrder = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 12
  object pgcRecipe: TPageControl
    Left = 0
    Top = 0
    Width = 225
    Height = 459
    ActivePage = ts_Only
    Align = alLeft
    Style = tsFlatButtons
    TabIndex = 0
    TabOrder = 0
    OnChange = pgcRecipeChange
    object ts_Only: TTabSheet
      Caption = #21046#23450#21270#26009#21333
      DesignSize = (
        217
        429)
      object Splitter1: TSplitter
        Left = 0
        Top = 213
        Width = 217
        Height = 2
        Cursor = crVSplit
        Align = alBottom
      end
      object TPanel
        Left = 0
        Top = 0
        Width = 217
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          217
          28)
        object Label1: TLabel
          Left = 8
          Top = 8
          Width = 30
          Height = 12
          Caption = #21697#21517':'
        end
        object cxbeGFKey: TcxButtonEdit
          Left = 38
          Top = 4
          Width = 178
          Height = 20
          Anchors = [akLeft, akTop, akRight]
          Properties.Buttons = <
            item
              Default = True
              Kind = bkGlyph
            end>
          Properties.OnButtonClick = cxbeGFKeyPropertiesButtonClick
          TabOrder = 0
        end
      end
      object TPanel
        Left = 0
        Top = 28
        Width = 217
        Height = 3
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
      end
      object cbbOnlineOperation: TComboBox
        Left = 8
        Top = 32
        Width = 208
        Height = 177
        Style = csSimple
        Anchors = [akLeft, akTop, akRight, akBottom]
        BiDiMode = bdLeftToRight
        ItemHeight = 12
        ParentBiDiMode = False
        TabOrder = 2
        OnKeyDown = cbbOnlineOperationKeyDown
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 215
        Width = 217
        Height = 214
        Align = alBottom
        Caption = #24453#23457#26680#21270#26009#21333
        TabOrder = 3
        object lstUncheck: TListBox
          Left = 2
          Top = 14
          Width = 213
          Height = 198
          Align = alClient
          ItemHeight = 12
          TabOrder = 0
          OnKeyDown = lstUncheckKeyDown
        end
      end
    end
    object TTabSheet
      Caption = #24050#24320#26009#26009#21333
      ImageIndex = 1
      object TPanel
        Left = 0
        Top = 0
        Width = 217
        Height = 3
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
      end
      object tvOnline: TTreeView
        Left = 0
        Top = 3
        Width = 217
        Height = 426
        Align = alClient
        Indent = 19
        PopupMenu = PopupMenu1
        ReadOnly = True
        TabOrder = 1
        OnKeyDown = tvOnlineKeyDown
      end
    end
  end
  object TPanel
    Left = 0
    Top = 459
    Width = 792
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      792
      28)
    object btnCheck: TSpeedButton
      Left = 458
      Top = 2
      Width = 75
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = #30830#35748'(&V)'
      Flat = True
      OnClick = btnCheckClick
    end
    object btnSave: TSpeedButton
      Left = 625
      Top = 2
      Width = 75
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = #20445#23384'(&S)'
      Flat = True
      OnClick = btnSaveClick
    end
    object btnClose: TSpeedButton
      Left = 708
      Top = 2
      Width = 75
      Height = 22
      Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
      Anchors = [akRight, akBottom]
      Caption = #36864#20986'(&X)'
      Flat = True
      OnClick = btnCloseClick
    end
    object btnDeletet: TSpeedButton
      Left = 541
      Top = 2
      Width = 75
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = #21024#38500'(&D)'
      Flat = True
      OnClick = btnDeletetClick
    end
    object btnRefresh: TSpeedButton
      Left = 377
      Top = 0
      Width = 75
      Height = 24
      Hint = #21047#26032'|'#21047#26032#21270#26009#21333#21015#34920
      Anchors = [akRight, akBottom]
      Caption = #21047#26032'(F5)'
      Flat = True
      OnClick = btnRefreshClick
    end
  end
  object cxspl_Only: TcxSplitter
    Left = 225
    Top = 0
    Width = 8
    Height = 459
    HotZoneClassName = 'TcxXPTaskBarStyle'
    Control = pgcRecipe
  end
  object pnl_Only: TPanel
    Left = 233
    Top = 0
    Width = 559
    Height = 459
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object TPanel
      Left = 0
      Top = 0
      Width = 559
      Height = 97
      Align = alTop
      BevelInner = bvLowered
      TabOrder = 0
      object Label2: TLabel
        Left = 16
        Top = 37
        Width = 54
        Height = 12
        Caption = #28322#27969#31867#22411':'
      end
      object Label3: TLabel
        Left = 16
        Top = 57
        Width = 42
        Height = 12
        Caption = #28322#27969#37327':'
      end
      object Label4: TLabel
        Left = 200
        Top = 37
        Width = 54
        Height = 12
        Caption = #35797'2Y'#32467#26524':'
      end
      object Label5: TLabel
        Left = 200
        Top = 57
        Width = 30
        Height = 12
        Caption = #26426#21488':'
      end
      object Label6: TLabel
        Left = 16
        Top = 16
        Width = 30
        Height = 12
        Caption = #21333#21495':'
      end
      object Label7: TLabel
        Left = 200
        Top = 16
        Width = 30
        Height = 12
        Caption = #24037#24207':'
      end
      object Label8: TLabel
        Left = 384
        Top = 16
        Width = 42
        Height = 12
        Caption = #35774#35745#20154':'
      end
      object Label9: TLabel
        Left = 384
        Top = 37
        Width = 54
        Height = 12
        Caption = #35774#35745#26102#38388':'
      end
      object Label10: TLabel
        Left = 384
        Top = 57
        Width = 42
        Height = 12
        Caption = #30830#35748#20154':'
      end
      object Label12: TLabel
        Left = 384
        Top = 78
        Width = 54
        Height = 12
        Caption = #30830#35748#26102#38388':'
      end
      object Label13: TLabel
        Left = 200
        Top = 78
        Width = 54
        Height = 12
        Caption = #24403#21069#20307#31215':'
      end
      object cbbFloodPercent: TComboBox
        Left = 68
        Top = 49
        Width = 121
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        ItemIndex = 0
        TabOrder = 0
        Text = #23567
        OnChange = ChangeValues
        Items.Strings = (
          #23567
          #20013
          #22823)
      end
      object cbbFloodClass: TComboBox
        Left = 68
        Top = 29
        Width = 121
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        ItemIndex = 0
        TabOrder = 1
        Text = #24490#29615#28322#27969
        OnChange = ChangeValues
        Items.Strings = (
          #24490#29615#28322#27969
          #22806#28322#27969)
      end
      object cbbMachineID: TComboBox
        Left = 256
        Top = 49
        Width = 121
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 2
        OnChange = ChangeValues
      end
      object cbbSampleType: TComboBox
        Left = 256
        Top = 29
        Width = 121
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 3
        OnChange = ChangeValues
        Items.Strings = (
          '0->'#30452#25509'OK'#9#12288
          '1->'#21152#26009#37325#35797#9
          '2->'#21152#26009'OK'#9#12288#9#12288
          '3->'#20914#31232#37325#35797
          '4->'#20914#31232'OK')
      end
      object cbTrace: TCheckBox
        Left = 68
        Top = 73
        Width = 97
        Height = 17
        Caption = #26159#21542#36319#36394
        TabOrder = 4
        OnClick = cbTraceClick
      end
      object edtRecipeNO: TEdit
        Left = 68
        Top = 8
        Width = 121
        Height = 20
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 5
      end
      object edtOperationName: TEdit
        Left = 256
        Top = 8
        Width = 121
        Height = 20
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 6
      end
      object edtOperator: TEdit
        Left = 440
        Top = 8
        Width = 121
        Height = 20
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 7
      end
      object edtOperateTime: TEdit
        Left = 440
        Top = 29
        Width = 121
        Height = 20
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 8
      end
      object edtChecker: TEdit
        Left = 440
        Top = 49
        Width = 121
        Height = 20
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 9
      end
      object edtCheckTime: TEdit
        Left = 440
        Top = 70
        Width = 121
        Height = 20
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 10
      end
      object edtCurVolume: TEdit
        Left = 256
        Top = 70
        Width = 121
        Height = 20
        Color = clBtnFace
        TabOrder = 11
      end
    end
    object pnlClient: TPanel
      Left = 232
      Top = 97
      Width = 327
      Height = 362
      Align = alRight
      BevelOuter = bvNone
      Caption = 'pnlClient'
      TabOrder = 1
      object grp1: TGroupBox
        Left = 0
        Top = 0
        Width = 327
        Height = 180
        Align = alClient
        TabOrder = 0
        object lvIncludeCard: TListView
          Left = 2
          Top = 14
          Width = 323
          Height = 164
          Align = alClient
          Checkboxes = True
          Columns = <
            item
              Caption = #21345#21495
              Width = 85
            end
            item
              Caption = #21697#21517
              Width = 140
            end
            item
              Caption = #30721#38271
              Width = 60
            end>
          GridLines = True
          HideSelection = False
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
        end
        object chkAll: TCheckBox
          Left = 10
          Top = 0
          Width = 78
          Height = 14
          Caption = #20840#36873'/'#21462#28040
          TabOrder = 1
          OnClick = chkAllClick
        end
      end
      object grp_Only: TGroupBox
        Left = 0
        Top = 188
        Width = 327
        Height = 174
        Align = alBottom
        Caption = #22791#27880
        TabOrder = 1
        object mmoRemark: TMemo
          Left = 2
          Top = 14
          Width = 323
          Height = 158
          Align = alClient
          ImeMode = imHanguel
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
      object cxSplitter1: TcxSplitter
        Left = 0
        Top = 180
        Width = 327
        Height = 8
        HotZoneClassName = 'TcxXPTaskBarStyle'
        AlignSplitter = salBottom
        Control = grp_Only
      end
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 97
      Width = 232
      Height = 362
      Align = alClient
      Caption = #21270#24037#26009'(&C):'
      TabOrder = 2
      object tvChemical: TTreeView
        Left = 2
        Top = 14
        Width = 228
        Height = 151
        Align = alClient
        Indent = 19
        TabOrder = 0
        OnKeyDown = tvChemicalKeyDown
      end
      object TPanel
        Left = 2
        Top = 165
        Width = 228
        Height = 29
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object btnAdd: TSpeedButton
          Left = 60
          Top = 5
          Width = 23
          Height = 22
          Flat = True
          OnClick = btnAddClick
        end
        object btnDel: TSpeedButton
          Left = 135
          Top = 5
          Width = 23
          Height = 22
          Flat = True
          OnClick = btnDelClick
        end
      end
      object vleChemicallist: TValueListEditor
        Left = 2
        Top = 194
        Width = 228
        Height = 166
        Align = alBottom
        TabOrder = 2
        TitleCaptions.Strings = (
          #21270#24037#26009#21517
          #29992#37327'(g/l)')
        ColWidths = (
          150
          72)
      end
    end
  end
  object cdsCards: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 152
    Top = 368
  end
  object PopupMenu1: TPopupMenu
    Left = 144
    Top = 88
    object NDiluteTry: TMenuItem
      Caption = #21152#26009#20914#31232
      OnClick = NDiluteTryClick
    end
    object NAddTry: TMenuItem
      Caption = #21152#26009#37325#35797
      OnClick = NAddTryClick
    end
  end
end

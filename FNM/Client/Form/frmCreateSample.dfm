object CreateSampleForm: TCreateSampleForm
  Left = 203
  Top = 159
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #21462#26679#39033#30446#36873#25321
  ClientHeight = 367
  ClientWidth = 633
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object TBevel
    Left = 276
    Top = -8
    Width = 9
    Height = 337
    Shape = bsLeftLine
  end
  object TPanel
    Left = 8
    Top = 23
    Width = 257
    Height = 298
    BevelInner = bvLowered
    TabOrder = 0
    object TStaticText
      Left = 2
      Top = 2
      Width = 253
      Height = 16
      Align = alTop
      BevelKind = bkSoft
      Caption = #26631#20934#21462#26679#20195#21495
      TabOrder = 0
    end
    object tv_StdSampleNO: TTreeView
      Left = 2
      Top = 18
      Width = 253
      Height = 278
      Align = alClient
      Indent = 19
      TabOrder = 1
      OnEnter = tv_StdSampleNOEnter
    end
  end
  object rb_UseStdSampleNO: TRadioButton
    Left = 8
    Top = 3
    Width = 113
    Height = 17
    Caption = #26631#20934#21462#26679
    TabOrder = 1
    OnClick = rb_UseStdSampleNOClick
  end
  object rb_UserDefindSample: TRadioButton
    Left = 289
    Top = 3
    Width = 113
    Height = 17
    Caption = #33258#23450#20041#21462#26679
    TabOrder = 2
  end
  object TPanel
    Left = 289
    Top = 23
    Width = 336
    Height = 298
    BevelInner = bvLowered
    TabOrder = 3
    object txt_Only: TStaticText
      Left = 2
      Top = 2
      Width = 332
      Height = 16
      Align = alTop
      BevelKind = bkSoft
      Caption = #27979#35797#39033#30446'('#31561#29289#27979#30340#25968#25454#34920')'
      TabOrder = 0
    end
    object lv_TestItems: TListView
      Left = 2
      Top = 18
      Width = 332
      Height = 278
      Align = alClient
      Checkboxes = True
      Columns = <
        item
          Caption = #27979#35797#39033#30446
          Width = 209
        end
        item
          Caption = #20013#25991#21517
          Width = 90
        end>
      ColumnClick = False
      GridLines = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 1
      ViewStyle = vsReport
      OnEnter = tv_StdSampleNOEnter
    end
  end
  object pnl_Only: TPanel
    Left = 0
    Top = 326
    Width = 633
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    DesignSize = (
      633
      41)
    object bvl_Only: TBevel
      Left = 0
      Top = 0
      Width = 633
      Height = 2
      Align = alTop
      Shape = bsBottomLine
    end
    object btn_Help: TButton
      Left = 8
      Top = 11
      Width = 75
      Height = 25
      Caption = #24110#21161'(&H)'
      TabOrder = 0
    end
    object btn_Cancel: TButton
      Left = 465
      Top = 11
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #21462#28040'(&C)'
      ModalResult = 2
      TabOrder = 1
    end
    object btn_OK: TButton
      Left = 553
      Top = 11
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #30830#23450'(&O)'
      Default = True
      ModalResult = 1
      TabOrder = 2
    end
  end
end

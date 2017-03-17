object SupplyRecipeForm: TSupplyRecipeForm
  Left = 137
  Top = 140
  BorderStyle = bsDialog
  Caption = #34917#20805#21270#26009#21333
  ClientHeight = 308
  ClientWidth = 471
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
  DesignSize = (
    471
    308)
  PixelsPerInch = 96
  TextHeight = 12
  object btn_Query: TSpeedButton
    Left = 292
    Top = 63
    Width = 127
    Height = 25
    Caption = #26597#35810#21345#21495'(&Q)'
    Flat = True
    OnClick = btn_QueryClick
  end
  object TStaticText
    Left = 15
    Top = 94
    Width = 58
    Height = 16
    Caption = #21345#21495'(&C):'
    FocusControl = lv_OnlineCard
    TabOrder = 7
  end
  object TStaticText
    Left = 15
    Top = 40
    Width = 58
    Height = 16
    Caption = #37197#26041'(&P):'
    TabOrder = 5
  end
  object txt_Only: TStaticText
    Left = 15
    Top = 10
    Width = 58
    Height = 16
    Caption = #24037#24207'(&O):'
    TabOrder = 2
  end
  object cbb_Operation: TComboBox
    Left = 67
    Top = 6
    Width = 123
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    TabOrder = 0
    OnChange = cbb_OperationChange
  end
  object cbb_StdPrescription: TComboBox
    Left = 67
    Top = 36
    Width = 123
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    TabOrder = 4
    OnChange = cbb_ChangeAComboBox
    OnEnter = cbb_EnterAControl
  end
  object TStaticText
    Left = 15
    Top = 69
    Width = 58
    Height = 16
    Caption = #26426#21488'(&M):'
    TabOrder = 3
  end
  object cbb_MachineID: TComboBox
    Left = 67
    Top = 65
    Width = 123
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    TabOrder = 1
    OnChange = cbb_ChangeAComboBox
    OnEnter = cbb_EnterAControl
  end
  object lv_OnlineCard: TListView
    Left = 67
    Top = 94
    Width = 397
    Height = 176
    Checkboxes = True
    Columns = <
      item
        Caption = #21345#21495
        Width = 100
      end
      item
        Alignment = taCenter
        Caption = #30721#38271
        Width = 60
      end
      item
        Alignment = taCenter
        Caption = #24320#22987#26102#38388
        Width = 150
      end>
    GridLines = True
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 6
    ViewStyle = vsReport
  end
  object btn_OK: TButton
    Left = 391
    Top = 279
    Width = 75
    Height = 25
    Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
    Anchors = [akRight, akBottom]
    Caption = #30830#23450'(&O)'
    ModalResult = 1
    TabOrder = 9
  end
  object btn_Help: TButton
    Left = 5
    Top = 279
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #24110#21161'(&H)'
    Enabled = False
    TabOrder = 8
  end
  object btn1: TButton
    Left = 307
    Top = 279
    Width = 75
    Height = 25
    Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
    Anchors = [akRight, akBottom]
    Caption = #21462#28040'(&C)'
    ModalResult = 2
    TabOrder = 10
  end
  object TStaticText
    Left = 220
    Top = 10
    Width = 82
    Height = 16
    Caption = #24320#22987#26102#38388'(&B):'
    TabOrder = 11
  end
  object TStaticText
    Left = 220
    Top = 40
    Width = 82
    Height = 16
    Caption = #32467#26463#26102#38388'(&E):'
    TabOrder = 12
  end
  object edt_BeginTime: TEdit
    Left = 292
    Top = 6
    Width = 125
    Height = 20
    TabOrder = 13
  end
  object edt_EndTime: TEdit
    Left = 292
    Top = 36
    Width = 125
    Height = 20
    TabOrder = 14
  end
end

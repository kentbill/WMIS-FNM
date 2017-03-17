object MutexChemicalkForm: TMutexChemicalkForm
  Left = 189
  Top = 42
  BorderStyle = bsDialog
  BorderWidth = 5
  Caption = #20114#26021#21270#24037#26009#32500#25252
  ClientHeight = 427
  ClientWidth = 267
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    267
    427)
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 0
    Top = 351
    Width = 48
    Height = 12
    Caption = #21270#24037#26009'1:'
  end
  object Label2: TLabel
    Left = 0
    Top = 383
    Width = 48
    Height = 12
    Caption = #21270#24037#26009'2:'
  end
  object btnRefresh: TButton
    Left = 16
    Top = 402
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #21047#26032'(&R)'
    TabOrder = 0
    OnClick = btnRefreshClick
  end
  object btnSave: TButton
    Left = 103
    Top = 402
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #20445#23384'(&S)'
    Default = True
    TabOrder = 1
    OnClick = btnSaveClick
  end
  object btnClose: TButton
    Left = 190
    Top = 402
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #36864#20986'(&X)'
    TabOrder = 2
    OnClick = btnCloseClick
  end
  object lvMutex: TListView
    Left = 0
    Top = 0
    Width = 267
    Height = 335
    Align = alTop
    Columns = <
      item
        Width = 0
      end
      item
        Caption = #21270#24037#26009
        Width = 130
      end
      item
        Width = 0
      end
      item
        Caption = #20114#26021#21270#24037#26009
        Width = 130
      end>
    GridLines = True
    RowSelect = True
    TabOrder = 3
    ViewStyle = vsReport
  end
  object cbCHemical: TComboBox
    Left = 44
    Top = 343
    Width = 145
    Height = 20
    ItemHeight = 12
    TabOrder = 4
  end
  object cbMutex: TComboBox
    Left = 44
    Top = 375
    Width = 145
    Height = 20
    ItemHeight = 12
    TabOrder = 5
  end
  object btnDelete: TButton
    Left = 189
    Top = 371
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #21024#38500'(&D))'
    TabOrder = 6
    OnClick = btnDeleteClick
  end
  object btnAdd: TButton
    Left = 190
    Top = 343
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #26032#22686'(&A))'
    TabOrder = 7
    OnClick = btnAddClick
  end
end

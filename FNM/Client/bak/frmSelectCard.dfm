object SelectCardForFactPrescripForm: TSelectCardForFactPrescripForm
  Left = 319
  Top = 331
  BorderStyle = bsDialog
  Caption = #35831#36873#25321#21345#21495
  ClientHeight = 218
  ClientWidth = 465
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 12
  object lv_IncludeCard: TListView
    Left = 0
    Top = 0
    Width = 465
    Height = 184
    Align = alClient
    Checkboxes = True
    Columns = <
      item
        Caption = #21345#21495
        Width = 90
      end
      item
        Caption = #21697#21517
        Width = 110
      end
      item
        Caption = #30721#38271
        Width = 40
      end
      item
        Caption = #24037#24207
        Width = 40
      end
      item
        Caption = #24037#24207#21517
        Width = 90
      end>
    GridLines = True
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object pnl_Only: TPanel
    Left = 0
    Top = 184
    Width = 465
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      465
      34)
    object btn_Help: TButton
      Left = 8
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #24110#21161'(&H)'
      Enabled = False
      TabOrder = 0
    end
    object btn_Next: TButton
      Left = 288
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #30830#23450'(&O)'
      Default = True
      ModalResult = 1
      TabOrder = 1
    end
    object btn_Exit: TButton
      Left = 376
      Top = 5
      Width = 75
      Height = 25
      Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #21462#28040'(&C)'
      ModalResult = 2
      TabOrder = 2
    end
  end
end

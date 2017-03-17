object LocateCarForm: TLocateCarForm
  Left = 298
  Top = 156
  BorderStyle = bsDialog
  Caption = #36710#21495#23450#20301
  ClientHeight = 394
  ClientWidth = 571
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 571
    Height = 393
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object grp1: TGroupBox
      Left = 328
      Top = 0
      Width = 233
      Height = 393
      Align = alLeft
      Caption = #24453#25918#32622#36710#21495#21015#34920
      TabOrder = 0
      object cbbCarNO: TComboBox
        Left = 8
        Top = 16
        Width = 217
        Height = 377
        BevelInner = bvNone
        BevelOuter = bvNone
        Style = csSimple
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 16
        ParentFont = False
        TabOrder = 0
        OnEnter = cbbCarNOEnter
      end
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 233
      Height = 393
      Align = alLeft
      Caption = #31354#36710#20301#21015#34920
      TabOrder = 1
      object cbbLocation: TComboBox
        Left = 8
        Top = 16
        Width = 217
        Height = 377
        BevelInner = bvNone
        BevelOuter = bvNone
        Style = csSimple
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 16
        ParentFont = False
        Sorted = True
        TabOrder = 0
      end
    end
    object pnl2: TPanel
      Left = 233
      Top = 0
      Width = 95
      Height = 393
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 2
      object btnSave: TSpeedButton
        Left = 6
        Top = 157
        Width = 81
        Height = 28
        Caption = #23450#20301'(&S)'
        OnClick = btnSaveClick
      end
      object btnRefresh: TSpeedButton
        Left = 6
        Top = 13
        Width = 81
        Height = 28
        Caption = #21047#26032'(&R)'
        Flat = True
        OnClick = btnRefreshClick
      end
      object SpeedButton2: TSpeedButton
        Left = 6
        Top = 317
        Width = 81
        Height = 28
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = SpeedButton2Click
      end
    end
  end
  object cdsLocateCar: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 256
    Top = 232
  end
end

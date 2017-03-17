object SelectWorkerForm: TSelectWorkerForm
  Left = 542
  Top = 191
  BorderStyle = bsSingle
  Caption = #36873#25321#25286#21367#22788#29702#20154
  ClientHeight = 417
  ClientWidth = 495
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object TPanel
    Left = 0
    Top = 0
    Width = 495
    Height = 384
    Align = alClient
    TabOrder = 0
    object lbl1: TLabel
      Left = 38
      Top = 24
      Width = 84
      Height = 13
      Caption = #25286#21367#24037#20154#21015#34920#65306
    end
    object lbl2: TLabel
      Left = 296
      Top = 64
      Width = 84
      Height = 13
      Caption = #26412#24067#21495#22788#29702#20154#65306
    end
    object btn1: TSpeedButton
      Left = 129
      Top = 44
      Width = 41
      Height = 25
      Caption = #25628#32034
      OnClick = btn1Click
    end
    object btn2: TSpeedButton
      Left = 174
      Top = 45
      Width = 57
      Height = 25
      Caption = #26174#31034#25152#26377
      OnClick = btn2Click
    end
    object TLabel
      Left = 200
      Top = 304
      Width = 72
      Height = 13
      Caption = #26412#27425#22788#29702#20154#65306
    end
    object lstWorker: TListBox
      Left = 45
      Top = 77
      Width = 129
      Height = 276
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ItemHeight = 13
      TabOrder = 0
    end
    object btnRight: TBitBtn
      Left = 188
      Top = 151
      Width = 75
      Height = 25
      TabOrder = 1
      OnClick = btnRightClick
      Glyph.Data = {
        DE000000424DDE0000000000000076000000280000000D0000000D0000000100
        0400000000006800000000000000000000001000000000000000000000000000
        BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7000777777077777700077777700777770007777770607777000770000066077
        7000770666666607700077066666666070007706666666077000770000066077
        7000777777060777700077777700777770007777770777777000777777777777
        7000}
    end
    object btnClear: TButton
      Left = 187
      Top = 192
      Width = 75
      Height = 24
      Caption = #28165#31354'(&C)'
      TabOrder = 2
      OnClick = btnClearClick
    end
    object edtFilter: TEdit
      Left = 46
      Top = 48
      Width = 81
      Height = 21
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 3
    end
    object lstWorkers: TListBox
      Left = 296
      Top = 88
      Width = 113
      Height = 193
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ItemHeight = 13
      TabOrder = 4
    end
    object edtWorkers: TEdit
      Left = 200
      Top = 328
      Width = 289
      Height = 21
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ReadOnly = True
      TabOrder = 5
    end
  end
  object pnl1: TPanel
    Left = 0
    Top = 384
    Width = 495
    Height = 33
    Align = alBottom
    TabOrder = 1
    object btnSave: TSpeedButton
      Left = 388
      Top = 4
      Width = 49
      Height = 25
      Caption = #30830#23450
      OnClick = btnSaveClick
    end
  end
  object cdsWorker: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 72
    Top = 160
  end
end

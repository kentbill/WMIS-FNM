object WorkerStationForm: TWorkerStationForm
  Left = 236
  Top = 151
  BorderStyle = bsDialog
  BorderWidth = 4
  Caption = #23433#25490#26426#21488#20154#21592
  ClientHeight = 388
  ClientWidth = 566
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  Position = poMainFormCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object btnRefresh: TButton
    Left = 334
    Top = 356
    Width = 75
    Height = 25
    Caption = #21047#26032'(&R)'
    TabOrder = 1
    OnClick = btnRefreshClick
  end
  object btnSave: TButton
    Left = 413
    Top = 355
    Width = 75
    Height = 25
    Caption = #20445#23384'(&S)'
    Default = True
    TabOrder = 2
    OnClick = btnSaveClick
  end
  object btnClose: TButton
    Left = 492
    Top = 355
    Width = 75
    Height = 25
    Cancel = True
    Caption = #36864#20986'(&X)'
    TabOrder = 3
    OnClick = btnCloseClick
  end
  object pgcWorkerStation: TPageControl
    Left = 0
    Top = 0
    Width = 566
    Height = 350
    ActivePage = tsWorkerStation
    Align = alTop
    TabIndex = 0
    TabOrder = 0
    object tsWorkerStation: TTabSheet
      Caption = #23433#25490#26426#21488#20154#21592
      object lblMachine: TLabel
        Left = 4
        Top = 7
        Width = 65
        Height = 13
        AutoSize = False
        Caption = #26426#21488#21015#34920':'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object lblWorker: TLabel
        Left = 148
        Top = 7
        Width = 65
        Height = 13
        AutoSize = False
        Caption = #24037#20154#21015#34920':'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object lblCurWorker: TLabel
        Left = 364
        Top = 7
        Width = 54
        Height = 12
        Caption = #24403#29677#20154#21592':'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object lblOperateType: TLabel
        Left = 284
        Top = 61
        Width = 54
        Height = 12
        Caption = #25805#20316#31867#22411':'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object lblMonitor: TLabel
        Left = 366
        Top = 270
        Width = 54
        Height = 12
        Caption = #36136#37327#29677#38271':'
      end
      object lbl1: TLabel
        Left = 367
        Top = 304
        Width = 54
        Height = 12
        Caption = #35745#21010#29677#38271':'
      end
      object lstMachine: TListBox
        Left = 4
        Top = 21
        Width = 129
        Height = 299
        ItemHeight = 12
        TabOrder = 0
        OnClick = lstMachineClick
      end
      object cbbWorkerGroup: TComboBox
        Left = 148
        Top = 23
        Width = 129
        Height = 20
        ItemHeight = 12
        TabOrder = 1
        OnChange = cbbWorkerGroupChange
      end
      object btnRight: TBitBtn
        Left = 284
        Top = 119
        Width = 75
        Height = 25
        TabOrder = 5
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
        Left = 283
        Top = 175
        Width = 75
        Height = 25
        Caption = #28165#31354'(&C)'
        TabOrder = 6
        OnClick = btnClearClick
      end
      object vleCurWorker: TValueListEditor
        Left = 368
        Top = 25
        Width = 183
        Height = 228
        TabOrder = 2
        TitleCaptions.Strings = (
          #22995#21517
          #31867#22411)
        OnDblClick = vleCurWorkerDblClick
        OnGetPickList = vleCurWorkerGetPickList
        ColWidths = (
          110
          67)
      end
      object lstWorker: TListBox
        Left = 149
        Top = 45
        Width = 129
        Height = 276
        ItemHeight = 12
        TabOrder = 3
        OnDblClick = lstWorkerDblClick
      end
      object cbbOperateType: TComboBox
        Left = 284
        Top = 80
        Width = 76
        Height = 20
        ItemHeight = 12
        TabOrder = 4
      end
      object edtQualityMonitor: TEdit
        Left = 419
        Top = 262
        Width = 130
        Height = 20
        TabOrder = 7
      end
      object btnQualityMonitor: TButton
        Left = 285
        Top = 257
        Width = 75
        Height = 25
        Caption = #36136#37327#29677#38271
        TabOrder = 8
        OnClick = btnQualityMonitorClick
      end
      object btnPlanMonitor: TButton
        Left = 286
        Top = 291
        Width = 75
        Height = 25
        Caption = #35745#21010#29677#38271
        TabOrder = 9
        OnClick = btnPlanMonitorClick
      end
      object edtPlanMonitor: TEdit
        Left = 420
        Top = 296
        Width = 130
        Height = 20
        TabOrder = 10
      end
      object chklstMachine: TCheckListBox
        Left = 8
        Top = 24
        Width = 129
        Height = 299
        ItemHeight = 12
        TabOrder = 11
        OnClick = chklstMachineClick
      end
    end
  end
  object btnSelect: TButton
    Left = 14
    Top = 355
    Width = 75
    Height = 25
    Caption = #21462#28040#36873#23450'(&U)'
    TabOrder = 4
    OnClick = btnSelectClick
  end
  object ds1: TDataSource
    Left = 112
    Top = 112
  end
  object cdsPlan: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 104
    Top = 208
  end
end

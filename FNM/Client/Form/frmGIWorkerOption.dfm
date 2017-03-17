object WorkerOptionForm: TWorkerOptionForm
  Left = 370
  Top = 119
  Width = 698
  Height = 551
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #20154#21592#29677#32452#32500#25252
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnlOption: TPanel
    Left = 281
    Top = 0
    Width = 124
    Height = 485
    Align = alClient
    TabOrder = 0
    object SBtnSelect: TSpeedButton
      Left = 24
      Top = 136
      Width = 75
      Height = 25
      Caption = '>'
      OnClick = SBtnSelectClick
    end
    object SBtnSelectAll: TSpeedButton
      Left = 24
      Top = 177
      Width = 75
      Height = 25
      Caption = '>>'
      OnClick = SBtnSelectAllClick
    end
    object SBtnCleanAll: TSpeedButton
      Left = 24
      Top = 218
      Width = 75
      Height = 25
      Caption = '<<'
      OnClick = SBtnCleanAllClick
    end
    object SBtnClean: TSpeedButton
      Left = 24
      Top = 259
      Width = 75
      Height = 25
      Caption = '<'
      OnClick = SBtnCleanClick
    end
    object Label2: TLabel
      Left = 12
      Top = 24
      Width = 85
      Height = 13
      AutoSize = False
      Caption = #29677#32452#23545#24212#37096#38376
    end
    object CBBDepartment: TComboBox
      Left = 12
      Top = 40
      Width = 100
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = CBBDepartmentChange
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 281
    Height = 485
    Align = alLeft
    Caption = #24453#36873#24037#20154
    TabOrder = 1
    object LstWaitWorker: TListBox
      Left = 2
      Top = 15
      Width = 277
      Height = 468
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
      OnDblClick = LstWaitWorkerDblClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 405
    Top = 0
    Width = 285
    Height = 485
    Align = alRight
    Caption = #24050#36873#24037#20154
    TabOrder = 2
    object LstWorker: TListBox
      Left = 2
      Top = 15
      Width = 281
      Height = 468
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
      OnDblClick = LstWorkerDblClick
    end
  end
  object PnlInfo: TPanel
    Left = 0
    Top = 485
    Width = 690
    Height = 39
    Align = alBottom
    TabOrder = 3
    object SBtnSave: TSpeedButton
      Left = 511
      Top = 8
      Width = 75
      Height = 25
      Caption = #20445#23384
      Enabled = False
      OnClick = SBtnSaveClick
    end
    object SBtnExit: TSpeedButton
      Left = 590
      Top = 8
      Width = 75
      Height = 25
      Caption = #36864#20986
      OnClick = SBtnExitClick
    end
    object Label1: TLabel
      Left = 248
      Top = 12
      Width = 33
      Height = 18
      AutoSize = False
      Caption = #24037#21495
    end
    object SBtnQuery: TSpeedButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = #21047#26032
      OnClick = SBtnQueryClick
    end
    object EdtWorkerID: TEdit
      Left = 280
      Top = 10
      Width = 124
      Height = 21
      TabOrder = 0
    end
    object btnLocalQuery: TButton
      Left = 408
      Top = 8
      Width = 75
      Height = 25
      Caption = #26412#22320#26597#35810
      TabOrder = 1
      OnClick = btnLocalQueryClick
    end
  end
  object cdsWorkerList: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 352
    Top = 304
  end
  object cdsFNWorkerList: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 296
    Top = 304
  end
end

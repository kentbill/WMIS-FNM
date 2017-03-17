object OTDForm: TOTDForm
  Left = 315
  Top = 172
  BorderStyle = bsDialog
  BorderWidth = 5
  Caption = 'OTD'#32479#35745#20449#24687
  ClientHeight = 295
  ClientWidth = 467
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    467
    295)
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 467
    Height = 262
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 190
      Width = 54
      Height = 12
      Caption = #20849#35745#21697#31181':'
    end
    object Label4: TLabel
      Left = 24
      Top = 79
      Width = 54
      Height = 12
      Caption = #25302#21333#21697#31181':'
    end
    object Label5: TLabel
      Left = 24
      Top = 106
      Width = 42
      Height = 12
      Caption = #26410#23436#25104':'
    end
    object Label6: TLabel
      Left = 24
      Top = 217
      Width = 30
      Height = 12
      Caption = #22791#27880':'
    end
    object lbl1: TLabel
      Left = 24
      Top = 135
      Width = 30
      Height = 12
      Caption = #29305#30333':'
    end
    object lbl2: TLabel
      Left = 24
      Top = 162
      Width = 30
      Height = 12
      Caption = #28418#30333':'
    end
    object lbl3: TLabel
      Left = 24
      Top = 16
      Width = 54
      Height = 12
      Caption = #24320#22987#26102#38388':'
    end
    object lbl4: TLabel
      Left = 248
      Top = 16
      Width = 54
      Height = 12
      Caption = #32467#26463#26102#38388':'
    end
    object bvl1: TBevel
      Left = 8
      Top = 60
      Width = 463
      Height = 3
      Shape = bsTopLine
    end
    object lbl5: TLabel
      Left = 24
      Top = 44
      Width = 30
      Height = 12
      Caption = #37096#38376':'
    end
    object DBText1: TDBText
      Left = 217
      Top = 117
      Width = 224
      Height = 71
      DataField = 'Ratio'
      DataSource = dsOTDStat
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -69
      Font.Name = #23435#20307
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object lbType: TLabel
      Left = 224
      Top = 79
      Width = 30
      Height = 12
      Caption = #31867#22411':'
    end
    object dtpBegin_Date: TDateTimePicker
      Left = 84
      Top = 13
      Width = 125
      Height = 20
      CalAlignment = dtaLeft
      Date = 38301.5052943634
      Time = 38301.5052943634
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 0
    end
    object dtpEnd_Date: TDateTimePicker
      Left = 312
      Top = 10
      Width = 125
      Height = 20
      CalAlignment = dtaLeft
      Date = 38301.5052943634
      Time = 38301.5052943634
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
    end
    object chkStatus: TCheckBox
      Left = 249
      Top = 39
      Width = 98
      Height = 19
      Caption = #25353#23436#25104#26085#26399
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object dbedtDelayed: TDBEdit
      Left = 84
      Top = 71
      Width = 109
      Height = 20
      Color = clMenu
      DataField = 'Delayed_Count'
      DataSource = dsOTDStat
      ReadOnly = True
      TabOrder = 3
    end
    object dbedtUnFinished: TDBEdit
      Left = 84
      Top = 98
      Width = 109
      Height = 20
      Color = clMenu
      DataField = 'UnFinished_Count'
      DataSource = dsOTDStat
      ReadOnly = True
      TabOrder = 4
    end
    object dbedtWhite: TDBEdit
      Left = 84
      Top = 125
      Width = 109
      Height = 20
      Color = clMenu
      DataField = 'White_Count'
      DataSource = dsOTDStat
      ReadOnly = True
      TabOrder = 5
    end
    object dbedtBleach: TDBEdit
      Left = 84
      Top = 152
      Width = 109
      Height = 20
      Color = clMenu
      DataField = 'Bleach_Count'
      DataSource = dsOTDStat
      ReadOnly = True
      TabOrder = 6
    end
    object dbedtTotal: TDBEdit
      Left = 84
      Top = 181
      Width = 109
      Height = 20
      Color = clMenu
      DataField = 'Total_Count'
      DataSource = dsOTDStat
      ReadOnly = True
      TabOrder = 7
    end
    object dbmmoRemark: TDBMemo
      Left = 84
      Top = 208
      Width = 353
      Height = 45
      Color = clMenu
      DataField = 'Remark'
      DataSource = dsOTDStat
      ReadOnly = True
      TabOrder = 8
    end
    object cbbCurrentDept: TComboBox
      Left = 84
      Top = 38
      Width = 125
      Height = 20
      Hint = #24403#21069#24212#29992#31243#24207#27491#22312#25805#20316#30340#37096#38376
      ItemHeight = 12
      TabOrder = 9
    end
    object cbbType: TComboBox
      Left = 262
      Top = 71
      Width = 175
      Height = 20
      Hint = #24403#21069#24212#29992#31243#24207#27491#22312#25805#20316#30340#37096#38376
      ItemHeight = 12
      TabOrder = 10
      Text = #22823#36135
      OnChange = cbbTypeChange
      Items.Strings = (
        #22823#36135
        #35797#26679
        #21512#35745
        'CPB'#22823#36135
        'CPB'#35797#26679
        'CPB'#21512#35745)
    end
  end
  object btnClose: TBitBtn
    Left = 392
    Top = 269
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #36864#20986'(&X)'
    TabOrder = 2
    OnClick = btnCloseClick
  end
  object btnQuery: TBitBtn
    Left = 362
    Top = 32
    Width = 75
    Height = 25
    Caption = #26597#35810'(&Q)'
    Default = True
    TabOrder = 1
    OnClick = btnQueryClick
  end
  object cdsOTDStat: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 160
    Top = 208
  end
  object dsOTDStat: TDataSource
    DataSet = cdsOTDStat
    Left = 224
    Top = 208
  end
end

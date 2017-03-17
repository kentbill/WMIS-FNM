object MFQueryForm: TMFQueryForm
  Left = 217
  Top = 197
  Width = 972
  Height = 480
  Caption = #20013#25511#38376#24133#26597#35810
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 956
    Height = 49
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 64
      Top = 16
      Width = 36
      Height = 13
      Caption = #26426#21488#65306
    end
    object Label2: TLabel
      Left = 256
      Top = 16
      Width = 36
      Height = 13
      Caption = #26102#38388#65306
    end
    object Label3: TLabel
      Left = 461
      Top = 16
      Width = 24
      Height = 13
      Caption = #21040#65306
    end
    object edtMachine: TEdit
      Left = 104
      Top = 13
      Width = 124
      Height = 21
      TabOrder = 0
    end
    object dtpDate: TDateTimePicker
      Left = 290
      Top = 14
      Width = 85
      Height = 20
      CalAlignment = dtaLeft
      Date = 40497.4241688773
      Time = 40497.4241688773
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
    end
    object btnQuery: TButton
      Left = 762
      Top = 12
      Width = 65
      Height = 25
      Caption = #26597#35810'(Q)'
      Default = True
      TabOrder = 2
      OnClick = btnQueryClick
    end
    object btnToExcel: TButton
      Left = 850
      Top = 12
      Width = 81
      Height = 25
      Caption = 'ToExcel'
      TabOrder = 3
      OnClick = btnToExcelClick
    end
    object dtpEnd: TDateTimePicker
      Left = 484
      Top = 13
      Width = 81
      Height = 20
      CalAlignment = dtaLeft
      Date = 40497.4241688773
      Time = 40497.4241688773
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 4
    end
    object dtptime: TDateTimePicker
      Left = 374
      Top = 14
      Width = 85
      Height = 20
      CalAlignment = dtaLeft
      Date = 40497.4241688773
      Time = 40497.4241688773
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkTime
      ParseInput = False
      TabOrder = 5
    end
    object dtptimeend: TDateTimePicker
      Left = 564
      Top = 13
      Width = 81
      Height = 20
      CalAlignment = dtaLeft
      Date = 40497.4241688773
      Time = 40497.4241688773
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkTime
      ParseInput = False
      TabOrder = 6
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 49
    Width = 956
    Height = 393
    Align = alClient
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 954
      Height = 391
      Align = alClient
      DataSource = DataSource1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object conn: TADOConnection
    Provider = 'SQLNCLI.1'
    Left = 192
    Top = 88
  end
  object ADOQuery1: TADOQuery
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=Reader#2!@;Persist Security Info=Tr' +
      'ue;User ID=Gewmfreader;Initial Catalog=GEWMFDB;Data Source=GETNT' +
      '15'
    CommandTimeout = 600
    Parameters = <>
    Left = 248
    Top = 88
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 296
    Top = 88
  end
  object SaveDialog1: TSaveDialog
    Left = 704
    Top = 8
  end
end

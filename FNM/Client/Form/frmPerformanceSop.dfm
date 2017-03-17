object PerformanceSopForm: TPerformanceSopForm
  Left = 216
  Top = 92
  Width = 849
  Height = 613
  Caption = 'PerformanceSopForm'
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
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 833
    Height = 575
    Align = alClient
    Caption = 'pnl1'
    TabOrder = 0
    object pnl2: TPanel
      Left = 1
      Top = 1
      Width = 831
      Height = 81
      Align = alTop
      TabOrder = 0
      object btnQuery: TSpeedButton
        Left = 408
        Top = 32
        Width = 57
        Height = 25
        Caption = #26597#35810
        OnClick = btnQueryClick
      end
      object lbl1: TLabel
        Left = 200
        Top = 21
        Width = 60
        Height = 13
        Caption = #24320#22987#26085#26399#65306
      end
      object lbl2: TLabel
        Left = 200
        Top = 51
        Width = 60
        Height = 13
        Caption = #25130#27490#26085#26399#65306
      end
      object lbl3: TLabel
        Left = 16
        Top = 32
        Width = 48
        Height = 13
        Caption = #21592#24037#21495#65306
      end
      object lbl4: TLabel
        Left = 64
        Top = 56
        Width = 96
        Height = 13
        Caption = #65288#40664#35748#25152#26377#21592#24037#65289
      end
      object edtWorkID: TEdit
        Left = 72
        Top = 29
        Width = 97
        Height = 21
        Color = clBtnFace
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 0
      end
      object edtBeginTime: TEdit
        Left = 265
        Top = 16
        Width = 113
        Height = 21
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 1
        Text = 'edtBeginTime'
      end
      object edtEndTime: TEdit
        Left = 265
        Top = 48
        Width = 113
        Height = 21
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 2
        Text = 'edtEndTime'
      end
    end
    object pnl3: TPanel
      Left = 1
      Top = 82
      Width = 831
      Height = 492
      Align = alClient
      Caption = 'pnl3'
      TabOrder = 1
      object cxgrdPerformanceSop: TcxGrid
        Left = 1
        Top = 1
        Width = 829
        Height = 490
        Align = alClient
        TabOrder = 0
        object cxgrdbtblvwPerformanceSopTV: TcxGridDBTableView
          DataController.DataSource = dsPerformanceSop
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OptionsData.Editing = False
        end
        object cxgrdPerformanceSopLV: TcxGridLevel
          GridView = cxgrdbtblvwPerformanceSopTV
        end
      end
    end
  end
  object cdsPerformanceSop: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 168
    Top = 304
  end
  object dsPerformanceSop: TDataSource
    DataSet = cdsPerformanceSop
    Left = 168
    Top = 368
  end
end

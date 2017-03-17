inherited ArtAnalysisForm: TArtAnalysisForm
  Left = 126
  Top = 206
  Width = 722
  Align = alTop
  Caption = #24037#33402#36131#20219#32771#26680
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object pnlValue: TPanel
    Left = 0
    Top = 417
    Width = 714
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      714
      36)
    object lbl1: TLabel
      Left = 16
      Top = 17
      Width = 30
      Height = 12
      Caption = #26085#26399':'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 158
      Top = 17
      Width = 30
      Height = 12
      Caption = #31867#22411':'
    end
    object btnSave: TBitBtn
      Left = 555
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #20445#23384'(&S)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnClose: TBitBtn
      Left = 635
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #36864#20986'(&X)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnCloseClick
    end
    object dtpQueryDate: TDateTimePicker
      Left = 48
      Top = 9
      Width = 100
      Height = 20
      CalAlignment = dtaLeft
      Date = 38301
      Time = 38301
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 2
    end
    object btnQuery: TBitBtn
      Left = 300
      Top = 7
      Width = 75
      Height = 25
      Caption = #26597#35810'(&Q)'
      Default = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnQueryClick
    end
    object cbbType: TComboBox
      Left = 192
      Top = 9
      Width = 100
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      ItemIndex = 0
      TabOrder = 4
      Text = #22806#36820#24037
      Items.Strings = (
        #22806#36820#24037
        #20869#36820#24037)
    end
  end
  object cxgrid: TcxGrid
    Left = 0
    Top = 0
    Width = 714
    Height = 417
    Align = alClient
    TabOrder = 1
    object cxgriddbTV: TcxGridDBTableView
      DataController.DataSource = dsArtAnalysis
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NavigatorButtons.ConfirmDelete = False
      OptionsView.Footer = True
      object cxgriddbTVCreate_Date: TcxGridDBColumn
        Caption = #26085#26399
        DataBinding.FieldName = 'Create_Date'
      end
      object cxgriddbTVFN_Card: TcxGridDBColumn
        Caption = #21345#21495
        DataBinding.FieldName = 'FN_Card'
      end
      object cxgriddbTVType: TcxGridDBColumn
        Caption = #31867#22411
        Visible = False
        DataBinding.FieldName = 'Type'
      end
      object cxgriddbTVJob_NO: TcxGridDBColumn
        Caption = #25490#21333#21495
        DataBinding.FieldName = 'Job_NO'
      end
      object cxgriddbTVGF_NO: TcxGridDBColumn
        Caption = #21697#21517
        Width = 52
        DataBinding.FieldName = 'GF_NO'
      end
      object cxgriddbTVQuantity: TcxGridDBColumn
        Caption = #30721#38271
        DataBinding.FieldName = 'Quantity'
      end
      object cxgriddbTVReason_Info: TcxGridDBColumn
        Caption = #22238#20462#21407#22240
        Width = 88
        DataBinding.FieldName = 'Reason_Info'
      end
      object cxgriddbTVChecker: TcxGridDBColumn
        Caption = 'Check'#20154
        Width = 64
        DataBinding.FieldName = 'Checker'
      end
      object cxgriddbTVWorker0: TcxGridDBColumn
        Caption = #36131#20219#20154'1'
        PropertiesClassName = 'TcxComboBoxProperties'
        Width = 64
        DataBinding.FieldName = 'Worker0'
      end
      object cxgriddbTVQty0: TcxGridDBColumn
        Caption = #36131#20219#30721#38271'1'
        DataBinding.FieldName = 'Qty0'
      end
      object cxgriddbTVWorker1: TcxGridDBColumn
        Caption = #36131#20219#20154'2'
        PropertiesClassName = 'TcxComboBoxProperties'
        Width = 64
        DataBinding.FieldName = 'Worker1'
      end
      object cxgriddbTVQty1: TcxGridDBColumn
        Caption = #36131#20219#30721#38271'2'
        DataBinding.FieldName = 'Qty1'
      end
      object cxgriddbTVRemark: TcxGridDBColumn
        Caption = #22791#27880
        DataBinding.FieldName = 'Remark'
      end
    end
    object cxGridl: TcxGridLevel
      GridView = cxgriddbTV
    end
  end
  object dsArtAnalysis: TDataSource
    DataSet = cdsArtAnalysis
    Left = 64
    Top = 144
  end
  object cxgpmOTD: TcxGridPopupMenu
    PopupMenus = <>
    Left = 80
    Top = 328
  end
  object cdsArtAnalysis: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 64
    Top = 112
  end
end

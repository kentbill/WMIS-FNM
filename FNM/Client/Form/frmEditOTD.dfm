inherited EditOTDForm: TEditOTDForm
  Left = 214
  Top = 125
  Width = 868
  Caption = #32534#36753'OTD'#21697#31181
  OldCreateOrder = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 12
  object cxspl2: TcxSplitter
    Left = 0
    Top = 398
    Width = 852
    Height = 8
    HotZoneClassName = 'TcxXPTaskBarStyle'
    AlignSplitter = salBottom
    Control = pnlValue
  end
  object pnlValue: TPanel
    Left = 0
    Top = 406
    Width = 852
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      852
      36)
    object btnAdd: TBitBtn
      Left = 541
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #22686#21152'(&A)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Visible = False
      OnClick = btnAddClick
    end
    object btnSave: TBitBtn
      Left = 701
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #20445#23384'(&S)'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnSaveClick
    end
    object btnClose: TBitBtn
      Left = 781
      Top = 4
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
      TabOrder = 2
      OnClick = btnCloseClick
    end
    object btnUpdateOTD: TBitBtn
      Left = 621
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #26356#26032'OTD'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnUpdateOTDClick
    end
  end
  object pgcOTD: TPageControl
    Left = 0
    Top = 0
    Width = 852
    Height = 398
    ActivePage = tbsOTD
    Align = alClient
    Style = tsFlatButtons
    TabIndex = 0
    TabOrder = 2
    OnChange = pgcOTDChange
    object tbsOTD: TTabSheet
      Caption = #32534#36753'OTD'
      object cxgridOTD: TcxGrid
        Left = 0
        Top = 32
        Width = 844
        Height = 336
        Align = alClient
        PopupMenu = pmOTD
        TabOrder = 0
        object cxgridtvOTD: TcxGridDBTableView
          DataController.DataSource = dsOTD
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OnCustomDrawCell = cxgridtvOTDCustomDrawCell
          OptionsView.Footer = True
          object cxgdbcOTDJob_NO1: TcxGridDBColumn
            Caption = #25490#21333#21495
            FooterAlignmentHorz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 77
            DataBinding.FieldName = 'Job_NO'
          end
          object cxgdbcOTDGF_NO1: TcxGridDBColumn
            Caption = #21697#21517
            FooterAlignmentHorz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 110
            DataBinding.FieldName = 'GF_NO'
          end
          object cxgdbcOTDOTD_Days1: TcxGridDBColumn
            Caption = 'OTD'#22825#25968
            PropertiesClassName = 'TcxSpinEditProperties'
            Properties.OnChange = cxgdbcOTDOTD_Days1PropertiesChange
            FooterAlignmentHorz = taCenter
            HeaderAlignmentHorz = taCenter
            SortOrder = soAscending
            Width = 73
            DataBinding.FieldName = 'OTD_Days'
          end
          object cxgdbcOTDLast_Received_Date1: TcxGridDBColumn
            Caption = #20102#26426#26085#26399
            FooterAlignmentHorz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 78
            DataBinding.FieldName = 'Last_Received_Date'
          end
          object cxgdbcOTDQuality_Type1: TcxGridDBColumn
            Caption = #36131#20219#37096#38376
            PropertiesClassName = 'TcxComboBoxProperties'
            FooterAlignmentHorz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 77
            DataBinding.FieldName = 'Quality_Type'
          end
          object cxgdbcOTDRemark1: TcxGridDBColumn
            Caption = #22791#27880
            FooterAlignmentHorz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 112
            DataBinding.FieldName = 'Remark'
          end
          object cxgdbcOTDUpdater1: TcxGridDBColumn
            Caption = #20462#25913#20154
            FooterAlignmentHorz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 62
            DataBinding.FieldName = 'Updater'
          end
          object cxgdbcOTDUpdate_Time1: TcxGridDBColumn
            Caption = #20462#25913#26102#38388
            FooterAlignmentHorz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 84
            DataBinding.FieldName = 'Update_Time'
          end
          object cxgridtvOTDIs_Active1: TcxGridDBColumn
            Caption = #26159#21542#26377#25928
            DataBinding.FieldName = 'Is_Active'
          end
          object cxgdbcOTDGF_ID1: TcxGridDBColumn
            Caption = #21697#21517'ID'
            FooterAlignmentHorz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 68
            DataBinding.FieldName = 'GF_ID'
          end
        end
        object cxGridlOTD: TcxGridLevel
          GridView = cxgridtvOTD
        end
      end
      object pnlTop: TPanel
        Left = 0
        Top = 0
        Width = 844
        Height = 32
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object lbl1: TLabel
          Left = 16
          Top = 14
          Width = 78
          Height = 12
          Caption = #26368#21518#25910#22383#26085#26399':'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object btnQuery: TBitBtn
          Left = 228
          Top = 1
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
          TabOrder = 0
          OnClick = btnQueryClick
        end
        object dtpQueryDate: TDateTimePicker
          Left = 96
          Top = 6
          Width = 125
          Height = 20
          CalAlignment = dtaLeft
          Date = 38301.6645457986
          Time = 38301.6645457986
          DateFormat = dfShort
          DateMode = dmComboBox
          Kind = dtkDate
          ParseInput = False
          TabOrder = 1
        end
        object dtpQueryEndDate: TDateTimePicker
          Left = 312
          Top = 4
          Width = 125
          Height = 20
          Hint = #32467#26463#26085#26399
          CalAlignment = dtaLeft
          Date = 38301.6645457986
          Time = 38301.6645457986
          DateFormat = dfShort
          DateMode = dmComboBox
          Kind = dtkDate
          ParseInput = False
          TabOrder = 2
          Visible = False
        end
        object chkCPBEndTime: TCheckBox
          Left = 448
          Top = 8
          Width = 105
          Height = 17
          Caption = 'CPB'#21306#38388#26597#35810'(&C)'
          TabOrder = 3
          OnClick = chkCPBEndTimeClick
        end
        object btnOpenOTD: TBitBtn
          Left = 664
          Top = 4
          Width = 177
          Height = 25
          Caption = #25171#24320#35797#26679'OTD'#30028#38754
          TabOrder = 4
          OnClick = btnOpenOTDClick
        end
      end
    end
    object tbsDelayOTD: TTabSheet
      Caption = #25302#21333#21697#31181
      ImageIndex = 1
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 844
        Height = 32
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object lbl3: TLabel
          Left = 24
          Top = 13
          Width = 54
          Height = 12
          Caption = #24320#22987#26102#38388':'
        end
        object lbl4: TLabel
          Left = 240
          Top = 13
          Width = 54
          Height = 12
          Caption = #32467#26463#26102#38388':'
        end
        object BitQueryDelayOTD: TBitBtn
          Left = 540
          Top = 0
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
          TabOrder = 0
          OnClick = btnQueryClick
        end
        object dtpBegin_Date: TDateTimePicker
          Left = 84
          Top = 5
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
        object dtpEnd_Date: TDateTimePicker
          Left = 301
          Top = 5
          Width = 125
          Height = 20
          CalAlignment = dtaLeft
          Date = 38301.5052943634
          Time = 38301.5052943634
          DateFormat = dfShort
          DateMode = dmComboBox
          Kind = dtkDate
          ParseInput = False
          TabOrder = 2
        end
        object chkStatus: TCheckBox
          Left = 441
          Top = 6
          Width = 98
          Height = 19
          Caption = #25353#23436#25104#26085#26399
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object chkCPB: TCheckBox
          Left = 624
          Top = 8
          Width = 97
          Height = 17
          Caption = #21482#26174#31034'CPB'
          TabOrder = 4
          OnClick = chkCPBClick
        end
      end
      object cxGridDelayOTD: TcxGrid
        Left = 0
        Top = 32
        Width = 844
        Height = 336
        Align = alClient
        TabOrder = 1
        object cxGridDBtvDelayOTD: TcxGridDBTableView
          DataController.DataSource = dsDelayOTD
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OnCustomDrawCell = cxGridDBtvDelayOTDCustomDrawCell
          OptionsView.Footer = True
          object cxGridDBtvDelayOTDJob_NO: TcxGridDBColumn
            Caption = #25490#21333#21495
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 64
            DataBinding.FieldName = 'Job_NO'
          end
          object cxGridDBtvDelayOTDGF_NO: TcxGridDBColumn
            Caption = #21697#21517
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            DataBinding.FieldName = 'GF_NO'
          end
          object cxGridDBtvDelayOTDPpo_Type: TcxGridDBColumn
            Caption = #25490#21333#31867#22411
            Options.Editing = False
            Width = 70
            DataBinding.FieldName = 'Ppo_Type'
          end
          object cxGridDBtvDelayOTDWhite_Type: TcxGridDBColumn
            Caption = #31867#22411
            HeaderAlignmentHorz = taCenter
            DataBinding.FieldName = 'White_Type'
          end
          object cxGridDBtvDelayOTDUrgent_Type1: TcxGridDBColumn
            Caption = #24613#21333#31867#22411
            DataBinding.FieldName = 'Urgent_Type'
          end
          object cxGridDBtvDelayOTDBU_Delivery_Date: TcxGridDBColumn
            Caption = #20132#26399
            HeaderAlignmentHorz = taCenter
            DataBinding.FieldName = 'BU_Delivery_Date'
          end
          object cxGridDBtvDelayOTDLast_Received_Date: TcxGridDBColumn
            Caption = #26368#21518#25910#22383#26085#26399
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 96
            DataBinding.FieldName = 'Last_Received_Date'
          end
          object cxGridDBtvDelayOTDPlan_Finished_Date: TcxGridDBColumn
            Caption = #35745#21010#23436#25104#26085#26399
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 95
            DataBinding.FieldName = 'Plan_Finished_Date'
          end
          object cxGridDBtvDelayOTDFact_Finished_Date: TcxGridDBColumn
            Caption = #23454#38469#23436#25104#26102#38388
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 88
            DataBinding.FieldName = 'Fact_Finished_Date'
          end
          object cxGridDBtvDelayOTDQuality_Type: TcxGridDBColumn
            Caption = #31532#19968#36131#20219
            PropertiesClassName = 'TcxComboBoxProperties'
            HeaderAlignmentHorz = taCenter
            Width = 75
            DataBinding.FieldName = 'Quality_Type'
          end
          object cxGridDBtvDelayOTDSecond_Reason: TcxGridDBColumn
            Caption = #31532#20108#36131#20219
            PropertiesClassName = 'TcxComboBoxProperties'
            HeaderAlignmentHorz = taCenter
            DataBinding.FieldName = 'Second_Reason'
          end
          object cxGridDBtvDelayOTDThird_Reason: TcxGridDBColumn
            Caption = #31532#19977#36131#20219
            PropertiesClassName = 'TcxComboBoxProperties'
            HeaderAlignmentHorz = taCenter
            DataBinding.FieldName = 'Third_Reason'
          end
          object cxGridDBtvDelayOTDFour_Reason: TcxGridDBColumn
            Caption = #31532#22235#36131#20219
            PropertiesClassName = 'TcxComboBoxProperties'
            HeaderAlignmentHorz = taCenter
            DataBinding.FieldName = 'Four_Reason'
          end
          object cxGridDBtvDelayOTDRemark: TcxGridDBColumn
            Caption = #22791#27880
            HeaderAlignmentHorz = taCenter
            Width = 255
            DataBinding.FieldName = 'Remark'
          end
          object cxGridDBtvDelayOTDIs_Active1: TcxGridDBColumn
            Caption = #26159#21542#26377#25928
            DataBinding.FieldName = 'Is_Active'
          end
          object cxGridDBtvDelayOTDGF_ID: TcxGridDBColumn
            Caption = #21697#21517'ID'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            DataBinding.FieldName = 'GF_ID'
          end
          object TcxGridDBColumn
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBtvDelayOTD
        end
      end
    end
    object tbsUrgentPpoInfo1: TTabSheet
      Caption = #25490#21333#25253#35686
      ImageIndex = 2
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 706
        Height = 32
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label1: TLabel
          Left = 24
          Top = 13
          Width = 30
          Height = 12
          Caption = #21697#21517':'
        end
        object edtGFNO: TEdit
          Left = 56
          Top = 8
          Width = 121
          Height = 20
          TabOrder = 0
        end
        object btnQueryUrgent: TBitBtn
          Left = 186
          Top = 4
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
          TabOrder = 1
          OnClick = btnQueryClick
        end
      end
      object cxGrid1: TcxGrid
        Left = 0
        Top = 32
        Width = 706
        Height = 340
        Align = alClient
        TabOrder = 1
        object cxGridTVUrgentPpoInfo: TcxGridDBTableView
          DataController.DataSource = dsDelayOTD
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OnCustomDrawCell = cxGridTVUrgentPpoInfoCustomDrawCell
          OptionsView.Footer = True
        end
        object cxGridLevel2: TcxGridLevel
          GridView = cxGridTVUrgentPpoInfo
        end
      end
    end
    object tbsOTDInfo: TTabSheet
      Caption = 'OTD'#24037#24207#36827#24230#36319#36394
      ImageIndex = 3
      object cxGrid2: TcxGrid
        Left = 0
        Top = 49
        Width = 706
        Height = 323
        Align = alClient
        TabOrder = 0
        object cxGridtvOTDInfo: TcxGridDBTableView
          DataController.DataSource = dsDelayOTD
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OnCustomDrawCell = cxGridTVUrgentPpoInfoCustomDrawCell
          OptionsView.Footer = True
        end
        object cxGridLevel3: TcxGridLevel
          GridView = cxGridtvOTDInfo
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 706
        Height = 49
        Align = alTop
        TabOrder = 1
        object Button1: TButton
          Left = 56
          Top = 16
          Width = 73
          Height = 25
          Caption = #21047#26032'(&R)'
          TabOrder = 0
        end
      end
    end
  end
  object dsOTD: TDataSource
    DataSet = cdsOTD
    Left = 56
    Top = 208
  end
  object cxgpmOTD: TcxGridPopupMenu
    PopupMenus = <>
    Left = 184
    Top = 304
  end
  object cdsOTD: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 136
  end
  object pmOTD: TPopupMenu
    Left = 56
    Top = 304
    object N1: TMenuItem
      Caption = #22686#21152'(&A)'
      OnClick = btnAddClick
    end
    object b1: TMenuItem
      Caption = #20445#23384'(&S)'
      OnClick = btnSaveClick
    end
    object N3: TMenuItem
      Caption = #36864#20986'(&X)'
      OnClick = btnCloseClick
    end
  end
  object dsDelayOTD: TDataSource
    DataSet = cdsDelayOTD
    Left = 184
    Top = 200
  end
  object cdsDelayOTD: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 184
    Top = 128
  end
  object cdsUrgentPpoInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 288
    Top = 136
  end
  object dsUrgentPpoInfo: TDataSource
    DataSet = cdsUrgentPpoInfo
    Left = 288
    Top = 184
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 280
    Top = 304
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clInfoBk
    end
  end
end

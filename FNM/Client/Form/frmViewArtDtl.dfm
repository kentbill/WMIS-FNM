object ViewArtDtlForm: TViewArtDtlForm
  Left = 217
  Top = 158
  Width = 599
  Height = 400
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #24037#33402#26597#30475
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object pnl_Only: TPanel
    Left = 0
    Top = 335
    Width = 591
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      591
      38)
    object btn_Cancel: TButton
      Left = 503
      Top = 7
      Width = 75
      Height = 25
      Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #36864#20986'(&X)'
      ModalResult = 1
      TabOrder = 0
    end
  end
  object TPanel
    Left = 0
    Top = 332
    Width = 591
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
  end
  object cxgrid_ArtDtl: TcxGrid
    Left = 145
    Top = 37
    Width = 446
    Height = 295
    Align = alClient
    TabOrder = 3
    object cxgridtv_ArtDtl: TcxGridDBTableView
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NavigatorButtons.ConfirmDelete = False
      OnCustomDrawCell = cxgridtv_ArtDtlCustomDrawCell
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
    end
    object cxGridl_ArtDtl: TcxGridLevel
      GridView = cxgridtv_ArtDtl
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 591
    Height = 37
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblWorkerID: TLabel
      Left = 8
      Top = 16
      Width = 54
      Height = 12
      Caption = #21592#24037#21345#21495':'
    end
    object Label1: TLabel
      Left = 144
      Top = 16
      Width = 54
      Height = 12
      Caption = #24320#22987#26102#38388':'
    end
    object Label2: TLabel
      Left = 328
      Top = 16
      Width = 54
      Height = 12
      Caption = #24320#22987#26102#38388':'
    end
    object edtWorkerID: TEdit
      Left = 64
      Top = 8
      Width = 73
      Height = 20
      MaxLength = 7
      TabOrder = 0
    end
    object edtBeginTime: TEdit
      Left = 200
      Top = 8
      Width = 121
      Height = 20
      TabOrder = 1
      Text = '2005-06-07 07:00:00'
    end
    object btnQuery: TButton
      Left = 512
      Top = 5
      Width = 75
      Height = 25
      Caption = #26597#35810'(&Q)'
      Default = True
      TabOrder = 3
      OnClick = btnQueryClick
    end
    object edtEndTime: TEdit
      Left = 384
      Top = 8
      Width = 121
      Height = 20
      TabOrder = 2
      Text = '2005-06-07 07:00:00'
    end
    object pnl1: TPanel
      Left = 272
      Top = 4
      Width = 233
      Height = 31
      BevelOuter = bvNone
      TabOrder = 4
      Visible = False
      object Label3: TLabel
        Left = 0
        Top = 11
        Width = 30
        Height = 12
        Caption = #26085#26399':'
      end
      object Label4: TLabel
        Left = 144
        Top = 11
        Width = 30
        Height = 12
        Caption = #29677#27425':'
      end
      object dtpDate: TDateTimePicker
        Left = 48
        Top = 5
        Width = 89
        Height = 20
        CalAlignment = dtaLeft
        Date = 40497.4241688773
        Time = 40497.4241688773
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 0
      end
      object cbbShift: TComboBox
        Left = 176
        Top = 5
        Width = 41
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 1
        Items.Strings = (
          #26089
          #20013
          #26202)
      end
    end
  end
  object vleTotal: TValueListEditor
    Left = 0
    Top = 37
    Width = 145
    Height = 295
    Align = alLeft
    Strings.Strings = (
      '=')
    TabOrder = 4
    TitleCaptions.Strings = (
      #39033#30446
      #20540)
    ColWidths = (
      78
      61)
  end
  object ds_ArtDtl: TDataSource
    Left = 80
    Top = 192
  end
end

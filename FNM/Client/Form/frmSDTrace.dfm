inherited SDTraceForm: TSDTraceForm
  Left = 400
  Top = 122
  Width = 795
  Height = 535
  Caption = #37325#35201#35797#26679#36319#36394
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 787
    Height = 50
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 104
      Top = 13
      Width = 30
      Height = 12
      Caption = #21697#21517':'
    end
    object Label2: TLabel
      Left = 136
      Top = 34
      Width = 480
      Height = 12
      Caption = 
        #25552#31034': ( '#21487#36755#20837#22810#20010#21697#21517','#29992#36887#21495#38548#24320' '#22914':DC2020-151930,PC80A50-151943,DC06-16920DF ' +
        ')'
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clGreen
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object sbClear: TSpeedButton
      Left = 675
      Top = 7
      Width = 23
      Height = 22
      Hint = #28165#38500#20869#23481
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008484
        8400848484008484840084848400848484008484840084848400848484008484
        840084848400848484008484840084848400FFFFFF00FFFFFF00848484008484
        8400848484008484840084848400848484008484840084848400848484008484
        840084848400848484008484840000000000FFFFFF00FFFFFF0084848400CED6
        D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF0084848400CED6
        D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CED6D600CED6
        D600CED6D600FFFFFF008484840000000000FFFFFF00FFFFFF0084848400CED6
        D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF0084848400CED6
        D600FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
        000000000000FFFFFF008484840000000000FFFFFF00FFFFFF0084848400CED6
        D600FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF0000FFFF0000FFFF0000FF
        FF0000848400000000008484840000000000FFFFFF00FFFFFF0084848400CED6
        D600FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF0000FFFF0000FFFF0000FF
        FF0000848400008484000000000000000000FFFFFF00FFFFFF0084848400CED6
        D600848484008484840084848400000000008484840000848400008484000084
        840000848400008484000084840000000000FFFFFF00FFFFFF0084848400CED6
        D600FF000000FF000000FF000000FF00000000000000FFFFFF0000FFFF0000FF
        FF0000FFFF0000848400008484000084840084848400FFFFFF0084848400CED6
        D600CED6D600CED6D600CED6D600CED6D600CED6D60000000000FFFFFF0000FF
        FF0000FFFF0000FFFF0000848400008484008484840084848400848484008484
        840084848400848484008484840084848400848484008484840084848400FFFF
        FF0000FFFF0000FFFF0000FFFF00008484000084840084848400FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
        8400FFFFFF0000FFFF0000FFFF0000FFFF008484840084848400FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF008484840084848400848484008484840084848400FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      ParentShowHint = False
      ShowHint = True
      OnClick = sbClearClick
    end
    object edtGFNO: TEdit
      Left = 136
      Top = 8
      Width = 537
      Height = 20
      TabOrder = 0
    end
    object btnQuery: TBitBtn
      Left = 701
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
    object rgType: TRadioGroup
      Left = 0
      Top = 0
      Width = 89
      Height = 50
      Align = alLeft
      ItemIndex = 0
      Items.Strings = (
        #26032#22686
        #20462#25913'/'#35299#38500)
      TabOrder = 2
      OnClick = rgTypeClick
    end
  end
  object pnlValue: TPanel
    Left = 0
    Top = 472
    Width = 787
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      787
      36)
    object Label3: TLabel
      Left = 4
      Top = 6
      Width = 366
      Height = 12
      Caption = #25552#31034': '#19981#38656#35201#30340#25490#21333#25968#25454#21487#20808#21024#38500#25481'     '#35299#38500#21069#35831#20808#36873#20013#24453#35299#38500#25968#25454
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clGreen
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label4: TLabel
      Left = 41
      Top = 22
      Width = 492
      Height = 12
      Caption = #37038#20214#21015#20013#22914#26524#38656#35201'Email'#32473#22810#20154','#35831#36755#20837#30331#38470#31995#32479#26102#30340#29992#25143#21517','#24182#29992#20998#21495';'#38548#24320' '#22914': fangy;gaoyp'
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clGreen
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object btnDelete: TBitBtn
      Left = 548
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #21024#38500'(&D)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnDeleteClick
    end
    object btnSave: TBitBtn
      Left = 628
      Top = 4
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
      TabOrder = 1
      OnClick = btnSaveClick
    end
    object btnClose: TBitBtn
      Left = 708
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
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 50
    Width = 787
    Height = 422
    Align = alClient
    TabOrder = 2
    object cxGridTVSDTraceInfo: TcxGridDBTableView
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NavigatorButtons.ConfirmDelete = False
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
    end
    object cxGridLevel2: TcxGridLevel
      GridView = cxGridTVSDTraceInfo
    end
  end
  object dsSDTrace: TDataSource
    DataSet = cdsSDTrace
    Left = 224
    Top = 144
  end
  object cdsSDTrace: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 224
    Top = 176
  end
  object dsOperationHdr: TDataSource
    Left = 224
    Top = 240
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 224
    Top = 176
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clInfoBk
    end
  end
end

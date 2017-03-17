object ProductionParameterForm: TProductionParameterForm
  Left = 390
  Top = 97
  Width = 800
  Height = 472
  Caption = #22383#24067#23567#26679#24037#24207#21442#25968#32500#25252
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
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
  TextHeight = 12
  object grpTop: TGroupBox
    Left = 0
    Top = 0
    Width = 792
    Height = 113
    Align = alTop
    Caption = #20449#24687#32500#25252
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object lbl1: TLabel
      Left = 16
      Top = 24
      Width = 59
      Height = 12
      Caption = #24037#24207#32534#21495':'
    end
    object lbl2: TLabel
      Left = 248
      Top = 24
      Width = 59
      Height = 12
      Caption = #24037#24207#21517#31216':'
    end
    object lbl3: TLabel
      Left = 16
      Top = 56
      Width = 59
      Height = 12
      Caption = #24037#24207#21442#25968':'
    end
    object cbbOpeCode: TComboBox
      Left = 80
      Top = 20
      Width = 145
      Height = 20
      ItemHeight = 12
      TabOrder = 0
      Text = 'cbbOpeCode'
      OnChange = cbbOpeCodeChange
    end
    object cbbOpeName: TComboBox
      Left = 312
      Top = 20
      Width = 145
      Height = 20
      ItemHeight = 12
      TabOrder = 1
      Text = 'cbbOpeName'
      OnChange = cbbOpeNameChange
    end
    object mmoOpeDes: TMemo
      Left = 80
      Top = 48
      Width = 561
      Height = 49
      Lines.Strings = (
        'mmo1')
      TabOrder = 2
    end
  end
  object cxSplitter1: TcxSplitter
    Left = 0
    Top = 113
    Width = 792
    Height = 8
    HotZoneClassName = 'TcxMediaPlayer8Style'
    AlignSplitter = salTop
    Control = grpTop
  end
  object grpClient: TGroupBox
    Left = 0
    Top = 121
    Width = 792
    Height = 324
    Align = alClient
    TabOrder = 2
    object dbgrdPP: TDBGrid
      Left = 2
      Top = 49
      Width = 788
      Height = 231
      Align = alClient
      DataSource = dsFnProductionParameter
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
      OnCellClick = dbgrdPPCellClick
      Columns = <
        item
          Expanded = False
          FieldName = 'Iden'
          Title.Caption = #24207#21495
          Width = 44
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Operation_Code'
          Title.Caption = #24037#24207#32534#21495
          Width = 99
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Operation_Name'
          Title.Caption = #24037#24207#21517#31216
          Width = 168
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Operation_Description'
          Title.Caption = #24037#24207#21442#25968
          Width = 272
          Visible = True
        end>
    end
    object pnlTop: TPanel
      Left = 2
      Top = 14
      Width = 788
      Height = 35
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object lbl4: TLabel
        Left = 16
        Top = 12
        Width = 59
        Height = 12
        Caption = #24037#24207#32534#21495':'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtQueryCode: TEdit
        Left = 80
        Top = 8
        Width = 145
        Height = 20
        TabOrder = 0
        Text = 'edtQueryCode'
      end
      object btnQuery: TButton
        Left = 232
        Top = 6
        Width = 75
        Height = 25
        Caption = #26597#35810
        TabOrder = 1
        OnClick = btnQueryClick
      end
    end
    object pnlBottom: TPanel
      Left = 2
      Top = 280
      Width = 788
      Height = 42
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      object pnlRight: TPanel
        Left = 244
        Top = 0
        Width = 544
        Height = 42
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          544
          42)
        object btnUpdate: TSpeedButton
          Left = 119
          Top = 10
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = #20462#25913
          Flat = True
          Glyph.Data = {
            66010000424D6601000000000000760000002800000014000000140000000100
            040000000000F0000000130B0000130B00001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFC0C0FFFFFFFFFFFFFFFFFFFFC0C0FFFFFFFFFFFFFFFFFFFFC0C0FFFF
            F0F0F0F0FFFFFFFFC0C0FFFFFFFFFFF00FFFFFFFC0C0FFFFFFFFFFF000FFFFFF
            C0C0FFF000000000B70FFFFFC0C0FFF0FFFFFFF0B80FFFFFC0C0FFF0F00F00F0
            0B70FFFFC0C0FFF0FFFFFFFF0B80FFFFC0C0FFF0CCCCCCCCC0B70FFFC0C0FFFF
            CFFFFFFFF0B00FFFC0C0FFFFCF00F00F000110FFC0C0FFFFCFFFFFFFFF000FFF
            C0C0FFFFCCCCCCCCCCCCFFFFC0C0FFFFC8CC8CC8CC8CFFFFC0C0FFFFCCCCCCCC
            CCCCFFFFC0C0FFFFFFFFFFFFFFFFFFFFC0C0FFFFFFFFFFFFFFFFFFFFC0C0FFFF
            FFFFFFFFFFFFFFFFC0C0}
          OnClick = btnUpdateClick
        end
        object btnAdd: TSpeedButton
          Left = 32
          Top = 9
          Width = 75
          Height = 27
          Anchors = [akRight, akBottom]
          Caption = #26032#22686
          Flat = True
          Glyph.Data = {
            66010000424D6601000000000000760000002800000015000000140000000100
            040000000000F0000000130B0000130B00001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFF000FFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFF000FFFF
            FFFFFFFFFFFFFFFFF000FFFFF00000000000FFFFF000FFFFF0FFFFFFFFF0FFFF
            F000FFFFF0FFFFFFFFF0FFFFF000FFFFF0FFFFFFFFF0FFFFF000FFFFF0FFFFFF
            FFF0FFFFF000FFFFF0FFFFFFFFF0FFFFF000FFFFF0FFFFFFFFF0FFFFF000FFFF
            F0FFFFFFFFF0FFFFF000FFFFF0FFFFFFFFF0FFFFF000FFFFF0FFFFFF0000FFFF
            F000FFFFF0FFFFFF0F0FFFFFF000FFFFF0FFFFFF00FFFFFFF000FFFFF0000000
            0FFFFFFFF000FFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFF000FFFF
            FFFFFFFFFFFFFFFFF000}
          OnClick = btnAddClick
        end
        object btnDel: TSpeedButton
          Left = 204
          Top = 9
          Width = 75
          Height = 27
          Anchors = [akRight, akBottom]
          Caption = #21024#38500
          Flat = True
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
            FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF0000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00
            FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00
            FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
            000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
            0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
            000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00
            FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF0000000000000000000000000000000000FF00FF00FF00FF00FF00
            FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF0000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00
            FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
          OnClick = btnDelClick
        end
        object btnSave: TSpeedButton
          Left = 288
          Top = 9
          Width = 75
          Height = 27
          Anchors = [akRight, akBottom]
          Caption = #20445#23384
          Flat = True
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000FF00FF00FF00FF000000
            0000FFFF0000FFFF000000000000000000000000000000000000000000000000
            0000C6C6C600C6C6C60000000000FFFF000000000000FF00FF00FF00FF000000
            0000FFFF0000FFFF000000000000000000000000000000000000000000000000
            0000C6C6C600C6C6C60000000000FFFF000000000000FF00FF00FF00FF000000
            0000FFFF0000FFFF000000000000000000000000000000000000000000000000
            0000C6C6C600C6C6C60000000000FFFF000000000000FF00FF00FF00FF000000
            0000FFFF0000FFFF000000000000000000000000000000000000000000000000
            0000000000000000000000000000FFFF000000000000FF00FF00FF00FF000000
            0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
            0000FFFF0000FFFF0000FFFF0000FFFF000000000000FF00FF00FF00FF000000
            0000FFFF0000FFFF000000000000000000000000000000000000000000000000
            00000000000000000000FFFF0000FFFF000000000000FF00FF00FF00FF000000
            0000FFFF000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
            C600C6C6C600C6C6C60000000000FFFF000000000000FF00FF00FF00FF000000
            0000FFFF000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
            C600C6C6C600C6C6C60000000000FFFF000000000000FF00FF00FF00FF000000
            0000FFFF000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
            C600C6C6C600C6C6C60000000000FFFF000000000000FF00FF00FF00FF000000
            0000FFFF000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
            C600C6C6C600C6C6C60000000000FFFF000000000000FF00FF00FF00FF000000
            0000FFFF000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
            C600C6C6C600C6C6C600000000000000000000000000FF00FF00FF00FF000000
            0000FFFF000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
            C600C6C6C600C6C6C60000000000FF00FF0000000000FF00FF00FF00FF000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
          OnClick = btnSaveClick
        end
        object btnClose: TSpeedButton
          Left = 461
          Top = 9
          Width = 75
          Height = 27
          Anchors = [akRight, akBottom]
          Caption = #36864#20986
          Flat = True
          Glyph.Data = {
            42020000424D4202000000000000420000002800000010000000100000000100
            1000030000000002000000000000000000000000000000000000007C0000E003
            00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C0000004200001F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C00000042004200001F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C0000000000420042004200000000000000000000000000000000
            1F7C1F7C1F7C1F7C000000420042004200001F7C1F7C00001F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C000000420042000000001F7C1F7C00001F7C1F7C1F7C1F7C
            10001F7C1F7C1F7C000000420042004200001F7C1F7C00001F7C1F7C1F7C1000
            10001F7C1F7C1F7C000000420042004200001F7C1F7C00001F7C1F7C10001000
            1000100010001F7C000000420042004200001F7C1F7C00001F7C100010001000
            1000100010001F7C000000420042004200001F7C1F7C00001F7C1F7C10001000
            1000100010001F7C00000042004200001F7C1F7C1F7C00001F7C1F7C1F7C1000
            10001F7C1F7C1F7C0000004200001F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C
            10001F7C1F7C1F7C000000001F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C000000000000000000000000000000001F7C1F7C1F7C1F7C
            1F7C1F7C1F7C}
          OnClick = btnCloseClick
        end
        object btnCancel: TSpeedButton
          Left = 376
          Top = 9
          Width = 75
          Height = 27
          Anchors = [akRight, akBottom]
          Caption = #21462#28040
          Flat = True
          OnClick = btnCancelClick
        end
      end
    end
  end
  object cdsFnOperationHdrList: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 472
    Top = 16
  end
  object cdsFnProductionParameter: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdsFnProductionParameterAfterScroll
    Left = 280
    Top = 352
  end
  object dsFnProductionParameter: TDataSource
    DataSet = cdsFnProductionParameter
    Left = 320
    Top = 352
  end
end

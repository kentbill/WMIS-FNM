object OperationForm: TOperationForm
  Left = 141
  Top = 82
  Width = 757
  Height = 591
  Caption = 'OperationForm'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 749
    Height = 265
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #26032#23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      749
      265)
    object Label1: TLabel
      Left = 8
      Top = 208
      Width = 54
      Height = 12
      Caption = #24037#24207#32534#21495':'
    end
    object Label2: TLabel
      Left = 192
      Top = 208
      Width = 54
      Height = 12
      Caption = #24037#24207#31867#22411':'
    end
    object Label3: TLabel
      Left = 376
      Top = 208
      Width = 54
      Height = 12
      Caption = #20013#25991#21517#31216':'
    end
    object Label4: TLabel
      Left = 560
      Top = 208
      Width = 54
      Height = 12
      Caption = #33521#25991#21517#31216':'
    end
    object btnAdd: TSpeedButton
      Left = 421
      Top = 232
      Width = 80
      Height = 25
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
    end
    object btnEdit: TSpeedButton
      Left = 501
      Top = 232
      Width = 80
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #32534#36753
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
    end
    object btnDelete: TSpeedButton
      Left = 581
      Top = 232
      Width = 80
      Height = 25
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
    end
    object btnSave: TSpeedButton
      Left = 662
      Top = 232
      Width = 80
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #20445#23384
      Enabled = False
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
    end
    object cxGrid1: TcxGrid
      Left = 1
      Top = 1
      Width = 747
      Height = 192
      Align = alTop
      TabOrder = 0
      object cxGrid1TV: TcxGridDBTableView
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1TV
      end
    end
    object DBEdit1: TDBEdit
      Left = 64
      Top = 200
      Width = 120
      Height = 20
      Color = clBtnFace
      DataField = 'Operation_Code'
      DataSource = dsOperationHdr
      ReadOnly = True
      TabOrder = 1
    end
    object DBComboBox1: TDBComboBox
      Left = 248
      Top = 200
      Width = 120
      Height = 20
      DataField = 'Operation_Type'
      DataSource = dsOperationHdr
      ItemHeight = 12
      TabOrder = 2
    end
    object DBEdit2: TDBEdit
      Left = 432
      Top = 200
      Width = 120
      Height = 20
      DataField = 'Operation_CHN'
      DataSource = dsOperationHdr
      TabOrder = 3
    end
    object DBEdit3: TDBEdit
      Left = 616
      Top = 200
      Width = 120
      Height = 20
      DataField = 'Operation_ENG'
      DataSource = dsOperationHdr
      TabOrder = 4
    end
    object DBCheckBox1: TDBCheckBox
      Left = 19
      Top = 234
      Width = 93
      Height = 17
      Anchors = [akRight, akBottom]
      Caption = #26159#21542#22806#21457#24037#24207
      DataField = 'Is_SC'
      DataSource = dsOperationHdr
      TabOrder = 5
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object DBCheckBox2: TDBCheckBox
      Left = 147
      Top = 234
      Width = 111
      Height = 17
      Anchors = [akRight, akBottom]
      Caption = #26159#21542#38656#35201#25490#35745#21010
      DataField = 'Is_Schedule'
      DataSource = dsOperationHdr
      TabOrder = 6
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object DBCheckBox3: TDBCheckBox
      Left = 291
      Top = 234
      Width = 73
      Height = 17
      Anchors = [akRight, akBottom]
      Caption = #26159#21542#26377#25928
      DataField = 'Is_Active'
      DataSource = dsOperationHdr
      TabOrder = 7
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 265
    Width = 749
    Height = 299
    Align = alClient
    Caption = 'GroupBox1'
    TabOrder = 1
    DesignSize = (
      749
      299)
    object Label5: TLabel
      Left = 8
      Top = 200
      Width = 42
      Height = 12
      Caption = #21442#25968#21517':'
    end
    object Label6: TLabel
      Left = 192
      Top = 200
      Width = 42
      Height = 12
      Caption = #33521#25991#21517':'
    end
    object Label7: TLabel
      Left = 376
      Top = 200
      Width = 54
      Height = 12
      Caption = #20351#29992#37096#38376':'
    end
    object Label8: TLabel
      Left = 560
      Top = 200
      Width = 42
      Height = 12
      Caption = #26522#20030#20540':'
    end
    object Label9: TLabel
      Left = 8
      Top = 232
      Width = 42
      Height = 12
      Caption = #40664#35748#20540':'
    end
    object Label10: TLabel
      Left = 192
      Top = 232
      Width = 42
      Height = 12
      Caption = #20540#31867#22411':'
    end
    object Label11: TLabel
      Left = 376
      Top = 232
      Width = 30
      Height = 12
      Caption = #21333#20301':'
    end
    object sbAdd: TSpeedButton
      Left = 421
      Top = 264
      Width = 80
      Height = 25
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
    end
    object sbEdit: TSpeedButton
      Left = 501
      Top = 264
      Width = 80
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #32534#36753
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
    end
    object sbDelete: TSpeedButton
      Left = 581
      Top = 264
      Width = 80
      Height = 25
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
    end
    object sbSave: TSpeedButton
      Left = 662
      Top = 264
      Width = 80
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #20445#23384
      Enabled = False
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
    end
    object lvDetail: TListView
      Left = 2
      Top = 14
      Width = 745
      Height = 170
      Align = alTop
      Columns = <
        item
          Caption = #24037#24207#20195#30721
          Width = 0
        end
        item
          Caption = #21442#25968#21517
        end
        item
          Caption = #33521#25991#21517
        end
        item
          Caption = #20351#29992#37096#38376
          Width = 60
        end
        item
          Caption = #26522#20030#20540
        end
        item
          Caption = #40664#35748#20540
        end
        item
          Caption = #20540#31867#22411
        end
        item
          Caption = #21333#20301
          Width = 40
        end
        item
          Caption = #26631#20934#24037#33402#26174#31034
          Width = 85
        end
        item
          Caption = #23454#38469#24037#33402#26174#31034
          Width = 85
        end
        item
          Caption = #25163#32455#26495#26174#31034
          Width = 85
        end
        item
          Caption = #22238#20462#24037#33402#26174#31034
          Width = 85
        end
        item
          Caption = #24037#33402#22238#39038#26174#31034
          Width = 85
        end
        item
          Caption = #25490#35745#21010#26174#31034
          Width = 85
        end>
      ColumnClick = False
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #26032#23435#20307
      Font.Style = []
      RowSelect = True
      ParentFont = False
      TabOrder = 0
      ViewStyle = vsReport
    end
    object Edit1: TEdit
      Left = 64
      Top = 192
      Width = 120
      Height = 20
      TabOrder = 1
      Text = 'Edit1'
    end
    object Edit2: TEdit
      Left = 248
      Top = 192
      Width = 120
      Height = 20
      TabOrder = 2
      Text = 'Edit2'
    end
    object Edit3: TEdit
      Left = 432
      Top = 192
      Width = 120
      Height = 20
      TabOrder = 3
      Text = 'Edit3'
    end
    object Edit4: TEdit
      Left = 616
      Top = 192
      Width = 120
      Height = 20
      TabOrder = 4
      Text = 'Edit4'
    end
    object Edit5: TEdit
      Left = 432
      Top = 224
      Width = 120
      Height = 20
      TabOrder = 5
      Text = 'Edit5'
    end
    object Edit6: TEdit
      Left = 64
      Top = 224
      Width = 120
      Height = 20
      TabOrder = 6
      Text = 'Edit6'
    end
    object ComboBox1: TComboBox
      Left = 248
      Top = 224
      Width = 120
      Height = 20
      ItemHeight = 12
      TabOrder = 7
      Text = 'ComboBox1'
    end
    object GroupBox2: TGroupBox
      Left = 7
      Top = 251
      Width = 411
      Height = 41
      Caption = #26159#21542#26174#31034
      TabOrder = 8
      object CheckBox1: TCheckBox
        Left = 78
        Top = 16
        Width = 73
        Height = 17
        Caption = #23454#38469#24037#33402
        TabOrder = 0
      end
      object CheckBox3: TCheckBox
        Left = 6
        Top = 16
        Width = 73
        Height = 17
        Caption = #26631#20934#24037#33402
        TabOrder = 1
      end
      object CheckBox2: TCheckBox
        Left = 150
        Top = 16
        Width = 57
        Height = 17
        Caption = #25163#32455#26495
        TabOrder = 2
      end
      object CheckBox4: TCheckBox
        Left = 206
        Top = 16
        Width = 81
        Height = 17
        Caption = #22238#20462#24037#33402
        TabOrder = 3
      end
      object CheckBox5: TCheckBox
        Left = 278
        Top = 16
        Width = 73
        Height = 17
        Caption = #24037#33402#22238#39038
        TabOrder = 4
      end
      object CheckBox6: TCheckBox
        Left = 350
        Top = 16
        Width = 56
        Height = 17
        Caption = #25490#35745#21010
        TabOrder = 5
      end
    end
    object CheckBox7: TCheckBox
      Left = 616
      Top = 227
      Width = 97
      Height = 17
      Caption = #26159#21542#26377#25928
      TabOrder = 9
    end
  end
  object dsOperationHdr: TDataSource
    Left = 264
    Top = 112
  end
end

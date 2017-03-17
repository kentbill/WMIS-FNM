object SendInfoManageForm: TSendInfoManageForm
  Left = 320
  Top = 171
  Width = 917
  Height = 533
  Caption = #25910#36865#31649#29702
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object TGroupBox
    Left = 0
    Top = 0
    Width = 909
    Height = 285
    Align = alClient
    TabOrder = 0
    object cxgrdSendInfo: TcxGrid
      Left = 2
      Top = 15
      Width = 905
      Height = 222
      Align = alClient
      TabOrder = 0
      object cxgdtvSendInfo: TcxGridDBTableView
        DataController.DataSource = dsSendInfo
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.MultiSelect = True
      end
      object cxgrdlvlSendInfo: TcxGridLevel
        GridView = cxgdtvSendInfo
      end
    end
    object GroupBox2: TGroupBox
      Left = 2
      Top = 237
      Width = 905
      Height = 46
      Align = alBottom
      TabOrder = 1
      object btn_AddCard: TSpeedButton
        Left = 260
        Top = 14
        Width = 75
        Height = 24
        Caption = #28155#21152'(&A)'
        Flat = True
        OnClick = btn_AddCardClick
      end
      object btn_RemoveCard: TSpeedButton
        Left = 172
        Top = 14
        Width = 75
        Height = 24
        Caption = #21024#38500'(&D)'
        Flat = True
        OnClick = btn_RemoveCardClick
      end
      object btn_Refefesh: TSpeedButton
        Left = 388
        Top = 14
        Width = 75
        Height = 24
        Caption = #21047#26032'(&R)'
        Flat = True
        OnClick = btn_RefefeshClick
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 285
    Width = 909
    Height = 214
    Align = alBottom
    Caption = #24050#35013#36710
    TabOrder = 1
    DesignSize = (
      909
      214)
    object btn_Save: TBitBtn
      Left = 742
      Top = 180
      Width = 58
      Height = 25
      Anchors = [akRight, akBottom]
      BiDiMode = bdLeftToRight
      Caption = #20445#23384'(&S)'
      Default = True
      Enabled = False
      ParentBiDiMode = False
      TabOrder = 0
      OnClick = btn_SaveClick
    end
    object btnCancel: TBitBtn
      Left = 666
      Top = 180
      Width = 58
      Height = 25
      Anchors = [akRight, akBottom]
      BiDiMode = bdLeftToRight
      Caption = #25764#28040'(&C)'
      Default = True
      Enabled = False
      ParentBiDiMode = False
      TabOrder = 1
      Visible = False
      OnClick = btnCancelClick
    end
    object btn_Exit: TBitBtn
      Left = 822
      Top = 179
      Width = 58
      Height = 25
      Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
      Anchors = [akRight, akBottom]
      BiDiMode = bdLeftToRight
      Cancel = True
      Caption = #36864#20986'(&X)'
      ParentBiDiMode = False
      TabOrder = 2
    end
    object lv_Load: TListView
      Left = 2
      Top = 15
      Width = 905
      Height = 154
      Align = alTop
      Columns = <
        item
          Caption = #36865#24067#21333#21495
          Width = 100
        end
        item
          Caption = #36865#24067#22320#28857
          Width = 200
        end>
      GridLines = True
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 3
      ViewStyle = vsReport
    end
  end
  object dsSendInfo: TDataSource
    DataSet = cdsSendInfo
    Left = 128
    Top = 80
  end
  object cdsSendInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 80
    Top = 80
  end
end

object CheckArtForm: TCheckArtForm
  Left = 565
  Top = 181
  BorderStyle = bsDialog
  Caption = 'CheckArtForm'
  ClientHeight = 438
  ClientWidth = 346
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 346
    Height = 393
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object vlelist: TValueListEditor
      Left = 0
      Top = 0
      Width = 346
      Height = 393
      Align = alClient
      Ctl3D = False
      DefaultRowHeight = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      Strings.Strings = (
        's=2'
        'a=1'
        'b=3'
        'c=4'
        'd=5'
        'e=6'
        'f=7'
        'g=8')
      TabOrder = 0
      TitleCaptions.Strings = (
        #21442#25968#21517
        #21442#25968#20540)
      OnDrawCell = vlelistDrawCell
      OnGetPickList = vlelistGetPickList
      OnKeyPress = vlelistKeyPress
      ColWidths = (
        106
        236)
    end
  end
  object pnl2: TPanel
    Left = 0
    Top = 393
    Width = 346
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnSave: TButton
      Left = 72
      Top = 13
      Width = 75
      Height = 25
      Caption = #30830#35748
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnCancel: TButton
      Left = 168
      Top = 14
      Width = 75
      Height = 25
      Caption = #21462#28040
      ModalResult = 2
      TabOrder = 1
    end
  end
  object cdsList: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 128
    Top = 280
  end
  object cdsItemPickList: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 240
    Top = 280
  end
end

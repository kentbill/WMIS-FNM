object WebQueryForm: TWebQueryForm
  Left = 9
  Top = 110
  Width = 812
  Height = 521
  Caption = #32593#39029#26597#35810
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
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 804
    Height = 28
    Align = alTop
    BevelInner = bvLowered
    Caption = 'pnl1'
    TabOrder = 0
    object lblAddress: TLabel
      Left = 5
      Top = 7
      Width = 38
      Height = 13
      Alignment = taCenter
      Caption = #22320#22336'(&D)'
    end
    object btnQuery: TSpeedButton
      Left = 677
      Top = 2
      Width = 23
      Height = 22
      Hint = #21047#26032
      Flat = True
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FF00FF00FF00FF00FF00
        FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
        FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000840000FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
        FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000084000000840000FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
        FF0000000000FFFFFF00FFFFFF00FFFFFF000084000000840000008400000084
        000000840000FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
        FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000084000000840000FFFF
        FF00FFFFFF0000840000FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
        FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000840000FFFF
        FF00FFFFFF0000840000FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
        FF0000000000FFFFFF00FFFFFF0000840000FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF0000840000FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
        FF0000000000FFFFFF00FFFFFF0000840000FFFFFF00FFFFFF0000840000FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
        FF0000000000FFFFFF00FFFFFF0000840000FFFFFF00FFFFFF00008400000084
        0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
        FF0000000000FFFFFF00FFFFFF00FFFFFF000084000000840000008400000084
        000000840000FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
        FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00008400000084
        0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
        FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000840000FFFF
        FF00FFFFFF0000000000000000000000000000000000FF00FF00FF00FF00FF00
        FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF0000000000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00
        FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000000000000000000000000000000000000000000000000000
        00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentFont = False
      OnClick = btnQueryClick
    end
    object btnStop: TSpeedButton
      Left = 700
      Top = 2
      Width = 23
      Height = 22
      Hint = #20572#27490
      Flat = True
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777770000007777777770999999077777771999999990777771999999999
        90777199FFF99FFF990771999FFFFFF99907719999FFFF999907719999FFFF99
        990771999FFFFFF9990771B9FFF99FFF9907771B9999999990777771B9999999
        077777771B999991777777777111111777777777777777777777}
      ParentFont = False
      OnClick = btnStopClick
    end
    object btnClose: TSpeedButton
      Left = 723
      Top = 2
      Width = 23
      Height = 22
      Hint = #36864#20986
      Flat = True
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
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
      ParentFont = False
      OnClick = btnStopClick
    end
    object cbbAddress: TComboBoxEx
      Left = 49
      Top = 2
      Width = 624
      Height = 22
      ItemsEx.CaseSensitive = False
      ItemsEx.SortType = stText
      ItemsEx = <>
      StyleEx = []
      ItemHeight = 16
      TabOrder = 0
      OnKeyDown = cbbAddressKeyDown
      OnSelect = btnQueryClick
      DropDownCount = 8
    end
  end
  object pnl2: TPanel
    Left = 0
    Top = 28
    Width = 804
    Height = 466
    Align = alClient
    BevelInner = bvSpace
    BevelOuter = bvLowered
    Caption = 'pnl2'
    TabOrder = 1
    object WebBrowser1: TWebBrowser
      Left = 2
      Top = 2
      Width = 800
      Height = 462
      Align = alClient
      TabOrder = 0
      ControlData = {
        4C000000AF520000C02F00000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
end

object HLManageForm: THLManageForm
  Left = 172
  Top = 148
  BorderStyle = bsDialog
  Caption = #25163#32455#29256#31649#29702
  ClientHeight = 278
  ClientWidth = 489
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  object pgc_HLList: TPageControl
    Left = 0
    Top = 0
    Width = 489
    Height = 243
    Align = alClient
    TabIndex = 0
    TabOrder = 0
    OnChange = pgc_HLListChange
    object TTabSheet
      Caption = #26410#25509#25910
      object tv_NOReceiveHLList: TTreeView
        Left = 0
        Top = 0
        Width = 481
        Height = 216
        Align = alClient
        Indent = 19
        TabOrder = 0
      end
    end
    object ts_Only: TTabSheet
      Caption = #24050#25509#25910
      ImageIndex = 1
      object tv_NoSendHLList: TTreeView
        Left = 0
        Top = 0
        Width = 481
        Height = 216
        Align = alClient
        Indent = 19
        TabOrder = 0
      end
    end
  end
  object pnl_Only: TPanel
    Left = 0
    Top = 243
    Width = 489
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      489
      35)
    object btn_Help: TBitBtn
      Left = 8
      Top = 5
      Width = 75
      Height = 25
      Caption = #24110#21161'(&H)'
      TabOrder = 0
    end
    object btn_Receive_SendHL: TBitBtn
      Left = 314
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #25509#25910'(&R)'
      TabOrder = 1
      OnClick = btn_Receive_SendHLClick
    end
    object btn_Exit: TBitBtn
      Left = 405
      Top = 5
      Width = 75
      Height = 25
      Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #36864#20986'(&X)'
      TabOrder = 2
      OnClick = btn_ExitClick
    end
  end
end

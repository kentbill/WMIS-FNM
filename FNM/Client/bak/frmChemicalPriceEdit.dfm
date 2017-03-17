object ChemicalPriceEditForm: TChemicalPriceEditForm
  Left = 289
  Top = 259
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #21270#24037#26009#20215#26684#20462#25913
  ClientHeight = 201
  ClientWidth = 378
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 12
  object txt2: TStaticText
    Left = 66
    Top = 52
    Width = 58
    Height = 16
    Caption = #21333#20215'(&P):'
    TabOrder = 11
  end
  object txt4: TStaticText
    Left = 66
    Top = 106
    Width = 82
    Height = 16
    Caption = #32467#26463#26085#26399'(&E):'
    TabOrder = 10
  end
  object txt3: TStaticText
    Left = 66
    Top = 80
    Width = 82
    Height = 16
    Caption = #36215#22987#26085#26399'(&S):'
    TabOrder = 7
  end
  object pnl_Only: TPanel
    Left = 0
    Top = 171
    Width = 378
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    DesignSize = (
      378
      30)
    object btn_Cancel: TButton
      Left = 290
      Top = 3
      Width = 75
      Height = 25
      Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #36864#20986'(&X)'
      ModalResult = 2
      TabOrder = 2
    end
    object btn_Help: TButton
      Left = 8
      Top = 3
      Width = 75
      Height = 25
      Caption = #24110#21161'(&H)'
      Enabled = False
      TabOrder = 0
    end
    object btn1: TButton
      Left = 202
      Top = 3
      Width = 75
      Height = 25
      Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
      Anchors = [akRight, akBottom]
      Caption = #20445#23384'(&S)'
      Default = True
      ModalResult = 1
      TabOrder = 1
    end
  end
  object TPanel
    Left = 0
    Top = 168
    Width = 378
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
  end
  object txt1: TStaticText
    Left = 66
    Top = 24
    Width = 70
    Height = 16
    Caption = #21270#24037#26009'(&C):'
    TabOrder = 8
  end
  object cbb_ChemicalName: TComboBox
    Left = 143
    Top = 16
    Width = 145
    Height = 20
    ItemHeight = 12
    TabOrder = 0
  end
  object dtp_ChemicalInBeginDate: TDateTimePicker
    Left = 143
    Top = 72
    Width = 145
    Height = 20
    CalAlignment = dtaLeft
    Date = 38462.4077495833
    Time = 38462.4077495833
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 2
  end
  object dtp_ChemicalInEndDate: TDateTimePicker
    Left = 143
    Top = 98
    Width = 145
    Height = 20
    CalAlignment = dtaLeft
    Date = 38462.4077495833
    Time = 38462.4077495833
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 3
  end
  object txt5: TStaticText
    Left = 66
    Top = 151
    Width = 238
    Height = 16
    Caption = #25552#31034':'#24050#25552#20132#20250#35745#25253#34920#30340#21270#24037#26009#21333#20215#19981#33021#20462#25913
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object edt1: TEdit
    Left = 143
    Top = 44
    Width = 145
    Height = 20
    TabOrder = 1
  end
  object chk1: TCheckBox
    Left = 148
    Top = 127
    Width = 97
    Height = 17
    Caption = #20316#20026#24403#21069#20215#26684
    TabOrder = 4
  end
end

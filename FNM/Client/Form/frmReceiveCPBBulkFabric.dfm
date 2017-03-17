inherited ReceiveCPBBulkFabricForm: TReceiveCPBBulkFabricForm
  Left = 290
  Top = 43
  Width = 925
  Caption = #25509#25910#22797#29256#24067
  OldCreateOrder = True
  WindowState = wsMaximized
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object PanelLeft: TPanel
    Left = 0
    Top = 0
    Width = 41
    Height = 442
    Align = alLeft
    TabOrder = 0
    Visible = False
  end
  object PanelRight: TPanel
    Left = 41
    Top = 0
    Width = 868
    Height = 442
    Align = alClient
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 1
      Top = 265
      Width = 866
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object PanelHead: TPanel
      Left = 1
      Top = 1
      Width = 866
      Height = 264
      Align = alTop
      TabOrder = 0
      object lbGF_NO: TLabel
        Left = 8
        Top = 16
        Width = 36
        Height = 12
        Caption = 'GF_NO:'
      end
      object Label1: TLabel
        Left = 8
        Top = 48
        Width = 30
        Height = 12
        Caption = #33394#21495':'
      end
      object Label2: TLabel
        Left = 184
        Top = 48
        Width = 24
        Height = 12
        Caption = 'RGB:'
      end
      object Label3: TLabel
        Left = 367
        Top = 48
        Width = 30
        Height = 12
        Caption = #21697#21517':'
      end
      object Label4: TLabel
        Left = 558
        Top = 48
        Width = 54
        Height = 12
        Caption = #32452#32455#35268#26684':'
      end
      object Label5: TLabel
        Left = 8
        Top = 72
        Width = 30
        Height = 12
        Caption = #23458#25143':'
      end
      object Label6: TLabel
        Left = 184
        Top = 72
        Width = 30
        Height = 12
        Caption = #25968#37327':'
      end
      object Label7: TLabel
        Left = 367
        Top = 72
        Width = 30
        Height = 12
        Caption = #20132#26399':'
      end
      object Label8: TLabel
        Left = 558
        Top = 72
        Width = 66
        Height = 12
        Caption = #19978#24037#24207#26102#38388':'
      end
      object Label9: TLabel
        Left = 558
        Top = 96
        Width = 54
        Height = 12
        Caption = #25910#24067#26102#38388':'
      end
      object Label10: TLabel
        Left = 8
        Top = 96
        Width = 30
        Height = 12
        Caption = #30721#38271':'
      end
      object Label11: TLabel
        Left = 367
        Top = 96
        Width = 42
        Height = 12
        Caption = #25910#24067#20154':'
      end
      object Label12: TLabel
        Left = 184
        Top = 96
        Width = 42
        Height = 12
        Caption = #36711#20313#29575':'
      end
      object Label13: TLabel
        Left = 8
        Top = 121
        Width = 30
        Height = 12
        Caption = #30333#24230':'
      end
      object Label14: TLabel
        Left = 184
        Top = 121
        Width = 42
        Height = 12
        Caption = #27611#25928#24038':'
      end
      object Label15: TLabel
        Left = 367
        Top = 121
        Width = 42
        Height = 12
        Caption = #27611#25928#20013':'
      end
      object Label16: TLabel
        Left = 558
        Top = 121
        Width = 42
        Height = 12
        Caption = #27611#25928#21491':'
      end
      object Label17: TLabel
        Left = 8
        Top = 145
        Width = 42
        Height = 12
        Caption = #33639#20809#37327':'
      end
      object Label18: TLabel
        Left = 8
        Top = 177
        Width = 30
        Height = 12
        Caption = #22791#27880':'
      end
      object Label19: TLabel
        Left = 184
        Top = 145
        Width = 42
        Height = 12
        Caption = #24405#20837#20154':'
      end
      object Label20: TLabel
        Left = 367
        Top = 145
        Width = 54
        Height = 12
        Caption = #24405#20837#26102#38388':'
      end
      object EdtQryGF_NO: TEdit
        Left = 56
        Top = 12
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        TabOrder = 0
        OnKeyDown = EdtQryGF_NOKeyDown
      end
      object btSearch: TButton
        Left = 192
        Top = 10
        Width = 68
        Height = 23
        Caption = #26597#35810
        TabOrder = 1
        OnClick = btSearchClick
      end
      object edtFN_Color_Code: TEdit
        Left = 56
        Top = 43
        Width = 121
        Height = 20
        TabStop = False
        Color = clBtnShadow
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        ReadOnly = True
        TabOrder = 2
      end
      object edtRGB: TEdit
        Left = 230
        Top = 43
        Width = 121
        Height = 20
        TabStop = False
        Color = clBtnShadow
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        ReadOnly = True
        TabOrder = 3
      end
      object edtGF_NO: TEdit
        Left = 423
        Top = 43
        Width = 121
        Height = 20
        TabStop = False
        Color = clBtnShadow
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        ReadOnly = True
        TabOrder = 4
      end
      object edtConstruction: TEdit
        Left = 627
        Top = 43
        Width = 121
        Height = 20
        TabStop = False
        Color = clBtnShadow
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        ReadOnly = True
        TabOrder = 5
      end
      object edtCustomer: TEdit
        Left = 56
        Top = 67
        Width = 121
        Height = 20
        TabStop = False
        Color = clBtnShadow
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        ReadOnly = True
        TabOrder = 6
      end
      object edtQty: TEdit
        Left = 230
        Top = 67
        Width = 121
        Height = 20
        TabStop = False
        Color = clBtnShadow
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        ReadOnly = True
        TabOrder = 7
      end
      object edtDelivery_Date: TEdit
        Left = 423
        Top = 67
        Width = 121
        Height = 20
        TabStop = False
        Color = clBtnShadow
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        ReadOnly = True
        TabOrder = 8
      end
      object edtLast_End_Time: TEdit
        Left = 627
        Top = 67
        Width = 121
        Height = 20
        TabStop = False
        Color = clBtnShadow
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        ReadOnly = True
        TabOrder = 9
      end
      object edtReceiveTime: TEdit
        Left = 627
        Top = 91
        Width = 121
        Height = 20
        TabStop = False
        Color = clBtnShadow
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        ReadOnly = True
        TabOrder = 13
      end
      object edtReceiveQuantity: TEdit
        Left = 56
        Top = 91
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        TabOrder = 10
      end
      object edtCHM_Rate: TEdit
        Left = 231
        Top = 91
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        TabOrder = 11
      end
      object edtwhiteness: TEdit
        Left = 56
        Top = 116
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        TabOrder = 14
      end
      object edtHairEffectLeft: TEdit
        Left = 230
        Top = 116
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        TabOrder = 15
      end
      object edtHairEffectEentre: TEdit
        Left = 423
        Top = 116
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        TabOrder = 16
      end
      object edtHairEffectRight: TEdit
        Left = 627
        Top = 116
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        TabOrder = 17
      end
      object edtFluorescenceQty: TEdit
        Left = 56
        Top = 140
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        TabOrder = 18
      end
      object edtOperator_Time: TEdit
        Left = 423
        Top = 140
        Width = 121
        Height = 20
        TabStop = False
        Color = clBtnShadow
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        ReadOnly = True
        TabOrder = 20
      end
      object cbReceiver: TComboBox
        Left = 423
        Top = 91
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        ItemHeight = 12
        TabOrder = 12
      end
      object cbOperator: TComboBox
        Left = 230
        Top = 139
        Width = 121
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        ItemHeight = 12
        TabOrder = 19
      end
      object edtRemark: TMemo
        Left = 56
        Top = 168
        Width = 369
        Height = 81
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        TabOrder = 21
      end
      object btSave: TButton
        Left = 272
        Top = 10
        Width = 68
        Height = 23
        Caption = #20445#23384'(&S)'
        TabOrder = 22
        OnClick = btSaveClick
      end
    end
    object PanelBody: TPanel
      Left = 1
      Top = 268
      Width = 866
      Height = 173
      Align = alClient
      TabOrder = 1
      object cxGrid1: TcxGrid
        Left = 1
        Top = 1
        Width = 864
        Height = 171
        Align = alClient
        TabOrder = 0
        TabStop = False
        object cxGridReceiveCPBFabricTask: TcxGridDBTableView
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OnCustomDrawCell = cxGridReceiveCPBFabricTaskCustomDrawCell
          OptionsView.GroupByBox = False
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = cxGridReceiveCPBFabricTask
        end
      end
    end
  end
  object cdsReceiveCPBFabricTask: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdsReceiveCPBFabricTaskAfterScroll
    Left = 403
    Top = 269
  end
  object dsReceiveCPBFabricTask: TDataSource
    DataSet = cdsReceiveCPBFabricTask
    Left = 264
    Top = 272
  end
end

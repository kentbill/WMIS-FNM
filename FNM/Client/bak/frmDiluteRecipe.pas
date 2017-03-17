unit frmDiluteRecipe;
{*|<PRE>*****************************************************************************

       软件名称 FNM CLIENT MODEL
       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT
       单元名称 frmDiluteRecipe.pas
       创建日期
       创建人员
       修改人员
       修改日期
       修改原因
       对应用例
       字段描述
       相关数据库表
       调用重要函数/SQL对象说明
       功能描述

******************************************************************************}

interface

uses
  uFNMPrescriptionInfo, Windows, Messages, SysUtils, Variants,Dialogs,
  Classes, Controls, Forms, DB, DBClient, cxButtonEdit, cxSplitter,
  ComCtrls, StdCtrls, Grids, ValEdit, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxSpinEdit, Buttons, ExtCtrls, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGrid, cxGridDBTableView, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxDBData, DBCtrls, Mask, frmBase, DBGrids;

type
  TDiluteRecipeForm = class(TBaseForm)
    cdsBatchDtl: TClientDataSet;
    spl1: TSplitter;
    btn_Add_Chemical: TSpeedButton;
    btn_Del_Chemical: TSpeedButton;
    tv_ChemicalName: TTreeView;
    pnl_Only1: TPanel;
    spl3: TSplitter;
    Vle_Chemicallist: TValueListEditor;
    btn_Query: TSpeedButton;
    edt_RecipeNO: TEdit;
    btn_SaveRecipe: TSpeedButton;
    btn_Exit: TSpeedButton;
    pnl1: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    cdsBatchHdr: TClientDataSet;
    cdsBatchView: TClientDataSet;
    dsBatchView: TDataSource;
    lbl4: TLabel;
    lbl5: TLabel;
    grp2: TGroupBox;
    lst_StepList: TListBox;
    dsBatchHdr: TDataSource;
    dbedtOriVolume: TDBEdit;
    dbedtDecVolume: TDBEdit;
    dbedtIncVolume: TDBEdit;
    dbmmoRemark: TDBMemo;
    grp1: TGroupBox;
    cxgdBatchView: TcxGrid;
    cxgdBatchViewTV: TcxGridDBTableView;
    cxgdBatchViewLevel1: TcxGridLevel;
    grp3: TGroupBox;
    cxgdFNCard: TcxGrid;
    cxgdFNCardTV: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    dsFNCardInfo: TDataSource;
    cdsFNCardInfo: TClientDataSet;
    txtsedf1: TStaticText;
    cxSplitter1: TcxSplitter;
    btnNew: TSpeedButton;
    lbl6: TLabel;
    edtBatchNO: TEdit;
    lbl7: TLabel;
    edtStepID: TEdit;
    btnPrint: TSpeedButton;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Vle_ChemicallistValidate(Sender: TObject; ACol,
      ARow: Integer; const KeyName, KeyValue: String);
    procedure Vle_ChemicallistGetEditMask(Sender: TObject; ACol,
      ARow: Integer; var Value: String);
    procedure lst_StepListDblClick(Sender: TObject);
    procedure btn_SaveRecipeClick(Sender: TObject);
    procedure btn_QueryClick(Sender: TObject);
    procedure btn_Add_ChemicalClick(Sender: TObject);
    procedure btn_Del_ChemicalClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
  private
    { private declarations }
    IsNew: Integer;
    procedure GetDiluteRecipeInfo(Batch_NO: string);
    procedure SaveDiluteRecipeInfo;
    procedure GetFNCardInfoByRecipeNO(Recipe_NO: string);
  public
    { Public declarations }
  end;

var
  DiluteRecipeForm: TDiluteRecipeForm;

implementation

uses Math, StrUtils, ServerDllPub, uFNMArtInfo,uFNMResource ,
    uDictionary, uShowMessage, uLogin, UAppOption, uGlobal, UGridDecorator,
  rptDiluteRecipe;

{$R *.dfm}
procedure TDiluteRecipeForm.GetFNCardInfoByRecipeNO(Recipe_NO: string);
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
    FNMServerArtObj.GetFNCardsByRecipeNO(Recipe_NO,vData,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsFNCardInfo.Data := vData;
  finally
    ShowMsg('', crDefault);
  end;
  GridDecorator.BindCxViewWithDataSource(cxgdFNCardTV, dsFNCardInfo);
end;

procedure TDiluteRecipeForm.GetDiluteRecipeInfo(Batch_NO: string);
var
  vData0,vData1,vData2: OleVariant;
  sErrorMsg: WideString;
begin
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
    FNMServerArtObj.GetDiluteRecipeInfo(vData0,vData1,vData2,Batch_NO,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsBatchView.Data := vData0;
    cdsBatchHdr.Data := vData1;
    cdsBatchDtl.Data := vData2;
    if not cdsBatchHdr.IsEmpty then
    begin
      edtBatchNO.Text := cdsBatchHdr.FieldByName('Batch_NO').AsString;
      edtStepID.Text := cdsBatchHdr.FieldByName('Step_ID').AsString;
    end;
  finally
    ShowMsg('', crDefault);
  end;
  GridDecorator.BindCxViewWithDataSource(cxgdBatchViewTV, dsBatchView);
  if cdsBatchView.FindField('Step_ID') = nil then Exit;
  with cxgdBatchViewTV.GetColumnByFieldName('Step_ID') do
  begin
    GroupIndex := 0;
    Visible := False;
  end;
end;

procedure TDiluteRecipeForm.SaveDiluteRecipeInfo;
var
  vData0,vData1: OleVariant;
  sErrorMsg: WideString;
begin
  if (not cdsBatchHdr.Active) or cdsBatchHdr.IsEmpty then Exit;
  if cdsBatchHdr.State in [dsEdit] then cdsBatchHdr.Post;
  if (not cdsBatchDtl.Active) or cdsBatchDtl.IsEmpty then Exit;
  if cdsBatchDtl.State in [dsInsert,dsEdit] then cdsBatchHdr.Post;
  if (cdsBatchHdr.ChangeCount = 0) and (cdsBatchDtl.ChangeCount = 0) then Exit;

  cdsBatchHdr.MergeChangeLog;
  cdsBatchDtl.MergeChangeLog;
  vData0 := VarArrayCreate([0, 1], VarVariant);
  vData0[0] := varArrayOf([cdsBatchHdr.FieldByName('Batch_NO').AsString,
                           cdsBatchHdr.FieldByName('Step_ID').AsInteger,
                           cdsBatchHdr.FieldByName('Ori_Volume').AsInteger,
                           cdsBatchHdr.FieldByName('Dec_Volume').AsInteger,
                           cdsBatchHdr.FieldByName('Inc_Volume').AsInteger,
                           cdsBatchHdr.FieldByName('Remark').AsString,
                           Login.LoginID]);
  vData1 := cdsBatchDtl.Data;;
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
    FNMServerArtObj.SaveDiluteRecipeInfo(IsNew,vData0,vData1,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TMsgDialog.ShowMsgDialog('保存数据成功',mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TDiluteRecipeForm.FormCreate(Sender: TObject);
begin
  btn_Query.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  btn_Add_Chemical.Glyph.LoadFromResourceName(HInstance, RES_RIGHT);
  btn_Del_Chemical.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  btn_SaveRecipe.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btn_Exit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
end;

procedure TDiluteRecipeForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TDiluteRecipeForm.FormDestroy(Sender: TObject);
begin
  DiluteRecipeForm:=nil;
end;

procedure TDiluteRecipeForm.btn_SaveRecipeClick(Sender: TObject);
begin
  SaveDiluteRecipeInfo;
end;

procedure TDiluteRecipeForm.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TDiluteRecipeForm.FormActivate(Sender: TObject);
begin
  //填充可选化工料
  FillTreeItemsFromDataSetByClassField(Dictionary.cds_ChemicalList,
    'Chemical_Name', 'Chemical_Type','Chemical_ID', '', tv_ChemicalName.Items);
end;

procedure TDiluteRecipeForm.Vle_ChemicallistGetEditMask(
  Sender: TObject; ACol, ARow: Integer; var Value: String);
begin
  Value := '###.####';
end;

procedure TDiluteRecipeForm.Vle_ChemicallistValidate(Sender: TObject; ACol,
  ARow: Integer; const KeyName, KeyValue: String);
var
  tempe: Extended;
  Chemical_ID: Integer;
  Unit_QTY: string;
begin
  if not cdsBatchDtl.Active then Exit;

  Chemical_ID := Integer(Vle_Chemicallist.Strings.Objects[ARow-1]);
  Unit_QTY := StringReplace(KeyValue, ' ', '', [rfReplaceAll]);

  if not TryStrToFloat(Unit_QTY, tempe)then
    raise Exception.CreateResFmt(@INV_NOItemValue, ['Numeric', 'Numeric']);

  if tempe <= 0 then
    raise Exception.CreateResFmt(@INV_ValueIsLessThenZero, ['']);

  if cdsBatchDtl.Locate('Chemical_ID', Chemical_ID,[]) then
  begin
    cdsBatchDtl.Edit;
    cdsBatchDtl.FieldByName('Unit_QTY').AsString:=Unit_QTY;
  end else
    raise Exception.CreateRes(@DataError);
end;

procedure TDiluteRecipeForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Sender = lst_StepList then
  case Key of
    VK_RETURN: lst_StepListDblClick(nil);
  end;

  if Sender = tv_ChemicalName then
  case Key of
    VK_RETURN: btn_Add_Chemical.Click;
  end;
end;

procedure TDiluteRecipeForm.lst_StepListDblClick(Sender: TObject);
begin
  if lst_StepList.Items.Count = 0 then Exit;

  GetDiluteRecipeInfo(lst_StepList.Items[lst_StepList.ItemIndex]);
  FillItemsFromDataSet(cdsBatchDtl, 'Chemical_Name', 'Unit_QTY', 'Chemical_ID' ,
    '=', Vle_Chemicallist.Strings);
  IsNew := 0;
end;

procedure TDiluteRecipeForm.btn_QueryClick(Sender: TObject);
begin
  inherited;
  if edt_RecipeNO.Text = ''  then Exit;
  lst_StepList.Items.Text := Dictionary.GetItemList('化料缸稀释',edt_RecipeNO.Text,
    Login.CurrentDepartment);
  GetFNCardInfoByRecipeNO(edt_RecipeNO.Text);
end;

procedure TDiluteRecipeForm.btn_Add_ChemicalClick(Sender: TObject);
var
  Chemical_ID:Integer;
begin
  inherited;
  if (tv_ChemicalName.Selected = nil) or (tv_ChemicalName.Selected.Level = 0) then Exit;
  if not cdsBatchDtl.Active then Exit;
  Chemical_ID:=Integer(tv_ChemicalName.Selected.Data);
  with Dictionary.cds_ChemicalList do
  begin
    try
      cdsBatchDtl.DisableControls;
      if Locate('Chemical_ID', Chemical_ID,[]) then
      begin
        if not cdsBatchDtl.Locate('Chemical_ID', Chemical_ID,[])then
        begin
          cdsBatchDtl.Append;
          cdsBatchDtl['Batch_NO']:= cdsBatchHdr['Batch_NO'];
          cdsBatchDtl['Step_ID']:= cdsBatchHdr['Step_ID'];
          cdsBatchDtl['Chemical_ID']:=Chemical_ID;
          cdsBatchDtl['Chemical_Name']:=FieldByName('Chemical_Name').AsString;
          cdsBatchDtl['Unit']:=FieldByName('Unit').AsString;
        end
      end else
        TMsgDialog.ShowMsgDialog(GetResourceString(@InvalidChemical_ID),2500);
    finally
      cdsBatchDtl.EnableControls;
    end;
  end;
  FillItemsFromDataSet(cdsBatchDtl, 'Chemical_Name', 'Unit_QTY', 'Chemical_ID' ,
    '=', Vle_Chemicallist.Strings)
end;

procedure TDiluteRecipeForm.btn_Del_ChemicalClick(Sender: TObject);
var
  Chemical_ID:Integer;
begin
  inherited;
  if (Vle_Chemicallist.Strings.Count = 0) or (Vle_Chemicallist.Row = 0) then Exit;
  if not cdsBatchDtl.Active then Exit;

  Chemical_ID:=Integer(Vle_Chemicallist.Strings.Objects[Vle_Chemicallist.Row - 1]);
  if cdsBatchDtl.Locate('Chemical_ID', Chemical_ID,[]) then cdsBatchDtl.Delete;
  FillItemsFromDataSet(cdsBatchDtl, 'Chemical_Name', 'Unit_QTY', 'Chemical_ID' ,
    '=', Vle_Chemicallist.Strings)
end;

procedure TDiluteRecipeForm.btnNewClick(Sender: TObject);
begin
  inherited;
  if (cdsBatchHdr.ChangeCount > 0) or (cdsBatchDtl.ChangeCount > 0) then
    if MessageDlg('数据已经更改,你需要保存数据吗?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      SaveDiluteRecipeInfo;
      Exit;
    end;

  if (not cdsBatchHdr.Active) or (not cdsBatchDtl.Active) then lst_StepListDblClick(nil);;
  if not cdsBatchHdr.Active then Exit;
  with cdsBatchHdr do
  begin
    Edit;
    FieldValues['Step_ID'] := FieldByName('Step_ID').AsInteger +1;
    FieldValues['Ori_Volume'] := FieldByName('Ori_Volume').AsInteger - FieldByName('Dec_Volume').AsInteger + FieldByName('Inc_Volume').AsInteger;
    FieldValues['Dec_Volume'] := 0;
    FieldValues['Inc_Volume'] := 0;
    Post;
  end;
  cdsBatchDtl.EmptyDataSet;
  IsNew := 14;
end;

procedure TDiluteRecipeForm.btnPrintClick(Sender: TObject);
var BatchNO: string;
begin
  inherited;
  BatchNO := edtBatchNO.Text+','+edtStepID.Text;
  if Trim(BatchNO) = ',' then Exit;
  PreViewDiluteRecipeReport(BatchNO);
end;

end.


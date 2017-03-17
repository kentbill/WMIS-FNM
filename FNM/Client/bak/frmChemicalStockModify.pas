unit frmChemicalStockModify;
{*|<PRE>*****************************************************************************
                                                                             
       软件名称 FNM CLIENT MODEL                                               
       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                              
       单元名称 frmChemicalStockModify.pas                                     
       创建日期 2004-11-10 16:57:20                                            
       创建人员 lvzd                                                           
       修改人员                                                                
       修改日期                                                                
       修改原因                                                                
       对应用例                                                                
       字段描述                                                                
       相关数据库表                                                            
       调用重要函数/SQL对象说明                                                
       功能描述 化工料库存修改单元
******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, StdCtrls, cxTextEdit, cxContainer, cxEdit,
  cxMaskEdit, cxSpinEdit, ComCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData,
  Grids, DBGrids;

type
  TChemicalStockModifyForm = class(TForm)
    pgc_Only: TPageControl;
    ts1: TTabSheet;
    pnl_Only: TPanel;
    cxSE_Quantity: TcxSpinEdit;
    cxSE_Price: TcxSpinEdit;
    Grid_ChemicalInData: TcxGrid;
    GridView_ChemicalInData: TcxGridDBTableView;
    GridLevel_ChemicalInData: TcxGridLevel;
    ts2: TTabSheet;
    pnl2: TPanel;
    cxSE_OutQuantity: TcxSpinEdit;
    txt_Only: TStaticText;
    Grid_ChemicalOutData: TcxGrid;
    GridView_ChemicalOutData: TcxGridDBTableView;
    GridLevel_ChemicalOutData: TcxGridLevel;
    cds_ChemicalInData: TClientDataSet;
    ds_ChemicalInData: TDataSource;
    cds_ChemicalOutData: TClientDataSet;
    ds_ChemicalOutData: TDataSource;
    cbb_Source: TComboBox;
    cbb_Destination: TComboBox;
    edt_ChemicalNameIn: TEdit;
    edt_NoteNO: TEdit;
    edt_ChemicalNameOut: TEdit;
    btn2: TButton;
    btn_Exit: TButton;
    btn_Help: TButton;
    dtp_ChemicalInDate: TDateTimePicker;
    btn_Query: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_QueryClick(Sender: TObject);
    procedure btn_SaveRecordClick(Sender: TObject);
    procedure AfterScrollData(DataSet: TDataSet);
  private
    { Private declarations }
    procedure ChangeEditControlEnable(DataSet: TDataSet; EnableEdit: Boolean);
    procedure GetChemicalInData;
    procedure GetChemicalOutData;
  public
    { Public declarations }
  end;

var
  ChemicalStockModifyForm: TChemicalStockModifyForm;

implementation

uses StrUtils, ServerDllPub, uAppOption, uFNMResource, uDictionary,
    uFNMArtInfo, uGridDecorator, uGlobal, uLogin;

{$R *.dfm}

procedure TChemicalStockModifyForm.ChangeEditControlEnable(DataSet: TDataSet; EnableEdit: Boolean);
begin
  if not EnableEdit then
  begin
    if DataSet = cds_ChemicalInData then
    begin
      cbb_Source.ItemIndex:=-1;
      cxSE_Price.Text:='0';
      cxSE_Quantity.Text:='0';
      edt_ChemicalNameIn.Text:='';
      edt_NoteNO.Text:='';
    end
    else//if DataSet = cds_ChemicalOutData then
    begin
      cbb_Destination.ItemIndex:=-1;
      cxSE_OutQuantity.Text:='0';
      edt_ChemicalNameOut.Text:='';
    end;
  end;

    if DataSet = cds_ChemicalInData then
    begin
      cbb_Source.Enabled:=EnableEdit;
      cxSE_Price.Enabled:=EnableEdit;
      cxSE_Quantity.Enabled:=EnableEdit;
      edt_ChemicalNameIn.Enabled:=EnableEdit;
      edt_NoteNO.Enabled:=EnableEdit;
    end
    else//if DataSet = cds_ChemicalOutData then
    begin
      cbb_Destination.Enabled:=EnableEdit;
      cxSE_OutQuantity.Enabled:=EnableEdit;
      edt_ChemicalNameOut.Enabled:=EnableEdit;
    end;
end;

procedure TChemicalStockModifyForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TChemicalStockModifyForm.FormDestroy(Sender: TObject);
begin
  ChemicalStockModifyForm:=nil;
end;

procedure TChemicalStockModifyForm.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TChemicalStockModifyForm.FormCreate(Sender: TObject);
begin
  ChangeEditControlEnable(cds_ChemicalInData, false);
  ChangeEditControlEnable(cds_ChemicalOutData, false);
  with Dictionary do
  try
    cds_MaterialFlowList.Filter:='Current_Department=''FN'' AND Flow_Description = ''收付化工料''';
    cds_MaterialFlowList.Filtered:=True;
    FillItemsFromDataSet(cds_MaterialFlowList, 'Relation_Department', 'Relation_Department_CHN', '', '->', cbb_Source.Items);
    FillItemsFromDataSet(cds_MaterialFlowList, 'Relation_Department', 'Relation_Department_CHN', '', '->', cbb_Destination.Items);
  finally
    cds_MaterialFlowList.Filtered:=false;;
  end;

  pgc_Only.ActivePageIndex:=0;
  dtp_ChemicalInDate.Date:=Now;
end;

procedure TChemicalStockModifyForm.btn_QueryClick(Sender: TObject);
begin
  case pgc_Only.ActivePageIndex of
    0: GetChemicalInData;
    1: GetChemicalOutData;
  end;
end;

procedure TChemicalStockModifyForm.GetChemicalInData;
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  try
    ChangeEditControlEnable(cds_ChemicalInData, false);
    cds_ChemicalInData.DisableControls;
    FNMServerObj.GetChemicalIn_OutDtl('INDATA', dtp_ChemicalInDate.Date, Login.CurrentDepartment, vData, sErrorMsg);
    if sErrorMsg <> '' then
      raise ExceptionEx.CreateResFmt(@ERR_GetChemicalInDtl, [sErrorMsg]);
    cds_ChemicalInData.Data:=vData;
    if cds_ChemicalInData.IsEmpty then
      raise Exception.CreateRes(@EMP_ChemicalInDtl);
    GridDecorator.BindCxViewWithDataSource(GridView_ChemicalInData,ds_ChemicalInData );
  finally
    cds_ChemicalInData.EnableControls;
    cds_ChemicalInData.AfterScroll(cds_ChemicalInData);
  end;
end;

procedure TChemicalStockModifyForm.GetChemicalOutData;
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  try
    ChangeEditControlEnable(cds_ChemicalOutData, false);
    cds_ChemicalOutData.DisableControls;
    FNMServerObj.GetChemicalIn_OutDtl('OUTDATA', dtp_ChemicalInDate.Date, Login.CurrentDepartment, vData, sErrorMsg);
    if sErrorMsg <> '' then
      raise ExceptionEx.CreateResFmt(@ERR_GetChemicalOutDtl, [sErrorMsg]);

    cds_ChemicalOutData.Data:=vData;
    if cds_ChemicalOutData.IsEmpty then
      raise Exception.CreateRes(@EMP_ChemicalOutDtl);

    GridDecorator.BindCxViewWithDataSource(GridView_ChemicalOutData, ds_ChemicalOutData);
  finally
    cds_ChemicalOutData.EnableControls;
    cds_ChemicalOutData.AfterScroll(cds_ChemicalOutData);
  end;
end;

procedure TChemicalStockModifyForm.btn_SaveRecordClick(Sender: TObject);
var
  Inc_Quantity: Single;
  vData: Variant;
  sErrorMsg: WideString;
begin
  if pgc_Only.ActivePageIndex = 0 then
  begin
    if not cds_ChemicalInData.Active or (cds_ChemicalInData['Chemical_name'] <> edt_ChemicalNameIn.Text ) then exit;
    //只能改大，不能改小
    Inc_Quantity:=cds_ChemicalInData['Enable_Quantity'] + StrToFloat(cxSE_Quantity.Text) - cds_ChemicalInData['In_Quantity'];
    if Inc_Quantity < 0 then
      raise Exception.CreateRes(@MSG_EnableQuantity);

    vData:=VarArrayOf([edt_NoteNO.Text, cxSE_Price.Text, cds_ChemicalInData['Chemical_ID'], LeftStr(cbb_Source.Text, 2),
                       cxSE_Quantity.Text, Inc_Quantity, cds_ChemicalInData['Iden']]);
    FNMServerObj.SaveChemicalStockEdit('ChemicalInData', vData, Login.LoginName, sErrorMsg);
    if sErrorMsg <> '' then
      raise ExceptionEx.CreateResFmt(@ERR_SaveChemicalSotckEdit, [sErrorMsg]);

    cds_ChemicalInData.Edit;
    cds_ChemicalInData['Note_NO']:=edt_NoteNO.Text;
    cds_ChemicalInData['Source']:=LeftStr(cbb_Source.Text, 2);
    cds_ChemicalInData['In_Quantity']:=cxSE_Quantity.Text;
    cds_ChemicalInData['Enable_Quantity']:=Inc_Quantity;
    cds_ChemicalInData['Price']:=cxSE_Price.Text;
    cds_ChemicalInData.MergeChangeLog;
  end;

  if pgc_Only.ActivePageIndex = 1 then
  begin
    if not cds_ChemicalOutData.Active or (cds_ChemicalOutData['Chemical_name'] <> edt_ChemicalNameOut.Text ) then exit;
    //只能改小，不能改大
    if cds_ChemicalOutData['used_QTY'] < StrToFloat(cxSE_OutQuantity.Text) then
      raise Exception.CreateRes(@MSG_IncOutQuantity);
    Inc_Quantity:=cds_ChemicalOutData['used_QTY'] - StrToFloat(cxSE_OutQuantity.Text);
    
    vData:=VarArrayOf([cxSE_OutQuantity.Text, LeftStr(cbb_Destination.Text, 2), cds_ChemicalOutData['Iden'],
                       Inc_Quantity, cds_ChemicalOutData['In_Iden']]);
    FNMServerObj.SaveChemicalStockEdit('ChemicalOutData', vData, Login.LoginName, sErrorMsg);
    if sErrorMsg <> '' then
      raise ExceptionEx.CreateResFmt(@ERR_SaveChemicalSotckEdit, [sErrorMsg]);

    cds_ChemicalOutData.Edit;
    cds_ChemicalOutData['Use_Department']:=LeftStr(cbb_Destination.Text, 2);
    cds_ChemicalOutData['used_QTY']:=cxSE_OutQuantity.Text;
    cds_ChemicalOutData.MergeChangeLog;
  end;
end;

procedure TChemicalStockModifyForm.AfterScrollData(
  DataSet: TDataSet);
begin
  if not DataSet.Active or DataSet.IsEmpty then Exit;
  if DataSet.ControlsDisabled then exit;
    
  if DataSet = cds_ChemicalInData then
  begin
    edt_ChemicalNameIn.Text:=DataSet.FieldByName('Chemical_Name').AsString;
    edt_NoteNO.Text:=DataSet.FieldByName('Note_NO').AsString;
    TGlobal.SetComboBoxValue(cbb_Source, DataSet['Source']);
    cxSE_Quantity.Text:=DataSet.FieldByName('In_Quantity').AsString;
    cxSE_Price.Text:=DataSet.FieldByName('Price').AsString;
  end;

  if DataSet = cds_ChemicalOutData then
  begin
    edt_ChemicalNameOut.Text:=DataSet.FieldByName('Chemical_Name').AsString;
    TGlobal.SetComboBoxValue(cbb_Destination, DataSet['Use_Department']);
    cxSE_OutQuantity.Text:=DataSet.FieldByName('Used_QTY').AsString;
  end;
  ChangeEditControlEnable(DataSet, true);
end;

end.

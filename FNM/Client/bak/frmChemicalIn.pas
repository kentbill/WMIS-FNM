unit frmChemicalIn;
{*|<PRE>*****************************************************************************

       软件名称 FNM CLIENT MODEL
       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT
       单元名称 frmChemicalIn.pas
       创建日期 2004-10-13 15:49:12
       创建人员 lvzd                                                           
       修改人员
       修改日期
       修改原因                                                                
       对应用例                                                                
       字段描述                                                                
       相关数据库表                                                            
       调用重要函数/SQL对象说明                                                
       功能描述 化工料入库单元
                                                                              
******************************************************************************}

interface

uses
  frmBase,
  Windows, Messages, SysUtils, Variants, Classes, Dialogs, Controls,
  Forms, StdCtrls, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit, ComCtrls, DB,
  DBClient, Buttons, ExtCtrls, cxSplitter, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData, cxDropDownEdit,
  cxCalc;

type
  TChemicalInForm = class(TBaseForm)
    cds_ChemicalInDtl: TClientDataSet;
    ds_ChemicalInDtl: TDataSource;
    btn_Save: TSpeedButton;
    btn_Query: TSpeedButton;
    btn_Exit: TSpeedButton;
    btn_Help: TSpeedButton;
    btn1: TSpeedButton;
    cxgridGrid_ChemicalInDtl: TcxGrid;
    cxgridtv_ChemicalInDtl: TcxGridDBTableView;
    cxGridlGridLevel_ChemicalInDtl: TcxGridLevel;
    pnl_Only: TPanel;
    cxspl1: TcxSplitter;
    cbb_ChemicalName: TComboBox;
    edt_NoteNO: TEdit;
    cbb_Source: TComboBox;
    dtp_ChemicalInDate: TDateTimePicker;
    txt_Only: TStaticText;
    cxse_Quantity: TcxSpinEdit;
    btn_AppendRecord: TSpeedButton;
    btn_EditRecord: TSpeedButton;
    btn_DeleteRecord: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_AppendRecordClick(Sender: TObject);
    procedure btn_EditReco1rdClick(Sender: TObject);
    procedure btn_DeleteR1ecordClick(Sender: TObject);
    procedure cds_ChemicalInDtlAfterScroll(DataSet: TDataSet);
    procedure btn_QueryClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    procedure InsertChemicalInRecord;
    {* 插入一条入库记录}
    function CheckInputData: Boolean;
    {* 检查用户输入的数据是否有效}
  end;

var
  ChemicalInForm: TChemicalInForm;

implementation

uses DateUtils, StrUtils, CommCtrl, ServerDllPub, UAppOption, uFNMResource, uFNMArtInfo,
     uDictionary, uLogin, uGridDecorator, uGlobal;

{$R *.dfm}

procedure TChemicalInForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TChemicalInForm.FormDestroy(Sender: TObject);
begin
  ChemicalInForm:=nil;
end;

procedure TChemicalInForm.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
  //刷新界面数据
  dtp_ChemicalInDate.Date:=IncDay(TDate(Now), -1);
  //加载收付关系
  try
    Dictionary.cds_MaterialFlowList.Filter:='Current_Department=''FN'' AND Flow_Description = ''收付化工料''';
    Dictionary.cds_MaterialFlowList.Filtered:=True;
    FillItemsFromDataSet(Dictionary.cds_MaterialFlowList, 'Relation_Department', 'Relation_Department_CHN', '', '->', cbb_Source.Items);
  finally
    Dictionary.cds_MaterialFlowList.Filtered:=false;;
  end;
  //加载化工料名称供用户选择                                            //   'Chemical_Name'  --
  FillItemsFromDataSet(Dictionary.cds_ChemicalList, 'Chemical_Short_Name', '', 'Chemical_ID', '', cbb_ChemicalName.Items);
  OnActivate:=nil;
end;

procedure TChemicalInForm.FormCreate(Sender: TObject);
begin
  //加载图标
  btn_Save.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btn_Exit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  btn_AppendRecord.Glyph.LoadFromResourceName(HInstance, RES_NEW);
  btn_EditRecord.Glyph.LoadFromResourceName(HInstance, RES_EDIT);
  btn_DeleteRecord.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  btn_Query.Glyph.LoadFromResourceName(HInstance, RES_QUERY);

  //建立本地数据集,供用户添加数据
  cds_ChemicalInDtl.CreateDataSet;
  GridDecorator.BindCxViewWithDataSource(cxgridtv_ChemicalInDtl, ds_ChemicalInDtl);
end;

function TChemicalInForm.CheckInputData: Boolean;
begin
  with cbb_ChemicalName do
  if (Text = '') or (Items.IndexOf(Text) = -1) then
  begin
    cbb_ChemicalName.SetFocus;
    raise Exception.CreateRes(@INV_NoChoiceChemicalName);
    exit;
  end;

  if cbb_Source.ItemIndex = -1 then
  begin
    cbb_Source.SetFocus;
    raise Exception.CreateRes(@INV_NoChoiceSource);
    exit;
  end;

  if StrToFloat(cxse_Quantity.Text) <= 0 then
  begin
    cxse_Quantity.SetFocus;
    raise Exception.CreateResFmt(@INV_ValueIsLessThenZero, ['收入数']);
  end;
  
  result := True;
end;

procedure TChemicalInForm.InsertChemicalInRecord;
var
  Chemical_ID: Integer;
  Chemical_Price: Single;
  Chemical_Name, Chemical_Type: String;
begin
  if not CheckInputData then exit;

  //取化工料的基本信息
  with cbb_ChemicalName do
    Chemical_ID:=Integer(Items.Objects[Items.IndexOf(Text)]);
  if not Dictionary.cds_ChemicalList.Locate('Chemical_ID', Chemical_ID, []) then exit;
  Chemical_Price:=Dictionary.cds_ChemicalList.FieldByName('Unit_Price').AsFloat;
  Chemical_Name:=Dictionary.cds_ChemicalList.FieldByName('Chemical_Name').AsString;
  Chemical_Type:=Dictionary.cds_ChemicalList.FieldByName('Chemical_Type').AsString;

  //加入记录数据
  cds_ChemicalInDtl.InsertRecord([dtp_ChemicalInDate.Date,       //In_Date
                                  edt_NoteNO.Text,               //Note_NO
                                  Chemical_ID,                   //Chemical_ID
                                  Chemical_Name,                 //Chemical_Name
                                  Chemical_Type,                 //Chemical_Type
                                  LeftStr(cbb_Source.Text, 2),   //Source
                                  cxse_Quantity.text,            //In_Quantity
                                  Chemical_Price,                //Unit_Price
                                  Login.CurrentDepartment,       //Current_Department
                                  Login.loginName]);             //Operator
end;

procedure TChemicalInForm.btn_AppendRecordClick(Sender: TObject);
begin
  try
    cds_ChemicalInDtl.DisableControls;
    cds_ChemicalInDtl.First;
    InsertChemicalInRecord;
    edt_NoteNO.SetFocus;
  finally
    cds_ChemicalInDtl.EnableControls
  end;
  edt_NoteNO.SetFocus;
end;

procedure TChemicalInForm.btn_EditReco1rdClick(Sender: TObject);
begin
  if cds_ChemicalInDtl.IsEmpty then exit;
  try
    cds_ChemicalInDtl.DisableControls;
    //先删除后添加
    btn_DeleteRecord.Click;
    InsertChemicalInRecord;
  finally
    cds_ChemicalInDtl.EnableControls
  end;
end;

procedure TChemicalInForm.btn_DeleteR1ecordClick(Sender: TObject);
begin
  if cds_ChemicalInDtl.IsEmpty then exit;

  cds_ChemicalInDtl.Delete;
end;

procedure TChemicalInForm.cds_ChemicalInDtlAfterScroll(DataSet: TDataSet);
begin
  if DataSet.IsEmpty or DataSet.ControlsDisabled then exit;

  with DataSet do
  begin
    cbb_ChemicalName.ItemIndex:=cbb_ChemicalName.Items.IndexOfObject(TObject(FieldByName('Chemical_ID').AsInteger));
    TGlobal.SetComboBoxValue(cbb_Source, FieldByName('Source').AsString);
    edt_NoteNO.Text:=FieldByName('Note_NO').AsString;
    cxse_Quantity.Text:=ifthen(Trim(FieldByName('In_Quantity').AsString) = '', '0', FieldByName('In_Quantity').AsString);
    // cxSE_Price.Text:=ifthen(Trim(FieldByName('Price').AsString) = '', '0', FieldByName('Price').AsString);
  end;
end;

procedure TChemicalInForm.btn_QueryClick(Sender: TObject);
begin
  //New A Form
//  //保存数据
//  //查询指定日期已经输入的入库数据
//  GetChemicalInDtl('ByDateTime', dtp_ChemicalInDate.Date, Login.CurrentDepartment, cds_ChemicalInDtl);
//
//  if cxgridtvGridDBTableView_ChemicalInDtl.ColumnCount = 0 then
//  begin
//    cxgridtvGridDBTableView_ChemicalInDtl.DataController.CreateAllItems;
//    cxgridtvGridDBTableView_ChemicalInDtl.ApplyBestFit;
//  end;
//
//  txt_DataTitle.Caption:=format(GetResourceString(@Caption_ChemicalInDtl), [DateToStr(dtp_ChemicalInDate.Date)]);
end;

procedure TChemicalInForm.btn_SaveClick(Sender: TObject);
var
  sErrorMsg: WideString;
begin
  if cds_ChemicalInDtl.IsEmpty then exit;

  try
    cds_ChemicalInDtl.DisableControls;
    //所有的数据都是新添加的
    cds_ChemicalInDtl.MergeChangeLog;

    //更新插入和修改的记录
    FNMServerObj.SaveChemicalInDtl(cds_ChemicalInDtl.Data, sErrorMsg);
    if sErrorMsg <> '' then
      raise Exception.CreateResFmt(@ERR_SaveChemicalInDtl, [sErrorMsg]);

    cds_ChemicalInDtl.EmptyDataSet;
    ShowMsgDialog(@MSG_SaveChemicalInInfoSuccess, mtInformation);
  finally
    cds_ChemicalInDtl.EnableControls;
  end;
end;

procedure TChemicalInForm.btn_ExitClick(Sender: TObject);
begin
  close;
end;

end.

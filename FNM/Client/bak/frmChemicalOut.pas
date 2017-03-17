unit frmChemicalOut;
{*|<PRE>*****************************************************************************
                                                                             
       ������� FNM CLIENT MODEL                                               
       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                              
       ��Ԫ���� frmChemicalCheck.pas                                           
       �������� 2004-10-13 15:49:57
       ������Ա lvzd                                                           
       �޸���Ա
       �޸�����                                                                
       �޸�ԭ��
       ��Ӧ����                                                                
       �ֶ�����
       ������ݿ��                                                            
       ������Ҫ����/SQL����˵��                                                
       �������� �����ϳ��ⵥԪ                                                               
                                                                              
******************************************************************************}

interface

uses
  frmBase,
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxSpinEdit, ComCtrls, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DB, DBClient, Buttons, ExtCtrls, cxSplitter,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxDBData, cxDropDownEdit, cxCalc;

type
  TChemicalOutForm = class(TBaseForm)
    cds_ChemicalOut: TClientDataSet;
    ds_ChemicalOut: TDataSource;
    btn_Help: TSpeedButton;
    btn_Save: TSpeedButton;
    btn_Query: TSpeedButton;
    btn_Exit: TSpeedButton;
    cxgrid_ChemicalOut1: TcxGrid;
    cxgridtv_ChemicalOut: TcxGridDBTableView;
    cxGridl_ChemicalOut: TcxGridLevel;
    cbb_Destination: TComboBox;
    txt_Only: TStaticText;
    dtp_ChemicalCheckDate: TDateTimePicker;
    cbb_ChemicalName: TComboBox;
    cxse_OutQuantity: TcxSpinEdit;
    rb_OutQuantity: TRadioButton;
    rb_StockQuantity: TRadioButton;
    pnl_Only: TPanel;
    cxspl1: TcxSplitter;
    cxce_StockQuantity: TcxCalcEdit;
    btn_AppendRecord: TSpeedButton;
    btn_EditRecord: TSpeedButton;
    btn_DeleteRecord: TSpeedButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btn_EditRecordClick(Sender: TObject);
    procedure btn_QueryClick(Sender: TObject);
    procedure btn_AppendRecordClick(Sender: TObject);
    procedure cds_ChemicalOutAfterScroll(DataSet: TDataSet);
    procedure ClickRadioButton(Sender: TObject);
    procedure btn_DeleteRecordClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ChangeAQuantityControl(Sender: TObject);
    procedure cxce_StockQuantityEnter(Sender: TObject);
  private
    { Private declarations }
    procedure InsertChemicalOutRecord;
    {* ����һ�������¼}
    function CheckInputData: Boolean;
    {* ����û�����������Ƿ���Ч}
  public
    { Public declarations }
  end;

var
  ChemicalOutForm: TChemicalOutForm;

implementation

uses StrUtils, uFNMArtInfo, uFNMResource, uDictionary, ServerDllPub,
  UAppOption, uLogin, uGridDecorator, uGlobal;

{$R *.dfm}

procedure TChemicalOutForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree
end;

procedure TChemicalOutForm.FormDestroy(Sender: TObject);
begin
  ChemicalOutForm:=nil;
end;

procedure TChemicalOutForm.ClickRadioButton(Sender: TObject);
begin
  if rb_StockQuantity.Checked then cxce_StockQuantity.SetFocus;
  if rb_OutQuantity.Checked then cxSE_OutQuantity.SetFocus;
end;

procedure TChemicalOutForm.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
  //ˢ�½�������
  dtp_ChemicalCheckDate.Date:=now;
  try
    Dictionary.cds_MaterialFlowList.Filter:='Current_Department=''FN'' AND Flow_Description = ''�ո�������''';
    Dictionary.cds_MaterialFlowList.Filtered:=True;
    FillItemsFromDataSet(Dictionary.cds_MaterialFlowList, 'Relation_Department', 'Relation_Department_CHN', '', '->', cbb_Destination.Items);
  finally
    Dictionary.cds_MaterialFlowList.Filtered:=false;;
  end;
  //���ػ��������ƹ��û�ѡ��                                                    //Chemical_Name  --
  FillItemsFromDataSet(Dictionary.cds_ChemicalList, 'Chemical_Short_Name', '', 'Chemical_ID', '', cbb_ChemicalName.Items);
  OnActivate:=nil;
end;

procedure TChemicalOutForm.FormCreate(Sender: TObject);
begin
  //����ͼ��
  btn_Save.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btn_Exit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  btn_AppendRecord.Glyph.LoadFromResourceName(HInstance, RES_NEW);
  btn_EditRecord.Glyph.LoadFromResourceName(HInstance, RES_EDIT);
  btn_DeleteRecord.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  btn_Query.Glyph.LoadFromResourceName(HInstance, RES_QUERY);

  //�����������ݼ�,���û��������
  cds_ChemicalOut.CreateDataSet;
  GridDecorator.BindCxViewWithDataSource(cxgridtv_ChemicalOut, ds_ChemicalOut);
end;

procedure TChemicalOutForm.InsertChemicalOutRecord;
var
  Chemical_ID: Integer;
  Chemical_Name, Chemical_Type: String;
begin
  if not CheckInputData then exit;

  //ȡ�����ϵĻ�����Ϣ
  with cbb_ChemicalName do
    Chemical_ID:=Integer(Items.Objects[Items.IndexOf(Text)]);
  if not Dictionary.cds_ChemicalList.Locate('Chemical_ID', Chemical_ID, []) then exit;

  Chemical_Name:=Dictionary.cds_ChemicalList.FieldByName('Chemical_Name').AsString;
  Chemical_Type:=Dictionary.cds_ChemicalList.FieldByName('Chemical_Type').AsString;

  //�����¼����
  cds_ChemicalOut.InsertRecord(['δ����',                                                       //Record_Status
                                Chemical_ID,                                                    //Chemical_ID
                                Chemical_Name,                                                  //Chemical_Name
                                Chemical_Type,                                                  //Chemical_Type
                                ifthen(rb_OutQuantity.Checked, cxSE_OutQuantity.Text, '0'),     //Used_QTY
                                ifthen(rb_StockQuantity.Checked, cxce_StockQuantity.Text, '0'), //Keep_Qty
                                LeftStr(cbb_Destination.Text, 2),                               //Use_Department
                                dtp_ChemicalCheckDate.Date,                                     //Out_Date
                                Login.loginName,                                                //Operator
                                Login.CurrentDepartment]);                                      //Current_Department
end;

procedure TChemicalOutForm.btn_AppendRecordClick(Sender: TObject);
begin
  try
    cds_ChemicalOut.DisableControls;
    //��ɾ�������
    cds_ChemicalOut.First;
    InsertChemicalOutRecord;
  finally
    cds_ChemicalOut.EnableControls
  end;
  cbb_ChemicalName.SetFocus;
end;

procedure TChemicalOutForm.btn_EditRecordClick(Sender: TObject);
begin
  if cds_ChemicalOut.IsEmpty or (cds_ChemicalOut.FieldByName('Record_Status').AsString = '�ѱ���') then exit;

  try
    cds_ChemicalOut.DisableControls;
    //��ɾ�������
    btn_DeleteRecord.Click;
    InsertChemicalOutRecord;
  finally
    cds_ChemicalOut.EnableControls
  end;
end;

procedure TChemicalOutForm.btn_DeleteRecordClick(Sender: TObject);
begin
  if cds_ChemicalOut.IsEmpty or (cds_ChemicalOut.FieldByName('Record_Status').AsString = '�ѱ���') then exit;

  cds_ChemicalOut.Delete;
end;

procedure TChemicalOutForm.btn_QueryClick(Sender: TObject);
begin
  //New A Form
end;

function TChemicalOutForm.CheckInputData: Boolean;
begin
  with cbb_ChemicalName do
  if (Text = '') or (Items.IndexOf(Text) = -1) then
  begin
    cbb_ChemicalName.SetFocus;
    raise Exception.CreateRes(@INV_NoChoiceChemicalName);
  end;

  if cbb_Destination.ItemIndex = -1 then
  begin
    cbb_Destination.SetFocus;
    raise Exception.CreateRes(@INV_NoChoiceDestination);
  end;

  if rb_OutQuantity.Checked and (StrToFloat(cxSE_OutQuantity.Text) <= 0) then
  begin
    cxSE_OutQuantity.SetFocus;
    raise Exception.CreateResFmt(@INV_ValueIsLessThenZero, ['������']);
  end;

  if rb_StockQuantity.Checked and (StrToFloat(cxce_StockQuantity.Text) < 0) then
  begin
    cxce_StockQuantity.SetFocus;
    raise Exception.CreateResFmt(@INV_ValueIsLessThenZero, ['�����']);
  end;

  result := True;
end;

procedure TChemicalOutForm.cds_ChemicalOutAfterScroll(DataSet: TDataSet);
begin
  if DataSet.IsEmpty or DataSet.ControlsDisabled then exit;
    
  with DataSet do
  begin
    cbb_ChemicalName.ItemIndex:=cbb_ChemicalName.Items.IndexOfObject(TObject(FieldByName('Chemical_ID').AsInteger));
    TGlobal.SetComboBoxValue(cbb_Destination, FieldByName('Use_Department').AsString);
    cxSE_OutQuantity.Text:=ifthen(FieldByName('Used_QTY').AsString = '', '0', FieldByName('Used_QTY').AsString);
    cxce_StockQuantity.Text:=ifthen(FieldByName('Keep_Qty').AsString = '', '0', FieldByName('Keep_Qty').AsString);
  end;
end;

procedure TChemicalOutForm.btn_SaveClick(Sender: TObject);
var
  RecordData: Variant;
  i, ErrorCount: Integer;
  sErrorMsg: WideString;
begin
  ErrorCount:=0;
  try
    cds_ChemicalOut.DisableControls;
    //���е����ݶ�������ӵ�
    cds_ChemicalOut.MergeChangeLog;

    cds_ChemicalOut.First;
    for i := 0 to cds_ChemicalOut.RecordCount - 1 do
    begin
      if cds_ChemicalOut.FieldByName('Record_Status').AsString = '�Ѵ洢' then
        continue;

      //���²�����޸ĵļ�¼
      with cds_ChemicalOut do
      RecordData:=
          VarArrayOf([FieldByName('Chemical_ID').AsString,
          ifthen(FieldByName('Used_QTY').AsString = '0', FieldByName('Keep_QTY').AsString, FieldByName('Used_QTY').AsString),
          ifthen(FieldByName('Used_QTY').AsString = '0', 'JC', 'HY'),
          FieldByName('Current_Department').AsString,
          FieldByName('Use_Department').AsString,
          FieldByName('Out_Date').AsString,
          FieldByName('Operator').AsString]);

      FNMServerObj.SaveChemicalOutDtl(RecordData, sErrorMsg);
      cds_ChemicalOut.Edit;
      if sErrorMsg <> '' then
      begin
        inc(ErrorCount);
        cds_ChemicalOut.FieldByName('Record_Status').AsString:=sErrorMsg;
      end
      else
        cds_ChemicalOut.FieldByName('Record_Status').AsString:='�Ѵ洢';
      
      cds_ChemicalOut.next;
    end;

    if ErrorCount <> 0 then
      ShowCustomMsgDialog(@ERR_SaveChemicalOutDtl, [ErrorCount], mtError);
  finally
    cds_ChemicalOut.EnableControls;
  end;
end;

procedure TChemicalOutForm.btn_ExitClick(Sender: TObject);
begin
  close;
end;

procedure TChemicalOutForm.ChangeAQuantityControl(
  Sender: TObject);
begin
  if Sender = cxSE_OutQuantity then rb_OutQuantity.Checked:=true;
  if Sender = cxce_StockQuantity then rb_StockQuantity.Checked:=true;
end;

procedure TChemicalOutForm.cxce_StockQuantityEnter(Sender: TObject);
begin
  inherited;
  cxce_StockQuantity.DroppedDown:=true;
end;

end.

unit frmChemical;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ExtCtrls, DBClient, ADODB, Buttons, ComCtrls,
  StdCtrls, cxSplitter, Grids, DBGrids;

type
  TChemicalForm = class(TBaseForm)
    dsChemical: TDataSource;
    adodsImport: TADODataSet;
    cdsChemical: TClientDataSet;
    Panel1: TPanel;
    cxGrid1: TcxGrid;
    cxGridDBTV: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    Panel2: TPanel;
    txt_Only: TStaticText;
    dtpQueryDate: TDateTimePicker;
    btnQuery: TSpeedButton;
    btnExcel: TSpeedButton;
    btnSave: TSpeedButton;
    btnExit: TSpeedButton;
    GroupBox1: TGroupBox;
    cbbChemicalName: TComboBox;
    cxSplitter1: TcxSplitter;
    Panel3: TPanel;
    edtQuantity: TEdit;
    RadioGroup1: TRadioGroup;
    Label1: TLabel;
    btnUpdate: TSpeedButton;
    StaticText1: TStaticText;
    dtpChangeDate: TDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChemicalForm: TChemicalForm;

implementation

uses uDictionary, uFNMArtInfo, uAppOption,uGlobal,ServerDllPub, uFNMResource, uLogin,
  uGridDecorator, uShowMessage;
{$R *.dfm}

procedure TChemicalForm.FormCreate(Sender: TObject);
begin
  inherited;
  btnQuery.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  btnExcel.Glyph.LoadFromResourceName(HInstance, RES_EXOPRTFILE);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnExit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  btnUpdate.Glyph.LoadFromResourceName(HInstance, RES_EDIT);
  cbbChemicalName.Align := alClient;
  dtpQueryDate.Date := Now - 1;
  dtpChangeDate.Date := Now -1;
  btnExcel.Enabled := False;
  //加载化工料名称供用户选择
  FillItemsFromDataSet(Dictionary.cds_ChemicalList, 'Chemical_Short_Name', '', 'Chemical_ID', '', cbbChemicalName.Items);
end;

procedure TChemicalForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TChemicalForm.FormDestroy(Sender: TObject);
begin
  inherited;
  ChemicalForm := nil;
end;

procedure TChemicalForm.btnQueryClick(Sender: TObject);
var
  vData : OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  inherited;
  try
    Screen.Cursor := crHourGlass;
    cdsChemical.DisableControls;
    sCondition := QuotedStr(DateToStr(dtpQueryDate.Date))+','+QuotedStr(Login.CurrentDepartment)+','+IntToStr(0);
    FNMServerObj.GetQueryData(vData,'GetChemicalInfo',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsChemical.Data := vData;
    GridDecorator.BindCxViewWithDataSource(cxGridDBTV, dsChemical);
    cxGridDBTV.Columns[0].Visible := False;
    cxGridDBTV.Columns[1].Visible := False;
  finally
    cdsChemical.EnableControls;
    Screen.Cursor :=  crDefault;
  end;
  btnExcel.Enabled := True;
end;

procedure TChemicalForm.btnExcelClick(Sender: TObject);   
begin
  inherited;
  TGlobal.GetRecordSetFromXLS(adodsImport);
  with adodsImport do
  begin
    if IsEmpty or (not Active) then Exit;
    if not cdsChemical.Active then Exit;
    First;
    while not Eof do
    begin
      if FieldByName('物料ID').AsInteger = 0 then
      begin
        Next;
        continue;
      end;
      if not Dictionary.cds_ChemicalList.Locate('Chemical_ID', FieldByName('物料ID').AsInteger, []) then
        raise Exception.CreateFmt('化工料ID:%d 不存在,请确认该化工料ID是否正确.', [FieldByName('物料ID').AsInteger]);

      if cdsChemical.Locate('Chemical_ID',FieldByName('物料ID').AsInteger,[]) then
      begin
         cdsChemical.Edit;
         cdsChemical.FieldByName('Chemical_Type').AsString := FieldByName('类型').AsString;
         cdsChemical.FieldByName('In_Qty').AsFloat := FieldByName('本日收入数量').AsFloat;
         cdsChemical.FieldByName('Remain').AsFloat := FieldByName('本日结存数量').AsFloat;
         cdsChemical.FieldByName('Out_Qty').AsFloat := cdsChemical.FieldByName('Last_Remain').AsFloat +
                                                       FieldByName('本日收入数量').AsFloat -
                                                       FieldByName('本日结存数量').AsFloat;
         cdsChemical.FieldByName('Price').AsFloat := FieldByName('单价').AsFloat;
      end else
      begin
         cdsChemical.Insert;
         cdsChemical.FieldByName('Create_Date').AsDateTime := dtpQueryDate.Date; 
         cdsChemical.FieldByName('Chemical_Type').AsString := FieldByName('类型').AsString;
         cdsChemical.FieldByName('Chemical_ID').AsInteger := FieldByName('物料ID').AsInteger;
         cdsChemical.FieldByName('Chemical_Name').AsString := FieldByName('物料名称').AsString;
         cdsChemical.FieldByName('Last_Remain').AsFloat := 0;
         cdsChemical.FieldByName('In_Qty').AsFloat := FieldByName('本日收入数量').AsFloat;
         cdsChemical.FieldByName('Remain').AsFloat := FieldByName('本日结存数量').AsFloat;
         cdsChemical.FieldByName('Out_Qty').AsFloat := FieldByName('本日收入数量').AsFloat -
                                                       FieldByName('本日结存数量').AsFloat;
         cdsChemical.FieldByName('Price').AsFloat := FieldByName('单价').AsFloat;
      end;
      Next;
    end;
    Close;
  end;
  cdsChemical.CheckBrowseMode;
end;

procedure TChemicalForm.btnSaveClick(Sender: TObject);
var
  sErrorMsg: WideString;
  vData : OleVariant;
  i: Integer;
begin
  with cdsChemical do
  begin
    if (not Active) or IsEmpty then Exit;
    MergeChangeLog;
    vData := VarArrayCreate([0, RecordCount -1], VarVariant);
    First;
    i := 0;
    while not Eof do
    begin
      vData[i] :=  varArrayOf([cdsChemical.FieldByName('Create_Date').AsString,
                               cdsChemical.FieldByName('Chemical_ID').AsString,
                               cdsChemical.FieldByName('Chemical_Name').AsString,
                               cdsChemical.FieldByName('Chemical_Type').AsString,
                               cdsChemical.FieldByName('In_Qty').AsString,
                               cdsChemical.FieldByName('Out_Qty').AsString,
                               cdsChemical.FieldByName('Remain').AsString,
                               cdsChemical.FieldByName('Price').AsString,
                               Login.CurrentDepartment,
                               Login.LoginName]);
      Next;
      Inc(i);
    end;
  end;

  FNMServerObj.SaveChemicalData(0, vData, sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
end;

procedure TChemicalForm.btnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TChemicalForm.btnUpdateClick(Sender: TObject);
var
  sCondition,sErrorMsg: WideString;
  Chemical_ID: Integer;
  tempe: Extended;
begin
  if not TryStrToFloat(edtQuantity.Text, tempe)then
    raise Exception.CreateResFmt(@INV_NOItemValue, ['Numeric', 'Numeric']);

  with cbbChemicalName do
  begin
    if Text = '' then Exit;
    Chemical_ID := Integer(Items.Objects[Items.IndexOf(Text)]);
  end;
  sCondition :=  QuotedStr(DateToStr(dtpChangeDate.Date))+',' + IntToStr(Chemical_ID)+','+ IntToStr(RadioGroup1.ItemIndex)+','+
                 QuotedStr(edtQuantity.Text)+','+ QuotedStr(Login.CurrentDepartment);
  FNMServerObj.SaveDataBySQL('AdjustChemicalInfo',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  TMsgDialog.ShowMsgDialog('更改数据成功', mtInformation);
end;

end.

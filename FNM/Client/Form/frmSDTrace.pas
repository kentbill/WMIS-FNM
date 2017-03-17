unit frmSDTrace;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  DBClient, cxDBEditRepository, cxEditRepositoryItems, cxDropDownEdit,
  cxCurrencyEdit, cxDBLookupComboBox, Grids, DBGrids;

type
  TSDTraceForm = class(TBaseForm)
    Panel2: TPanel;
    Label1: TLabel;
    edtGFNO: TEdit;
    btnQuery: TBitBtn;
    pnlValue: TPanel;
    btnDelete: TBitBtn;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    Label2: TLabel;
    cxGrid1: TcxGrid;
    cxGridTVSDTraceInfo: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    rgType: TRadioGroup;
    Label3: TLabel;
    dsSDTrace: TDataSource;
    cdsSDTrace: TClientDataSet;
    dsOperationHdr: TDataSource;
    Label4: TLabel;
    sbClear: TSpeedButton;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnQueryClick(Sender: TObject);
    procedure rgTypeClick(Sender: TObject);
    procedure sbClearClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetSDTraceInfo;
    procedure SaveSDTraceInfo(Index: Integer);
  public
    { Public declarations }
  end;

var
  SDTraceForm: TSDTraceForm;

implementation

uses ServerDllPub, UShowMessage, uAppOption,uLogin,uGlobal,uDictionary, uGridDecorator;

{$R *.dfm}

procedure TSDTraceForm.rgTypeClick(Sender: TObject);
begin
  inherited;
  if rgType.ItemIndex = 0 then
  begin
    btnDelete.Caption := '删除(&D)';
    btnSave.Caption  := '保存(&S)';
  end else
  begin
    btnDelete.Caption := '更新&U)';
    btnSave.Caption  := '解除(&R)';
  end;
  if cdsSDTrace.Active  then
    cdsSDTrace.EmptyDataSet;
end;

procedure TSDTraceForm.btnDeleteClick(Sender: TObject);
var
  i, GF_ID: Integer;
  Job_NO: string;
begin
  inherited;
  if rgType.ItemIndex = 0 then
  begin
    if cxGridTVSDTraceInfo.Controller.SelectedRowCount = 0 then exit;
    if not cdsSDTrace.Active or cdsSDTrace.IsEmpty then Exit;
    with cdsSDTrace do
    try
      DisableControls;
      Filtered := false;
      for i := cxGridTVSDTraceInfo.Controller.SelectedRowCount - 1 downto 0 do
      begin
        with cxGridTVSDTraceInfo do
        begin
           GF_ID := Controller.SelectedRows[i].Values[GetColumnByFieldName('GF_ID').Index];
           Job_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Job_NO').Index];
        end;
        if Locate('GF_ID;Job_NO', VarArrayOf([GF_ID, Job_NO]), []) then
            Delete;
      end;
    finally
    Filtered := true;
    EnableControls;
  end;
  end else
    SaveSDTraceInfo(1);
end;

procedure TSDTraceForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  if rgType.ItemIndex = 0 then
    SaveSDTraceInfo(0)
  else
    SaveSDTraceInfo(2);
end;

procedure TSDTraceForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TSDTraceForm.FormCreate(Sender: TObject);
begin
  inherited;
  edtGFNO.Clear;
end;

procedure TSDTraceForm.FormDestroy(Sender: TObject);
begin
  inherited;
  SDTraceForm := nil;
end;

procedure TSDTraceForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TSDTraceForm.btnQueryClick(Sender: TObject);
begin
  inherited;
  GetSDTraceInfo;
end;

procedure TSDTraceForm.GetSDTraceInfo;
var vData: OleVariant;
    sCondition,sGFNO, sErrorMsg: WideString;
begin
  try
    ShowMsg('正在获取数据稍等！',crHourGlass);
    sGFNO := Trim(edtGFNO.Text);
    if (rgType.ItemIndex = 0) and (sGFNO = '') then Exit;
    sCondition := QuotedStr(sGFNO)+','+QuotedStr(Login.LoginID)+','+QuotedStr(Login.CurrentDepartment)+','+ IntToStr(rgType.ItemIndex);
    FNMServerObj.GetQueryData(vData,'GETSDTraceInfo',sCondition,sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsSDTrace.Data := vData;
    if cdsSDTrace.RecordCount = 0 then
    begin
      TMsgDialog.ShowMsgDialog('没有相应的数据,请重新查询',1);
      Exit;
    end;
    GridDecorator.BindCxViewWithDataSource(cxGridTVSDTraceInfo, dsSDTrace, True);
    if rgType.ItemIndex = 1 then
      cxGridTVSDTraceInfo.GetColumnByFieldName('Release').Styles.Content := cxStyle1;
    cxGridTVSDTraceInfo.GetColumnByFieldName('Trace_Text').Styles.Content := cxStyle1;
    cxGridTVSDTraceInfo.GetColumnByFieldName('Operation_Code').Styles.Content := cxStyle1;
    cxGridTVSDTraceInfo.GetColumnByFieldName('FN_Delivery_Date').Styles.Content := cxStyle1;
    cxGridTVSDTraceInfo.GetColumnByFieldName('Recipients').Styles.Content := cxStyle1;
    cxGridTVSDTraceInfo.GetColumnByFieldName('Is_Email').Styles.Content := cxStyle1;
    //下拉列表
    cxGridTVSDTraceInfo.GetColumnByFieldName('Trace_Text').PropertiesClassName := 'TcxComboBoxProperties';
    TcxComboBoxProperties(cxGridTVSDTraceInfo.GetColumnByFieldName('Trace_Text').Properties).Items.Text := Dictionary.GetItemList('试样跟踪',Login.CurrentDepartment,'');
    Dictionary.cds_OperationHdrList.Filtered := False;
    dsOperationHdr.DataSet := Dictionary.cds_OperationHdrList;
    cxGridTVSDTraceInfo.GetColumnByFieldName('Operation_Code').PropertiesClassName := 'TcxLookupComboBoxProperties';
    TcxLookupComboBoxProperties(cxGridTVSDTraceInfo.GetColumnByFieldName('Operation_Code').Properties).ListSource := dsOperationHdr;
    TcxLookupComboBoxProperties(cxGridTVSDTraceInfo.GetColumnByFieldName('Operation_Code').Properties).KeyFieldNames :='Operation_Code';
    with TcxLookupComboBoxProperties(cxGridTVSDTraceInfo.GetColumnByFieldName('Operation_Code').Properties).ListColumns.Add do
    begin
      Caption := '工序名';
      FieldName := 'Operation_CHN';
    end;
    with TcxLookupComboBoxProperties(cxGridTVSDTraceInfo.GetColumnByFieldName('Operation_Code').Properties).ListColumns.Add do
    begin
      Caption := '类型';
      FieldName := 'Operation_Type';
    end;
    cxGridTVSDTraceInfo.ApplyBestFit(nil);
  finally
    ShowMsg('',crDefault);
  end;
end;

procedure TSDTraceForm.SaveSDTraceInfo(Index: Integer);
var
  vData: OleVariant;
  sEmail,sErrorMsg: WideString;
  i: Integer;
begin
  try
    ShowMsg('正在保存数据稍等！', crHourGlass);
    begin
      if TGlobal.DeltaIsNull(cdsSDTrace) then Exit;
      TempClientDataSet.Data := cdsSDTrace.Delta;
      vData := VarArrayCreate([0, cdsSDTrace.ChangeCount - 1], VarVariant);
      i := 0;
      while not TempClientDataSet.Eof do
      begin
        if cdsSDTrace.Locate('GF_ID;Job_NO',VarArrayOf([TempClientDataSet.Fieldbyname('GF_ID').AsInteger, TempClientDataSet.Fieldbyname('Job_NO').AsString]),[]) then
        begin
          if (Index = 0) or (Index = 1) then
          begin
            if cdsSDTrace.FieldByName('Is_Email').AsBoolean then
               sEmail := '1'
             else
               sEmail := '0';
            vData[i] := varArrayOf([cdsSDTrace.FieldByName('GF_ID').AsString,
                                     cdsSDTrace.FieldByName('Job_NO').AsString,
                                     cdsSDTrace.FieldByName('Trace_Text').AsString,
                                     cdsSDTrace.FieldByName('FN_Delivery_Date').AsString,
                                     cdsSDTrace.FieldByName('Operation_Code').AsString,
                                     cdsSDTrace.FieldByName('Recipients').AsString,
                                     sEmail,
                                     Login.CurrentDepartment,
                                     Login.LoginName]);
          end else
          begin
            if cdsSDTrace.FieldByName('Release').AsBoolean then
              vData[i] := varArrayOf([cdsSDTrace.FieldByName('GF_ID').AsString,
                                      cdsSDTrace.FieldByName('Job_NO').AsString,
                                      Login.CurrentDepartment,
                                      Login.LoginName,
                                      cdsSDTrace.FieldByName('Operation_Code').AsString
                                     ]);
         end;
        end;
        TempClientDataSet.Next;
        TempClientDataSet.Next;
        Inc(i);
      end;
    end;
    FNMServerObj.SaveSDTraceInfo(vData,Index,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TSDTraceForm.sbClearClick(Sender: TObject);
begin
  inherited;
  edtGFNO.Clear;
end;

end.

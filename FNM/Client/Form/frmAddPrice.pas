unit frmAddPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxButtonEdit, ExtCtrls, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid,uGridDecorator, DBClient;

type
  TAddPriceForm = class(TForm)
    pnl_Only: TPanel;
    lbl1: TLabel;
    cxbe_GFKeyValue: TcxButtonEdit;
    pnl_Only2: TPanel;
    grp1: TGroupBox;
    lv_CardList: TListView;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    cbb_Class: TComboBox;
    cbb_ReasonType: TComboBox;
    cbbReasonName: TComboBox;
    cbb_Operator: TComboBox;
    cbb_Machine: TComboBox;
    cbb_BeforeAfter: TComboBox;
    Panel1: TPanel;
    btn_SaveAccident: TButton;
    btn_Cancel: TButton;
    cxgridPrice: TcxGrid;
    cxgridtvPrice: TcxGridDBTableView;
    cxgridlPrice: TcxGridLevel;
    edtRespone: TEdit;
    Button1: TButton;
    dsPrice: TDataSource;
    cdsprice: TClientDataSet;
    cdsReasonType: TClientDataSet;
    procedure cxbe_GFKeyValuePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxbe_GFKeyValueKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lv_CardListClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbbReasonNameChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btn_SaveAccidentClick(Sender: TObject);
    procedure SaveData;
    procedure CheckData;
    procedure GetWorkers;
    procedure cbb_MachineChange(Sender: TObject);
    procedure cbb_ReasonTypeChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure QueryData;
    procedure btn_CancelClick(Sender: TObject);
  private
    isOK:Boolean;
    sFncard:string;
    sFinder,sMachineID,sOperation,sScore,sReason:string;

    function GetOperation(aItemIndex: Integer): string;
    { Private declarations }
  public
    { Public declarations }

  end;

var
  AddPriceForm: TAddPriceForm;

implementation

uses StrUtils, uDictionary, UAppOption,
    uFNMArtInfo, uGlobal, ServerDllPub, uFNMResource,
    uLogin, uShowMessage;

{$R *.dfm}

procedure TAddPriceForm.cxbe_GFKeyValuePropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  sSQL,sErrMsg:WideString;
  vData:OleVariant;
begin
  if Trim(cxbe_GFKeyValue.Text) = '' then exit;

  //GetOnLineCardByGFKeyValue(cxbe_GFKeyValue.Text, Login.CurrentDepartment, TempClientDataSet);
  sSQL := QuotedStr('ByGFKeyValueDistinct')+','
          + QuotedStr(cxbe_GFKeyValue.Text)+','
          + QuotedStr(Login.CurrentDepartment);
  FNMServerObj.GetQueryData(vData,'GetOnLineCard', sSQL, sErrMsg);
  if sErrMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  TempClientDataSet.Data := vData;
  FillListItemsFromDataSet(TempClientDataSet, 'FN_Card', '', ['Quantity'], lv_CardList.Items);
end;

procedure TAddPriceForm.cxbe_GFKeyValueKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN: cxbe_GFKeyValue.Properties.OnButtonClick(Sender, 0);
  end;
end;

procedure TAddPriceForm.lv_CardListClick(Sender: TObject);
var
  i:integer;
  sCard:string;
  sSQL,sErrMsg:WideString;
  vData:OleVariant;
begin
  for i:=0 to lv_CardList.Items.Count-1 do
  begin
    if lv_CardList.Items[i].Selected then
      sCard :=  lv_CardList.Items[i].Caption;
  end;
  sFncard := sCard;
  //LOAD 工序
  sSQL := QuotedStr(sCard) + ',6,' + QuotedStr('');
  FNMServerObj.GetQueryData(vData, 'GetColorInfo',sSQL, sErrMsg);
  if sErrMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  TempClientDataSet.Data := vData;
  // ID : 191523 edit by Kim Jin 2015-12-08
  cdsReasonType.Data := vData;
  FillItemsFromDataSet(TempClientDataSet, 'operation_chn', 'operation_code', '', '-', cbb_ReasonType.Items);

end;

procedure TAddPriceForm.FormCreate(Sender: TObject);
var
  sSQL,sErrMsg:WideString;
  vData:OleVariant;
begin

  //取错项原因
  FNMServerObj.GetBaseTableInfo(vData, 'fnPrizeReasonList', sErrMsg);
  if sErrMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  TempClientDataSet.Data := vData;
  FillItemsFromDataSet(TempClientDataSet, 'Reason', '', '', '', cbbReasonName.Items);

  //LOAD 发现人
  FillItemsFromDataSet(Dictionary.cds_WorkerList, 'Worker_ID', 'Worker_Name', 'iden', '-', cbb_Operator.Items);
  //LOAD 机台
  FillItemsFromDataSet(Dictionary.cds_FinishMachineList, 'machine_model_chn', 'machine_id', '', '-', cbb_Machine.Items);
  
end;

procedure TAddPriceForm.cbbReasonNameChange(Sender: TObject);
var
  sSelect:string;
  sSQL,sErrMsg:WideString;
  vData:OleVariant;
begin
  FNMServerObj.GetBaseTableInfo(vData, 'fnPrizeReasonList', sErrMsg);
  if sErrMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  TempClientDataSet.Data := vData;
  TempClientDataSet.Filter := 'Reason = ''' + cbbReasonName.Text + '''';
  TempClientDataSet.Filtered := True;
  cbb_Class.ItemIndex := cbb_Class.Items.IndexOf(TempClientDataSet.FieldByName('Prize').AsString);
  TempClientDataSet.Filtered := False;
end;

procedure TAddPriceForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TAddPriceForm.FormDestroy(Sender: TObject);
begin
  addpriceform:= nil;
end;

procedure TAddPriceForm.btn_SaveAccidentClick(Sender: TObject);
begin
  CheckData;
  if isOK then
    SaveData;
end;

procedure TAddPriceForm.SaveData();
var
  sSQL,sErrMsg:WideString;
  vData:OleVariant;

begin

  sFinder    := MidStr(cbb_Operator.Text,pos('-',cbb_Operator.Text) + 1,Length(cbb_Operator.Text) - pos('-',cbb_Operator.Text)) ;
  sMachineID := MidStr(cbb_Machine.Text,pos('-',cbb_Machine.Text) + 1,Length(cbb_Machine.Text) - pos('-',cbb_Machine.Text)) ;
  sOperation := MidStr(cbb_ReasonType.Text,pos('-',cbb_ReasonType.Text) + 1,Length(cbb_ReasonType.Text) - pos('-',cbb_ReasonType.Text)) ;
  sScore     := cbb_Class.Text;
  sReason    := cbbReasonName.Text;

  sSQL := '0,'+ QuotedStr(sFinder) + ',' + QuotedStr(sFncard) + ',' + QuotedStr(sMachineID) + ',' +
           QuotedStr(sOperation) + ',' + sScore + ',' + QuotedStr(sReason) + ',' +
           QuotedStr(login.CurrentDepartment) + ',' + QuotedStr(login.LoginID);
  FNMServerObj.GetQueryData(vData,'SaveWorkerPrice',sSQL,sErrMsg);
  if sErrMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  TMsgDialog.ShowMsgDialog('保存成功！', mtInformation);

  QueryData;

end;

procedure TAddPriceForm.CheckData();
var
  sFncard:string;
begin
  isOK := False;

  if lv_CardList.Selected = nil then
  begin
     TMsgDialog.ShowMsgDialog('请选择卡号!',mtInformation);
     isOK := False;
     Exit;
  end;
  sFncard := lv_CardList.Selected.Caption;

  if cbb_Operator.Text = '' then
  begin
    TMsgDialog.ShowMsgDialog('请选择发现人!',mtInformation);
    isOK := False;
    Exit;
  end;
  if cbb_Machine.Text = '' then
  begin
    TMsgDialog.ShowMsgDialog('请选择机台!',mtInformation);
    isOK := False;
    Exit;
  end;
  if cbb_ReasonType.Text = '' then
  begin
    TMsgDialog.ShowMsgDialog('请选择工序!',mtInformation);
    isOK := False;
    Exit;
  end;
  if cbb_Class.Text = '' then
  begin
    TMsgDialog.ShowMsgDialog('请选择分额!',mtInformation);
    isOK := False;
    Exit;
  end;
  if cbb_Class.Text <> '2' then
  begin
    if edtRespone.Text = '' then
    begin
      TMsgDialog.ShowMsgDialog('请选择责任人!',mtInformation);
      isOK := False;
      Exit;
    end;
  end;
  if cbbReasonName.Text = '' then
  begin
    TMsgDialog.ShowMsgDialog('请选择错项!',mtInformation);
    isOK := False;
    Exit;
  end;
  isOK := True;
end;

procedure TAddPriceForm.cbb_MachineChange(Sender: TObject);
begin
  sMachineID := MidStr(cbb_Machine.Text,pos('-',cbb_Machine.Text) + 1,Length(cbb_Machine.Text) - pos('-',cbb_Machine.Text)) ;
  //if (sFncard <> '') and (cbb_ReasonType.Text <> '') then
  //   GetWorkers;
end;

procedure TAddPriceForm.GetWorkers();
var
  sSQL,sErrMsg:WideString;
  vData:OleVariant;
begin
  sSQL := '2,' + QuotedStr(sFncard) + ',' + QuotedStr(sMachineID) + ',' + QuotedStr(sOperation) + ',' + QuotedStr(login.CurrentDepartment);
  FNMServerObj.GetQueryData(vData,'GetWorkerNames',sSQL,sErrMsg);
  if sErrMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  TempClientDataSet.Data := vData;
  if not TempClientDataSet.IsEmpty then
  begin
    edtRespone.Text := TempClientDataSet.fieldbyname('names').AsString;
  end;

end;

procedure TAddPriceForm.cbb_ReasonTypeChange(Sender: TObject);
begin
  //sOperation := MidStr(cbb_ReasonType.Text,pos('-',cbb_ReasonType.Text) + 1,Length(cbb_ReasonType.Text) - pos('-',cbb_ReasonType.Text)) ;
  // ID : 191523 edit by Kim Jin 2015-12-08
  sOperation := GetOperation(cbb_ReasonType.ItemIndex);
  if (sFncard <> '') and (cbb_Machine.Text <> '') then
     GetWorkers;
end;

procedure TAddPriceForm.Button1Click(Sender: TObject);
begin
  QueryData;
end;

procedure TAddPriceForm.QueryData();
var
  sSQL,sErrMsg:WideString;
  vData:OleVariant;
begin
  //刷新列表
  sSQL := '1';
  FNMServerObj.GetQueryData(vData,'SaveWorkerPrice',sSQL,sErrMsg);
  if sErrMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  cdsprice.Data := vData;
  GridDecorator.BindCxViewWithDataSource(cxgridtvPrice,dsprice,True);
end;

procedure TAddPriceForm.btn_CancelClick(Sender: TObject);
begin
  close;
end;

function TAddPriceForm.GetOperation(aItemIndex: Integer): string;
var
  i: Integer;
begin
  cdsReasonType.First;
  for i:= 0 to cdsReasonType.RecordCount - 1 do
  begin
    if i = aItemIndex then
    begin
      Result := cdsReasonType.FieldByName('operation_code').AsString;
      Break;
    end;
    cdsReasonType.Next;
  end;
end;

end.

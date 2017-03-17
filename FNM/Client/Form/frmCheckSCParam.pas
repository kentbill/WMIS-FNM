unit frmCheckSCParam;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DBClient;

type
  TCheckSCParamForm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    cbGF_NO: TComboBox;
    btnResfresh: TButton;
    btnOK: TButton;
    cxgridCheckInfo: TcxGrid;
    cxgridtvCheckInfo: TcxGridDBTableView;
    cxGridlCheckInfo: TcxGridLevel;
    cdsCheckInfo: TClientDataSet;
    dsCheckInfo: TDataSource;
    GroupBox4: TGroupBox;
    rdoCheck: TRadioButton;
    rdoNoCheck: TRadioButton;
    rdoAll: TRadioButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnResfreshClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CheckSCParamForm: TCheckSCParamForm;

implementation

uses
    Math, StrUtils, ServerDllPub, uFNMArtInfo,uFNMResource ,
    uDictionary, uShowMessage, uLogin, UAppOption, uGlobal, UGridDecorator;

{$R *.dfm}

procedure TCheckSCParamForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TCheckSCParamForm.FormDestroy(Sender: TObject);
begin
  CheckSCParamForm := nil;
end;

procedure TCheckSCParamForm.btnResfreshClick(Sender: TObject);
var
  sErrMsg,sSQL1:WideString;
  sSQL,sType,sGFNO:string;
  vData,vData1:OleVariant;
  i:Integer;
begin

  if rdoCheck.Checked then
     sType := 'checked'
  else if rdoNoCheck.Checked then
     sType := 'nochecke'
  else if rdoAll.Checked then
     sType := 'all';

  sGFNO := cbGF_NO.Text;

  sSQL := QuotedStr(sType) + ',' + QuotedStr(login.CurrentDepartment) + ',' + QuotedStr(sGFNO);
  FNMServerObj.GetQueryData(vData, 'CheckSCParam', sSQL, sErrMsg);
  if sErrMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  TempClientDataSet.Data := vData;
  cdsCheckInfo.Data := vData;

  GridDecorator.BindCxViewWithDataSource(cxgridtvCheckInfo, dsCheckInfo,True);
  GridDecorator.HideFields(cxgridtvCheckInfo,['iden']);     //隐藏IDEN

  //设置列编辑属性
  i:=0;
  while i < cxgridtvCheckInfo.ColumnCount do
  begin
     cxgridtvCheckInfo.Columns[i].Options.Editing := False;
     i:= i+ 1;
  end;
  cxgridtvCheckInfo.GetColumnByFieldName('Check_Value_Speed').Options.Editing:=true;
  cxgridtvCheckInfo.GetColumnByFieldName('Check_Value_QMJM').Options.Editing:=true;
end;

procedure TCheckSCParamForm.btnOKClick(Sender: TObject);
var
  vData,vData1: OleVariant;
  sFncard,sOperationCode,sStepno,sSpeed,sQMJM,sCondition:WideString;
  sErrorMsg,sSQL1: WideString;
  i:Integer;
begin

  with cxgridtvCheckInfo do
  begin
    DataController.SelectAll;
    for i:=0 to cxgridtvCheckInfo.DataController.RowCount - 1 do
    begin

      sFncard := sFncard + Controller.SelectedRows[i].Values[GetColumnByFieldName('fn_card').Index] + ',';
      sOperationCode := sOperationCode + Controller.SelectedRows[i].Values[GetColumnByFieldName('operation_code').Index] + ',';
      sStepno := sStepno + IntToStr(Controller.SelectedRows[i].Values[GetColumnByFieldName('step_no').Index])  + ',';
      sSpeed := sSpeed + Controller.SelectedRows[i].Values[GetColumnByFieldName('Check_Value_Speed').Index] + ',';
      sQMJM := sQMJM + Controller.SelectedRows[i].Values[GetColumnByFieldName('Check_Value_QMJM').Index] + ',';

    end;
  end;
  sCondition := QuotedStr(sFncard) + ',' + QuotedStr(sOperationCode) + ',' +QuotedStr(sStepno) + ',' + QuotedStr(sSpeed) + ',' + QuotedStr(sQMJM) + ',' + QuotedStr(login.LoginID) ;
  FNMServerObj.SaveDataBySQL('SaveCheckSCParam',sCondition, sErrorMsg);
  if sErrorMsg <> '' then
    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError)
  else
  begin
    cdsCheckInfo.MergeChangeLog;
    TMsgDialog.ShowMsgDialog('数据保存成功！', mtInformation);
  end;
end;

procedure TCheckSCParamForm.FormCreate(Sender: TObject);
var
  sErrMsg:WideString;
  sSQL:string;
  vData:OleVariant;
begin

  //load 待外发品名
  sSQL := QuotedStr('GFNO') + ',' + QuotedStr(login.CurrentDepartment) + ',' + QuotedStr('');
  FNMServerObj.GetQueryData(vData, 'CheckSCParam', sSQL, sErrMsg);
  if sErrMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  TempClientDataSet.Data := vData;
  TGlobal.FillItemsFromDataSet(TempClientDataSet, 'GF_NO', '', '', cbgf_no.Items);
  
end;

end.

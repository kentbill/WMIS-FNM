unit frmSaveScrapInfo;

interface

uses
  Windows, Messages, Classes, Controls, Graphics, ComCtrls, Forms,
  StdCtrls, Buttons, ExtCtrls, cxSpinEdit, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxButtonEdit, DB, Grids, ValEdit, DBClient, Menus;

type
  TSaveScrapInfoForm = class(TForm)
    GroupBox1: TGroupBox;
    lblQuantity: TLabel;
    edtQuantity: TEdit;
    lblMargin: TLabel;
    edtMargin: TEdit;
    btnSave: TButton;
    btnCancel: TButton;
    cboFabricNo: TComboBox;
    lblFabricNo: TLabel;
    cdsFabricNo: TClientDataSet;
    Label1: TLabel;
    edtSquad: TEdit;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
   GF_NO:string;
   FN_Card:string;
   Fabric_NO:string;
   Job_NO:string;
   Operation_Code:string;
   Machine_ID:string;
   Current_Department:string;
   Operator:string;
  public
    { Public declarations }

  end;

procedure CreateNewScrapInfo(sGF_NO :string;sFN_Card:string;sJob_NO:string;sOperation_Code:string;sMachine_ID:string;sCurrent_Department:string;sOperator:string);

implementation

uses SysUtils, Variants, StrUtils, uDictionary, UAppOption,
    uFNMArtInfo, Dialogs, uGlobal, ServerDllPub, uFNMResource,
    uLogin, uShowMessage;

{$R *.dfm}
var
  SaveScrapInfoForm: TSaveScrapInfoForm;


procedure CreateNewScrapInfo(sGF_NO :string;sFN_Card:string;sJob_NO:string;sOperation_Code:string;sMachine_ID:string;sCurrent_Department:string;sOperator:string);
var
  sSQL,sErrMsg:WideString;
  vData:OleVariant;
begin
  if SaveScrapInfoForm = nil then
    SaveScrapInfoForm:=TSaveScrapInfoForm.Create(Application);

  with SaveScrapInfoForm do
  begin
    GF_NO:= sGF_NO;
    FN_Card:= sFN_Card;
    //Fabric_NO:= sFabric_NO;
    Job_NO:=sJob_NO;
    Operation_Code:=sOperation_Code;
    Machine_ID:=sMachine_ID;
    Current_Department:=sCurrent_Department;
    Operator:=sOperator;

    sSQL := QuotedStr(FN_Card)+','''','''',' + '1';
    FNMServerObj.GetQueryData(vData, 'fnCheckRoll',sSQL ,sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    cdsFabricNo.Data := vData;
    if cdsFabricNo.RecordCount <= 0 then Exit;

    cboFabricNo.Items.Clear;
    cdsFabricNo.First;
    while not cdsFabricNo.Eof do
    begin
      cboFabricNo.Items.Add(cdsFabricNo.FieldByName('fabric_no').AsString);
      cdsFabricNo.Next;
    end;
    cboFabricNo.ItemIndex :=0;
  end;
  SaveScrapInfoForm.Show;
end;


procedure TSaveScrapInfoForm.btnSaveClick(Sender: TObject);
var
   sSQL,sErrMsg:WideString;
begin
  try
    if Operator = '' then
    begin
      Operator := Login.LoginID;
    end;

    sSQL := QuotedStr(GF_NO)+','+QuotedStr(FN_Card)+','+
                     QuotedStr(cboFabricNo.Text)+','+ QuotedStr(Job_NO)+','+
                     edtQuantity.Text + ',' + QuotedStr(edtMargin.Text) + ',' +
                     QuotedStr(Operation_Code) + ',' + QuotedStr(Machine_ID) + ',' +
                     QuotedStr(Current_Department)+','+ QuotedStr(Operator) + ',' + QuotedStr(edtSquad.Text);
    FNMServerObj.SaveDataBySQL('SaveScrapInfo',sSQL,sErrMsg);
    if sErrMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
    btnSave.Enabled := False;
  finally

  end;
end;

procedure TSaveScrapInfoForm.btnCancelClick(Sender: TObject);
begin
  Close;
end;

end.

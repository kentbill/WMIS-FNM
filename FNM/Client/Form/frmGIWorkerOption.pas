unit frmGIWorkerOption;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, DB, DBClient, frmBase;

type
  TWorkerOptionForm = class(TForm)
    PnlOption: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    LstWaitWorker: TListBox;
    LstWorker: TListBox;
    SBtnSelect: TSpeedButton;
    SBtnSelectAll: TSpeedButton;
    SBtnCleanAll: TSpeedButton;
    SBtnClean: TSpeedButton;
    cdsWorkerList: TClientDataSet;
    PnlInfo: TPanel;
    SBtnSave: TSpeedButton;
    SBtnExit: TSpeedButton;
    Label1: TLabel;
    EdtWorkerID: TEdit;
    SBtnQuery: TSpeedButton;
    Label2: TLabel;
    CBBDepartment: TComboBox;
    btnLocalQuery: TButton;
    cdsFNWorkerList: TClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure LstWaitWorkerDblClick(Sender: TObject);
    procedure LstWorkerDblClick(Sender: TObject);
    procedure SBtnSelectClick(Sender: TObject);
    procedure SBtnCleanClick(Sender: TObject);
    procedure SBtnSelectAllClick(Sender: TObject);
    procedure SBtnCleanAllClick(Sender: TObject);
    procedure SBtnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure SBtnExitClick(Sender: TObject);
    procedure SBtnQueryClick(Sender: TObject);
    procedure btnLocalQueryClick(Sender: TObject);
    procedure CBBDepartmentChange(Sender: TObject);
  private
    { Private declarations }
    procedure init;
    procedure FullWorker(aCDS : TClientDataSet; aLst : TStrings);
    function GetWorkerData(aWorkerID, aQueryWorkerID : String) : Boolean;
    function GetNowWorkerData(aWorkerID, aDepartment : String) : Boolean;
    procedure Move(srcList , destList : TStrings; moveIndex : integer);
    procedure MoveAll(srcList , destList : TStrings);
    procedure Save;
    procedure Query;
    procedure LocalQuery(aWorkerID : string);
    function CheckWorker(workerList : String) : Boolean;
  public
    { Public declarations }
  end;

var
  WorkerOptionForm: TWorkerOptionForm;

implementation

uses ServerDllPub, uLogin, uGlobal, uFNMResource, uShowMessage;

{$R *.dfm}

{ TWorkerOptionForm }

function TWorkerOptionForm.GetWorkerData(aWorkerID, aQueryWorkerID : String) : Boolean;  //aDepartment
var
  sql : string;
  sErrorMsg : WideString;
  vData : OleVariant;
begin
  Result := False;
  cdsFNWorkerList.Close;
  cdsFNWorkerList.Filter := '';
  sql := aWorkerID; //aDepartment + '|' + 
  if aQueryWorkerID <> '' then
    sql := sql + '|' + aQueryWorkerID;

  FNMServerObj.GetQueryData(vData, 'GiFullCarFabricsData', 'GetWorkerList,' + QuotedStr(sql), sErrorMsg);
  if Trim(sErrorMsg) <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
    Exit;
  end;//if
  cdsFNWorkerList.Data := vData;
  if(cdsFNWorkerList.Active) and (cdsFNWorkerList.RecordCount > 0) then
  begin
    FullWorker(cdsFNWorkerList, LstWaitWorker.Items);
    Result := True;
  end;//if
end;

function TWorkerOptionForm.GetNowWorkerData(aWorkerID, aDepartment: String): Boolean;
var
  sErrorMsg : WideString;
  vData : OleVariant;
  s : String;
begin
  Result := False;
  cdsWorkerList.Close;
  FNMServerObj.GetQueryData(vData, 'GiFullCarFabricsData', QuotedStr('GetNowWorkerList') + ',' + QuotedStr(aDepartment + '|' + aWorkerID), sErrorMsg);
  if Trim(sErrorMsg) <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
    Exit;
  end;//if
  cdsWorkerList.Data := vData;
  LstWorker.Items.Clear;
  if(cdsWorkerList.Active) and (cdsWorkerList.RecordCount > 0) then
  begin
    FullWorker(cdsWorkerList, LstWorker.Items);
    Result := True;
  end;//if
end;

procedure TWorkerOptionForm.init;
begin
  Self.Width := 698;
  SBtnExit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  SBtnQuery.Glyph.LoadFromResourceName(HInstance, RES_QUERY);

  CBBDepartment.Items.Add('G1');
  CBBDepartment.Items.Add('G2');
  CBBDepartment.Items.Add('G3');
  CBBDepartment.ItemIndex := 0;
end;

procedure TWorkerOptionForm.FullWorker(aCDS: TClientDataSet; aLst: TStrings);
begin
  aLst.Clear;
  aCDS.First;
  while not aCDS.Eof do
  begin
    aLst.Add(aCDS.FieldByName('Worker_ID').AsString + '->' + aCDS.FieldByName('Worker_Name').AsString);
    aCDS.Next;
  end;//while
end;


procedure TWorkerOptionForm.FormShow(Sender: TObject);
begin
  init;
end;

procedure TWorkerOptionForm.Move(srcList, destList: TStrings; moveIndex : integer);
begin
  if srcList.Count > 0 then
  begin
    if moveIndex < 0 then
      moveIndex := 0;

    if destList.IndexOf(srcList.Strings[moveIndex]) = -1 then //检查是否有重复
      destList.Add(srcList.Strings[moveIndex]);

    srcList.Delete(moveIndex);
  end;//if
end;

procedure TWorkerOptionForm.MoveAll(srcList, destList: TStrings);
var
  i : Integer;
begin
  for i := 0 to srcList.Count -1 do
    Move(srcList, destList, 0);
end;

procedure TWorkerOptionForm.LstWaitWorkerDblClick(Sender: TObject);
begin
  Move(LstWaitWorker.Items, LstWorker.Items, LstWaitWorker.ItemIndex);
end;

procedure TWorkerOptionForm.LstWorkerDblClick(Sender: TObject);
begin
  Move(LstWorker.Items, LstWaitWorker.Items, LstWorker.ItemIndex);
end;

procedure TWorkerOptionForm.SBtnSelectClick(Sender: TObject);
begin
  Move(LstWaitWorker.Items, LstWorker.Items, LstWaitWorker.ItemIndex);
end;

procedure TWorkerOptionForm.SBtnCleanClick(Sender: TObject);
begin
  Move(LstWorker.Items, LstWaitWorker.Items,LstWorker.ItemIndex);
end;

procedure TWorkerOptionForm.SBtnSelectAllClick(Sender: TObject);
begin
   MoveAll(LstWaitWorker.Items, LstWorker.Items);
end;

procedure TWorkerOptionForm.SBtnCleanAllClick(Sender: TObject);
begin
   MoveAll(LstWorker.Items, LstWaitWorker.Items);
end;

procedure TWorkerOptionForm.Save;
var
  i : Integer;
  workerID, sql, sErrorMsg : WideString;
  vData : OleVariant;
begin
  if LstWorker.Items.Count = 0 then
    Exit;

  if CBBDepartment.Text = '' then
  begin
    TMsgDialog.ShowMsgDialog('请选择人员班组部门',mtWarning);
    CBBDepartment.SetFocus;
    Exit;
  end;//if

  for i := 0 to LstWorker.Items.Count - 1 do
    workerID := workerID + copy(LstWorker.Items.Strings[i], 1, pos('->', LstWorker.Items.Strings[i]) - 1) + ',';

  if CheckWorker(workerID) then
  begin
    sql := QuotedStr('SaveWorker') + ',' +  QuotedStr(CBBDepartment.Text + '|' + Login.LoginID + '|' + workerID);//Login.CurrentDepartment
    FNMServerObj.GetQueryData(vData,'GiFullCarFabricsData', sql, sErrorMsg);

    if Trim(sErrorMsg) <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end else
      TMsgDialog.ShowMsgDialog('班组人员数据保存成功', mtInformation);
  end;//if
end;

procedure TWorkerOptionForm.SBtnSaveClick(Sender: TObject);
begin
  Save;
end;

procedure TWorkerOptionForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TWorkerOptionForm.FormDestroy(Sender: TObject);
begin
  WorkerOptionForm := nil;
end;

procedure TWorkerOptionForm.SBtnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TWorkerOptionForm.Query;
begin
  if GetWorkerData(Login.LoginID, '') then //Login.CurrentDepartment
  //if GetWorkerData('0002', 'G2', EdtWorkerID.Text) then
  begin
    SBtnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
    SBtnSave.Enabled := True;
    GetNowWorkerData(Login.LoginID, CBBDepartment.Text);
  end;//if
end;

procedure TWorkerOptionForm.SBtnQueryClick(Sender: TObject);
begin
  Query;
end;

procedure TWorkerOptionForm.LocalQuery(aWorkerID: string);
begin
  if cdsFNWorkerList.Active then
  begin
    if trim(aWorkerID) <> '' then
    begin
      cdsFNWorkerList.Filtered := False;
      cdsFNWorkerList.Filter := 'Worker_ID = ' + QuotedStr(aWorkerID);
      cdsFNWorkerList.Filtered := True;
    end
    else
    begin
      cdsFNWorkerList.Filtered := False;
      cdsFNWorkerList.Filter := '';
    end;//else
    FullWorker(cdsFNWorkerList, LstWaitWorker.Items);
  end;//if
end;

procedure TWorkerOptionForm.btnLocalQueryClick(Sender: TObject);
begin
  LocalQuery(EdtWorkerID.Text);
end;

procedure TWorkerOptionForm.CBBDepartmentChange(Sender: TObject);
begin
  GetNowWorkerData(Login.LoginID, CBBDepartment.Text);
end;

function TWorkerOptionForm.CheckWorker(workerList: String): Boolean;
var
  sql, sErrorMsg : WideString;
  vData : OleVariant;
begin
  Result := False;
  sql := QuotedStr('CheckWorker') + ',' +  QuotedStr(CBBDepartment.Text  + '|' + workerList);
  FNMServerObj.GetQueryData(vData, 'GiFullCarFabricsData', sql, sErrorMsg);
 if Trim(sErrorMsg) <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
    Exit;
  end;
  Result := True;
end;

end.

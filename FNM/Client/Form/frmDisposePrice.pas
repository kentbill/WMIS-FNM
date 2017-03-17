unit frmDisposePrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGrid,
  StdCtrls, ComCtrls, ExtCtrls, Buttons, DB, DBClient, cxDBData,
  cxGridDBTableView;

type
  TDisposePriceForm = class(TForm)
    Panel1: TPanel;
    tbcAccident: TTabControl;
    gbLeft: TGroupBox;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    btn_Exit: TBitBtn;
    btnSubmit: TBitBtn;
    cbb_Result: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    dsPrice: TDataSource;
    cdsPrice: TClientDataSet;
    cxgridPrice: TcxGrid;
    cxgridtvPrice: TcxGridDBTableView;
    cxgridlPrice: TcxGridLevel;
    mmRemark: TMemo;
    btnQuery: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure QueryData;
    procedure SaveData;
    procedure FilterPrice;
    procedure tbcAccidentChange(Sender: TObject);
    procedure btnSubmitClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DisposePriceForm: TDisposePriceForm;

implementation

uses StrUtils, uDictionary, UAppOption,
    uFNMArtInfo, uGlobal, ServerDllPub, uFNMResource,
    uLogin, uShowMessage,uGridDecorator;

{$R *.dfm}

procedure TDisposePriceForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TDisposePriceForm.FormDestroy(Sender: TObject);
begin
  DisposePriceForm:= nil;
end;

procedure TDisposePriceForm.QueryData();
var
  sSQL,sErrMsg:WideString;
  vData:OleVariant;
begin
  //刷新列表
  sSQL := '2';
  FNMServerObj.GetQueryData(vData,'SaveWorkerPrice',sSQL,sErrMsg);
  if sErrMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  cdsprice.Data := vData;
  GridDecorator.BindCxViewWithDataSource(cxgridtvPrice,dsprice,True);
end;

procedure TDisposePriceForm.FormCreate(Sender: TObject);
begin
  QueryData;
end;

procedure TDisposePriceForm.FilterPrice;
var
  iGrade:Integer;
begin
  if not cdsPrice.Active then Exit;

  iGrade := tbcAccident.TabIndex;

  cdsPrice.Filtered := False;
  cdsPrice.Filter := 'Grade= '+ IntToStr(iGrade);
  cdsPrice.Filtered := True;

  GridDecorator.BindCxViewWithDataSource(cxgridtvPrice,dsprice,True);
  //GridDecorator.BindcxTableView(cxgridtvPrice, cdsPrice, ['iden', 'group_id', 'fn_card', 'finder_id', 'machine_ID', 'Operation', 'score']);
  //cxgtv_AccidentList.Columns[cxgtv_AccidentList.FindItemByName('Grade').Index].Visible := False;

end;


procedure TDisposePriceForm.tbcAccidentChange(Sender: TObject);
begin
  FilterPrice;
end;

procedure TDisposePriceForm.btnSubmitClick(Sender: TObject);
begin
  SaveData;
end;

procedure TDisposePriceForm.SaveData;
var
  sIden:string;
  i:Integer;
  sSQL,sErrMsg:WideString;
  vData:OleVariant;
begin
  //刷新列表
  sIden := '';

  with cxgridtvPrice do
  begin
    for i:=0 to Controller.SelectedRowCount - 1 do
    begin
      sIden := sIden + IntToStr(Controller.SelectedRows[i].Values[GetColumnByFieldName('iden').Index]) + ',';
    end;
  end;
  
  if sIden = '' then Exit;

  sSQL := '3' + ',' + QuotedStr(sIden) + ',' + QuotedStr(cbb_Result.Text) + ',' + QuotedStr(mmRemark.Text) + ',' + QuotedStr(login.LoginID);
  FNMServerObj.GetQueryData(vData,'SaveWorkerPrice',sSQL,sErrMsg);
  if sErrMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
end;

procedure TDisposePriceForm.btnQueryClick(Sender: TObject);
begin
  QueryData;
  FilterPrice;
end;

procedure TDisposePriceForm.btn_ExitClick(Sender: TObject);
begin
  close;
end;

end.

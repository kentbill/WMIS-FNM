unit frmCPBCustomerGroup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, DB, DBClient, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Buttons, ExtCtrls, cxDBEdit,
  cxCheckBox, cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit, StdCtrls;

type
  TCPBCustomerGroupForm = class(TBaseForm)
    cdsCustomer: TClientDataSet;
    dsCustomer: TDataSource;
    pnl_Only: TPanel;
    cxgridtvCustomer: TcxGridDBTableView;
    cxGridlCustomer: TcxGridLevel;
    cxgridCustomer: TcxGrid;
    lbl1: TLabel;
    cxdbcbbGroup: TcxDBComboBox;
    cxdbcbIsActive: TcxDBCheckBox;
    btn_Query: TSpeedButton;
    btnSave: TSpeedButton;
    btn_Exit: TSpeedButton;
    btnCancel: TSpeedButton;
    lbl2: TLabel;
    cxdbte1: TcxDBTextEdit;
    cdsGroup: TClientDataSet;
    cxgdbcCustomerDBColumn1: TcxGridDBColumn;
    cxgdbcCustomerDBColumn2: TcxGridDBColumn;
    cxgdbcCustomerDBColumn3: TcxGridDBColumn;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure UpdateActions; override;
    procedure btnCancelClick(Sender: TObject);
    procedure btn_QueryClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetBtnState;
    procedure DataRefresh;
    procedure DataSave;
    procedure DataCancel;
    procedure DataQuery;
    function CloseQuery:Boolean;
  public
    { Public declarations }
  end;

var
  CPBCustomerGroupForm: TCPBCustomerGroupForm;

implementation

uses ServerDllPub, uGlobal, uShowMessage, uLogin, uGridDecorator, uFNMArtInfo;

{$R *.dfm}


{ TCPBCustomerGroupForm }

function TCPBCustomerGroupForm.CloseQuery: Boolean;
begin
  if not TGlobal.DeltaIsNull(cdsCustomer) then
  begin
    if TMsgDialog.ShowMsgDialog('数据未保存，是否保存！', mtConfirmation, [mebYes, mebNo], mebYes)= mrNo then
      Result := false;
  end
  else
    Result := False;
end;

procedure TCPBCustomerGroupForm.DataCancel;
begin
  cdsCustomer.CancelUpdates;
end;

procedure TCPBCustomerGroupForm.DataQuery;
begin
//
end;

procedure TCPBCustomerGroupForm.DataRefresh;
var
  vData:OleVariant;
  sErrMsg:WideString;
begin
  try
    ShowMsg('正在查询稍等！', crHourGlass);

    FNMServerObj.GetBaseTableInfo(vData, 'fnCPBCustomerGroup', sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    cdsGroup.Data := vData;

    if cdsGroup.IsEmpty then
      Exit;

    FillItemsFromDataSet(cdsGroup, 'Customer_Group','','','',cxdbcbbGroup.Properties.Items);

    FNMServerObj.GetBaseTableInfo(vData,'fnCPBCustomer',sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg,mtError);
      Exit;
    end;
    cdsCustomer.Data := vData;
    cdsCustomer.FieldByName('Customer').ReadOnly := True;
    GridDecorator.BindCxViewWithDataSource(cxgridtvCustomer, dsCustomer);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCPBCustomerGroupForm.DataSave;
var
  vData: OleVariant;
  sErrMsg: WideString;
begin
  try
    ShowMsg('', crHourGlass);
    if TGlobal.DeltaIsNull(cdsCustomer) then Exit;

    //保存数据
    vData := cdsCustomer.Delta;
    FNMServerObj.SaveBaseTableInfo(vData, 'fnCPBCustomer', 'Customer', sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    cdsCustomer.MergeChangeLog;
    TMsgDialog.ShowMsgDialog('保存成功!',mtInformation);
  finally
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TCPBCustomerGroupForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TCPBCustomerGroupForm.FormCreate(Sender: TObject);
begin
  DataRefresh;
end;

procedure TCPBCustomerGroupForm.FormDestroy(Sender: TObject);
begin
  CPBCustomerGroupForm := nil;
end;

procedure TCPBCustomerGroupForm.SetBtnState;
begin
  btnCancel.Enabled := not TGlobal.DeltaIsNull(cdsCustomer);
  btnSave.Enabled := btnCancel.Enabled;
  cxdbcbbGroup.Enabled := not cdsCustomer.IsEmpty;
end;

procedure TCPBCustomerGroupForm.UpdateActions;
begin
  inherited;
  SetBtnState;
end;

procedure TCPBCustomerGroupForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  DataCancel;
end;

procedure TCPBCustomerGroupForm.btn_QueryClick(Sender: TObject);
begin
  inherited;
  DataRefresh;
end;

procedure TCPBCustomerGroupForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  DataSave;
end;

procedure TCPBCustomerGroupForm.btn_ExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.


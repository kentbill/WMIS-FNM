unit frmCPBStock;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, Buttons, ExtCtrls, DB, ADODB, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, DBClient,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxSplitter, StdCtrls;

type
  TCPBStockForm = class(TBaseForm)
    adodsImport: TADODataSet;
    Panel2: TPanel;
    btnImport: TSpeedButton;
    btnSave: TSpeedButton;
    btnExit: TSpeedButton;
    cxGrid1: TcxGrid;
    cxGridDBTV: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cdsCPBIn: TClientDataSet;
    dsCPBIn: TDataSource;
    GroupBox1: TGroupBox;
    cxSplitter1: TcxSplitter;
    cxGrid2: TcxGrid;
    cxGridDBTVStock: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    dsCPBStock: TDataSource;
    btnRefresh: TSpeedButton;
    btnDelete: TSpeedButton;
    pnlAdd: TPanel;
    btnAdd: TSpeedButton;
    edtQuantity: TEdit;
    cbbFabric_Type: TComboBox;
    btnoK: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtConstruction: TEdit;
    Label5: TLabel;
    edtGF_NO: TEdit;
    cdsTemp: TClientDataSet;
    procedure btnImportClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure UpdateActions; override;
    procedure btnDeleteClick(Sender: TObject);
    procedure btnoKClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure edtQuantityKeyPress(Sender: TObject; var Key: Char);
    procedure edtGF_NOKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CPBStockForm: TCPBStockForm;

implementation

uses   ServerDllPub, uFNMResource, uShowMessage, uLogin, uGlobal, UGridDecorator, uDictionary;
{$R *.dfm}

procedure TCPBStockForm.btnImportClick(Sender: TObject);
var
  GFNOStr,QuantityStr, sFabricType,sCondition: string;
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取数据稍等！',crHourGlass);
    if cdsCPBIn.Active then
      cdsCPBIn.EmptyDataSet;
    GFNOStr := '';
    QuantityStr :='';
    TGlobal.GetRecordSetFromXLS(adodsImport);
    with adodsImport do
    begin
      if IsEmpty or (not Active) then Exit;
      First;
      while not Eof do
      begin
        GFNOStr := GFNOStr + FieldByName('品名').AsString + ',';
        QuantityStr := QuantityStr + FieldByName('数量').AsString + ',';
        sFabricType := sFabricType + FieldByName('布种').AsString + ',';
        Next;
      end;
      Close;
    end;
    sCondition := QuotedStr(GFNOStr)+','+QuotedStr(QuantityStr)+','+QuotedStr(sFabricType);
    FNMServerObj.GetQueryData(vData,'CPBGetIn',sCondition,sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsCPBIn.Data := vData;
    GridDecorator.BindCxViewWithDataSource(cxGridDBTV, dsCPBIn);
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;    
end;

procedure TCPBStockForm.btnSaveClick(Sender: TObject);
var
  GFIDStr,QuantityStr, sFabricType, sCondition: string;
  sErrorMsg: WideString;
begin
  inherited;
  GFIDStr := '';
  QuantityStr :='';
  with cdsCPBIn do
  begin
    if IsEmpty or (not Active) then Exit;
    First;
    while not Eof do
    begin
      GFIDStr := GFIDStr + FieldByName('GF_ID').AsString + ',';
      QuantityStr := QuantityStr + FieldByName('Quantity').AsString + ',';
      sFabricType := sFabricType + FieldByName('Fabric_Type').AsString + ',';
      Next;
    end;
  end;
  sCondition := QuotedStr(GFIDStr)+','+QuotedStr(QuantityStr)+','+QuotedStr(sFabricType)+','+QuotedStr(Login.CurrentDepartment)+','+QuotedStr(Login.LoginID);;
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
    FNMServerObj.SaveDataBySQL('CPBSaveIn',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    btnRefresh.Click;
    TMsgDialog.ShowMsgDialog('保存数据成功',mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCPBStockForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TCPBStockForm.FormDestroy(Sender: TObject);
begin
  inherited;
  CPBStockForm := nil;
end;

procedure TCPBStockForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  if Dictionary.cds_CPBStock.Active then
    Dictionary.cds_CPBStock.Close;
  dsCPBStock.DataSet := Dictionary.cds_CPBStock;
  GridDecorator.BindCxViewWithDataSource(cxGridDBTVStock, dsCPBStock);
end;

procedure TCPBStockForm.FormCreate(Sender: TObject);
begin
  inherited;
  btnImport.Glyph.LoadFromResourceName(HInstance, RES_EXOPRTFILE);
  btnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnExit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
end;

procedure TCPBStockForm.btnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TCPBStockForm.UpdateActions;
begin
  inherited;
  btnSave.Enabled := not cdsCPBIn.IsEmpty;
end;

procedure TCPBStockForm.btnDeleteClick(Sender: TObject);
var
  sCondition: String;
  sGF_Id,sGF_NO: string;
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  inherited;
  if cxGridDBTVStock.DataController.DataSource = nil then Exit;
  With cxGridDBTVStock.DataController.DataSource.DataSet do
  begin
    if not IsEmpty then
    begin
      if MessageDlg('你确认要删除该记录吗?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;

      sGF_Id:= cxGridDBTVStock.DataController.DataSource.DataSet.FieldByName('GF_ID').AsString;
      sGF_NO:= '';
      sCondition := '1,' + sGF_Id + ',' + QuotedStr(sGF_NO) + ',0,'
        + QuotedStr('0')+','+QuotedStr(Login.CurrentDepartment);
      try
        ShowMsg('正在获取数据稍等！', crHourGlass);
        FNMServerObj.SaveDataBySQL('CPBStockUpdate',sCondition,sErrorMsg);
        if sErrorMsg <> '' then
        begin
          TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
          Exit;
        end;
        btnRefresh.Click;
        TMsgDialog.ShowMsgDialog('删除数据成功！',mtInformation);
      finally
        ShowMsg('', crDefault);
      end;
    end;
  end;
end;

procedure TCPBStockForm.btnoKClick(Sender: TObject);
var
  sCondition: String;
  sGF_Id,sGF_NO, sQuantity,sFabric_Type: string;
  sErrorMsg: WideString;
begin
  inherited;
  if Trim(edtGF_NO.Text) = '' then
  begin
    TMsgDialog.ShowMsgDialog('品名不能为空！',mtInformation);
    Exit;
  end;
  
  sGF_NO:= Trim(edtGF_NO.Text);
  sQuantity:= Trim(edtQuantity.Text);
  sFabric_Type:= Trim(cbbFabric_Type.Text);
  sCondition := '2,0,'+ QuotedStr(sGF_NO) + ','+ sQuantity+ ','
    + QuotedStr(sFabric_Type)+','+QuotedStr(Login.CurrentDepartment);
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
    FNMServerObj.SaveDataBySQL('CPBStockUpdate',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    btnRefresh.Click;
    TMsgDialog.ShowMsgDialog('新增数据成功！',mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCPBStockForm.btnAddClick(Sender: TObject);
begin
  inherited;
  pnlAdd.Left := round((Self.Width - 8 - pnlAdd.Width) / 2);
  pnlAdd.Top :=  round((Self.Height - 8 - pnlAdd.Height) / 2);
  pnlAdd.Visible:= True;
  edtGF_NO.SetFocus;
  edtQuantity.Text:= '0';
  cbbFabric_Type.ItemIndex:= 7;
end;

procedure TCPBStockForm.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  pnlAdd.Visible:= False;
end;

procedure TCPBStockForm.edtQuantityKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not (Key in ['0'..'9','.',#8,#27]) then
  begin
    Key:= #0;
  end;
end;

procedure TCPBStockForm.edtGF_NOKeyPress(Sender: TObject; var Key: Char);
var
  sCondition: String;
  sGF_NO,sQuantity,sFabric_Type: string;
  sErrorMsg: WideString;
  vData: OleVariant;
begin
  inherited;
  if Key = #13 then
  begin
    if Trim(edtGF_NO.Text) <> '' then
    begin
      sGF_NO:= Trim(edtGF_NO.Text);
      sQuantity:= Trim(edtQuantity.Text);
      sFabric_Type:= Trim(cbbFabric_Type.Text);
      sCondition := '3,0,' + QuotedStr(sGF_NO) +','+ QuotedStr(sQuantity)+ ','
        + QuotedStr(sFabric_Type)+','+QuotedStr(Login.CurrentDepartment);
      try
        ShowMsg('正在获取数据稍等！', crHourGlass);
        FNMServerObj.GetQueryData(vData,'CPBStockUpdate',sCondition,sErrorMsg);
        if sErrorMsg <> '' then
        begin
          TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
          Exit;
        end;
        cdsTemp.Data:=vData;
        if not cdsTemp.IsEmpty then
          edtConstruction.Text:= cdsTemp.FieldByName('Construction').AsString;
      finally
        ShowMsg('', crDefault);
      end;

    end;
  end;
end;

end.

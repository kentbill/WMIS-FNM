unit frmOutRework;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, DBClient, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, Buttons, StdCtrls, DBCtrls, Mask, ComCtrls,
  MakeSQL, cxSplitter;

type
  TOutReworkFrom = class(TForm)
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    OutRemarkTV: TcxGridDBTableView;
    OutRemarkLV: TcxGridLevel;
    cxgrdOutRemark: TcxGrid;
    cdsOutRemark: TClientDataSet;
    dsOutRemark: TDataSource;
    lbl1: TLabel;
    edtFabricNO: TEdit;
    dbedtProduct_count: TDBEdit;
    lbl2: TLabel;
    dbedtRework_reason: TDBEdit;
    dbedthandle_situation: TDBEdit;
    dbedtlevels: TDBEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    dbcbbhandle_way: TDBComboBox;
    btnSelect: TSpeedButton;
    btnSave: TSpeedButton;
    lbl5: TLabel;
    dbedthandle_person: TDBEdit;
    btn3: TSpeedButton;
    pnl4: TPanel;
    pnl5: TPanel;
    FabricTV: TcxGridDBTableView;
    FabricLV: TcxGridLevel;
    cxgrd1: TcxGrid;
    btnadd: TSpeedButton;
    btnAlter: TSpeedButton;
    cdsFabric: TClientDataSet;
    dsFabric: TDataSource;
    btnDelte: TSpeedButton;
    btn1: TSpeedButton;
    pnl6: TPanel;
    pnl7: TPanel;
    btnAdds: TSpeedButton;
    btnAddAll: TSpeedButton;
    btnCancel: TSpeedButton;
    btn2: TSpeedButton;
    btnCancelAll: TSpeedButton;
    btnSaves: TSpeedButton;
    pgc1: TPageControl;
    pgOutReworkNew: TTabSheet;
    pgOutWorkQuery: TTabSheet;
    pnl9: TPanel;
    cxgrdbtblvwOutReworkQueryLV: TcxGridDBTableView;
    cxgrdOutReworkQueryTV: TcxGridLevel;
    cxgrdOutReworkQuery: TcxGrid;
    pnl8: TPanel;
    pnl10: TPanel;
    btn4: TSpeedButton;
    sqmmk1: TMakeSQL;
    pnl11: TPanel;
    cdsOutReworkQuery: TClientDataSet;
    dsOutReworkQuery: TDataSource;
    cdsWorkers: TClientDataSet;
    dsWorkers: TDataSource;
    pnl12: TPanel;
    procedure btnSelectClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure initialize;
    procedure btnaddClick(Sender: TObject);
    procedure btnAlterClick(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btnDelteClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btnAddsClick(Sender: TObject);
    procedure Add ;
    procedure btnAddAllClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCancelAllClick(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btnSavesClick(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure cxgrd1DblClick(Sender: TObject);
    procedure FabricTVDblClick(Sender: TObject);
    procedure dbcbbhandle_wayExit(Sender: TObject);
  private
    is_handnew:Boolean;
    { Private declarations }
  public
    workers:string;
    { Public declarations }
  end;

var
  OutReworkFrom: TOutReworkFrom;

implementation
uses uShowMessage,ServerDllPub, uLogin, UAppOption, uGlobal, uGridDecorator,
  frmSelectWorker;

{$R *.dfm}

procedure TOutReworkFrom.btnSelectClick(Sender: TObject);
var
  sSQL, sErrMsg:WideString;
  vData:Olevariant;
begin
//    IF edtFabricNO.Text='' then
  //  begin
  //       showmessage('请先输入 回修布号');
       //  exit;
   // end;
    //查询布号信息
    sSQL:= 'EXEC usp_GetOutReworkFabric ' +QuotedStr(login.CurrentDepartment)+','+QuotedStr(edtFabricNO.Text)  ;
    FNMServerObj.GetQueryBySQL(vData, sSQL, sErrMsg);
  if sErrMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg,mtError);
    Exit;
  end;
   cdsFabric.Data:=vData;
   GridDecorator.BindCxViewWithDataSource(FabricTV, dsFabric);

   {*//查询已登记的布号信息
   // sSQL:= 'select * from fnmdb..fnOutRework where fabric_no= ' +QuotedStr(edtFabricNO.Text)  ;
    //showmessage(sSQL);
   // FNMServerObj.GetQueryBySQL(vData, sSQL, sErrMsg);
  if sErrMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg,mtError);
    Exit;
  end;
   cdsOutRemark.Data:=vData; *}
  showmessage('查询成功');

end;

procedure TOutReworkFrom.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   action:=caFree;
end;

procedure TOutReworkFrom.FormDestroy(Sender: TObject);
begin
   OutReworkFrom:=nil;
end;

procedure TOutReworkFrom.btnSaveClick(Sender: TObject);
var
    vData:OleVariant;
    sErrorMsg,sErrMsg:WideString;
    sSQL,worker:WideString;
    iden:string;
begin
    //保存到拆卷记录表
    vData:=cdsOutRemark.Delta;
    FNMServerObj.SaveBaseTableInfo(vData, 'fnmdb.dbo.fnOutRework', 'Iden', sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;

    //保存后，重新加载data，更新iden到处理人表
    sSQL:= 'select * from fnmdb..fnOutRework where fabric_no= ' +QuotedStr(edtFabricNO.Text)  ;
    FNMServerObj.GetQueryBySQL(vData, sSQL, sErrMsg);
  if sErrMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg,mtError);
    Exit;
  end;
   cdsOutRemark.Data:=vData;

    iden:=cdsOutRemark.fieldbyname('iden').asstring;
    worker:=cdsOutRemark.fieldbyname('handle_person').asstring;
    //保存处理人
    sSQL:= 'EXEC usp_GetOutReworkFabric ' +QuotedStr(login.CurrentDepartment)+','+''''''+','+'3'+','+QuotedStr(iden)+','+QuotedStr(worker)  ;
    FNMServerObj.GetQueryBySQL(vData, sSQL, sErrMsg);
    if sErrMsg<>'' then
    begin
     TMsgDialog.ShowMsgDialog(sErrMsg,mtError);
     Exit;
    end;

    pnl3.Enabled:=True;
    pnl3.Color:= clBtnFace;
    showmessage('保存成功！');
end;

procedure TOutReworkFrom.FormCreate(Sender: TObject);
begin
      initialize;
      is_handnew:=False;

end;

procedure TOutReworkFrom.initialize;
var
  ssql:string;
  vdata:OleVariant;
  sErrMsg:WideString;
begin
    sSQL:= 'select * from fnmdb..fnOutRework where 1=2';
    FNMServerObj.GetQueryBySQL(vData, sSQL, sErrMsg);
   if sErrMsg<>'' then
   begin
     TMsgDialog.ShowMsgDialog(sErrMsg,mtError);
     Exit;
   end;
   cdsOutRemark.Data:=vData;
   GridDecorator.BindCxViewWithDataSource(OutRemarkTV, dsOutRemark);

   //初始化workers的值
    sSQL:= 'select top 1 handle_person from fnmdb..fnOutRework order by iden desc';
    FNMServerObj.GetQueryBySQL(vData, sSQL, sErrMsg);
   if sErrMsg<>'' then
   begin
     TMsgDialog.ShowMsgDialog(sErrMsg,mtError);
     Exit;
   end;
   cdsWorkers.Data:=vData;

   workers:= cdsWorkers.fieldbyname('handle_person').AsString;

   //初始化
   pnl7.Enabled:=False;
   pnl7.Color:= clBtnShadow;

end;

procedure TOutReworkFrom.btnaddClick(Sender: TObject);
begin
    if cdsOutRemark.RecordCount>0 then
    begin
      showmessage('该布号之前已做登记,修改信息请点击 修改按钮');
      exit;
    end;

    pnl7.Enabled:=True;
    pnl7.Color:= clBtnFace;

    cdsOutRemark.Append;
    with cdsOutRemark do
    begin
    cdsOutRemark.Edit;
    FieldByName('GF_NO').AsString:=cdsFabric.FieldByName('GF_NO').AsString;
    FieldByName('Fabric_NO').AsString:=cdsFabric.FieldByName('Fabric_NO').AsString;
    FieldByName('Quantity').AsString:=cdsFabric.FieldByName('Quantity').AsString;
    FieldByName('Rework_reason').AsString:=cdsFabric.FieldByName('Rework_reason').AsString;
    FieldByName('operate_time').AsDateTime:=Now;
    end;

end;

procedure TOutReworkFrom.btnAlterClick(Sender: TObject);
begin

    pnl3.Enabled:=True;
    pnl3.Color:= clBtnFace;
end;

procedure TOutReworkFrom.btn3Click(Sender: TObject);
var
  i:Integer;
  sFabric_NO:string;
begin
    cdsOutRemark.Edit;
  if not Assigned(SelectWorkerForm) then
    SelectWorkerForm:= TSelectWorkerForm.Create(Self);
    SelectWorkerForm.ShowModal;

    if  is_handnew then
      dbedthandle_person.Text:=workers
     else
     begin
    //更新所有的处理人
    OutRemarkTV.DataController.SelectAll;
    for i := OutRemarkTV.Controller.SelectedRowCount - 1 downto 0 do
    begin
         with OutRemarkTV do
         sFabric_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Fabric_NO').Index];

       if cdsOutRemark.Locate('Fabric_NO', sFabric_NO, []) then
       begin
         cdsOutRemark.edit;
          //ShowMessage(cdsOutRemark.FieldByName('Fabric_NO').AsString);
         cdsOutRemark.FieldByName('handle_person').AsString:=workers;
         //ShowMessage('test');
         end;
    end;
    end;

end;

procedure TOutReworkFrom.btnDelteClick(Sender: TObject);
var
  iden:string;
  vdata:OleVariant;
  ssql,sErrMsg:WideString;
begin
     if cdsOutRemark.RecordCount<1 then
     begin
       ShowMessage('没有该布号的登记信息，不允许删除！');
       exit;
     end;
     showmessage(cdsOutRemark.fieldbyname('iden').AsString);
     iden:=cdsOutRemark.fieldbyname('iden').AsString;

      IF edtFabricNO.Text='' then
    begin
         showmessage('请先输入 回修布号');
         exit;
    end;
    //查询布号信息
    sSQL:= 'EXEC usp_GetOutReworkFabric ' +QuotedStr(login.CurrentDepartment)+','+''''''+','+'2'+','+QuotedStr(iden)  ;

    //showmessage(sSQL);
    FNMServerObj.GetQueryBySQL(vData, sSQL, sErrMsg);
    if sErrMsg<>'' then
    begin
     TMsgDialog.ShowMsgDialog(sErrMsg,mtError);
     Exit;
    end
    else ShowMessage('数据删除成功');
    cdsOutRemark.data:=null;


end;

procedure TOutReworkFrom.btn1Click(Sender: TObject);
begin
        close;
end;

procedure TOutReworkFrom.btnAddsClick(Sender: TObject);
begin
   // if Sender = btnAdds then
   // FabricTV.DataController.SelectAll;

  Add;
  pnl7.Enabled:=True;
  pnl7.Color:= clBtnFace;
end;

procedure TOutReworkFrom.Add;
 var
    i, j: Integer;
    sFabric_NO: string;
begin
     if FabricTV.Controller.SelectedRowCount = 0 then exit;
     //if not CheckData then Exit;
     try
    cdsFabric.DisableControls;
    for i :=FabricTV.Controller.SelectedRowCount - 1 downto 0 do
    begin
      with FabricTV do
         sFabric_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Fabric_NO').Index];

      if cdsFabric.Locate('Fabric_NO', sFabric_NO, []) then
      begin
        cdsOutRemark.Append;
        cdsOutRemark.Edit;
        cdsOutRemark.FieldByName('GF_NO').AsString:=cdsFabric.FieldByName('GF_NO').AsString;
        cdsOutRemark.FieldByName('Fabric_NO').AsString:=cdsFabric.FieldByName('Fabric_NO').AsString;
        cdsOutRemark.FieldByName('Quantity').AsString:=cdsFabric.FieldByName('Quantity').AsString;
        cdsOutRemark.FieldByName('Rework_reason').AsString:=cdsFabric.FieldByName('Rework_reason').AsString;
        cdsOutRemark.FieldByName('note_no').AsString:=cdsFabric.FieldByName('note_no').AsString;
        cdsOutRemark.FieldByName('operate_time').AsDateTime:=Now;
        cdsOutRemark.FieldByName('handle_person').AsString:=workers;
        cdsFabric.Edit;
        cdsFabric.FieldByName('Print_Card').Value := 1;
      end
      else
        TMsgDialog.ShowMsgDialog('不能定位这个布号！', mtWarning);
    end;
  finally
    cdsFabric.EnableControls;
  end;
  cdsFabric.FindNext;

  with FabricTV do
    DataController.ClearSelection;

   cdsFabric.Filtered:=False;
    cdsFabric.Filter :='Print_Card=''0''' ;
   cdsFabric.Filtered:=True;



end;

procedure TOutReworkFrom.btnAddAllClick(Sender: TObject);
begin
   FabricTV.DataController.SelectAll;
   add;
   pnl7.Enabled:=True;
   pnl7.Color:= clBtnFace;
end;

procedure TOutReworkFrom.btnCancelClick(Sender: TObject);
var
  i:Integer;
  sFabric_NO:string;
begin
  if OutRemarkTV.Controller.SelectedRowCount = 0 then exit;

  with cdsFabric do
  try
    DisableControls;
    Filtered := false;
    for i := OutRemarkTV.Controller.SelectedRowCount - 1 downto 0 do
    begin
      with OutRemarkTV do
         sFabric_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Fabric_NO').Index];

      if cdsOutRemark.Locate('Fabric_NO', sFabric_NO, []) then
        cdsOutRemark.Delete;

      if Locate('Fabric_NO', sFabric_NO, []) then
      begin
        Edit;
        FieldByName('Print_Card').Value := 0;
      end;
    end;
  finally
    Filter :='Print_Card=''0''' ;
    Filtered := true;
    EnableControls;
  end;

end;

procedure TOutReworkFrom.btnCancelAllClick(Sender: TObject);
var
  i:Integer;
  sFabric_NO:string;
begin
   OutRemarkTV.DataController.SelectAll;
  with cdsFabric do
  try
    DisableControls;
    Filtered := false;
    for i := OutRemarkTV.Controller.SelectedRowCount - 1 downto 0 do
    begin
      with OutRemarkTV do
         sFabric_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Fabric_NO').Index];

      if cdsOutRemark.Locate('Fabric_NO', sFabric_NO, []) then
        cdsOutRemark.Delete;

      if Locate('Fabric_NO', sFabric_NO, []) then
      begin
        Edit;
        FieldByName('Print_Card').Value := 0;
      end;
    end;
  finally
    Filter :='Print_Card=''0''' ;
    Filtered := true;
    EnableControls;
  end;
end;

procedure TOutReworkFrom.btn2Click(Sender: TObject);
begin
    pnl7.Enabled:=True;
    pnl7.Color:= clBtnFace;

    is_handnew:=True;
end;

procedure TOutReworkFrom.btnSavesClick(Sender: TObject);
var
    vData:OleVariant;
    sErrorMsg,sErrMsg:WideString;
    sSQL,worker:WideString;
    iden:string;
    i : Integer;
begin
    //保存到拆卷记录表
    if TGlobal.DeltaIsNull(cdsOutRemark) then Exit;

    //检查处理方式不可以空
    OutRemarkTV.DataController.SelectAll;
    cdsOutRemark.First;
    for i := OutRemarkTV.Controller.SelectedRowCount - 1 downto 0 do
    begin
        if cdsOutRemark.FieldByName('handle_way').AsString ='' then
        begin
          showmessage('处理方式为空，请先选择！');
          exit;
        end;
         cdsOutRemark.Next;
    end;

    vData:=cdsOutRemark.Delta;
    FNMServerObj.SaveBaseTableInfo(vData, 'fnmdb.dbo.fnOutRework', 'Iden', sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;

    //保存到人员表
     sSQL:= 'EXEC usp_GetOutReworkFabric '''','''' '+',4'  ;
    // showmessage(sSQL);
     FNMServerObj.GetQueryBySQL(vData, sSQL, sErrMsg);
  if sErrMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg,mtError);
    Exit;
  end;
    initialize;
    showmessage('保存成功');

end;

procedure TOutReworkFrom.btn4Click(Sender: TObject);
 var
  QueryCondition: string;
  sSQL, sErrMsg:WideString;
  vData:Olevariant;
Begin
  QueryCondition := sqmmk1.GetSql;
  if QueryCondition = '' then exit;

  //showmessage(QueryCondition);

  sSQL:= 'EXEC usp_GetOutReworkFabric '''' '+','+QuotedStr(QueryCondition)+',5'  ;
  // showmessage(sSQL);

  FNMServerObj.GetQueryBySQL(vData, sSQL, sErrMsg);
  if sErrMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg,mtError);
    Exit;
  end;
   cdsOutReworkQuery.Data:=vData;
   GridDecorator.BindCxViewWithDataSource(cxgrdbtblvwOutReworkQueryLV, dsOutReworkQuery);

  
end;

procedure TOutReworkFrom.cxgrd1DblClick(Sender: TObject);
begin
  Add;
  pnl7.Enabled:=True;
  pnl7.Color:= clBtnFace;

end;

procedure TOutReworkFrom.FabricTVDblClick(Sender: TObject);
begin
     Add;
  pnl7.Enabled:=True;
  pnl7.Color:= clBtnFace;
end;

procedure TOutReworkFrom.dbcbbhandle_wayExit(Sender: TObject);
var
  i:Integer;
  HandleWay:string;
begin
   HandleWay:=dbcbbhandle_way.Text;
   if HandleWay<>'' then
   begin
    //更新所有的处理方式
    OutRemarkTV.DataController.SelectAll;
    cdsOutRemark.First;
    for i := OutRemarkTV.Controller.SelectedRowCount - 1 downto 0 do
    begin
         cdsOutRemark.edit;
         cdsOutRemark.FieldByName('handle_way').AsString:=HandleWay;
         cdsOutRemark.Next;
    end;
    end;
   end;

end.

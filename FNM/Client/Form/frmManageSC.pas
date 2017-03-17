unit frmManageSC;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmSendInfoCheck.pas                                          }
{       创建日期 2004-8-26 16:20:05                                            }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{            读: FNMDB..fnJobTraceHdr表所有字段                                }
{            写: FNMDB..fnJobTraceHdr表字段Art_Check及Art_Check_Time           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述 送布前工艺CHECK                                               }
{                                                                              }
{******************************************************************************}


interface

uses
  uFNMResource, Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,Dialogs, frmBase, StdCtrls, ExtCtrls, OleCtrls, Buttons,
  DB, DBClient, ComCtrls, StrUtils, GFCADLib_TLB, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxSplitter, CheckLst, Math, cxGridBandedTableView,
  cxGridDBBandedTableView, cxCheckBox, cxGridCustomPopupMenu,
  cxGridPopupMenu, cxDropDownEdit,cxGridDBDataDefinitions;

type
  TManageSCForm = class(TBaseForm)
    cdsSendInfo: TClientDataSet;
    dsSendInfo: TDataSource;
    cdsUnSelect: TClientDataSet;
    dsUnSelect: TDataSource;
    cdsSelect: TClientDataSet;
    dsSelect: TDataSource;
    pgcMain: TPageControl;
    tsReceive: TTabSheet;
    tsReject: TTabSheet;
    pnlLeft: TPanel;
    cxSplitter1: TcxSplitter;
    cxdbgUnSelect: TcxGrid;
    cxdbgtvUnSelect: TcxGridDBTableView;
    cxGridlUnSelect: TcxGridLevel;
    lstFNCard: TListBox;
    pnlCard: TPanel;
    pnl2: TPanel;
    btnAdd: TSpeedButton;
    btnUp: TSpeedButton;
    btnCancel: TSpeedButton;
    btnDown: TSpeedButton;
    cxdbgSelect: TcxGrid;
    cxdbgtvSelect: TcxGridDBTableView;
    cxGridlSelect: TcxGridLevel;
    cxspl1: TcxSplitter;
    cxgridSendInfo: TcxGrid;
    cxgridtvSendInfo: TcxGridDBTableView;
    cxGridlcxgrid2Level1: TcxGridLevel;
    pnlTop: TPanel;
    lblContractNO: TLabel;
    btnRefresh: TSpeedButton;
    btnSave: TSpeedButton;
    btnClose: TSpeedButton;
    cbbContractNO: TComboBox;
    tsRjtApr: TTabSheet;
    pnlRejectBottom: TPanel;
    pnlRejectClient: TPanel;
    pnlRejectFnCardDetail: TPanel;
    cxgrdlvlFnCardDetl: TcxGridLevel;
    cxgrdFnCardDetl: TcxGrid;
    cxgrdbndtblvwFnCardDetl: TcxGridDBBandedTableView;
    cxgrdbndclmnRejectChecked: TcxGridDBBandedColumn;
    cxgrdbndclmnRejectFabric_NO: TcxGridDBBandedColumn;
    pnlRejectFncardTop: TPanel;
    btnSearch: TSpeedButton;
    edtFnCard: TEdit;
    lblFnCard: TLabel;
    edtFabricNo: TEdit;
    lblFabricNo: TLabel;
    cxgrdbndclmnRejectFN_Card: TcxGridDBBandedColumn;
    cxgrdbndclmnRejectGF_ID: TcxGridDBBandedColumn;
    cxgrdbndclmnRejectGF_NO: TcxGridDBBandedColumn;
    cxgrdbndclmnRejectJob_NO: TcxGridDBBandedColumn;
    cxgrdbndclmnRejectQuantity: TcxGridDBBandedColumn;
    dsReject: TDataSource;
    cdsReject: TClientDataSet;
    pnl1: TPanel;
    btnRejectExit: TSpeedButton;
    btnRejectSave: TSpeedButton;
    cxgrdpmnReject: TcxGridPopupMenu;
    pnlAprBottom: TPanel;
    pnlAprBottomRight: TPanel;
    btnAprExit: TSpeedButton;
    btnAprSave: TSpeedButton;
    Panel1: TPanel;
    Panel2: TPanel;
    cxgrdAprFnCardDetl: TcxGrid;
    cxgrdbndtblvwAprFnCardDetl: TcxGridDBBandedTableView;
    cxgrdbndclmnAprIs_Select: TcxGridDBBandedColumn;
    cxGridDBBandedColumn2: TcxGridDBBandedColumn;
    cxGridDBBandedColumn3: TcxGridDBBandedColumn;
    cxGridDBBandedColumn4: TcxGridDBBandedColumn;
    cxGridDBBandedColumn5: TcxGridDBBandedColumn;
    cxGridDBBandedColumn6: TcxGridDBBandedColumn;
    cxGridDBBandedColumn7: TcxGridDBBandedColumn;
    cxgrdlvlAprFnCardDetl: TcxGridLevel;
    Panel3: TPanel;
    btnAprSearch: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    edtAprFnCard: TEdit;
    edtAprFabricNo: TEdit;
    cdsApr: TClientDataSet;
    dsApr: TDataSource;
    cbbOpType: TComboBox;
    cxgrdbndclmnSC_Contract_NO: TcxGridDBBandedColumn;
    cxgrdbndclmnIS_BACK_FABRIC: TcxGridDBBandedColumn;
    cxgrdbndclmnIden: TcxGridDBBandedColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cdsUnSelectFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure btnAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure cxdbgtvUnSelectKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxdbgtvSelectKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsSelectFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure cbbContractNOSelect(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnRejectSaveClick(Sender: TObject);
    procedure btnRejectExitClick(Sender: TObject);
    procedure cbbOpTypeChange(Sender: TObject);
    procedure btnAprSearchClick(Sender: TObject);
    procedure btnAprSaveClick(Sender: TObject);

  private
    { Private declarations }
    sContract_NO :string;
    Is_Approve_Man:Boolean;
    procedure Initialize;
    procedure Add;
    procedure Cancel;
    procedure GetSCInfo;
    procedure GetData;
    procedure SaveSCInfo;
    procedure SaveData;

    procedure SetGridReadOnly(argGrid:TcxGridTableView;escapeColNames:TStringList);
    procedure SetGridData(argOpType:string);
    function GetDilimiterStringFromCxGrid(argGrid:TcxGrid;argFieldName,argDilimiter,argCheckedFieldName:string):string;
    procedure SaveRejectData(opType:string);
  public
    { Public declarations }
{* -----------------------------------------------------------------------------
   过程名称 PublicQuery ;PublicExport; PublicSave
   创建人员 zhangjy
   创建日期 2004-8-31 15:41:59
   参数列表 None
   返回值   None
   功能描述 响应TOOLBAR相应的事件
   处理流程
   参考文档

   附加说明
-------------------------------------------------------------------------------}
    procedure PublicQuery; override;
    procedure PublicExport; override;
    procedure PublicSave; override;
  end;
var
  ManageSCForm: TManageSCForm;

implementation

uses ServerDllPub, uGlobal, uShowMessage, uLogin, uGridDecorator,
  uAppOption,uDictionary,uCADInfo;

{$R *.dfm}

const
  RejectOpTypeText='退布';
  EditRejectOpTypeText='退布编辑';
  AprRejectOpTypeText='退布审核';

procedure TManageSCForm.PublicQuery;
begin
  GetData;
end;

procedure TManageSCForm.PublicExport;
begin
  TGlobal.SaveDataToFile(cdsSendInfo, sftXLS)
end;

procedure TManageSCForm.PublicSave;
begin
  SaveData;
end;
procedure TManageSCForm.Initialize;
var
  tmpList:TStringList;
begin
  btnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnAdd.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btnDown.Glyph.LoadFromResourceName(HInstance, RES_DOWNALL);
  btnCancel.Glyph.LoadFromResourceName(HInstance, RES_UP);
  btnUp.Glyph.LoadFromResourceName(HInstance, RES_UPALL);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  lstFNCard.Items.Clear;
  cxdbgtvSelect.OnDblClick := TGlobal.DblClickAWinControl;
  cxdbgtvUnSelect.OnDblClick := TGlobal.DblClickAWinControl;
  cbbContractNO.Items.Text := Dictionary.GetItemList('外发合同号',Login.CurrentDepartment,'SC');

  //--
  cbbOpType.Items.Clear;
  cbbOpType.Items.Add(RejectOpTypeText);
  cbbOpType.Items.Add(EditRejectOpTypeText);
  cbbOpType.ItemIndex:=0;
  try
    tmpList:=TStringList.Create;
    tmpList.Add('cxgrdbndclmnRejectChecked');
    tmpList.Add('cxgrdbndclmnIS_BACK_FABRIC');
    Self.SetGridReadOnly(cxgrdbndtblvwFnCardDetl,tmpList);

    //--
    tmpList.Clear;
    tmpList.Add('cxgrdbndclmnAprIs_Select');
    Self.SetGridReadOnly(cxgrdbndtblvwAprFnCardDetl,tmpList);
  finally
    tmpList.Free;
  end;

  if Pos('5',Login.UserLevelList)>0  then
  begin
    Self.Is_Approve_Man:=True;
    tsReceive.TabVisible:=False;
    tsReject.TabVisible:=False;
    pgcMain.ActivePage:=tsRjtApr;
  end
  else
  begin
    Self.Is_Approve_Man:=False;
    tsRjtApr.TabVisible:=False;
    pgcMain.ActivePage:=tsReceive;
  end;

end;

procedure TManageSCForm.GetSCInfo;
var vData: OleVariant;
    sCondition,sErrorMsg: WideString;
begin
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
    if sContract_NO='' then Exit;
   sCondition := QuotedStr(sContract_NO)+','+QuotedStr(login.CurrentDepartment);
   FNMServerObj.GetQueryData(vData,'GetSCInfo',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsUnSelect.Data := vData[0];
    cdsSelect.Data := vData[0];
    cdsSendInfo.Data := vData[1];
    lstFNCard.Items.Clear;
    cdsUnSelect.Filtered := True;
    cdsSelect.Filtered := True;
    //填充cxGrid
    GridDecorator.BindCxViewWithDataSource(cxdbgtvSelect, dsSelect,True);
    GridDecorator.AddFooter(cxdbgtvSelect,['FN_Card','Quantity'],[skCount,skSum]);
    GridDecorator.BindCxViewWithDataSource(cxdbgtvUnSelect, dsUnSelect);
    GridDecorator.AddFooter(cxdbgtvUnSelect,['FN_Card','Quantity'],[skCount,skSum]);
    GridDecorator.BindCxViewWithDataSource(cxgridtvSendInfo, dsSendInfo);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TManageSCForm.GetData;
begin
  GetSCInfo;
end;

procedure TManageSCForm.SaveSCInfo;
var
  sCondition,sFNCardStr, sErrorMsg: WideString;
  i: integer;
begin
  try
    ShowMsg('正在保存数据稍等！', crHourGlass);
    if lstFNCard.Items.Count = 0 then Exit;
   //变量赋值及保存卡号记录
    sFNCardStr := StringReplace(lstFNCard.Items.Text,#13#10,',',[rfReplaceAll]);
    sCondition := QuotedStr(sContract_NO)+','+QuotedStr(sFNCardStr)+','+
              QuotedStr(Login.CurrentDepartment)+','+QuotedStr(Login.LoginName);
    FNMServerObj.SaveDataBySQL('SaveSCInfo',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
    for i := 0 to lstFNCard.Items.Count -1 do
    begin
      cdsUnSelect.Filtered := False;
      while cdsUnSelect.Locate('FN_Card',lstFNCard.Items[i],[]) do
        cdsUnSelect.Delete;
      cdsUnSelect.Filtered := True;
      cdsSelect.Filtered := False;
      while cdsSelect.Locate('FN_Card',lstFNCard.Items[i],[]) do
        cdsSelect.Delete;
      cdsSelect.Filtered := True;
    end;
    lstFNCard.Items.Clear;
    cbbContractNO.Items.Delete(cbbContractNO.Items.IndexOf(sContract_NO));
    cbbContractNO.ItemIndex :=-1;
    TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TManageSCForm.SaveData;
begin
  SaveSCInfo;
end;

procedure TManageSCForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TManageSCForm.FormDestroy(Sender: TObject);
begin
  inherited;
  ManageSCForm := nil;
end;

procedure TManageSCForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  cbbContractNO.Items.Text := Dictionary.GetItemList('外发合同号',Login.CurrentDepartment,'SC');
end;

procedure TManageSCForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveData;
end;

procedure TManageSCForm.FormCreate(Sender: TObject);
begin
  inherited;
  Initialize;
end;

procedure TManageSCForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TManageSCForm.Add;
var i: Integer;
    sFN_Card: string;
begin
  if (not cdsUnSelect.Active) or (cdsUnSelect.IsEmpty) then Exit;
  for i :=cxdbgtvUnSelect.Controller.SelectedRowCount - 1 downto 0 do
  begin
    with cxdbgtvUnSelect do
      sFN_Card := Controller.SelectedRows[i].Values[GetColumnByFieldName('FN_Card').Index];
    lstFNCard.Items.Add(sFN_Card);
  end;
  cdsUnSelect.Filtered := False;
  cdsUnSelect.Filtered := True;
  cdsSelect.Filtered := False;
  cdsSelect.Filtered := True;
end;

procedure TManageSCForm.Cancel;
var i,Index: Integer;
    sFN_Card: string;
begin
  if (not cdsSelect.Active) or (cdsSelect.IsEmpty) then Exit;
  for i :=cxdbgtvSelect.Controller.SelectedRowCount - 1 downto 0 do
  begin
    with cxdbgtvSelect do
      sFN_Card := Controller.SelectedRows[i].Values[GetColumnByFieldName('FN_Card').Index];
    Index := lstFNCard.Items.IndexOf(sFN_Card);
    if Index <> -1 then
      lstFNCard.Items.Delete(Index);
  end;
  cdsUnSelect.Filtered := False;
  cdsUnSelect.Filtered := True;
  cdsSelect.Filtered := False;
  cdsSelect.Filtered := True;
end;

procedure TManageSCForm.cdsUnSelectFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept := Pos(DataSet.FieldByName('FN_Card').AsString,lstFNCard.Items.Text) = 0;
end;

procedure TManageSCForm.cdsSelectFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept := Pos(DataSet.FieldByName('FN_Card').AsString,lstFNCard.Items.Text) > 0;
end;

procedure TManageSCForm.btnAddClick(Sender: TObject);
begin
  inherited;
  Add;
end;

procedure TManageSCForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  Cancel;
end;

procedure TManageSCForm.btnDownClick(Sender: TObject);
begin
  inherited;
  cxdbgtvUnSelect.DataController.SelectAll;
  Add;
end;

procedure TManageSCForm.btnUpClick(Sender: TObject);
begin
  inherited;
  cxdbgtvSelect.DataController.SelectAll;
  Cancel;
end;

procedure TManageSCForm.cxdbgtvUnSelectKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
   if key = vk_Return then
    Add;
end;

procedure TManageSCForm.cxdbgtvSelectKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = vk_Return then
    Cancel;
end;

procedure TManageSCForm.cbbContractNOSelect(Sender: TObject);
begin
  inherited;
  sContract_NO := cbbContractNO.Text;
  if cdsSendInfo.Active then cdsSendInfo.EmptyDataSet;
  if cdsUnSelect.Active then cdsUnSelect.EmptyDataSet;
  if cdsSelect.Active then cdsSelect.EmptyDataSet;
  GetData;
end;

procedure TManageSCForm.btnSearchClick(Sender: TObject);

begin
  //inherited;
  Self.SetGridData(cbbOpType.Text);
end;

procedure TManageSCForm.SetGridData(argOpType:string);
var
  errMsg,sSql:WideString;
  vData:OleVariant;
  tmpFnCard,tmpFabricNo:string;
begin
  try
    try
      if(argOpType=AprRejectOpTypeText)then
      begin
        cxgrdbndtblvwAprFnCardDetl.BeginUpdate;
        cdsApr.DisableControls;
        tmpFnCard:=edtAprFnCard.Text;
        tmpFabricNo:=edtAprFabricNo.Text;
      end
      else
      begin
        cxgrdbndtblvwFnCardDetl.BeginUpdate;
        cdsReject.DisableControls;
        tmpFnCard:=edtFnCard.Text;
        tmpFabricNo:=edtFabricNo.Text;
      end;

      if(argOpType=RejectOpTypeText) then
      begin
        sSql:=Format('exec usp_GetSCInfo ''%s'',''%s'',''%s'',''Return'' ',[tmpFnCard,Login.CurrentDepartment,tmpFabricNo]);
      end
      else if(argOpType=EditRejectOpTypeText)then
      begin
        sSql:=Format('exec usp_GetSCInfo ''%s'',''%s'',''%s'',''RtnEdit'' ',[tmpFnCard,Login.CurrentDepartment,tmpFabricNo]);
      end
      else if(argOpType=AprRejectOpTypeText)then
      begin
        sSql:=Format('exec usp_GetSCInfo ''%s'',''%s'',''%s'',''Apr'' ',[tmpFnCard,Login.CurrentDepartment,tmpFabricNo]);
      end
      else
      begin
        ShowMessage('不支持的操作类型查询');
        Exit
      end;

      FNMServerObj.GetQueryBySQL(vData,sSql,errMsg);
      if errMsg <> '' then
      begin
        TMsgDialog.ShowMsgDialog(errMsg,mtError);
        Exit;
      end;

      if(argOpType=AprRejectOpTypeText)then
      begin
        cdsApr.Data:=vData;
      end
      else
      begin
        cdsReject.Data:=vData;
      end;

    except on e:Exception do
      begin
        Application.ShowException(e);
      end;
    end;
  finally
    if(argOpType=AprRejectOpTypeText)then
    begin
      cxgrdbndtblvwAprFnCardDetl.EndUpdate;
      cdsApr.EnableControls;
    end
    else
    begin
      cdsReject.EnableControls;
      cxgrdbndtblvwFnCardDetl.EndUpdate;
    end;
  end;

  if(argOpType=AprRejectOpTypeText)then
  begin
    cxgrdbndtblvwAprFnCardDetl.ApplyBestFit(nil);
    GridDecorator.AddFooter(cxgrdbndtblvwAprFnCardDetl,['FN_Card','Quantity'],[skCount,skSum]);
  end
  else
  begin
    cxgrdbndtblvwFnCardDetl.ApplyBestFit();
    GridDecorator.AddFooter(cxgrdbndtblvwFnCardDetl,['FN_Card','Quantity'],[skCount,skSum]);
  end;

end;

procedure TManageSCForm.SetGridReadOnly(argGrid:TcxGridTableView;escapeColNames:TStringList);
var
  i:Integer;
begin
  if(argGrid=nil)then
  begin
    Exit;
  end;
  if(escapeColNames=nil)then
  begin
    Exit;
  end;

  for i := 0 to argGrid.ColumnCount - 1 do
  begin
    if not (escapeColNames.IndexOf( argGrid.Columns[i].Name)>=0)then
    begin
      argGrid.Columns[i].Options.Editing := False;
    end;
  end;
end;
procedure TManageSCForm.btnRejectSaveClick(Sender: TObject);
begin
  //inherited;
  Self.SaveRejectData(cbbOpType.Text);
end;

procedure TManageSCForm.SaveRejectData(opType:string);
var
  errMsg,sSql:WideString;
  oData:OleVariant;
  tmpFnCard,tmpFabricNos,tmpDept,tmpOper,tmpContractNo,tmpStatus:string;
  lprow:Integer;
  tmpChkItem,tmpDilimiterItem:TcxCustomGridTableItem;
begin
  try
    try
      tmpFnCard:= edtFnCard.Text;
      tmpFabricNos:= Self.GetDilimiterStringFromCxGrid(cxgrdFnCardDetl,'Fabric_NO',',','Is_Select');
      tmpDept:=login.CurrentDepartment;
      tmpOper:=login.LoginID;
      tmpStatus:=Self.GetDilimiterStringFromCxGrid(cxgrdFnCardDetl,'IS_BACK_FABRIC',',','Is_Select');
      if(tmpFabricNos='')then
      begin
        ShowMessage('请勾选要保存的纪录');
        Exit;
      end;
      
      if(opType=RejectOpTypeText)then
      begin
        sSql:=Format('EXEC FNMDB.dbo.usp_SaveSCInfoNOCharge ''%s'', ''%s'', ''%s'',''%s'''
                        ,[tmpFnCard,tmpFabricNos,tmpDept,tmpOper]);
      end
      else if (opType=EditRejectOpTypeText)then
      begin
        tmpChkItem:=cxgrdbndtblvwFnCardDetl.DataController.GetItemByFieldName('Is_Select');
        tmpDilimiterItem:=cxgrdbndtblvwFnCardDetl.DataController.GetItemByFieldName('SC_Contract_NO');
        for lprow:=0 to cxgrdbndtblvwFnCardDetl.DataController.RowCount-1 do
        begin
          with cxgrdbndtblvwFnCardDetl.DataController do
          begin
            if( VarToStr(GetValue(lpRow,tmpChkItem.Index))='True')then
            begin
              if(tmpContractNo='')then
              begin
                tmpContractNo:= VarToStr(GetValue(lpRow,tmpDilimiterItem.Index))
              end
              else
              begin
                if(VarToStr(GetValue(lpRow,tmpDilimiterItem.Index))<>tmpContractNo)then
                begin
                  ShowMessage('编辑退布时，每次修改的合同号必须唯一');
                  exit;
                end;
              end;
            end;
          end;
        end;
        sSql:=Format('EXEC FNMDB.dbo.usp_SaveSCChangeStatus ''%s'', ''%s'', ''%s'',''%s'', ''%s'''
                        ,[tmpContractNo,tmpFabricNos,tmpStatus,tmpDept,tmpOper]);
      end
      else
      begin
        ShowMessage('不支持操作类型保存');
        Exit;
      end;

      FNMServerObj.GetQueryBySQL(oData,sSql,errMsg);
      if errMsg <> '' then
      begin
        TMsgDialog.ShowMsgDialog(errMsg,mtError);
        Exit;
      end;

      ShowMessage('保存成功');
      btnSearch.Click;
    except on e:Exception do
      begin
        Application.ShowException(e);
      end;
    end;
  finally

  end;
end;


procedure TManageSCForm.btnRejectExitClick(Sender: TObject);
begin
  //inherited;
  Close;
end;

procedure TManageSCForm.cbbOpTypeChange(Sender: TObject);
begin
  Self.SetGridData(cbbOpType.Text);
end;

//功能：获取tcxgrid用户勾选行，指定列拼成的comma字符串
function TManageSCForm.GetDilimiterStringFromCxGrid(argGrid:TcxGrid;argFieldName,argDilimiter,argCheckedFieldName:string):string;
var
  lpRow,checkColIdx,idenColIdx:Integer;
  tmpChkItem,tmpDilimiterItem:TcxCustomGridTableItem;
  tmpDBDataController:TcxGridDBDataController;
  rtnCommaStr:string;
begin
  if(argGrid=nil)then
  begin
    Result:='';
    Exit;
  end;
  if(argFieldName='') or(argDilimiter='')then
  begin
    Result:='';
    Exit;
  end;
  if not(argGrid.ActiveView.DataController is TcxGridDBDataController)then
  begin
    Result:='';
    Exit;
  end;
  tmpDBDataController:= (argGrid.ActiveView.DataController as TcxGridDBDataController);
  tmpDilimiterItem:=tmpDBDataController.GetItemByFieldName(argFieldName);
  if(tmpDilimiterItem=nil)then
  begin
    Result:='';
    Exit;
  end;
  if(argCheckedFieldName<>'')then
  begin
    tmpChkItem:=tmpDBDataController.GetItemByFieldName(argCheckedFieldName);
    if(tmpChkItem=nil)then
    begin
      Result:='';
      Exit;
    end;
  end;

  rtnCommaStr:='';
  with tmpDBDataController do
  begin
    for lprow:=0 to RowCount-1 do
    begin
      if((tmpChkItem<>nil) and( VarToStr(GetValue(lpRow,tmpChkItem.Index))='True'))
        or
        (tmpChkItem=nil)then
      begin
        rtnCommaStr:=rtnCommaStr
              +VarToStr(GetValue(lpRow,tmpDilimiterItem.Index))
              +argDilimiter;
      end;
    end;
  end;


  if(RightStr(rtnCommaStr,Length(argDilimiter))=argDilimiter)then
  begin
    rtnCommaStr:=Copy(rtnCommaStr,1,Length(rtnCommaStr)-Length(argDilimiter));
  end;
  
  Result:=rtnCommaStr;
end;

procedure TManageSCForm.btnAprSearchClick(Sender: TObject);
begin
  //inherited;
  Self.SetGridData(AprRejectOpTypeText);
end;

procedure TManageSCForm.btnAprSaveClick(Sender: TObject);
var
  errMsg,sSql:WideString;
  vData:OleVariant;
  tmpIdenCommaString:string;
begin
  //inherited;
  try
    if not Self.Is_Approve_Man then
    begin
      ShowMessage('无审核权限');
      Exit;
    end;

    tmpIdenCommaString:=Self.GetDilimiterStringFromCxGrid(cxgrdAprFnCardDetl,'Iden',',','Is_Select');
    if(tmpIdenCommaString='')then
    begin
      ShowMessage('请勾选要保存的纪录');
      Exit;
    end;

    sSql:=Format('exec USP_SaveSCApproveInfo @IdenCommaString=''%s'',@Apr_Man=''%s'''
                        ,[tmpIdenCommaString,Login.LoginID]);
    FNMServerObj.GetQueryBySQL(vData,sSql,errMsg);
    if(errMsg<>'')then
    begin
      ShowMessage(errMsg);
      Exit;
    end;

    ShowMessage('保存成功');
    btnAprSearch.Click;
  except on e:Exception do
    begin
      Application.ShowException(e);
    end;
  end;
end;

end.

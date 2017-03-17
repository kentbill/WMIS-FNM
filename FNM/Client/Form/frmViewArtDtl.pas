unit frmViewArtDtl;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmViewArtDtl.pas                                             }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 lvzd                                                          }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  查看工艺信息                                                 }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, DB,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, Grids, ValEdit, ComCtrls;

type
  TViewArtDtlForm = class(TForm)
    btn_Cancel: TButton;
    ds_ArtDtl: TDataSource;
    pnl_Only: TPanel;
    cxgrid_ArtDtl: TcxGrid;
    cxgridtv_ArtDtl: TcxGridDBTableView;
    cxGridl_ArtDtl: TcxGridLevel;
    pnlTop: TPanel;
    lblWorkerID: TLabel;
    edtWorkerID: TEdit;
    edtBeginTime: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnQuery: TButton;
    edtEndTime: TEdit;
    vleTotal: TValueListEditor;
    pnl1: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    dtpDate: TDateTimePicker;
    cbbShift: TComboBox;
    procedure btnQueryClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxgridtv_ArtDtlCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
    sMachineType:String;
  protected
     procedure UpdateActions; override;
  public
    { Public declarations }
  end;

var
  ViewArtDtlForm: TViewArtDtlForm;
  itype: Integer;
procedure ViewArtDtl(ArtDtlDataSet: TDataSet);
procedure ViewWorkerYield(Index: Integer);
procedure ViewAccidentInfo(FN_Card: string);
procedure ViewSuspendInfo(Machine_ID: string; Index: Integer);
procedure ViewWorkerShift;
procedure ViewOTDAnalysis;
procedure ViewAffirmCard(sMachine:String; sType: Integer);

implementation

uses uFNMResource, uDictionary, uGridDecorator, ServerDllPub, uShowMessage,
  uLogin;

{$R *.dfm}
procedure ViewAccidentInfo(FN_Card: string);
var vData:OleVariant;
    sErrorMsg:WideString;
begin
  if FN_Card ='' then Exit;
  if ViewArtDtlForm = nil then
    ViewArtDtlForm:=TViewArtDtlForm.Create(Application);
  ViewArtDtlForm.pnlTop.Height := 0;
  ViewArtDtlForm.Caption := '处理单查看';

  FNMServerArtObj.GetAccidentInfoByFNCard(FN_Card,vData,sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,2);
    Exit;
  end;
  TempClientDataSet.Data := vData;
  ViewArtDtlForm.ds_ArtDtl.DataSet :=  TempClientDataSet;
  ViewArtDtlForm.cxgridtv_ArtDtl.ClearItems;
  GridDecorator.BindCxViewWithDataSource(ViewArtDtlForm.cxgridtv_ArtDtl, ViewArtDtlForm.ds_ArtDtl);
  try
    ViewArtDtlForm.ShowModal;
  finally
   ViewArtDtlForm.Free;
  end;
end;

procedure ViewSuspendInfo(Machine_ID: string;Index:Integer);
begin
  if ViewArtDtlForm = nil then
    ViewArtDtlForm:=TViewArtDtlForm.Create(Application);
  ViewArtDtlForm.pnlTop.Height := 37;
  ViewArtDtlForm.Caption := '停机记录查询';
  ViewArtDtlForm.lblWorkerID.Caption := '机台ID :';
  ViewArtDtlForm.edtWorkerID.Text := Machine_ID;
  ViewArtDtlForm.edtBeginTime.Text :=FormatDateTime(DateTimeFmtStr, Now-1);
  ViewArtDtlForm.edtEndTime.Text :=FormatDateTime(DateTimeFmtStr, Now);
  ViewArtDtlForm.ds_ArtDtl.DataSet := nil;
  ViewArtDtlForm.cxgridtv_ArtDtl.ClearItems;
  itype := Index;
  try
    ViewArtDtlForm.ShowModal;
  finally
   ViewArtDtlForm.Free;
  end
end;

procedure ViewWorkerYield(Index:Integer);
begin
  if ViewArtDtlForm = nil then
    ViewArtDtlForm:=TViewArtDtlForm.Create(Application);
  ViewArtDtlForm.pnlTop.Height := 37;
  ViewArtDtlForm.Caption := '工人产量查询';
  ViewArtDtlForm.lblWorkerID.Caption := '员工卡号:';
  ViewArtDtlForm.edtWorkerID.Clear;
  ViewArtDtlForm.edtBeginTime.Text :=FormatDateTime(DateTimeFmtStr, Now-1);
  ViewArtDtlForm.edtEndTime.Text :=FormatDateTime(DateTimeFmtStr, Now);
  ViewArtDtlForm.ds_ArtDtl.DataSet := nil;
  ViewArtDtlForm.cxgridtv_ArtDtl.ClearItems;
  itype := Index;
  try
    ViewArtDtlForm.ShowModal;
  finally
   ViewArtDtlForm.Free;
  end
end;

procedure ViewArtDtl(ArtDtlDataSet: TDataSet);
begin
  if ViewArtDtlForm = nil then
    ViewArtDtlForm:=TViewArtDtlForm.Create(Application);
  ViewArtDtlForm.Caption := '工艺查看';
  ViewArtDtlForm.pnlTop.Height := 0;
  with ViewArtDtlForm do
  begin
    ds_ArtDtl.DataSet:=ArtDtlDataSet;
    cxgridtv_ArtDtl.ClearItems;
    GridDecorator.BindCxViewWithDataSource(cxgridtv_ArtDtl, ds_ArtDtl);
    cxgridtv_ArtDtl.GetColumnByFieldName('Step_no').GroupIndex:=0;
    cxgridtv_ArtDtl.GetColumnByFieldName('Step_no').Visible:=false;
    cxgridtv_ArtDtl.GetColumnByFieldName('EditStep_no').Visible:=false;
    cxgridtv_ArtDtl.DataController.Groups.FullExpand;
    try
      ShowModal;
    finally
      Free;
    end
  end;
end;

//查看轮休 2008-9-24 cuijf
procedure ViewWorkerShift;
var
  vData:OleVariant;
  sSQL, sErrMsg:WideString;
begin
  if ViewArtDtlForm = nil then
    ViewArtDtlForm:=TViewArtDtlForm.Create(Application);

  ViewArtDtlForm.pnlTop.Height := 0;
  ViewArtDtlForm.Caption := '轮休查询';

  sSQL := QuotedStr('QueryWorkerShift')+ ','+ QuotedStr(login.CurrentDepartment)+ ','+ QuotedStr(login.LoginName);
  FNMServerObj.GetQueryData(vData, 'CommonSQL', sSQL, sErrMsg);
  if sErrMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg,2);
    Exit;
  end;

  TempClientDataSet.Data := vData;
  ViewArtDtlForm.ds_ArtDtl.DataSet :=  TempClientDataSet;

  ViewArtDtlForm.cxgridtv_ArtDtl.ClearItems;
  GridDecorator.BindCxViewWithDataSource(ViewArtDtlForm.cxgridtv_ArtDtl, ViewArtDtlForm.ds_ArtDtl);
  try
    ViewArtDtlForm.ShowModal;
  finally
   ViewArtDtlForm.Free;
  end;
end;

//查看OTD拖单 2009-9-11 cuijf
procedure ViewOTDAnalysis;
var
  vData:OleVariant;
  sSQL, sErrMsg:WideString;
begin
  if ViewArtDtlForm = nil then
    ViewArtDtlForm:=TViewArtDtlForm.Create(Application);

  ViewArtDtlForm.Label2.Visible := False;
  ViewArtDtlForm.edtEndTime.Visible := False;

  ViewArtDtlForm.edtBeginTime.Text :=FormatDateTime(DateTimeFmtStr, Now-1);
  ViewArtDtlForm.vleTotal.Visible := False;

  ViewArtDtlForm.Caption := 'OTD拖单查询';
  itype := 5;
  try
    ViewArtDtlForm.ShowModal;
  finally
   ViewArtDtlForm.Free;
  end;
end;

procedure TViewArtDtlForm.btnQueryClick(Sender: TObject);
var
  vData: OleVariant;
  sSQL, sErrMsg, sCondition,sWorker_ID,sBegin_Time,sEnd_Time,sErrorMsg: WideString;
begin
  //审卡疵点预防查询
  if iType= 7 then
  begin
    if cbbShift.Text= '' then Exit;

    sSQL := QuotedStr(Login.CurrentDepartment) + ','
          + QuotedStr(DateToStr(dtpDate.Date))+','
          + QuotedStr(cbbShift.Text)+','
          + QuotedStr(sMachineType);
    FNMServerObj.GetQueryData(vData,'fnAffirmCardQuery',sSQL,sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg,2);
      Exit;
    end;

    TempClientDataSet.Data := vData;
    ds_ArtDtl.DataSet :=  TempClientDataSet;

    cxgridtv_ArtDtl.ClearItems;
    GridDecorator.BindCxViewWithDataSource(cxgridtv_ArtDtl, ds_ArtDtl);
    Exit;
  end;
     //未加工审卡疵点预防查询
  if iType= 8 then
  begin
    sSQL := QuotedStr(Login.CurrentDepartment) + ','
          + QuotedStr('')+','
          + QuotedStr('')+','
          + QuotedStr(sMachineType)+',1';
    FNMServerObj.GetQueryData(vData,'fnAffirmCardQuery',sSQL,sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg,2);
      Exit;
    end;

    TempClientDataSet.Data := vData;
    ds_ArtDtl.DataSet :=  TempClientDataSet;

    cxgridtv_ArtDtl.ClearItems;
    GridDecorator.BindCxViewWithDataSource(cxgridtv_ArtDtl, ds_ArtDtl);
    Exit;
  end;

  if edtWorkerID.Text ='' then Exit;
  if edtBeginTime.Text = edtEndTime.Text then Exit;
  sWorker_ID := edtWorkerID.Text;
  sBegin_Time := edtBeginTime.Text;
  sEnd_Time := edtEndTime.Text;

  if iType= 5 then
  begin
    sSQL := QuotedStr(sBegin_Time) + ','+QuotedStr(Login.CurrentDepartment)+ ',1,'+ QuotedStr(sWorker_ID);
    FNMServerObj.GetQueryData(vData,'GetOTDAnalysisData',sSQL,sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg,2);
      Exit;
    end;

    TempClientDataSet.Data := vData;
    ds_ArtDtl.DataSet :=  TempClientDataSet;

    cxgridtv_ArtDtl.ClearItems;
    GridDecorator.BindCxViewWithDataSource(cxgridtv_ArtDtl, ds_ArtDtl);
    Exit;
  end;


  sCondition := QuotedStr(sBegin_Time)+',' +QuotedStr(sEnd_Time)+','+QuotedStr(Login.CurrentDepartment)+','+QuotedStr(sWorker_ID)+','+IntToStr(iType);
  FNMServerObj.GetQueryData(vData,'TerminalQuery',sCondition,sErrorMsg);
//  FNMServerObj.TerminalQuery(vData,sWorker_ID,sBegin_Time,sEnd_Time,Login.CurrentDepartment,itype,sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,2);
    Exit;
  end;
  if (iType = 0) or (iType = 1) then
  begin
    TempClientDataSet.Data := vData;
    ds_ArtDtl.DataSet :=  TempClientDataSet;
    GridDecorator.BindCxViewWithDataSource(cxgridtv_ArtDtl, ds_ArtDtl);
  end;
  if iType = 0 then
    GridDecorator.AddFooter(cxgridtv_ArtDtl,['数量','折算数量'],[skSum,skSum]);
  if iType = 2 then
  begin
    TempClientDataSet.Data := vData[0];
    with TempClientDataSet do
    begin
      vleTotal.Strings.Clear;
      vleTotal.Strings.Add('个人产量='+FieldByName('个人产量').AsString);
      vleTotal.Strings.Add('个人产量累计='+FieldByName('个人产量累计').AsString);
      vleTotal.Strings.Add('A*='+FieldByName('A*').AsString);
      vleTotal.Strings.Add('A*累计='+FieldByName('A*累计').AsString);
      vleTotal.Strings.Add('C='+FieldByName('C').AsString);
      vleTotal.Strings.Add('C累计='+FieldByName('C累计').AsString);
      vleTotal.Strings.Add('外回修='+FieldByName('外回修').AsString);
      vleTotal.Strings.Add('外回修累计='+FieldByName('外回修累计').AsString);
      vleTotal.Strings.Add('内回修='+FieldByName('内回修').AsString);
      vleTotal.Strings.Add('内回修累计='+FieldByName('内回修累计').AsString);
    end;
    TempClientDataSet.Data := vData[1];
    ds_ArtDtl.DataSet :=  TempClientDataSet;
    GridDecorator.BindCxViewWithDataSource(cxgridtv_ArtDtl, ds_ArtDtl);
  end;
end;

procedure TViewArtDtlForm.FormDestroy(Sender: TObject);
begin
  ViewArtDtlForm := nil;
end;

procedure TViewArtDtlForm.cxgridtv_ArtDtlCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if ViewArtDtlForm.Caption <> '轮休查询' then Exit;
  
  if AViewInfo.Text = '早' then
       ACanvas.Font.Color:=RGB(0,255,255)
  else if AViewInfo.Text = '中' then
       ACanvas.Font.Color:=RGB(255,0,255)
  else if AViewInfo.Text = '晚' then          
       ACanvas.Font.Color:=RGB(255,255,0)
  else if AViewInfo.Text = '' then
       ACanvas.Brush.Color:=RGB(0,255,0);
end;

procedure TViewArtDtlForm.UpdateActions;
begin
  inherited;
  vleTotal.Visible := iType = 2;
end;

procedure ViewAffirmCard(sMachine:String; sType:Integer);
var
  vData:OleVariant;
  sSQL, sErrMsg:WideString;
begin
  if ViewArtDtlForm = nil then
    ViewArtDtlForm:=TViewArtDtlForm.Create(Application);

  with ViewArtDtlForm do
  begin
    itype := sType;

    lblWorkerID.Visible := False;
    Label1.Visible := False;
    edtWorkerID.Visible := False;
    edtBeginTime.Visible := False;
    Label2.Visible := False;
    edtEndTime.Visible := False;
    vleTotal.Visible := False;

    sMachineType := sMachine;

    if sType= 7 then
    begin
      pnl1.Visible := true;
      dtpDate.Date := Date;
      Caption := '当班疵点预防查询';
    end
    else if sType= 8 then
    begin
      Caption := '机台未加工疵点预防查询';
      btnQueryClick(nil);
    end;

    try
      ShowModal;
    finally
      Free;
    end;
  end;

end;

end.

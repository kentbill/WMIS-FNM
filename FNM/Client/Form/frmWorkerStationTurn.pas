{******************************************************************************
                                                                              
       软件名称 FNM                                                            
       版权所有 (C) 2004-2009 ESQUEL GROUP GET/IT
       单元名称 frmWorkerStationTurn.pas
       创建日期 2009-04-28 10:54:40                                            
       创建人员 cuijf                                                          
       修改人员                                                                
       修改日期                                                                
       修改原因                                                                
       对应用例                                                                
       字段描述                                                                
       相关数据库表                                                            
       调用重要函数/SQL对象说明                                                
       功能描述                                                                
                                                                              
******************************************************************************}
unit frmWorkerStationTurn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, DBClient, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Buttons, ExtCtrls, ADODB;

type
  TWorkerStationTurnForm = class(TBaseForm)
    pnl1: TPanel;
    btnQuery: TSpeedButton;
    btnExcel: TSpeedButton;
    btnSave: TSpeedButton;
    btnExit: TSpeedButton;
    cxgridtvWorkerStationTurn: TcxGridDBTableView;
    cxGridlWorkerStationTurn: TcxGridLevel;
    cxgridWorkerStationTurn: TcxGrid;
    dsWorkerStationTurn: TDataSource;
    cdsWorkerStationTurn: TClientDataSet;
    dsImport: TADODataSet;
    btnQueryResult: TSpeedButton;
    btnDelete: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnQueryResultClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure cxgridtvWorkerStationTurnCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure pnl1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
    procedure SetBtnState;
    procedure DataRefresh;
    procedure DataSave;
    procedure DataCancel;
    procedure DataUpload;
    procedure DataQuery;
    function CloseQuery:Boolean;
  public
    { Public declarations }
  end;

var
  WorkerStationTurnForm: TWorkerStationTurnForm;

implementation

uses ServerDllPub, uGlobal, uShowMessage, uLogin, uGridDecorator;
  
{$R *.dfm}

{ TWorkerStationTurnForm }

function TWorkerStationTurnForm.CloseQuery: Boolean;
begin
  if not TGlobal.DeltaIsNull(cdsWorkerStationTurn) then
  begin
    if TMsgDialog.ShowMsgDialog('数据未保存，是否保存！', mtConfirmation, [mebYes, mebNo], mebYes)= mrNo then
      Result := false;
  end
  else
    Result := False;
end;

procedure TWorkerStationTurnForm.DataCancel;
begin
  cdsWorkerStationTurn.CancelUpdates;
end;

procedure TWorkerStationTurnForm.DataRefresh;
var
  vData: OleVariant;
  sSQL, sErrMsg: WideString;
begin
  try
    ShowMsg('', crHourGlass);

    sSQL := QuotedStr('fnWorkerShift')+ ','+ QuotedStr(login.CurrentDepartment);
    FNMServerObj.GetQueryData(vData, 'CommonSQL', sSQL, sErrMsg);
    if sErrMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;

    cdsWorkerStationTurn.Data := vData;

    if (cxgridtvWorkerStationTurn.ColumnCount<2) or (cdsWorkerStationTurn.Fields[5].Name<>'班次') then
    begin
      GridDecorator.BindCxViewWithDataSource(cxgridtvWorkerStationTurn, dsWorkerStationTurn, True);
      GridDecorator.SetcxTableView(cxgridtvWorkerStationTurn, ['Operator','Operate_Time'],[], False);
    end;

  finally
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TWorkerStationTurnForm.DataSave;
var
  vData: OleVariant;
  sErrMsg: WideString;
begin
  try
    ShowMsg('', crHourGlass);
    if TGlobal.DeltaIsNull(cdsWorkerStationTurn) then Exit;

    //保存数据
    vData := cdsWorkerStationTurn.Delta;
    FNMServerObj.SaveBaseTableInfo(vData, 'fnWorkerShift', 'Machine_Type,Worker_ID,Dept,Shift,Work_Day', sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    cdsWorkerStationTurn.MergeChangeLog;

  finally
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TWorkerStationTurnForm.DataUpload;
var
  i, icount:Integer;
begin
  cdsWorkerStationTurn.DisableControls;
  try
    ShowMsg('正在上传数据...', crHourGlass);
    
    if cdsWorkerStationTurn.Fields[5].Name<>'班次' then
      DataRefresh;

    if not cdsWorkerStationTurn.Active then Exit;

    TGlobal.GetRecordSetFromXLS(dsImport);
    with dsImport do
    begin
      if IsEmpty or (not Active) then Exit;

      First;
      while not Eof do
      begin
        icount := Fields.Count;

        if Fields[5].Name<>'班次' then
        begin
          if Fields[0].Value<> '部门' then
            for i:=4 to icount-1 do
            begin
              if (Fields[i].FieldName<>'') and (Fields[i].Text<>'') and (Fields[i].Text<>' ') then
              begin
                if cdsWorkerStationTurn.Locate('Machine_Type;Worker_ID;Dept;Work_Day',VarArrayOf([FieldByName('机台').AsString,FieldByName('员工号').AsString,FieldByName('部门').AsString,Fields[i].FieldName]),[]) then
                begin
                  cdsWorkerStationTurn.Edit;
                  cdsWorkerStationTurn.FieldByName('Shift').AsString := Fields[i].Text;
                  cdsWorkerStationTurn.Post;
                end
                else
                begin
                  cdsWorkerStationTurn.Append;
                  cdsWorkerStationTurn.FieldByName('Machine_Type').AsString := FieldByName('机台').AsString;
                  cdsWorkerStationTurn.FieldByName('Worker_ID').AsString := FieldByName('员工号').AsString;
                  cdsWorkerStationTurn.FieldByName('Worker_Name').AsString := FieldByName('姓名').AsString;
                  cdsWorkerStationTurn.FieldByName('Dept').AsString := FieldByName('部门').AsString;
                  cdsWorkerStationTurn.FieldByName('Shift').AsString := Fields[i].Text;
                  cdsWorkerStationTurn.FieldByName('Work_Day').AsString := Fields[i].FieldName;
                  cdsWorkerStationTurn.FieldByName('Operator').AsString := login.LoginName;
                  cdsWorkerStationTurn.Post;
                end;
              end;
            end;
        end
        else
        begin
          if FieldByName('机台').AsString<>'' then
          begin
            cdsWorkerStationTurn.Append;
            cdsWorkerStationTurn.FieldByName('Machine_Type').AsString := FieldByName('机台').AsString;
            cdsWorkerStationTurn.FieldByName('Worker_ID').AsString := FieldByName('员工号').AsString;
            cdsWorkerStationTurn.FieldByName('Worker_Name').AsString := FieldByName('姓名').AsString;
            cdsWorkerStationTurn.FieldByName('Dept').AsString := FieldByName('部门').AsString;
            cdsWorkerStationTurn.FieldByName('Shift').AsString := FieldByName('班次').AsString;
            cdsWorkerStationTurn.FieldByName('Work_Day').AsString := FieldByName('时间').AsString;
            cdsWorkerStationTurn.FieldByName('Operator').AsString := login.LoginName;
            cdsWorkerStationTurn.Post;
          end;
        end;

        Next;
      end;
      
      Close;
    end;
  finally
    cdsWorkerStationTurn.EnableControls;
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TWorkerStationTurnForm.SetBtnState;
begin
  btnSave.Enabled := not TGlobal.DeltaIsNull(cdsWorkerStationTurn);
  btnDelete.Enabled := (cxgridtvWorkerStationTurn.ColumnCount=8) and (not cdsWorkerStationTurn.IsEmpty);
end;

procedure TWorkerStationTurnForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TWorkerStationTurnForm.FormCreate(Sender: TObject);
begin
  inherited;
  DataRefresh;
end;

procedure TWorkerStationTurnForm.FormDestroy(Sender: TObject);
begin
  inherited;
  WorkerStationTurnForm := nil;
end;

procedure TWorkerStationTurnForm.btnQueryClick(Sender: TObject);
begin
  inherited;
  DataRefresh;
end;

procedure TWorkerStationTurnForm.btnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TWorkerStationTurnForm.btnExcelClick(Sender: TObject);
begin
  inherited;
  DataUpload;
end;

procedure TWorkerStationTurnForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  DataSave;
end;

procedure TWorkerStationTurnForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := not CloseQuery;
end;

procedure TWorkerStationTurnForm.DataQuery;
var
  sSQL, sErrMsg: WideString;
  vData: OleVariant;
begin
  try     
    ShowMsg('', crHourGlass);
    
    sSQL := QuotedStr('QueryWorkerShift')+ ','+ QuotedStr(login.CurrentDepartment)+ ','+ QuotedStr(login.LoginName);
    FNMServerObj.GetQueryData(vData, 'CommonSQL', sSQL, sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg,2);
      Exit;
    end;

    cdsWorkerStationTurn.Data := vData;
    GridDecorator.BindCxViewWithDataSource(cxgridtvWorkerStationTurn, dsWorkerStationTurn, True);
    GridDecorator.SetcxTableView(cxgridtvWorkerStationTurn, [],[], True);
  finally
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TWorkerStationTurnForm.btnQueryResultClick(Sender: TObject);
begin
  inherited;
  DataQuery;
end;

procedure TWorkerStationTurnForm.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if not cdsWorkerStationTurn.Active then Exit;

  cdsWorkerStationTurn.Delete;
  SetBtnState;
end;

procedure TWorkerStationTurnForm.cxgridtvWorkerStationTurnCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if AViewInfo.Text = '早' then
       ACanvas.Font.Color:=RGB(0,255,255)
  else if AViewInfo.Text = '中' then
       ACanvas.Font.Color:=RGB(255,0,255)
  else if AViewInfo.Text = '晚' then          
       ACanvas.Font.Color:=RGB(255,255,0)
  else if AViewInfo.Text = '' then
       ACanvas.Brush.Color:=RGB(0,255,0);
end;

procedure TWorkerStationTurnForm.pnl1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  SetBtnState;
end;

end.

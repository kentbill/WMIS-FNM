unit frmViewArtDtl;
{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmViewArtDtl.pas                                             }
{       �������� 2004-8-26 13:50:57                                            }
{       ������Ա lvzd                                                          }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{       ������Ҫ����/SQL����˵��                                               }
{       ��������  �鿴������Ϣ                                                 }
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
  ViewArtDtlForm.Caption := '�����鿴';

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
  ViewArtDtlForm.Caption := 'ͣ����¼��ѯ';
  ViewArtDtlForm.lblWorkerID.Caption := '��̨ID :';
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
  ViewArtDtlForm.Caption := '���˲�����ѯ';
  ViewArtDtlForm.lblWorkerID.Caption := 'Ա������:';
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
  ViewArtDtlForm.Caption := '���ղ鿴';
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

//�鿴���� 2008-9-24 cuijf
procedure ViewWorkerShift;
var
  vData:OleVariant;
  sSQL, sErrMsg:WideString;
begin
  if ViewArtDtlForm = nil then
    ViewArtDtlForm:=TViewArtDtlForm.Create(Application);

  ViewArtDtlForm.pnlTop.Height := 0;
  ViewArtDtlForm.Caption := '���ݲ�ѯ';

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

//�鿴OTD�ϵ� 2009-9-11 cuijf
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

  ViewArtDtlForm.Caption := 'OTD�ϵ���ѯ';
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
  //�󿨴õ�Ԥ����ѯ
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
     //δ�ӹ��󿨴õ�Ԥ����ѯ
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
    GridDecorator.AddFooter(cxgridtv_ArtDtl,['����','��������'],[skSum,skSum]);
  if iType = 2 then
  begin
    TempClientDataSet.Data := vData[0];
    with TempClientDataSet do
    begin
      vleTotal.Strings.Clear;
      vleTotal.Strings.Add('���˲���='+FieldByName('���˲���').AsString);
      vleTotal.Strings.Add('���˲����ۼ�='+FieldByName('���˲����ۼ�').AsString);
      vleTotal.Strings.Add('A*='+FieldByName('A*').AsString);
      vleTotal.Strings.Add('A*�ۼ�='+FieldByName('A*�ۼ�').AsString);
      vleTotal.Strings.Add('C='+FieldByName('C').AsString);
      vleTotal.Strings.Add('C�ۼ�='+FieldByName('C�ۼ�').AsString);
      vleTotal.Strings.Add('�����='+FieldByName('�����').AsString);
      vleTotal.Strings.Add('������ۼ�='+FieldByName('������ۼ�').AsString);
      vleTotal.Strings.Add('�ڻ���='+FieldByName('�ڻ���').AsString);
      vleTotal.Strings.Add('�ڻ����ۼ�='+FieldByName('�ڻ����ۼ�').AsString);
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
  if ViewArtDtlForm.Caption <> '���ݲ�ѯ' then Exit;
  
  if AViewInfo.Text = '��' then
       ACanvas.Font.Color:=RGB(0,255,255)
  else if AViewInfo.Text = '��' then
       ACanvas.Font.Color:=RGB(255,0,255)
  else if AViewInfo.Text = '��' then          
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
      Caption := '����õ�Ԥ����ѯ';
    end
    else if sType= 8 then
    begin
      Caption := '��̨δ�ӹ��õ�Ԥ����ѯ';
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

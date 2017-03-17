unit frmDistributeTerminal;
{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmDistributeTerminal.pas                                     }
{       �������� 2004-8-26 13:50:42                                            }
{       ������Ա zhangjy                                                       }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{           ����FNMDB..fnStock�������е��ֶ�                                   }
{           д��FNMDB..fnStock���е��ֶ�Car_NO                                 }
{       ������Ҫ����/SQL����˵��                                               }
{       �������� ����ֲ���¼�����¿���fnStock�ĳ��ƺ�                       }
{                                                                              }
{******************************************************************************}

interface

{$I Terminal.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, DB, DBClient, StdCtrls, Buttons, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ExtCtrls, cxGraphics, cxCustomData, cxStyles,
  cxFilter, cxData, cxDataStorage, cxEdit, cxDBData;

type
  TDistributeTerminalForm = class(TForm)
    pnlClient: TPanel;
    cdsStockInfo: TClientDataSet;
    dsStockInfo: TDataSource;
    cxgridtvStockInfo: TcxGridDBTableView;
    cxGridlcxgrid2Level1: TcxGridLevel;
    cxgridStockInfo: TcxGrid;
    pnlNormalTop: TPanel;
    lbl2: TLabel;
    btnRefresh: TSpeedButton;
    lblCar_NO: TLabel;
    btnEdit: TSpeedButton;
    btnCancel: TSpeedButton;
    btnSave: TSpeedButton;
    btnClose: TSpeedButton;
    lbl: TLabel;
    cbbNormal: TComboBox;
    edtCar_NO: TEdit;
    chkIncludeCarNO: TCheckBox;
    lstOperator: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cxgridtvStockInfoCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgridtvStockInfoFocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure cbbNormalSelect(Sender: TObject);
  private
    { Private declarations }
//    sMachine_ID: string; //�ֲ�����
    sCurrent_Department: string; //��ǰ��������
{* -----------------------------------------------------------------------------
   �������� Initialize
   ������Ա zhangjy
   �������� 2004-8-26 14:24:10
   �����б� None
   ����ֵ   None
   �������� ��ʼ���������
   ��������
   �ο��ĵ�

   ����˵��
-------------------------------------------------------------------------------}
    procedure Initialize;
{* -----------------------------------------------------------------------------
   �������� RefreshData
   ������Ա zhangjy
   �������� 2004-8-26 14:24:39
   �����б� None
   ����ֵ   None
   �������� ˢ������
   ��������
   �ο��ĵ�

   ����˵��
-------------------------------------------------------------------------------}
    procedure GetDistributeInfo;
    procedure ShowWorkerList;    
    procedure GetData;
{* -----------------------------------------------------------------------------
   �������� SaveDistributeInfo;
   ������Ա zhangjy
   �������� 2004-8-26 14:28:13
   �����б� None
   ����ֵ   None
   �������� ����ֲ���¼
   ��������
   �ο��ĵ�

   ����˵��
-------------------------------------------------------------------------------}
    procedure SaveDistributeInfo;
    procedure Updatedata(sCarNo:string);
    procedure SaveData;
  public
    { Public declarations }
  end;
var
  DistributeTerminalForm: TDistributeTerminalForm;

procedure FillAllDistributeSourceToItems(Department: String; AItems: TStrings);
implementation

uses Dialogs, StrUtils, ServerDllPub, uGlobal, uShowMessage,
  uGridDecorator, uAppOption, uDictionary, uLogin, uCADInfo, 
  uFNMResource
  {$IFDEF TERMINAL}
    , uTerminal
  {$ENDIF};

{$R *.dfm}
procedure FillAllDistributeSourceToItems(Department: String; AItems: TStrings);
begin
  with Dictionary, Dictionary.cds_MaterialFlowList do
  try
    Filter:= 'Current_Department=' + QuotedStr(Department) + ' AND Flow_Description=' + QuotedStr('�ֲ���Դ');
    Filtered:= True;
    TGlobal.FillItemsFromDataSet(Dictionary.cds_MaterialFlowList, 'Relation_Department', 'Relation_Department_CHN', '-', AItems);
  finally
    Filtered:=false;
  end;
end;

procedure TDistributeTerminalForm.Initialize;
begin
  sCurrent_Department := Login.CurrentDepartment;
  //������Դ
  {$IFDEF TERMINAL}
    Self.FormStyle := fsNormal;
    // Self.BorderStyle := bsNone;
    cbbNormal.Enabled:=false;
    cbbNormal.Color:=clBtnFace;
    cbbNormal.Style:=csSimple;
//    GetData();
  {$ELSE}
    Self.FormStyle := fsMDIChild;
    Self.BorderStyle := bsSizeable;
  {$ENDIF}

  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  btnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnEdit.Glyph.LoadFromResourceName(HInstance, RES_EDIT);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
end;

procedure TDistributeTerminalForm.GetDistributeInfo;
var vData: OleVariant;
    sCondition,sErrorMsg: WideString;
begin
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('���ڻ�ȡ�����Եȣ�', crHourGlass);
   //��ȡ���ֲ���Ϣ
    sCondition:='Current_Department = '+QuotedStr(Login.CurrentDepartment) + 'AND Source = '+ QuotedStr(LeftStr(cbbNormal.text, 2))
                + ' AND FN_Card = ''N/A'''+ IfThen(chkIncludeCarNO.Checked,'',' AND Car_NO=''''');
    FNMServerObj.GetQueryData(vData,'GetStockInfo',sCondition,sErrorMsg);
  //  FNMServerObj.GetStockInfo(vData,sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsStockInfo.Data := vData;
    if cdsStockInfo.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('û�д��ֲ�������',2);
      Exit;
    end;
     //���cxGrid
    GridDecorator.BindCxViewWithDataSource(cxgridtvStockInfo, dsStockInfo);
    GridDecorator.AddFooter(cxgridtvStockInfo,['Quantity','Fabric_No'],[skSum,skCount]);
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('', crDefault);
  end;
end;

procedure TDistributeTerminalForm.GetData;
begin
  GetDistributeInfo;
end;

procedure TDistributeTerminalForm.UpdateData(sCarNo :string);
var
  i,iCol: Integer;
  Fabric_NO: string;
begin
  cdsStockInfo.ReadOnly :=false;
  cdsStockInfo.DisableControls ;
  for i:=0 to cxgridtvStockInfo.Controller.SelectedRowCount -1 do
  begin
    iCol:=cxgridtvStockInfo.GetColumnByFieldName('FabrIc_NO').Index ;
    Fabric_NO:=cxgridtvStockInfo.Controller.SelectedRows[i].Values[iCol];
    if cdsStockInfo.Locate('Fabric_NO',Fabric_NO,[loCaseInsensitive]) then
    begin
     cdsStockInfo.Edit ;
     cdsStockInfo.FieldByName('Car_NO').Value :=sCarNo;
     cdsStockInfo.post;
    end;
  end;
  cdsStockInfo.ReadOnly := True;
  cdsStockInfo.EnableControls ;
end;

procedure TDistributeTerminalForm.SaveDistributeInfo;
var
  vDelta: OleVariant;
  sMachine_ID,sErrorMsg,sFabricNOStr: WideString;
begin
  if TGlobal.DeltaIsNull(cdsStockInfo) then Exit;
  sFabricNOStr := '';
  with cdsStockInfo do
  begin
    First;
    while not Eof do
    begin
      if FieldByName('Car_NO').AsString<>'' then
         sFabricNOStr := sFabricNOStr+FieldByName('Fabric_NO').AsString+',';
      Next;
    end;
  end;
  if sFabricNOStr = '' then Exit;
  sMachine_ID := sCurrent_Department+LeftStr(cbbNormal.Items[cbbNormal.ItemIndex], 2);
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('���ڱ��������Եȣ�', crHourGlass);
    vDelta := cdsStockInfo.Delta;
//    FNMServerObj.SaveBaseTableInfo(vDelta,'dbo.uvw_fnStock','Fabric_NO',sErrorMsg);
    FNMServerObj.SaveDistributeInfo(vDelta,sFabricNOStr,sMachine_ID,sCurrent_Department,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TMsgDialog.ShowMsgDialog('�������ݳɹ�', mtInformation);
    cdsStockInfo.MergeChangeLog;
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('', crDefault);
  end;
end;

procedure TDistributeTerminalForm.SaveData;
begin
  SaveDistributeInfo;
end;

procedure TDistributeTerminalForm.FormCreate(Sender: TObject);
begin
  Initialize();
end;

procedure TDistributeTerminalForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not TGlobal.DeltaIsNull(cdsStockInfo) then
  begin
    if TMsgDialog.ShowMsgDialog('�����и��ģ���Ҫ������',mtConfirmation,[mebYes,mebNo],mebYes) =mrYes then
      saveData;
  end;
  Action := caFree;
end;

procedure TDistributeTerminalForm.FormDestroy(Sender: TObject);
begin
  DistributeTerminalForm := nil;
end;

procedure TDistributeTerminalForm.btnRefreshClick(Sender: TObject);
begin
  GetData();
end;

procedure TDistributeTerminalForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TDistributeTerminalForm.btnEditClick(Sender: TObject);
begin
  if edtCar_No.Text='' then
  begin
    TMsgDialog.ShowMsgDialog('�����복�ƺţ�',mtWarning);
    edtCar_No.SetFocus ;
    Exit;
  end;
  UpdateData(trim(edtCar_No.Text ));
end;

procedure TDistributeTerminalForm.btnSaveClick(Sender: TObject);
begin
  SaveData;
end;

procedure TDistributeTerminalForm.btnCancelClick(Sender: TObject);
begin
  UpdateData('');
end;

procedure TDistributeTerminalForm.cxgridtvStockInfoCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var iCol:integer;
    sCarNo:String;
begin
  if AViewInfo.Focused then
    exit;

   icol := cxgridtvStockInfo.GetColumnByFieldName('Car_No').Index;
   sCarNo := AViewInfo.GridRecord.Values[icol];
   if sCarNo<>'' then
       ACanvas.Font.Color:=RGB(255,0,255);
end;

procedure TDistributeTerminalForm.cxgridtvStockInfoFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord;
  ANewItemRecordFocusingChanged: Boolean);
begin
  btnEdit.Enabled :=cdsStockInfo.FieldByName('Car_No').AsString = '';
  btnCancel.Enabled :=cdsStockInfo.FieldByName('Car_No').AsString <>'';
end;

procedure TDistributeTerminalForm.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F11 then
    if cdsStockInfo.Active then ShowCADPicture(cdsStockInfo.FieldByName('GF_ID').AsString);
end;

procedure TDistributeTerminalForm.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
  sCurrent_Department := Login.CurrentDepartment;
{$IFDEF TERMINAL}
  cbbNormal.Text:=DistributeSource;
  Caption:=DistributeSource + ' ' + '�ֲ��ն�';
  Application.Title:=Caption;
  ShowWorkerList;
  GetData();
{$ELSE}
  FillAllDistributeSourceToItems(sCurrent_Department, cbbNormal.Items);
{$ENDIF}
  OnActivate:=nil;
end;

procedure TDistributeTerminalForm.cbbNormalSelect(Sender: TObject);
begin
  ShowWorkerList;
end;

procedure TDistributeTerminalForm.ShowWorkerList;
begin
  if cbbNormal.ItemIndex =-1  then Exit;
  Dictionary.cds_WorkerStationList.Close;   //��ʱˢ��
  Dictionary.cds_WorkerStationList.Filtered := False;
  Dictionary.cds_WorkerStationList.Filter := 'Machine_ID=' + QuotedStr(Login.CurrentDepartment+LeftStr(cbbNormal.Items[cbbNormal.ItemIndex], 2));
  Dictionary.cds_WorkerStationList.Filtered := True;
  TGlobal.FillItemsFromDataSet(Dictionary.cds_WorkerStationList,'Worker_ID','','--',lstOperator.Items);
end;

end.


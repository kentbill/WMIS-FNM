unit frmSendSCInfo;

{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmSendInfo.pas                                               }
{       �������� 2004-8-26 16:22:52                                            }
{       ������Ա zhangjy                                                       }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{            ��: FNMDB..fnStock�������ֶ�                                      }
{            д: FNMDB..fnPay�������ֶ�                                        }
{            д: FNMDB..fnJobTraceDtl��                                        }
{       ������Ҫ����/SQL����˵��                                               }
{       ��������                                                               }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, StdCtrls, ExtCtrls, OleCtrls, Buttons,
  DB, DBClient, ComCtrls, StrUtils, GFCADLib_TLB, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxSplitter,Math;

type
  TSendSCInfoForm = class(TBaseForm)
    cdsSendInfo: TClientDataSet;
    dsSendInfo: TDataSource;
    btnClose: TSpeedButton;
    btnSave: TSpeedButton;
    btnRefresh: TSpeedButton;
    cxspl1: TcxSplitter;
    spl1: TSplitter;
    grpSource: TGroupBox;
    pnl7: TPanel;
    lblQuantitySource: TLabel;
    edtQuantitySource: TEdit;
    lvSource: TListView;
    pnlButton: TPanel;
    btnRight: TSpeedButton;
    btnRightAll: TSpeedButton;
    btnLeft: TSpeedButton;
    btnLeftAll: TSpeedButton;
    grpDestinate: TGroupBox;
    pnl8: TPanel;
    lblQuantityDestinate: TLabel;
    edtQuantityDestinate: TEdit;
    lvDestinate: TListView;
    cxgrdOnlineSendInfo: TcxGrid;
    cxgrdtvSendInfo: TcxGridDBTableView;
    cxgrdlvlOnLineGridlcxgrid2Level1: TcxGridLevel;
    btnSb: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnRightClick(Sender: TObject);
    procedure btnRightAllClick(Sender: TObject);
    procedure btnLeftClick(Sender: TObject);
    procedure btnLeftAllClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure lvSourceDblClick(Sender: TObject);
    procedure lvDestinateDblClick(Sender: TObject);
    procedure lvSourceColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvDestinateColumnClick(Sender: TObject; Column: TListColumn);
    procedure FormCreate(Sender: TObject);
    procedure lvSourceKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvDestinateKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvDestinateCustomDraw(Sender: TCustomListView;
      const ARect: TRect; var DefaultDraw: Boolean);
    procedure cbbDestinateChange(Sender: TObject);
    procedure lvSourceChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvDestinateChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure FormActivate(Sender: TObject);
    procedure btnSbClick(Sender: TObject);
  private
    { Private declarations }
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
   �������� GetData
   ������Ա zhangjy
   �������� 2004-8-26 14:24:39
   �����б� None
   ����ֵ   None
   �������� ��ȡ����
   ��������
   �ο��ĵ�

   ����˵��
-------------------------------------------------------------------------------}
    procedure GetSendInfo;
    procedure GetSendNoteInfo;
    procedure GetData;
{* -----------------------------------------------------------------------------
   �������� SaveData
   ������Ա zhangjy
   �������� 2004-8-26 16:18:53
   �����б� None
   ����ֵ   None
   �������� �����Ͳ���Ϣ
   ��������
   �ο��ĵ�

   ����˵��
-------------------------------------------------------------------------------}
    procedure SaveSendInfo;
    procedure SaveData;
  public
    { Public declarations }
{* -----------------------------------------------------------------------------
   �������� PublicQuery ;PublicExport; PublicSave
   ������Ա zhangjy
   �������� 2004-8-31 15:41:59
   �����б� None
   ����ֵ   None
   �������� ��ӦTOOLBAR��Ӧ���¼�
   ��������
   �ο��ĵ�

   ����˵��
-------------------------------------------------------------------------------}
    //procedure FiltercxGridTableView(FildName, FilterValue: String);
    procedure PublicQuery; override;
    procedure PublicExport; override;
    procedure PublicSave; override;
  end;
var
  SendSCInfoForm: TSendSCInfoForm;

implementation

uses ServerDllPub, uGlobal,uShowMessage, uLogin, uGridDecorator,
  uAppOption, uDictionary, uFNMResource,rptSendInfo, frmSendInfo;

{$R *.dfm}

procedure TSendSCInfoForm.PublicQuery;
begin
  GetData;
end;

procedure TSendSCInfoForm.PublicExport;
begin
  TGlobal.SaveDataToFile(cdsSendInfo, sftXLS)
end;

procedure TSendSCInfoForm.PublicSave;
begin
  SaveData;
end;

procedure TSendSCInfoForm.Initialize;
begin
  //����BUTTONͼƬ
  btnRight.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btnRightAll.Glyph.LoadFromResourceName(HInstance, RES_DOWNALL);
  btnLeft.Glyph.LoadFromResourceName(HInstance, RES_UP);
  btnLeftAll.Glyph.LoadFromResourceName(HInstance, RES_UPALL);
  btnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
   // ����Ͳ��ص�
  //Dictionary.cds_MaterialFlowList.Filtered := False;
  //Dictionary.cds_MaterialFlowList.Filter := 'Current_Department=' + QuotedStr(Login.CurrentDepartment) + ' AND Flow_Description=' + QuotedStr('�Ͳ��ص�');
  //Dictionary.cds_MaterialFlowList.Filtered := True;
  //TGlobal.FillItemsFromDataSet(Dictionary.cds_MaterialFlowList, 'Relation_Department', 'Relation_Department_CHN', '->', cbbDestinate.Items);

  //if Login.CurrentDepartment <> 'FX' Then
  //begin
  //�ƻ��೤/�����೤
  //Dictionary.cds_WorkerList.Filtered := False;
  //Dictionary.cds_WorkerList.Filter := 'Department=' + QuotedStr(Login.CurrentDepartment) + ' AND Worker_Group=' + QuotedStr('�ƻ��೤');
  //Dictionary.cds_WorkerList.Filtered := True;
  //TGlobal.FillItemsFromDataSet(Dictionary.cds_WorkerList, 'Worker_Name', '', '', cbPlanOperator.Items);
  //Dictionary.cds_WorkerList.Filtered := False;
  //Dictionary.cds_WorkerList.Filter := 'Department=' + QuotedStr(Login.CurrentDepartment) + ' AND Worker_Group=' + QuotedStr('�����೤');
  //Dictionary.cds_WorkerList.Filtered := True;
  //TGlobal.FillItemsFromDataSet(Dictionary.cds_WorkerList, 'Worker_Name', '', '', cbQualityOperator.Items);
  //end;
  //lbQualityOperator.Visible :=  Login.CurrentDepartment <> 'FX';
  //lbPlanOperator.Visible :=  Login.CurrentDepartment <> 'FX';
  //cbQualityOperator.Visible :=  Login.CurrentDepartment <> 'FX';
  //cbPlanOperator.Visible :=  Login.CurrentDepartment <> 'FX';

  //ListView��ѡ
  //lvSource.MultiSelect := True;
  //lvDestinate.MultiSelect := True;

  edtQuantitySource.Text := '0.0';
  edtQuantityDestinate.Text := '0.0';
  //cbbDestinate.ItemIndex := 0;
end;

procedure TSendSCInfoForm.GetSendInfo;
var vData: OleVariant;
  sCondition,sErrorMsg,sDestination: WideString;
  i,j: Integer;
  sOperator: string;
begin
  lvDestinate.Items.Clear ; //Added by wlx
  edtQuantityDestinate.Text :='';
  //if cbbDestinate.Text ='' then
  //begin
  //  TMsgDialog.ShowMsgDialog('��ѡ���Ͳ��ص㣡',mtWarning);
  //  cbbDestinate.SetFocus;
  //  exit;
  //end;
  try
    ShowMsg('���ڻ�ȡ�����Եȣ�', crHourGlass);
   //��ȡ���򿨵Ŀ�����Ϣ
    sDestination:='';
    sCondition := QuotedStr(sDestination)+',' + QuotedStr(Login.CurrentDepartment)+','+IntToStr(2);
    FNMServerObj.GetQueryData(vData,'GetSendInfo',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TempClientDataSet.Filter := '';
    cdsSendInfo.Filter := '';
    TempClientDataSet.Data := vData;

    if TempClientDataSet.IsEmpty then
    begin
      lvSource.Items.Clear;
      lvDestinate.Items.Clear;
      TMsgDialog.ShowMsgDialog('û�д��Ͳ�����Ϣ',2);
      Exit;
    end;
    //���δ�򿨵�ListView
    //����ID : 285178   tracy tan 2017-1-6

    TGlobal.FillItemsFromDataSet(TempClientDataSet, 'Quantity',['FN_Card','Quantity','Operation_CHN','GF_NO','step_no','job_no','Check_Value','Current_Department','Current_StepNo', 'Current_OperationCode','Location','WV_Actual_Finish_Date'],nil,edtQuantitySource,lvSource.Items);
    TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
    //���cxGrid
    //GridDecorator.BindCxViewWithDataSource(cxgridtvSendInfo, dsSendInfo);
    //Dictionary.cds_WorkerStationList.Filtered := False;
//    if Dictionary.cds_WorkerStationList.Locate('Current_Department;Operate_Type',VarArrayOf([Login.CurrentDepartment,'�ƻ�']),[]) then
//    begin
//      sOperator:='';
//      sOperator :=  Dictionary.cds_WorkerStationList.FieldByName('Worker_ID').AsString;
//      i:= Pos('(',sOperator);
//      j:= Pos(')',sOperator);
//      sOperator := Copy(sOperator,i+1,j-i-1);
//      cbPlanOperator.ItemIndex := cbPlanOperator.Items.IndexOf(sOperator);
//    end;

//    if Dictionary.cds_WorkerStationList.Locate('Current_Department;Operate_Type',VarArrayOf([Login.CurrentDepartment,'����']),[]) then
//    begin
//      sOperator:='';
//      sOperator :=  Dictionary.cds_WorkerStationList.FieldByName('Worker_ID').AsString;
//      i:= Pos('(',sOperator);
//      j:= Pos(')',sOperator);
//      sOperator := Copy(sOperator,i+1,j-i-1);
//      cbQualityOperator.ItemIndex := cbQualityOperator.Items.IndexOf(sOperator);
//    end;
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TSendSCInfoForm.GetSendNoteInfo;
var vData: OleVariant;
  sCondition,sErrorMsg,sDestination: WideString;
begin
    sCondition := QuotedStr(sDestination)+',' + QuotedStr(Login.CurrentDepartment)+','+IntToStr(3);
    FNMServerObj.GetQueryData(vData,'GetSendInfo',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsSendInfo.Data := vData;
    GridDecorator.BindCxViewWithDataSource(cxgrdtvSendInfo, dsSendInfo);
end;

procedure TSendSCInfoForm.GetData;
begin
  GetSendInfo;
  GetSendNoteInfo;
end;

procedure TSendSCInfoForm.SaveSendInfo;
var i: Integer;
   sCondition,sFNCardList, sStepNOList,sNote_NO,sOperator, sErrorMsg: WideString;
begin
  inherited;
  try
    if lvDestinate.Items.Count = 0 then Exit;

    ShowMsg('���ڱ��������Եȣ�', crHourGlass);

    sOperator := Login.LoginName;


    sFNCardList := '';
    sStepNOList:='';
    for i := 0 to lvDestinate.Items.Count - 1 do
    begin
      sFNCardList := sFNCardList + lvDestinate.Items[i].Caption + ',';
      sStepNOList := sStepNOList + lvDestinate.Items[i].SubItems[3] + ',';
    end;
    sFNCardList := LeftStr(sFNCardList, Length(sFNCardList) - 1);
    sStepNOList := LeftStr(sStepNOList, Length(sStepNOList) - 1);

    sCondition :=  QuotedStr(sFNCardList)+',' + QuotedStr(sStepNOList)+','+ QuotedStr(Login.CurrentDepartment)+',' +
                 QuotedStr(sOperator);
    FNMServerObj.SaveDataBySQLEx('SaveSCSendInfo',sCondition,sNote_NO,sErrorMsg);
   //  FNMServerObj.SaveSendInfo(sFNCardList, sDestination, , sOperator, 0,sNote_NO, sErrorMsg);

    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      exit;
    end;

//    for i := 0 to lvDestinate.Items.Count - 1 do
//    begin
//      while cdsSendInfo.Locate('FN_Card;step_no', VarArrayOf([lvDestinate.Items[i].Caption,lvDestinate.Items[i].SubItems[3]]), []) do
//        cdsSendInfo.Delete;
//    end;

    lvDestinate.Items.Clear;
    TMsgDialog.ShowMsgDialog('�������ݳɹ�', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
      //��ӡ�Ͳ���
//  if not Assigned(SendInfoReport) then
//    SendInfoReport := TSendInfoReport.Create(nil);
//  SendInfoReport.PreviewReport(sNote_No,True);
end;

procedure TSendSCInfoForm.SaveData;
begin
  SaveSendInfo;
end;

procedure TSendSCInfoForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TSendSCInfoForm.FormDestroy(Sender: TObject);
begin
  inherited;
  SendSCInfoForm := nil;
end;

procedure TSendSCInfoForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  GetData;
end;

procedure TSendSCInfoForm.btnRightClick(Sender: TObject);
begin
  TGlobal.MoveDataEx(lvSource,lvDestinate,0,nil,edtQuantitySource,nil,edtQuantityDestinate);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TSendSCInfoForm.btnRightAllClick(Sender: TObject);
begin
  TGlobal.MoveDataEx(lvSource,lvDestinate,0,nil,edtQuantitySource,nil,edtQuantityDestinate,True);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TSendSCInfoForm.btnLeftClick(Sender: TObject);
begin
  TGlobal.MoveDataEx(lvDestinate,lvSource,0,nil,edtQuantityDestinate, nil, edtQuantitySource);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TSendSCInfoForm.btnLeftAllClick(Sender: TObject);
begin
  TGlobal.MoveDataEx(lvDestinate,lvSource,0,nil,edtQuantityDestinate, nil, edtQuantitySource,True);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TSendSCInfoForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveData;
end;

procedure TSendSCInfoForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TSendSCInfoForm.lvSourceDblClick(Sender: TObject);
begin
  TGlobal.MoveDataEx(lvSource,lvDestinate,0,nil,edtQuantitySource,nil,edtQuantityDestinate);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;



procedure TSendSCInfoForm.lvDestinateDblClick(Sender: TObject);
begin
  TGlobal.MoveDataEx(lvDestinate,lvSource,0,nil,edtQuantityDestinate, nil, edtQuantitySource);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;


procedure TSendSCInfoForm.lvSourceColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  inherited;
  TGlobal.SortListView(lvSource, Column);
end;

procedure TSendSCInfoForm.lvDestinateColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  inherited;
  TGlobal.SortListView(lvDestinate, Column);
end;

procedure TSendSCInfoForm.FormCreate(Sender: TObject);
begin
  inherited;
  Initialize;
end;

procedure TSendSCInfoForm.lvSourceKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    TGlobal.MoveDataEx(lvSource,lvDestinate,0,nil,edtQuantitySource, nil,edtQuantityDestinate);
    TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
  end;
end;

procedure TSendSCInfoForm.lvDestinateKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    TGlobal.MoveDataEx(lvDestinate,lvSource,0,nil,edtQuantityDestinate, nil, edtQuantitySource);
    TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
  end;
end;

procedure TSendSCInfoForm.lvDestinateCustomDraw(Sender: TCustomListView;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
  inherited;
  btnSave.Enabled := lvDestinate.Items.Count>0;
end;

procedure TSendSCInfoForm.cbbDestinateChange(Sender: TObject);
begin
  inherited;
  GetData();
end;

//procedure TSendSCInfoForm.FiltercxGridTableView(FildName, FilterValue: String);
//begin
//  with cxgridtvSendInfo, DataController.Filter do
//  begin
//    BeginUpdate;
//    try
//      Root.Clear;
//      Root.AddItem(cxgridtvSendInfo.GetColumnByFieldName(FildName), foEqual, FilterValue, FilterValue);
//      if not Active then
//        Active:=true;
//    finally
//      EndUpdate;
//    end;
//  end;
//end;

procedure TSendSCInfoForm.lvSourceChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  inherited;
  if lvSource.ItemIndex < 0 then Exit;
  //FiltercxGridTableView('FN_Card', lvSource.Items[lvSource.ItemIndex].Caption);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TSendSCInfoForm.lvDestinateChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  inherited;
  if lvDestinate.ItemIndex < 0 then Exit;
  //FiltercxGridTableView('FN_Card', lvDestinate.Items[lvDestinate.ItemIndex].Caption);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;



procedure TSendSCInfoForm.FormActivate(Sender: TObject);
begin
  inherited;
  Application.ProcessMessages;
  //ˢ�½�������
  PostMessage(Handle, WM_KEYDOWN, VK_F5, 0);
  btnRefresh.Click;
  OnActivate:=nil;
end;

procedure TSendSCInfoForm.btnSbClick(Sender: TObject);
var
  i:Integer;
  sCondition,sNoteNoList, sStepNOList,sNote_NO,sOperator, sErrorMsg: WideString;
begin
  inherited;

  with cxgrdtvSendInfo do
  begin
    for i :=Controller.SelectedRowCount - 1 downto 0 do
    begin
      sNoteNoList := sNoteNoList + Controller.SelectedRows[i].Values[GetColumnByFieldName('Note_no').Index] + ',';
    end;
  end;
  sStepNOList := '';
  sCondition :=  QuotedStr(sNoteNoList)+',' + QuotedStr(sStepNOList)+','+ QuotedStr(Login.CurrentDepartment)+',' +
                 QuotedStr(sOperator);
    FNMServerObj.SaveDataBySQLEx('SaveSCSendInfo',sCondition,sNote_NO,sErrorMsg);
   //  FNMServerObj.SaveSendInfo(sFNCardList, sDestination, , sOperator, 0,sNote_NO, sErrorMsg);

    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      exit;
    end;

//    for i := 0 to lvDestinate.Items.Count - 1 do
//    begin
//      while cdsSendInfo.Locate('FN_Card;step_no', VarArrayOf([lvDestinate.Items[i].Caption,lvDestinate.Items[i].SubItems[3]]), []) do
//        cdsSendInfo.Delete;
//    end;

    lvDestinate.Items.Clear;
    TMsgDialog.ShowMsgDialog('�������ݳɹ�', mtInformation);
end;

end.

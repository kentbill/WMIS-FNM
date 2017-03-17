unit frmJobTrace;
{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmJobTrace.pas                                          }
{       �������� 2004-8-26 16:20:05                                            }
{       ������Ա zhangjy                                                       }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{       ������Ҫ����/SQL����˵��                                               }
{       �������� �Ͳ�ǰ����CHECK                                               }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, StdCtrls, ExtCtrls, Buttons, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, uFNMResource,
  uCADInfo, DBClient,Math, ComCtrls;

type
  TJobTraceForm = class(TBaseForm)
    pnl1: TPanel;
    pnl2: TPanel;
    lbledtFNCard: TLabeledEdit;
    btnQuery: TSpeedButton;
    btnDown: TSpeedButton;
    btnClose: TSpeedButton;
    btnUp: TSpeedButton;
    lbledtSpeed: TLabeledEdit;
    lbledtCarNO: TLabeledEdit;
    lbledtWidth: TLabeledEdit;
    cxtvJobTrace: TcxGridDBTableView;
    cxGridJobTraceLevel1: TcxGridLevel;
    cxGridJobTrace: TcxGrid;
    cdsJobTrace: TClientDataSet;
    dsJobTrace: TDataSource;
    lbl1: TLabel;
    cbbMachine_ID: TComboBox;
    dtpDate: TDateTimePicker;
    lbl2: TLabel;
    dtpTime: TDateTimePicker;
    lbledtRoll: TLabeledEdit;
    lbllocation: TLabel;
    edtArea: TEdit;
    procedure btnQueryClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbledtFNCardKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsJobTraceAfterScroll(DataSet: TDataSet);
    procedure cxtvJobTraceCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    CanUpStepNO: Integer;
    procedure Initialize;
    procedure GetJobTraceInfo;
    procedure SetMachineOperation(Index: Integer);
    procedure CheckLF();
    procedure WriteAccidentBill();
    { Private declarations }
  public
    { Public declarations }
    sDownLF:string;
    sQuantity,sOperation_Code,saLF,sFnCard:string;
  end;

var
  JobTraceForm: TJobTraceForm;

implementation

uses ServerDllPub, uGlobal, uShowMessage, uLogin, uGridDecorator,uDictionary,StrUtils;

{$R *.dfm}

procedure TJobTraceForm.GetJobTraceInfo;
var vData: OleVariant;
    sFNCard: string;
    sCondition,sErrorMsg: WideString;
begin
  try
    ShowMsg('���ڻ�ȡ�����Եȣ�', crHourGlass);
    CanUpStepNO := 0;
    cdsJobTrace.AfterScroll := nil;
    //��ȡ���Ľ��ȸ�����Ϣ
    sFNCard := Trim(lbledtFNCard.Text);
    if sFNCard= '' then Exit;
    if (sFNCard[1] <> 'N') and (Length(sFNCard) <> 9) then
    begin
      TMsgDialog.ShowMsgDialog('����λ������,����������', 1);
      Exit;
    end;
    //FNMServerObj.GetJobTraceInfo(vData, sFNCard,Login.CurrentDepartment,0,sErrorMsg);
    sCondition := QuotedStr(sFNCard)+','+ QuotedStr(Login.CurrentDepartment)+',0';
    FNMServerObj.GetQueryData(vData,'GetJobTrace',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      Application.ShowException(Exception.Create(sErrorMsg));
      Exit;
    end;
    cdsJobTrace.Data := vData;
    if cdsJobTrace.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('û����Ӧ������,�����²�ѯ', 1);
      Exit;
    end;
    GridDecorator.BindCxViewWithDataSource(cxtvJobTrace, dsJobTrace);
    if cdsJobTrace.Locate('Status','δ�ӹ�',[loCaseInsensitive]) then
      CanUpStepNO := cdsJobTrace.FieldValues['Step_NO'];
  finally
    cdsJobTrace.AfterScroll :=  cdsJobTraceAfterScroll;
    cdsJobTraceAfterScroll(cdsJobTrace);
    ShowMsg('', crDefault);
  end;
end;

procedure TJobTraceForm.SetMachineOperation(Index: Integer);
var
  sFNCard, sCarNO, sRoll, sMachineID,sOperate_Time,sOperator,sOperation_Code,XJ: string;
  dSpeed, dWidth: Double;
  iStepNO: Integer;
  sCondition,sErrorMsg: WideString;
begin
  inherited;
  try
    ShowMsg('���ڱ��������Եȣ�', crHourGlass);
    cdsJobTrace.AfterScroll := nil;
    cdsJobTrace.DisableControls;
    sOperation_Code := cdsJobTrace.FieldValues['Operation_Code'];
    iStepNO := cdsJobTrace.FieldValues['Step_NO'];
    if cdsJobTrace.FieldValues['Machine_ID']<> null then
     sMachineID := cdsJobTrace.FieldValues['Machine_ID'];
    sFNCard := Trim(lbledtFNCard.Text);
    if sFNCard = '' then Exit;
    sCarNO := Trim(lbledtCarNO.Text);
    sRoll := Trim(lbledtRoll.Text);

    sOperate_Time := FormatDateTime('yyyy-mm-dd', dtpDate.Date) + ' ' + TimeToStr(dtpTime.Time);
    sOperator := Login.LoginID;
    dSpeed := 0;
    dWidth := 0;
    if Index = 0 then
    begin
      if (sMachineID='') and (cbbMachine_ID.Text = '') then
      begin
        TMsgDialog.ShowMsgDialog('��ѡ���̨', 1);
        cbbMachine_ID.SetFocus;
        Exit;
      end;
      sMachineID := Copy(cbbMachine_ID.Text,1,pos('->',cbbMachine_ID.Text)-1);
      if not TGlobal.CheckValueIsNumeric(lbledtSpeed.Text, '�����������ݲ�����') then Exit;
      dSpeed := StrToFloat(lbledtSpeed.Text);
      if dSpeed = 0.0 then
      begin
        TMsgDialog.ShowMsgDialog('�������ݲ���������������', 1);
        lbledtSpeed.SetFocus;
        Exit;
      end;
    end;
    if Index = 2 then
    begin
      if sCarNO = '' then
      begin
        TMsgDialog.ShowMsgDialog('�������µĳ��ƺ�', 1);
        lbledtCarNO.SetFocus;
        Exit;
      end;
      if not TGlobal.CheckValueIsNumeric(lbledtWidth.Text, '����������ݲ�����') then Exit;
      dWidth := StrToFloat(lbledtWidth.Text);
      if dWidth = 0.0 then
      begin
        TMsgDialog.ShowMsgDialog('������ݲ���������������', 1);
        lbledtWidth.SetFocus;
        Exit;
      end;
    end;
  // ��⹤���Ƿ����ڴ˻�̨��
    with Dictionary.cds_OperationHdrList do
    begin
      Filter := 'Operation_Type =''Hand_Dip''';
      Filtered := True;
      if not Locate('Operation_Code',sOperation_Code,[loCaseInsensitive]) then
      begin
          Dictionary.cds_OperationMapMachineModel.Filtered := False;
          if not Dictionary.cds_OperationMapMachineModel.Locate('Operation_Code;Machine_Model', VarArrayOf([sOperation_Code,copy(sMachineID,1,2)]),[loCaseInsensitive]) then
          begin
            TMsgDialog.ShowMsgDialog('�˹������ڴ˻�̨��,������ѡ���̨',mtError);
            cbbMachine_ID.SetFocus;
            Exit;
          end;
      end;
    end;

    XJ := '';
    sCondition:=QuotedStr(sFNCard)+','
              +IntToStr(iStepNO)+','
            + QuotedStr(sMachineID)+','
            + QuotedStr(sCarNO)+','
            + FloatToStr(dSpeed)+','
            + FloatToStr(dWidth)+','
            + QuotedStr(sOperate_Time)+','
            + QuotedStr(sOperator)+','
            + QuotedStr(login.CurrentDepartment)+','
            + IntToStr(Index)+ ','
            + QuotedStr(sRoll) + ','
            + QuotedStr(XJ) + ','
            + QuotedStr(edtArea.Text);
//    FNMServerObj.SetMachineOperation(sFNCard,iStepNO,sMachineID, sCarNO, dSpeed, dWidth,sOperate_Time,sOperator,login.CurrentDepartment, Index, sErrorMsg);
    FNMServerObj.SaveDataBySQL('SetMachineOperation',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
    case Index of
      0: begin
          cdsJobTrace.Edit;
          cdsJobTrace.FieldValues['Status'] := '���ӹ�';
          cdsJobTrace.FieldValues['Begin_Time'] := FormatDateTime('yyyy-mm-dd', dtpDate.Date) + ' ' + TimeToStr(dtpTime.Time);
          cdsJobTrace.FieldValues['Machine_ID'] := sMachineID;
          cdsJobTrace.Post;
          btnUp.Enabled := False;
          lbledtSpeed.Enabled := btnUp.Enabled;
          lbledtWidth.Enabled := not btnUp.Enabled;
          lbledtCarNO.Enabled := not btnUp.Enabled;
          lbledtRoll.Enabled := lbledtCarNO.Enabled;
          lbledtCarNO.Text := '';
          lbledtRoll.Text := '';
          btnDown.Enabled := True;
         end;
      2: begin
          btnDown.Enabled := False;
          cdsJobTrace.Edit;
          cdsJobTrace.FieldValues['Status'] := '�����';
          cdsJobTrace.FieldValues['End_Time'] :=  FormatDateTime('yyyy-mm-dd', dtpDate.Date) + ' ' + TimeToStr(dtpTime.Time);
          cdsJobTrace.Post;
          Inc(CanUpStepNO);
         end;
    end;
    lbledtSpeed.Color := IfThen(lbledtSpeed.Enabled, clWindow, clMenu);
    lbledtWidth.Color := IfThen(lbledtWidth.Enabled, clWindow, clMenu);
    lbledtCarNO.Color := IfThen(lbledtCarNO.Enabled, clWindow, clMenu);
    lbledtRoll.Color := lbledtCarNO.Color;

    TMsgDialog.ShowMsgDialog('�������ݳɹ�', mtInformation);
  finally
    cxtvJobTrace.ApplyBestFit(nil);
    cdsJobTrace.AfterScroll := cdsJobTraceAfterScroll;
    cdsJobTrace.EnableControls;
    if (sOperation_Code ='035') or (sOperation_Code ='049') then//���� ��ë

      btnQuery.Click;
    ShowMsg('', crDefault);
  end;
end;

procedure TJobTraceForm.btnQueryClick(Sender: TObject);
begin
  inherited;
  GetJobTraceInfo;
end;

procedure TJobTraceForm.btnUpClick(Sender: TObject);
begin
  inherited;
  SetMachineOperation(0);
end;

procedure TJobTraceForm.btnDownClick(Sender: TObject);
begin
  inherited;
  if (LeftStr(cbbMachine_ID.Text,2) ='MC') or (LeftStr(cbbMachine_ID.Text,2) ='ST') then
  begin
    sDownLF := lbledtWidth.Text;
    with cxtvJobTrace do
    begin
      sQuantity := Controller.SelectedRows[0].Values[GetColumnByFieldName('Quantity').Index];
      sOperation_Code := Controller.SelectedRows[0].Values[GetColumnByFieldName('Operation_Code').Index];
      saLF := Controller.SelectedRows[0].Values[GetColumnByFieldName('���').Index];
    end;
    sFnCard := lbledtFNCard.Text;
  end;

  SetMachineOperation(2);
  CheckLF();
end;

//˿�ⶨ�ͻ� ������
procedure TJobTraceForm.CheckLF();
var
  i:Integer;
begin
  //˿�ⶨ�ͻ� ������
  if (LeftStr(cbbMachine_ID.Text,2) ='MC') then
  begin

    if saLF = '' then
      Exit;
      //saLF:= '0';
    if sDownLF = '' then
      sDownLF :='0'
    else
      sDownLF :=sDownLF;

    if (StrToFloat(saLF) > StrToFloat(sDownLF) + 2) or (StrToFloat(saLF) < StrToFloat(sDownLF) - 2) then
    begin
      WriteAccidentBill();
    end;
  end;

  if  (LeftStr(cbbMachine_ID.Text,2) ='ST') then
  begin

    if saLF = '' then
      Exit;
      //saLF:= '0';
    if sDownLF = '' then
      sDownLF :='0'
    else
      sDownLF :=sDownLF;

    if (StrToFloat(saLF) > StrToFloat(sDownLF) + 1) or (StrToFloat(saLF) < StrToFloat(sDownLF) - 1) then
    begin
      WriteAccidentBill();
    end;
  end;
end;

procedure TJobTraceForm.WriteAccidentBill();
var
  sCondition,sErrorMsg:WideString;
  sQuantity,sOperation_Code,saLF:string;
begin
//  sQuantity := cdsJobTrace.FieldByName('Quantity').AsString;
//  sOperation_Code := cdsJobTrace.FieldByName('Operation_Code').AsString;
//  saLF := cdsJobTrace.FieldByName('���').AsString;

  sCondition := QuotedStr(sFnCard) + ',' +
                QuotedStr(sOperation_Code) + ',' + QuotedStr(LeftStr(cbbMachine_ID.Text,4)) +
                ',' + QuotedStr('����ԭ��,�볤,ʵ�����,�������') + ',' + QuotedStr(''+ ',' + sQuantity+','+sDownLF + ',' +saLF);
  FNMServerObj.SaveDataBySQL('AutoCreateAccident',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
    Exit;
  end;
end;

procedure TJobTraceForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TJobTraceForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TJobTraceForm.FormCreate(Sender: TObject);
begin
  inherited;
  Initialize;
end;

procedure TJobTraceForm.Initialize;
begin
  btnQuery.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnDown.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btnUp.Glyph.LoadFromResourceName(HInstance, RES_UP);
  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  dtpDate.Date := Date();
  dtpTime.Time := Time();
  with Dictionary do
  try
    with cds_FinishMachineList do
    begin
      Filter := 'Department ='+ QuotedStr(login.CurrentDepartment);
      Filtered := True;
      TGlobal.FillItemsFromDataSet(cds_FinishMachineList, 'Machine_ID', 'Machine_Model_CHN', '->', cbbMachine_ID.Items);
    end;
    with cds_OperationHdrList do
    begin
      Filter := 'Operation_Type =''Hand_Dip''';
      Filtered := True;
      while not Eof do
      begin
        cbbMachine_ID.Items.Append(FieldByName('Operation_Code').AsString + '->' + FieldByName('Operation_CHN').AsString);
        Next;
      end;
    end;
  finally
    cds_FinishMachineList.Filtered:=false;
    cds_OperationHdrList.Filtered:=false;
  end;
  SetWindowLong(lbledtSpeed.Handle,GWL_STYLE,GetWindowLong(lbledtSpeed.Handle,GWL_STYLE) or ES_NUMBER);
  SetWindowLong(lbledtWidth.Handle,GWL_STYLE,GetWindowLong(lbledtWidth.Handle,GWL_STYLE) or ES_NUMBER);
end;

procedure TJobTraceForm.FormDestroy(Sender: TObject);
begin
  inherited;
  JobTraceForm := nil;
end;

procedure TJobTraceForm.lbledtFNCardKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = 13 then
    GetJobTraceInfo;
end;

procedure TJobTraceForm.cdsJobTraceAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if (not DataSet.Active) or DataSet.IsEmpty then Exit;
  if DataSet.FieldByName('Status').AsString='�����' then
  begin
    btnUp.Enabled := False;
    btnDown.Enabled := False;
    Exit;
  end;
  if DataSet.FieldByName('Fact_Art_ID').AsInteger < 0 then //����
     btnUp.Enabled := True
  else if DataSet.FieldByName('Operation_Code').AsString='000' then
     btnUp.Enabled := (DataSet.FieldByName('Status').AsString='δ�ӹ�')
  else
  begin
    with Dictionary.cds_OperationHdrList do
    begin
      Filtered := False;
      if Locate('Operation_Code;Operation_Type',
         VarArrayOf([DataSet.FieldByName('Operation_Code').AsString,'DIP']),[loCaseInsensitive]) then
        btnUp.Enabled := False
      else
        btnUp.Enabled := (CanUpStepNO =DataSet.FieldByName('Step_NO').AsInteger)
           and DataSet.FieldByName('Begin_Time').IsNull and (UpperCase(Login.CurrentDepartment) = UpperCase(DataSet.FieldByName('Current_Department').AsString)) ;
     end;
  end;
  lbledtSpeed.Text := DataSet.FieldByName('Speed').AsString;
  lbledtSpeed.Enabled := btnUp.Enabled;
  btnDown.Enabled := (not DataSet.FieldByName('Begin_Time').IsNull) and (DataSet.FieldByName('End_Time').IsNull);
end;

procedure TJobTraceForm.cxtvJobTraceCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var Begin_Col, End_Col,Status_Col : Integer;
begin
  inherited;
  if AViewInfo.Focused then  Exit;
  Begin_Col := TcxGridDBTableView(Sender).GetColumnByFieldName('Begin_Time').Index;
  End_Col := TcxGridDBTableView(Sender).GetColumnByFieldName('End_Time').Index;
  Status_Col := TcxGridDBTableView(Sender).GetColumnByFieldName('Status').Index;
  if AViewInfo.GridRecord.Values[Status_Col] = '�����' then
  ACanvas.Font.Color := clSilver;
  if (not VarIsNull(AViewInfo.GridRecord.Values[Begin_Col]))
     and (VarIsNull(AViewInfo.GridRecord.Values[End_Col])) then
  begin
    ACanvas.Font.Size := 10;
    ACanvas.Font.Style := ACanvas.Font.Style + [fsBold, fsItalic];
  end;
end;

end.


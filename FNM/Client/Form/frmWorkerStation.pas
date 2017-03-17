unit frmWorkerStation;
{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmWorkerStation.pas                                                 }
{       �������� 2004-9-8 18:12:43                                             }
{       ������Ա zhangjy                                                       }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{       ������Ҫ����/SQL����˵��                                               }
{       ��������  ���Ż�̨��Ա                                                            }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, StdCtrls, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DBClient, ComCtrls, ADODB, ExtCtrls, DBCtrls,
  Mask, StrUtils, CheckLst, Buttons, Grids, ValEdit, DBGrids, cxContainer,
  cxCheckBox, cxCheckListBox;

type
  TWorkerStationForm = class(TForm)
    btnRefresh: TButton;
    btnSave: TButton;
    btnClose: TButton;
    pgcWorkerStation: TPageControl;
    tsWorkerStation: TTabSheet;
    lblMachine: TLabel;
    lstMachine: TListBox;
    lblWorker: TLabel;
    cbbWorkerGroup: TComboBox;
    btnRight: TBitBtn;
    btnClear: TButton;
    lblCurWorker: TLabel;
    vleCurWorker: TValueListEditor;
    lstWorker: TListBox;
    cbbOperateType: TComboBox;
    lblOperateType: TLabel;
    ds1: TDataSource;
    lblMonitor: TLabel;
    edtQualityMonitor: TEdit;
    btnQualityMonitor: TButton;
    btnPlanMonitor: TButton;
    lbl1: TLabel;
    edtPlanMonitor: TEdit;
    cdsPlan: TClientDataSet;
    chklstMachine: TCheckListBox;
    btnSelect: TButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure lstMachineClick(Sender: TObject);
    procedure cbbWorkerGroupChange(Sender: TObject);
    procedure lstWorkerDblClick(Sender: TObject);
    procedure btnRightClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure vleCurWorkerGetPickList(Sender: TObject;
      const KeyName: string; Values: TStrings);
    procedure vleCurWorkerDblClick(Sender: TObject);
    procedure btnQualityMonitorClick(Sender: TObject);
    procedure btnPlanMonitorClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure chklstMachineClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);

  private
    { Private declarations }
    //Max_WorkerCount_Per_Machine: Integer; // ÿ̨���������������
{* -----------------------------------------------------------------------------
   �������� Initialize
   ������Ա zhangjy
   �������� 2004-9-9 12:04:06
   �����б� None
   ����ֵ   None
   �������� ��ʼ���������
   ��������
   �ο��ĵ�

   ����˵��
-------------------------------------------------------------------------------}
    procedure Initialize;
{* -----------------------------------------------------------------------------
   �������� SaveWorkerInfo,SaveWorkerGroupInfo
   ������Ա zhangjy
   �������� 2004-9-9 12:04:25
   �����б� None
   ����ֵ   None
   �������� ���湤�˼����������Ϣ
   ��������
   �ο��ĵ�

   ����˵��
-------------------------------------------------------------------------------}
    procedure SaveWorkerStationInfo;
{* -----------------------------------------------------------------------------
   �������� FilterData
   ������Ա zhangjy
   �������� 2004-9-13 12:09:46
   �����б� Index: Integer ;ItemIndex:Integer
   ����ֵ   None
   �������� ���ݹ���
   ��������
   �ο��ĵ�

   ����˵��
-------------------------------------------------------------------------------}
    procedure FilterData(Index: Integer; ItemIndex: Integer);
    procedure GetData();
    procedure AddDataToCurWorkerList;
    procedure GetWorkerShift;
    procedure FilterWorker(sMachine:String);
    function CheckData(var WorkerList: WideString; vle: TValueListEditor): Boolean;
    function GetMachines:String;
  public
    { Public declarations }
  end;

var
  WorkerStationForm: TWorkerStationForm;

implementation

uses ServerDllPub, uGlobal, frmMain, uShowMessage, uLogin, uGridDecorator,
  uAppOption,uDictionary;

{$R *.dfm}

procedure TWorkerStationForm.AddDataToCurWorkerList;
var Worker:string;
begin
  //��ⰲ����Ա����
//  if vleCurWorker.RowCount > Max_WorkerCount_Per_Machine then
//  begin
//    TMsgDialog.ShowMsgDialog('ÿ̨������ల�� 5 ���ˣ������೤���ƻ��೤�� 3 �������� (�³�Ԥ�����ɰ��� 4 ��)', mtWarning);
//    Exit;
//  end;

  //��ӵ�������Ա��//��������ڵ�ǰѡ����Ա�������
  Worker := LeftStr(lstWorker.Items[lstWorker.ItemIndex],7)+'('+MidStr(lstWorker.Items[lstWorker.ItemIndex],10,Length(lstWorker.Items[lstWorker.ItemIndex])-9)+')';
  if vleCurWorker.Strings.IndexOf(Worker) = -1 then
    vleCurWorker.Strings.Add(Worker + '=' + cbbOperateType.Text);
  cbbOperateType.ItemIndex := vleCurWorker.RowCount - 1;
  //����BUTTON��״̬
//  btnRight.Enabled := (vleCurWorker.RowCount <= Max_WorkerCount_Per_Machine);
end;

procedure TWorkerStationForm.FilterData(Index: Integer; ItemIndex: Integer);
var FilterStr: string;
  str: string;
begin
  if ItemIndex < 0 then exit;
  FilterStr := '';
  case Index of
    0: begin
        //str:=lstMachine.Items[ItemIndex];
        str:=chklstMachine.Items[ItemIndex];
        str := LeftStr(str, Pos('->', str) - 1);
        FilterStr := 'Operate_Type <> ''����'' AND Operate_Type <> ''�ƻ�''AND Current_Department = ' + QuotedStr(Login.CurrentDepartment);
        FilterStr := FilterStr + ' AND Machine_ID = ' + QuotedStr(str);
        TGlobal.FilterData(Dictionary.cds_WorkerStationList,FilterStr);
        TGlobal.FillItemsFromDataSet(Dictionary.cds_WorkerStationList, 'Worker_ID', 'Operate_Type', '=', vleCurWorker.Strings);

        Dictionary.cds_WorkerStationList.Filtered := False;

        //2008-9-24 cuijf ����
        if Pos('#',str)>0 then
          FilterWorker(LeftStr(str,2))
        else
          FilterWorker(str);

        if edtQualityMonitor.Text = '' then
          if Dictionary.cds_WorkerStationList.Locate('Machine_ID;Current_Department;Operate_Type', VarArrayOf([str, Login.CurrentDepartment, '����']), []) then
            edtQualityMonitor.Text := Dictionary.cds_WorkerStationList.FieldByName('Worker_ID').AsString;
        if edtPlanMonitor.Text ='' then
          if Dictionary.cds_WorkerStationList.Locate('Machine_ID;Current_Department;Operate_Type', VarArrayOf([str, Login.CurrentDepartment, '�ƻ�']), []) then
            edtPlanMonitor.Text := Dictionary.cds_WorkerStationList.FieldByName('Worker_ID').AsString;
        cbbOperateType.ItemIndex := 0;
       end;
    1: begin
        FilterStr := 'Department = ' + QuotedStr(Login.CurrentDepartment);
        if ItemIndex > 0 then
        begin
          str := cbbWorkerGroup.Items[ItemIndex];//Trim(LeftStr(cbbWorkerGroup.Items[ItemIndex], pos('->', cbbWorkerGroup.Items[ItemIndex]) - 1));
          FilterStr := FilterStr + ' AND Worker_Group = ' + QuotedStr(str);
        end;
        TGlobal.FilterData(Dictionary.cds_WorkerList,FilterStr);
        TGlobal.FillItemsFromDataSet(Dictionary.cds_WorkerList, 'Worker_ID', 'Worker_Name', '->', lstWorker.Items);
       end;
  else ;
  end;
  cbbOperateType.ItemIndex := 0;
end;

procedure TWorkerStationForm.Initialize;
begin
//  Max_WorkerCount_Per_Machine := 3;
  GetData();
end;

procedure TWorkerStationForm.GetData();
var
  FilterStr: string;
begin
  //Machine
  FilterStr := 'Department =' + QuotedStr(Login.CurrentDepartment);
  TGlobal.FilterData(Dictionary.cds_FinishMachineList,FilterStr);
  //TGlobal.FillItemsFromDataSet(Dictionary.cds_FinishMachineList, 'Machine_ID', 'Machine_Model_CHN', '->', lstMachine.Items);
  TGlobal.FillItemsFromDataSet(Dictionary.cds_FinishMachineList, 'Machine_ID', 'Machine_Model_CHN', '->', chklstMachine.Items);
  with Dictionary.cds_OperationHdrList do
  begin
    Filtered := False;
    Filter := 'Operation_Type =''Hand_Dip''';
    Filtered := True;
    First;
    while not Eof do
    begin
      //lstMachine.Items.add(FieldByName('Operation_Code').AsString+'->'+FieldByName('Operation_CHN').AsString);
      chklstMachine.Items.add(FieldByName('Operation_Code').AsString+'->'+FieldByName('Operation_CHN').AsString);
      Next;
    end;
  end;
  //lstMachine.Items.Add(Login.CurrentDepartment+'G1->һ����ֲ�');
  //lstMachine.Items.Add(Login.CurrentDepartment+'G3->������ֲ�');
  chklstMachine.Items.Add(Login.CurrentDepartment+'G1->һ����ֲ�');
  chklstMachine.Items.Add(Login.CurrentDepartment+'G3->������ֲ�');
  //���Ϸ�
  with Dictionary.cds_VatList do
  try
    Filter := Format('Vat_Studio LIKE ''%s''', [Login.CurrentDepartment + '%']);
    Filtered := True;
    while not Eof do
    begin
      //if lstMachine.Items.IndexOf(FieldByName('Vat_Studio').AsString + '->' + '���Ϸ�') = -1 then
      //  lstMachine.Items.add(FieldByName('Vat_Studio').AsString + '->' + '���Ϸ�');
      if chklstMachine.Items.IndexOf(FieldByName('Vat_Studio').AsString + '->' + '���Ϸ�') = -1 then
        chklstMachine.Items.add(FieldByName('Vat_Studio').AsString + '->' + '���Ϸ�');
      Next;
    end;
  finally
    Filtered := False;
  end;

  //WorkerGroup
  FilterStr := 'Department =' + QuotedStr(Login.CurrentDepartment);
  TGlobal.FilterData(Dictionary.cds_WorkerGroupList,FilterStr);
  TGlobal.FillItemsFromDataSet(Dictionary.cds_WorkerGroupList, 'Worker_Group', '', '->', cbbWorkerGroup.Items);
  cbbWorkerGroup.Items.Insert(0, 'ȫ��');
  cbbWorkerGroup.ItemIndex := 0;
  //Worker
  FilterStr := 'Department =' + QuotedStr(Login.CurrentDepartment);
  TGlobal.FilterData(Dictionary.cds_WorkerList,FilterStr);
  TGlobal.FillItemsFromDataSet(Dictionary.cds_WorkerList, 'Worker_ID', 'Worker_Name', '->', lstWorker.Items);
  //OperateType
  TGlobal.FillItemsFromString('����,����,�䲼', ',', 3, cbbOperateType.Items);
  cbbOperateType.ItemIndex := 0;
  Dictionary.cds_WorkerStationList.Close;
  ds1.DataSet := Dictionary.cds_WorkerStationList;

  GetWorkerShift;
end;

procedure TWorkerStationForm.SaveWorkerStationInfo;
var sWorkerList, sMachine_ID: WideString;
   sCondition,sErrorMsg: WideString;
begin
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('���ڱ��������Եȣ�', crHourGlass);
    {
    if lstMachine.ItemIndex = -1 then
    begin
      TMsgDialog.ShowMsgDialog('����ѡ���̨', 2);
      Exit;
    end;
    }
    if chklstMachine.ItemIndex = -1 then
    begin
      TMsgDialog.ShowMsgDialog('����ѡ���̨', 2);
      Exit;
    end;

    sMachine_ID := GetMachines;
    if sMachine_ID= '' then
      sMachine_ID :=  LeftStr(chklstMachine.Items[chklstMachine.ItemIndex],Pos('->',chklstMachine.Items[chklstMachine.ItemIndex])-1);
      //sMachine_ID :=  LeftStr(lstMachine.Items[lstMachine.ItemIndex],Pos('->',lstMachine.Items[lstMachine.ItemIndex])-1);

    //�������
    if not CheckData(sWorkerList, vleCurWorker) then
    begin
      TMsgDialog.ShowMsgDialog('�����������������,һ̨������ల��5����,������೤', 2);
      Exit;
    end;
    sCondition :=  QuotedStr(sWorkerList)+','+ QuotedStr(sMachine_ID)+','+QuotedStr(Login.CurrentDepartment)+','+QuotedStr(Login.LoginName);
    FNMServerObj.SaveDataBySQL('SaveWorkStation',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TMsgDialog.ShowMsgDialog('�������ݳɹ�', mtInformation);
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('', crDefault);
  end;
end;

function TWorkerStationForm.CheckData(var WorkerList: WideString; vle: TValueListEditor): Boolean;
var i: Integer;
begin
  Result := True;
  if Trim(edtQualityMonitor.Text) = '' then
  begin
    Result := False;
    Exit;
  end;
//  if vle.RowCount - 1 > Max_WorkerCount_Per_Machine then
//  begin
//    Result := False;
//    Exit;
//  end;
//  if vle.RowCount - 1 = Max_WorkerCount_Per_Machine then
//  begin
//    if (vle.Strings[0] = vle.Strings[1]) or
//      (vle.Strings[0] = vle.Strings[2]) or
////      (vle.Strings[0] <> vle.Strings[3]) and
//      (vle.Strings[1] = vle.Strings[2]) then
////      (vle.Strings[1] <> vle.Strings[3]) and
////      (vle.Strings[2] <> vle.Strings[3])
//    begin
//      Result := False;
//      Exit;
//    end;
//  end;
  WorkerList := '';
  if vleCurWorker.Strings.Text <> '' then
    for i := 0 to vle.RowCount - 2 do //delete the first caption row
      WorkerList := WorkerList + LeftStr(vle.Strings[i], 7) + RightStr(vle.Strings[i], 4) + ',';
  if Trim(edtQualityMonitor.Text)<>'' then
    WorkerList := WorkerList+ LeftStr(edtQualityMonitor.Text, 7) + '����' + ',';
  if Trim(edtPlanMonitor.Text)<>'' then
  WorkerList := WorkerList+ LeftStr(edtPlanMonitor.Text, 7) + '�ƻ�' + ',';
 // Delete(WorkerList, Length(WorkerList), 1);
end;

procedure TWorkerStationForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TWorkerStationForm.FormDestroy(Sender: TObject);
begin
  inherited;
  WorkerStationForm := nil;
end;

procedure TWorkerStationForm.btnRefreshClick(Sender: TObject);
begin
  GetData;
end;

procedure TWorkerStationForm.btnSaveClick(Sender: TObject);
begin
  SaveWorkerStationInfo;
end;

procedure TWorkerStationForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TWorkerStationForm.lstMachineClick(Sender: TObject);
begin
//  Max_WorkerCount_Per_Machine := 3;
//  //�³�Ԥ�����ɰ��� 4 ��
//  if (LeftStr(lstMachine.Items[lstMachine.ItemIndex],2)='CP') and ('FA'= Login.CurrentDepartment) then
//    Max_WorkerCount_Per_Machine := 4;

  FilterData(0, lstMachine.ItemIndex);
end;

procedure TWorkerStationForm.cbbWorkerGroupChange(Sender: TObject);
begin
  FilterData(1, cbbWorkerGroup.ItemIndex);
end;

procedure TWorkerStationForm.lstWorkerDblClick(Sender: TObject);
begin
  AddDataToCurWorkerList;
end;

procedure TWorkerStationForm.btnRightClick(Sender: TObject);
begin
  AddDataToCurWorkerList;
end;

procedure TWorkerStationForm.btnClearClick(Sender: TObject);
begin
  if vleCurWorker.Strings.Text <> '' then
    vleCurWorker.Strings.Clear;
end;

procedure TWorkerStationForm.vleCurWorkerGetPickList(Sender: TObject;
  const KeyName: string; Values: TStrings);
begin
  TGlobal.FillItemsFromString('����,����,�䲼', ',', 3, Values);
end;

procedure TWorkerStationForm.vleCurWorkerDblClick(Sender: TObject);
begin
  if vleCurWorker.Strings.Text <> '' then
    vleCurWorker.DeleteRow(vleCurWorker.Row);
//  btnRight.Enabled := (vleCurWorker.RowCount <= Max_WorkerCount_Per_Machine);
end;

procedure TWorkerStationForm.btnQualityMonitorClick(Sender: TObject);
begin
  edtQualityMonitor.Text := LeftStr(lstWorker.Items[lstWorker.ItemIndex],7)+'('+MidStr(lstWorker.Items[lstWorker.ItemIndex],10,Length(lstWorker.Items[lstWorker.ItemIndex])-9)+')';
end;

procedure TWorkerStationForm.btnPlanMonitorClick(Sender: TObject);
begin
  edtPlanMonitor.Text := LeftStr(lstWorker.Items[lstWorker.ItemIndex],7)+'('+MidStr(lstWorker.Items[lstWorker.ItemIndex],10,Length(lstWorker.Items[lstWorker.ItemIndex])-9)+')';
end;

procedure TWorkerStationForm.FormActivate(Sender: TObject);
begin
  OnActivate:=nil;
  Application.ProcessMessages;

  Initialize;
end;

procedure TWorkerStationForm.GetWorkerShift;
var
  vData: OleVariant;
  sSQL, sErrMsg: WideString;
begin
  //ȡ���Ѿ��źõİ�
  sSQL := QuotedStr('fnGetWorkerShift')+','+ QuotedStr(Login.CurrentDepartment);
  FNMServerObj.GetQueryData(vData, 'CommonSQL', sSQL, sErrMsg);
  if sErrMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;

  cdsPlan.Data := vData;
end;

procedure TWorkerStationForm.FilterWorker(sMachine:String);
begin
  //������Ա
  with cdsPlan do
  begin
    if not Active then Exit;
    if IsEmpty then Exit;
    Filter := 'Machine_Model = '+ QuotedStr(sMachine);
    Filtered := False;
    Filtered := True;
    if cdsPlan.RecordCount>0 then
    begin
      TGlobal.FillItemsFromDataSet(cdsPlan, 'Worker_ID', 'Worker_Name', '->', lstWorker.Items);
    end
    else
    begin
      if lstWorker.Items.Count<10 then
      begin
        FilterData(1, cbbWorkerGroup.ItemIndex);
      end
    end;
    
    Filtered := False;
  end;
  

end;

procedure TWorkerStationForm.chklstMachineClick(Sender: TObject);
begin
  FilterData(0, chklstMachine.ItemIndex);
end;

procedure TWorkerStationForm.btnSelectClick(Sender: TObject);
var
  i:Integer;
begin
  if chklstMachine.Items.Count<1 then
    Exit;
  for i:=0 to chklstMachine.Items.Count-1 do
  begin
    if chklstMachine.Checked[i] then
    begin
      chklstMachine.Checked[i] := False;
    end;
  end;
end;

function TWorkerStationForm.GetMachines: String;
var
  i:integer;
  str:String;
begin
  for i:=0 to chklstMachine.Items.Count-1 do
  begin
    if chklstMachine.Checked[i] then
    begin
      str:= str+LeftStr(chklstMachine.Items[i],Pos('->',chklstMachine.Items[i])-1)+',';
    end;
  end;
  Result := str;
end;

end.


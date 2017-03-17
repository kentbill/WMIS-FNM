unit frmMachineEfficiency;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, ADODB, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, TeeProcs, TeEngine,
  Chart, DbChart, ComCtrls, Series, DBClient;

type
  TMachineEfficiencyForm = class(TForm)
    pnl_Only: TPanel;
    cmb_MachineList: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    cmb_ParamterList: TComboBox;
    cmb_BeginTime: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    cmb_EndTime: TComboBox;
    btn_ParamterLog: TButton;
    btn_MachineEfficiency: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    DBChart1: TDBChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    cds_ParamterList: TClientDataSet;
    cds_ParamterLog: TClientDataSet;
    DataSource1: TDataSource;
    procedure FormActivate(Sender: TObject);
    procedure cmb_MachineListChange(Sender: TObject);
    procedure cmb_ParamterListDropDown(Sender: TObject);
    procedure btn_ParamterLogClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_MachineEfficiencyClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MachineEfficiencyForm: TMachineEfficiencyForm;

implementation

uses
  StrUtils, DateUtils, uFNMArtInfo, UGridDecorator, ServerDllPub, uFNMResource;

{$R *.dfm}

procedure TMachineEfficiencyForm.FormActivate(Sender: TObject);
begin
  OnActivate := nil;
  Application.ProcessMessages;
  cmb_BeginTime.Text := DateToStr(Now - 1) + ' 07:00:00';
  cmb_EndTime.Text := DateToStr(Now) + ' 07:00:00';
end;

procedure TMachineEfficiencyForm.cmb_MachineListChange(Sender: TObject);
begin
  cmb_ParamterList.Items.Clear;
end;

procedure TMachineEfficiencyForm.cmb_ParamterListDropDown(Sender: TObject);
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  if not cds_ParamterList.Active then
  begin
    ThirdFacadeObj.GetMONMachineParamterList(vData, sErrorMsg);
    if sErrorMsg <> '' then
      raise ExceptionEx.CreateResFmt(@ERR_GetMONMachinePar, [sErrorMsg]);
    cds_ParamterList.Data := vData;
  end;
  cds_ParamterList.Filtered := False;
  cds_ParamterList.Filter := Format('Machine = ''%s''', [LeftStr(cmb_MachineList.Text, 4)]);
  cds_ParamterList.Filtered := True;

  FillItemsFromDataSet(cds_ParamterList, 'Name', '', '', '', cmb_ParamterList.Items);
end;

procedure TMachineEfficiencyForm.btn_ParamterLogClick(Sender: TObject);
{var
  vData: OleVariant;
  sErrorMsg: WideString;}
begin
{  if cmb_MachineList.Text  = '' then
    raise Exception.Create('请选择机台');
  if cmb_BeginTime.Text  = '' then
    raise Exception.Create('请输入开始时间');
  if cmb_EndTime.Text  = '' then
    raise Exception.Create('请输入结束时间');
  if cmb_ParamterList.Text  = '' then
    raise Exception.Create('请请选择参数');

  ThirdFacadeObj.GetMONMachineParamterList(LeftStr(cmb_MachineList.Text, 4), cmb_BeginTime.Text, cmb_EndTime.Text, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetMONMachineParLog, [sErrorMsg]);
  cds_ParamterLog.Data:=vData;

  ADOQry_List.Filtered:=false;
  if not ADOQry_List.Locate('Machine;Name', VarArrayOf([cmb_MachineList.Text, cmb_ParamterList.Text]), []) then
    Exit;

  GridDecorator.BindCxViewWithDataSource(cxGrid1DBTableView1, DataSource1, True);
}end;

procedure TMachineEfficiencyForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TMachineEfficiencyForm.FormDestroy(Sender: TObject);
begin
  MachineEfficiencyForm := nil;
end;

procedure TMachineEfficiencyForm.btn_MachineEfficiencyClick(Sender: TObject);
var
  vData: OleVariant;
  sErrorMsg: WideString;
  LastTime, CurrentTime: TDateTime;
  EfficiencySeconds, LastMeterCounter, CurrentMeterCounter, MeterCounter: Integer;
begin
  if cmb_MachineList.Text  = '' then
    raise Exception.Create('请选择机台');
  if cmb_BeginTime.Text  = '' then
    raise Exception.Create('请输入开始时间');
  if cmb_EndTime.Text  = '' then
    raise Exception.Create('请输入结束时间');

  ThirdFacadeObj.GetMONMachineEfficiency(LeftStr(cmb_MachineList.Text, 4), cmb_BeginTime.Text, cmb_EndTime.Text, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetMONMachineParLog, [sErrorMsg]);

  cds_ParamterLog.Data:=vData;
  EfficiencySeconds:=0;
  MeterCounter:=0;

  try
    cds_ParamterLog.DisableControls;
    cds_ParamterLog.First;
    LastTime:=cds_ParamterLog.FieldByName('LogTimeStamp').AsDateTime;
    LastMeterCounter:=cds_ParamterLog.FieldByName('MeterCounter').AsInteger;
    cds_ParamterLog.Edit;
    cds_ParamterLog.FieldByName('MeterCounter').AsInteger:=MeterCounter;
    while not cds_ParamterLog.Eof do
    begin
      cds_ParamterLog.Next;

      CurrentTime:=cds_ParamterLog.FieldByName('LogTimeStamp').AsDateTime;
      CurrentMeterCounter:=cds_ParamterLog.FieldByName('MeterCounter').AsInteger;

      if (cds_ParamterLog['Act_machine_speed'] <> 0) and (CurrentMeterCounter <> LastMeterCounter) then
      begin
        if CurrentMeterCounter > LastMeterCounter then
          MeterCounter:=MeterCounter + (CurrentMeterCounter - LastMeterCounter);

        if CurrentMeterCounter < LastMeterCounter then
          MeterCounter:=MeterCounter + CurrentMeterCounter;

        EfficiencySeconds:=EfficiencySeconds + SecondsBetween(CurrentTime, LastTime);
      end;
      LastTime:=CurrentTime;
      LastMeterCounter:=CurrentMeterCounter;
      cds_ParamterLog.Edit;
      cds_ParamterLog.FieldByName('MeterCounter').AsInteger:=MeterCounter;
    end;

    Caption := FloatToStr(EfficiencySeconds / SecondsBetween(StrToDateTime(cmb_BeginTime.Text), StrToDateTime(cmb_EndTime.Text)))
  finally
    cds_ParamterLog.EnableControls;
  end;
  cds_ParamterLog.First;

  Series1.DataSource:=cds_ParamterLog;
  Series1.XLabelsSource:='LogTimeStamp';
  Series1.YValues.ValueSource:='Act_machine_speed';
  Series1.Title:='Act_machine_speed';
  Series1.Active:=True;

  Series2.DataSource:=cds_ParamterLog;
  Series2.XLabelsSource:='LogTimeStamp';
  Series2.YValues.ValueSource:='MeterCounter';
  Series2.Title:='MeterCounter';
  Series2.Active:=True;

  GridDecorator.BindCxViewWithDataSource(cxGrid1DBTableView1, DataSource1, True);
end;

end.

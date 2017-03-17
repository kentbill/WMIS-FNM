unit frmEnergyQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, OleCtrls, VCFI, ExtCtrls, TeeProcs, TeEngine, Chart,
  DbChart, Series, StdCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Buttons, DBClient, CheckLst;

type
  TEnergyQueryForm = class(TForm)
    GroupBox1: TGroupBox;
    tbcStatistic: TTabControl;
    tdcStatistic: TDBChart;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    btnHourReport: TBitBtn;
    btnClassReport: TBitBtn;
    btnDayReport: TBitBtn;
    btnWeekReport: TBitBtn;
    btnMonthReport: TBitBtn;
    btnWorngReport: TBitBtn;
    dsStatistic: TDataSource;
    cdsStatistic: TClientDataSet;
    cxgrid_Statistic: TcxGrid;
    cxgridtv_Statistic: TcxGridDBTableView;
    cxGridl_Statistic: TcxGridLevel;
    Label1: TLabel;
    Label2: TLabel;
    Series1: TLineSeries;
    Label3: TLabel;
    Label4: TLabel;
    edtBegin: TEdit;
    edtEnd: TEdit;
    cbCustom: TCheckBox;
    Series2: TBarSeries;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LoadControl();
    procedure tbcStatisticChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnHourReportClick(Sender: TObject);
    procedure btnClassReportClick(Sender: TObject);
    procedure btnDayReportClick(Sender: TObject);
    procedure btnWeekReportClick(Sender: TObject);
    procedure btnMonthReportClick(Sender: TObject);
    procedure btnWorngReportClick(Sender: TObject);
  private
    { Private declarations }
    procedure QueryData(vType:Integer);
    procedure FillChart();
    procedure SetSeriesType(var dbchart:TDBChart);
    procedure FillControl(vCds:TClientDataSet);
    procedure ClearControl();
    procedure check_click(Sender: TObject);
 
  public
    { Public declarations }
    iType:Integer;
  end;

var
  EnergyQueryForm: TEnergyQueryForm;

implementation

uses
    StrUtils, Math, frmMachineSample, uAppOption, uGlobal, uShowMessage, 
     ServerDllPub, uCADInfo, uDictionary, uLogin, uGridDecorator;

{$R *.dfm}

procedure TEnergyQueryForm.FormDestroy(Sender: TObject);
begin
  EnergyQueryForm := nil;
end;

procedure TEnergyQueryForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TEnergyQueryForm.LoadControl();
begin
  if tbcStatistic.TabIndex = 0 then
  begin
    tdcStatistic.Visible := False;
    cxgrid_Statistic.Visible := True;
    cxgrid_Statistic.Align := alClient;
  end
  else
  begin
    cxgrid_Statistic.Visible := False;
    tdcStatistic.Visible := True;
    tdcStatistic.Align := alClient;
    //FillChart;
  end;

end;

procedure TEnergyQueryForm.tbcStatisticChange(Sender: TObject);
begin
  LoadControl;
  //SetSeriesType(tdcStatistic);
  if cdsStatistic.FieldCount > 0 then
  begin
    ClearControl;
    FillControl(cdsStatistic);
  end;
  FillChart;
end;

procedure TEnergyQueryForm.FormCreate(Sender: TObject);
begin
  LoadControl;
end;

procedure TEnergyQueryForm.QueryData(vType:Integer);
var
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin

  tdcStatistic.SeriesList.Clear;
  ClearControl;
  iType := vType;
  cdsStatistic.Fields.Clear;
  cxgridtv_Statistic.ClearItems;

  //if iType = 0 then
  if cbCustom.Checked then
    sCondition := QuotedStr(edtBegin.Text) + ',' + QuotedStr(edtEnd.Text) + ',' + '1' + ',' + IntToStr(iType)
  else
    sCondition := QuotedStr('') + ',' + QuotedStr('') + ',' + '1' + ',' + IntToStr(iType);
//  if iType = 1 then
//    sCondition := QuotedStr('') + ',' + QuotedStr('') + ',' + '1' + ',' + IntToStr(iType);


  FNMServerObj.GetQueryData(vData,'GetEnergyReportInfo',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog('查询出错。',mtError);
    Exit;
  end;
  cdsStatistic.Data := vData;
  GridDecorator.BindCxViewWithDataSource(cxgridtv_Statistic,dsStatistic);
  FillControl(cdsStatistic);
  FillChart;
  ClearControl;
end;

procedure TEnergyQueryForm.FillChart();
var
  i,j: Integer;
  b:Boolean;
  LineSeriesTemp:TLineSeries;
  BarSeriesTemp:TBarSeries;
begin

  if cdsStatistic.Data = null then
     Exit;

  tdcStatistic.SeriesList.Clear;
  j := GroupBox3.ControlCount -1;
  for i:=0 to j do
  begin
     if GroupBox3.Controls[i].ClassName = 'TCheckBox' then
     begin
        if TCheckBox(GroupBox3.Controls[i]).Checked then
        begin
          if tbcStatistic.TabIndex = 1 then
          begin
            LineSeriesTemp := TLineSeries.Create(self);
            LineSeriesTemp.Title := TCheckBox(GroupBox3.Controls[i]).Caption;
            tdcStatistic.AddSeries(LineSeriesTemp);
            LineSeriesTemp.DataSource := cdsStatistic;
            if iType <> 5 then
              LineSeriesTemp.XLabelsSource := 'span'
            else
              LineSeriesTemp.XLabelsSource := '故障信息';

            LineSeriesTemp.YValues.ValueSource := TCheckBox(GroupBox3.Controls[i]).Caption;
          end;
          if tbcStatistic.TabIndex = 2 then
          begin
            BarSeriesTemp := TBarSeries.Create(self);
            BarSeriesTemp.Title := TCheckBox(GroupBox3.Controls[i]).Caption;
            BarSeriesTemp.Marks.Style := smsValue;
            tdcStatistic.AddSeries(BarSeriesTemp);
            BarSeriesTemp.DataSource := cdsStatistic;
            if iType <> 5 then
              BarSeriesTemp.XLabelsSource := 'span'
            else
              BarSeriesTemp.XLabelsSource := '故障信息';
            BarSeriesTemp.YValues.ValueSource := TCheckBox(GroupBox3.Controls[i]).Caption;
          end;
        end;
     end;
  end;
  //showmessage(IntToStr(tdcStatistic.SeriesList.Count));
  //SetSeriesType(tdcStatistic);
end;

procedure TEnergyQueryForm.SetSeriesType(var dbchart:TDBChart);
var i: Integer;
begin
//  for i:= 0 to dbchart.SeriesCount-1 do
//    dbchart.Series[i].Active := tbcStatistic.TabIndex = i + 1;
 // dbchart.View3DOptions.Orthogonal := False;
end;

procedure TEnergyQueryForm.btnHourReportClick(Sender: TObject);
begin
  QueryData(0);
end;

procedure TEnergyQueryForm.FillControl(vCds:TClientDataSet);
var
  i:Integer;
  b:Boolean;
begin
  b:= True;
  if tbcStatistic.TabIndex <> 0 then
  begin
    for i:=0 to vCds.Fields.Count -1 do
    begin
      with TCheckBox.Create(self) do
      begin
        if (vCds.Fields[i].FullName <> '开始时间') and
           (vCds.Fields[i].FullName <> '结束时间') and
           (vCds.Fields[i].FullName <> '故障信息') and
           (vCds.Fields[i].FullName <> 'span')
            then
        begin
          if b then
          begin
            Checked := True;
            b:= False;
          end
          else
          begin
            Checked := False;
          end;

          Parent :=GroupBox3;
          Caption := vCds.Fields[i].FullName;
          Left:=10;
          Top:=i*40;
          OnClick := check_click;
        end;
      end;
    end;
  end;
end;

procedure TEnergyQueryForm.check_click(Sender: TObject);
begin
  FillChart;
end;

procedure TEnergyQueryForm.ClearControl();
var
  i,j:Integer;
begin
  j:= GroupBox3.ControlCount -1;
  for i:=0 to j do
  begin
    if GroupBox3.ControlCount >= 2 then
    begin
      if GroupBox3.Controls[1].ClassName = 'TCheckBox' then
        GroupBox3.Controls[1].Free;
    end;
  end;
end;

procedure TEnergyQueryForm.btnClassReportClick(Sender: TObject);
begin
  QueryData(1);
end;

procedure TEnergyQueryForm.btnDayReportClick(Sender: TObject);
begin
  QueryData(2);
end;

procedure TEnergyQueryForm.btnWeekReportClick(Sender: TObject);
begin
  QueryData(3);
end;

procedure TEnergyQueryForm.btnMonthReportClick(Sender: TObject);
begin
  QueryData(4);
end;

procedure TEnergyQueryForm.btnWorngReportClick(Sender: TObject);
begin
  QueryData(5);
end;

end.

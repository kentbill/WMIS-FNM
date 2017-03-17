unit frmPlanAnalysis;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, OleCtrls, VCFI, ExtCtrls, TeeProcs, TeEngine, Chart,
  DbChart, Series, StdCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Buttons, DBClient, CheckLst;

type
  TPlanAnalysisForm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    Button1: TButton;
    tdcFA1: TDBChart;
    Series1: TBarSeries;
    Series2: TBarSeries;
    Series3: TBarSeries;
    Series4: TBarSeries;
    Series5: TBarSeries;
    Series6: TBarSeries;
    Series7: TBarSeries;
    Series8: TBarSeries;
    tdcFA2: TDBChart;
    BarSeries1: TBarSeries;
    BarSeries2: TBarSeries;
    BarSeries3: TBarSeries;
    BarSeries4: TBarSeries;
    BarSeries5: TBarSeries;
    BarSeries6: TBarSeries;
    BarSeries7: TBarSeries;
    BarSeries8: TBarSeries;
    tdcFG1: TDBChart;
    BarSeries9: TBarSeries;
    BarSeries10: TBarSeries;
    BarSeries11: TBarSeries;
    BarSeries12: TBarSeries;
    BarSeries13: TBarSeries;
    BarSeries14: TBarSeries;
    BarSeries15: TBarSeries;
    BarSeries16: TBarSeries;
    tdcFG2: TDBChart;
    BarSeries17: TBarSeries;
    BarSeries18: TBarSeries;
    BarSeries19: TBarSeries;
    BarSeries20: TBarSeries;
    BarSeries21: TBarSeries;
    BarSeries22: TBarSeries;
    BarSeries23: TBarSeries;
    BarSeries24: TBarSeries;
    GroupBox8: TGroupBox;
    tdcSpecial: TDBChart;
    BarSeries25: TBarSeries;
    BarSeries26: TBarSeries;
    BarSeries27: TBarSeries;
    BarSeries28: TBarSeries;
    GroupBox9: TGroupBox;
    tdcSpecialFG: TDBChart;
    BarSeries33: TBarSeries;
    BarSeries34: TBarSeries;
    BarSeries35: TBarSeries;
    BarSeries36: TBarSeries;
    procedure Button1Click(Sender: TObject);
    procedure RefreshData();
    procedure FillChart(index:Integer;vDBchart:TDBChart;tmpSeries:TBarSeries;cdsTemp:TClientDataSet);
    procedure FillChartSpecial(index:Integer;vDBchart:TDBChart;tmpSeries:TBarSeries;cdsTemp:TClientDataSet);
    procedure tdcFA1DblClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tdcFA1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PlanAnalysisForm: TPlanAnalysisForm;

implementation

uses
    StrUtils, Math, frmMachineSample, uAppOption, uGlobal, uShowMessage, 
     ServerDllPub, uCADInfo, uDictionary, uLogin, uGridDecorator;

{$R *.dfm}

procedure TPlanAnalysisForm.Button1Click(Sender: TObject);
begin
  RefreshData();
end;
procedure TPlanAnalysisForm.RefreshData();
var
 vData: OleVariant;
  sCondition,sErrorMsg: WideString;
  i,j:Integer;
  BarSeriesTemp:array of TBarSeries;
  BarSeriesSpecial:array of TBarSeries;
  BarSeriesAfter:array of TBarSeries;
  BarSeriesTempFG:array of TBarSeries;
  BarSeriesAfterFG:array of TBarSeries;
  BarSeriesSpecialFG:array of TBarSeries;

  cdsTemp:array of TClientDataSet;
  cdsSpical:array of TClientDataSet;
  cdsAfter:array of TClientDataSet;
  cdsTempFG:array of TClientDataSet;
  cdsSpicalFG:array of TClientDataSet;
  cdsAfterFG:array of TClientDataSet;
begin
  tdcFA1.SeriesList.Clear;
  tdcSpecial.SeriesList.Clear;
  tdcFA2.SeriesList.Clear;
  tdcFG1.SeriesList.Clear;
  tdcSpecialFG.SeriesList.Clear;
  tdcFG2.SeriesList.Clear;

  SetLength(BarSeriesTemp,8);
  SetLength(BarSeriesSpecial,4);
  SetLength(BarSeriesAfter,8);
  SetLength(BarSeriesTempFG,8);
  SetLength(BarSeriesSpecialFG,4);
  SetLength(BarSeriesAfterFG,8);

  SetLength(cdsTemp,8);
  SetLength(cdsSpical,4);
  SetLength(cdsAfter,8);
  SetLength(cdsTempFG,8);
  SetLength(cdsSpicalFG,4);
  SetLength(cdsAfterFG,8);
  //  FA 普通色
  for i:=0 to 7 do
  begin
    sCondition := IntToStr(i+1) + ',' + QuotedStr('FA');
    FNMServerObj.GetQueryData(vData,'PlanStatisitc',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog('查询出错。',mtError);
      Exit;
    end;
    cdsTemp[i] := TClientDataSet.Create(nil);
    cdsTemp[i].Data := vData[0];

    cdsAfter[i] := TClientDataSet.Create(nil);
    cdsAfter[i].Data:= vData[1];

    BarSeriesTemp[i] := TBarSeries.Create(self);
    BarSeriesAfter[i] := TBarSeries.Create(self);

    FillChart(i,tdcFA1,BarSeriesTemp[i],cdsTemp[i]);
    FillChart(i,tdcFA2,BarSeriesAfter[i],cdsAfter[i]);
  end;

  //  FA 特殊色
  for i:=0 to 3 do
  begin
    sCondition := IntToStr(i+1) + ',' + QuotedStr('FA')+ ',1';
    FNMServerObj.GetQueryData(vData,'PlanStatisitc',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog('查询出错。',mtError);
      Exit;
    end;
    cdsSpical[i] := TClientDataSet.Create(nil);
    cdsSpical[i].Data := vData;
    BarSeriesSpecial[i] := TBarSeries.Create(self);
    FillChartSpecial(i,tdcSpecial,BarSeriesSpecial[i],cdsSpical[i]);
  end;

  //FG
  for i:=0 to 7 do
  begin
    sCondition := IntToStr(i+1) + ',' + QuotedStr('FG');
    FNMServerObj.GetQueryData(vData,'PlanStatisitc',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog('查询出错。',mtError);
      Exit;
    end;
    cdsTempFG[i] := TClientDataSet.Create(nil);
    cdsTempFG[i].Data := vData[0];

    cdsAfterFG[i] := TClientDataSet.Create(nil);
    cdsAfterFG[i].Data:= vData[1];

    BarSeriesTempFG[i] := TBarSeries.Create(self);
    BarSeriesAfterFG[i] := TBarSeries.Create(self);

    FillChart(i,tdcFG1,BarSeriesTempFG[i],cdsTempFG[i]);
    FillChart(i,tdcFG2,BarSeriesAfterFG[i],cdsAfterFG[i]);
  end;

  //  FG 特殊色
  for i:=0 to 3 do
  begin
    sCondition := IntToStr(i+1) + ',' + QuotedStr('FG')+ ',1';
    FNMServerObj.GetQueryData(vData,'PlanStatisitc',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog('查询出错。',mtError);
      Exit;
    end;
    cdsSpicalFG[i] := TClientDataSet.Create(nil);
    cdsSpicalFG[i].Data := vData;
    BarSeriesSpecialFG[i] := TBarSeries.Create(self);
    FillChartSpecial(i,tdcSpecialFG,BarSeriesSpecialFG[i],cdsSpicalFG[i]);
  end;

end;

procedure TPlanAnalysisForm.FillChart(index:Integer;vDBchart:TDBChart;tmpSeries:TBarSeries;cdsTemp:TClientDataSet);
begin
  tmpSeries := TBarSeries.Create(self);
  case index of
      0: tmpSeries.Title := '0-1000';
      1: tmpSeries.Title := '1001-10000';
      2: tmpSeries.Title := '10001-25000';
      3: tmpSeries.Title := '25001-40000';
      4: tmpSeries.Title := '40000-60001';
      5: tmpSeries.Title := '60001-80000';
      6: tmpSeries.Title := '80001-100000';
      7: tmpSeries.Title := '100000以上';
  end;
    tmpSeries.Marks.Style := smsValue;
    tmpSeries.Marks.Visible := False;
    vDBchart.AddSeries(tmpSeries);
    if cdsTemp.RecordCount > 0 then
      tmpSeries.DataSource := cdsTemp;
    tmpSeries.XLabelsSource := 'type';
    tmpSeries.YValues.ValueSource := 'counts';
    //TBarSeries(tmpSeries).MultiBar := mbStacked;
end;

procedure TPlanAnalysisForm.FillChartSpecial(index:Integer;vDBchart:TDBChart;tmpSeries:TBarSeries;cdsTemp:TClientDataSet);
begin
  tmpSeries := TBarSeries.Create(self);
  case index of
      0: tmpSeries.Title := 'TQ';
      1: tmpSeries.Title := 'OR';
      2: tmpSeries.Title := 'RD';
      3: tmpSeries.Title := 'GN';
  end;
    tmpSeries.Marks.Style := smsValue;
    tmpSeries.Marks.Visible := False;
    vDBchart.AddSeries(tmpSeries);
    if cdsTemp.RecordCount > 0 then
      tmpSeries.DataSource := cdsTemp;
    tmpSeries.XLabelsSource := 'type';
    tmpSeries.YValues.ValueSource := 'counts';
    //TBarSeries(tmpSeries).MultiBar := mbStacked;
end;

procedure TPlanAnalysisForm.tdcFA1DblClick(Sender: TObject);
begin
  GroupBox5.Visible :=False;
  GroupBox2.Visible := False;

  GroupBox4.Align := alClient;
  GroupBox1.Align := alClient;
end;

procedure TPlanAnalysisForm.FormMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ShowMessage('1212121');
end;

procedure TPlanAnalysisForm.tdcFA1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
//  GroupBox1.Visible := True;
//  GroupBox2.Visible := True;
//  //GroupBox3.Visible := True;
//  GroupBox4.Visible := True;
//  GroupBox5.Visible := True;
//  GroupBox6.Visible := True;
//  GroupBox7.Visible := True;
//
//  GroupBox1.Align := altop;
//  GroupBox1.Height := 321;
//  GroupBox2.Align := alClient;
//
//  GroupBox4.Width := 839;
//  GroupBox4.Align := alLeft;
//  GroupBox5.Align := alClient;
//  GroupBox6.Align := alLeft;
//  GroupBox7.Align := alClient;
  end;
end;

procedure TPlanAnalysisForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TPlanAnalysisForm.FormDestroy(Sender: TObject);
begin
  PlanAnalysisForm := nil;
end;

end.

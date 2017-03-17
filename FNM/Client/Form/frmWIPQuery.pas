unit frmWIPQuery;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmWIPQuery.pas                                               }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  WIP查看                                                      }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, DBClient, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxSplitter, TeeProcs, TeEngine, Chart,
  DbChart, ExtCtrls, StdCtrls, Series, Buttons;

type
  TWIPQueryForm = class(TBaseForm)
    pnlTop: TPanel;
    pnlBottom: TPanel;
    cxsplTop: TcxSplitter;
    pnlClient: TPanel;
    dbchtOperationCode: TDBChart;
    cxgridtvWIP: TcxGridDBTableView;
    cxGridlWIP: TcxGridLevel;
    cxgridWIP: TcxGrid;
    dsWIPDetail: TDataSource;
    cdsWIPDetail: TClientDataSet;
    cdsWIPOperationCode: TClientDataSet;
    btnClose: TBitBtn;
    btnRefresh: TBitBtn;
    rgSeriesType: TRadioGroup;
    btnExport: TBitBtn;
    dlgSaveDlg: TSaveDialog;
    chk3D: TCheckBox;
    Series4: TBarSeries;
    Series5: TPieSeries;
    Series6: TLineSeries;
    cbbCurrentDept: TComboBox;
    lbl1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure rgSeriesTypeClick(Sender: TObject);
    procedure chk3DClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cxgridtvWIPCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure GetWIPInfo();
    procedure GetData();
    procedure FillChart();
    procedure SetSeriesType(var dbchart:TDBChart);
  public
    { Public declarations }
  end;

var
  WIPQueryForm: TWIPQueryForm;

implementation

uses  ServerDllPub, uGlobal, uShowMessage, uGridDecorator, uAppOption, uLogin,
  frmMain,uDictionary;

{$R *.dfm}

procedure TWIPQueryForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TWIPQueryForm.FormDestroy(Sender: TObject);
begin
  inherited;
  WIPQueryForm := nil;
end;

procedure TWIPQueryForm.FillChart();
var i: Integer;
begin
  for i:=0 to dbchtOperationCode.SeriesCount-1 do
  begin
   dbchtOperationCode.Series[i].DataSource := cdsWIPOperationCode;
   dbchtOperationCode.Series[i].XLabelsSource := 'Operation_CHN';
  end;
  Series4.YValues.ValueSource := 'Quantity';
  Series5.YValues.ValueSource := 'Quantity';
  Series6.YValues.ValueSource := 'Quantity';
  SetSeriesType(dbchtOperationCode);
end;

procedure TWIPQueryForm.SetSeriesType(var dbchart:TDBChart);
var i: Integer;
begin
  for i:= 0 to dbchart.SeriesCount-1 do
    dbchart.Series[i].Active := rgSeriesType.ItemIndex =i ;
  dbchart.View3DOptions.Orthogonal := chk3D.Checked;
end;

procedure TWIPQueryForm.GetData();
begin
  Screen.Cursor :=  crHourGlass;
  GetWIPInfo();
  Screen.Cursor :=  crDefault
end;

procedure TWIPQueryForm.GetWIPInfo();
var vData: OleVariant;
    sCondition,sCurrentDepartment,sErrorMsg: WideString;
begin
  try
    ShowMsg('正在获取数据稍等！',crHourGlass);
    sCurrentDepartment := copy(cbbCurrentDept.Text,1,pos('->',cbbCurrentDept.Text)-1);
    sCondition := QuotedStr(sCurrentDepartment);
    FNMServerObj.GetQueryData(vData,'GetWIPInfo',sCondition,sErrorMsg);

    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsWIPDetail.Data := vData[0];
    cdsWIPOperationCode.Data := vData[1];
    FillChart();
    dbchtOperationCode.Title.Text.Clear;
    dbchtOperationCode.Title.Text.Add(sCurrentDepartment+'->工序WIP');
    GridDecorator.BindCxViewWithDataSource(cxgridtvWIP, dsWIPDetail);
  finally
    ShowMsg('',crDefault);
  end;
end;

procedure TWIPQueryForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  GetData();
end;

procedure TWIPQueryForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TWIPQueryForm.btnExportClick(Sender: TObject);
begin
  inherited;
  TGlobal.SaveDataToFile(cdsWIPDetail,sftXLS);
  if not dlgSaveDlg.Execute then Exit;
  dbchtOperationCode.SaveToBitmapFile(dlgSaveDlg.FileName);
end;

procedure TWIPQueryForm.rgSeriesTypeClick(Sender: TObject);
begin
  inherited;
  SetSeriesType(dbchtOperationCode);
end;

procedure TWIPQueryForm.chk3DClick(Sender: TObject);
begin
  inherited;
  SetSeriesType(dbchtOperationCode);
end;

procedure TWIPQueryForm.FormActivate(Sender: TObject);
begin
  inherited;
  OnActivate:=nil;
  Application.ProcessMessages;
  GetData();
end;

procedure TWIPQueryForm.cxgridtvWIPCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  Operation_CHN: string;
  PC_Req_Finish_Date: TDateTime;
begin
  inherited;
  if AViewInfo.Focused then Exit;

  with AViewInfo.GridRecord, TcxGridDBTableView(Sender) do
  if VarIsNull(Values[GetColumnByFieldName('PC_Req_Finish_Date').Index]) or
     varIsNull(Values[GetColumnByFieldName('Operation_CHN').Index]) then
    Exit;

  Operation_CHN := AViewInfo.GridRecord.Values[TcxGridDBTableView(Sender).GetColumnByFieldName('Operation_CHN').Index];
  PC_Req_Finish_Date := AViewInfo.GridRecord.Values[TcxGridDBTableView(Sender).GetColumnByFieldName('PC_Req_Finish_Date').Index];

  if (Pos('IN', Operation_CHN) = 0) and
     (Pos('IF', Operation_CHN) = 0) and
     (Pos('IX',Operation_CHN) = 0)  and
     (Pos('待送布', Operation_CHN) = 0) and
     (PC_Req_Finish_Date < Now()) then
    ACanvas.Font.Color := clBlue;
end;

procedure TWIPQueryForm.FormShow(Sender: TObject);
begin
  inherited;
  TGlobal.FillComboBoxFromDataSet(Dictionary.cds_DepartmentList,'Department','Description','->',cbbCurrentDept);
  cbbCurrentDept.Text := FNMMainForm.cbbCurrentDept.Text;
  GetData();
  cxsplTop.CloseSplitter;
end;

end.

unit frmFabricReport;
{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmFabricReport.pas                                            }
{       �������� 2004-8-26 13:50:57                                            }
{       ������Ա zhangjy                                                       }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{       ������Ҫ����/SQL����˵��                                               }
{       ��������  ����򿨼�¼                                                 }
{                                                                              }
{******************************************************************************}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, DBClient, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxSplitter, TeeProcs, TeEngine, Chart,
  DbChart, ExtCtrls, StdCtrls, Series, Buttons, ComCtrls;

type
  TFabricReportForm = class(TBaseForm)
    pnlBottom: TPanel;
    pnlClient: TPanel;
    cxgridtvFabricReport: TcxGridDBTableView;
    cxGridlFabricReport: TcxGridLevel;
    cxgridFabricReport: TcxGrid;
    dsFabricReport: TDataSource;
    cdsFabricReport: TClientDataSet;
    btnClose: TBitBtn;
    btnRefresh: TBitBtn;
    dtpBeginDate: TDateTimePicker;
    dtpBeginTime: TDateTimePicker;
    dtpEndDate: TDateTimePicker;
    dtpEndTime: TDateTimePicker;
    lblBeginTime: TLabel;
    lblEndTime: TLabel;
    lbl1: TLabel;
    cbbCurrentDept: TComboBox;
    cbbReportType: TComboBox;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cbbReportTypeChange(Sender: TObject);
  private
    { Private declarations }
    procedure Initialize();
    procedure GetFabricReportInfo();
    procedure GetData();
  public
    { Public declarations }
    procedure PublicQuery; override;
    procedure PublicExport; override;
  end;

var
  FabricReportForm: TFabricReportForm;

implementation

uses  ServerDllPub, uGlobal, UShowMessage, uGridDecorator, uAppOption, uLogin,
  frmMain,uDictionary;

{$R *.dfm}
procedure TFabricReportForm.PublicQuery;
begin
  GetData();
end;

procedure TFabricReportForm.PublicExport;
begin
  TGlobal.SaveDataToFile(cdsFabricReport, sftXLS);
end;

procedure TFabricReportForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFabricReportForm.FormDestroy(Sender: TObject);
begin
  inherited;
  FabricReportForm := nil;
end;

procedure TFabricReportForm.GetData();
begin
  GetFabricReportInfo();
end;

procedure TFabricReportForm.GetFabricReportInfo();
var vData: OleVariant;
    iType:Integer;
    sCondition,sCurrentDepartment,sBeginTime,sEndTime,sErrorMsg: WideString;

begin
  try
    ShowMsg('���ڻ�ȡ�����Եȣ�',crHourGlass);
    //��ȡ��/�±���ͳ����Ϣ
    iType := cbbReportType.ItemIndex;
    sBeginTime := DateTimeToStr(Trunc(dtpBeginDate.Date) + Frac(dtpBeginTime.Time));
    sEndTime := DateTimeToStr(Trunc(dtpEndDate.Date) + Frac(dtpEndTime.Time));
    sCurrentDepartment := copy(cbbCurrentDept.Text,1,pos('->',cbbCurrentDept.Text)-1);
    sCondition := QuotedStr(sBeginTime)+ ','+ QuotedStr(sEndTime)+','+ QuotedStr(sCurrentDepartment)+','+IntToStr(iType);
    FNMServerObj.GetQueryData(vData,'GetFabricReportInfo',sCondition,sErrorMsg);
//    FNMServerObj.GetFabricReportInfo(vData,sBeginTime,sEndTime,sCurrentDepartment,iType,sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsFabricReport.Data := vData;
    if cdsFabricReport.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('û����Ӧ������,�����²�ѯ',1);
      cdsFabricReport.EmptyDataSet;
      Exit;
    end;
    GridDecorator.BindCxViewWithDataSource(cxgridtvFabricReport, dsFabricReport,True);
    if cbbReportType.ItemIndex <> 3 then
      GridDecorator.AddFooter(cxgridtvFabricReport,['Quantity'],[skSum])
    else
      GridDecorator.AddFooter(cxgridtvFabricReport,['���մ�','���´�','������','������','���նԷ�����','���նԷ�����','�շ�FN�����','�·�FN�����','��FN�����',
        '��FN�����','���ͳ�Ʒ','���ͳ�Ʒ','���ͶԷ�����','���ͶԷ�����','�����ⷢ','�����ⷢ','��������','��������'],
        [skSum,skSum,skSum,skSum,skSum,skSum,skSum,skSum,skSum,skSum,skSum,skSum,skSum,skSum,skSum,skSum,skSum,skSum]);
  finally
    ShowMsg('',crDefault);
  end;
end;
procedure TFabricReportForm.Initialize();
begin
  dtpBeginDate.Date := Now()-1;
  dtpBeginTime.Time := StrToTime('07:00:00');
  dtpEndDate.Date := dtpBeginDate.Date+1;
  dtpEndTime.Time:= dtpBeginTime.Time;
  cbbReportType.ItemIndex := 0;
  TGlobal.FillComboBoxFromDataSet(Dictionary.cds_DepartmentList,'Department','Description','->',cbbCurrentDept);
  cbbCurrentDept.Text := FNMMainForm.cbbCurrentDept.Text;
end;

procedure TFabricReportForm.FormCreate(Sender: TObject);
begin
  inherited;
  Initialize();
end;

procedure TFabricReportForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  GetData();
end;

procedure TFabricReportForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFabricReportForm.cbbReportTypeChange(Sender: TObject);
begin
  inherited;
  dtpBeginDate.Visible := cbbReportType.ItemIndex <>1;
  dtpBeginTime.Visible := cbbReportType.ItemIndex <>1;
  dtpEndDate.Visible := cbbReportType.ItemIndex <>1;
  dtpEndTime.Visible := cbbReportType.ItemIndex <>1;
  lblBeginTime.Visible := cbbReportType.ItemIndex <>1;
  lblEndTime.Visible := cbbReportType.ItemIndex <>1;
end;

end.

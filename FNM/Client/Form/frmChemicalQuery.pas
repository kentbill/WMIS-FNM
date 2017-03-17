unit frmChemicalQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, StdCtrls, Buttons, ComCtrls,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  ExtCtrls, cxGridBandedTableView, cxGridDBBandedTableView, ADODB, DBClient,
  cxGridCustomPopupMenu, cxGridPopupMenu, Grids, DBGrids, DBTables;

type
  TChemicalQueryForm = class(TBaseForm)
    Notebook1: TNotebook;
    Panel1: TPanel;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    lbl1: TLabel;
    dtpQueryDate: TDateTimePicker;
    btnQuery: TBitBtn;
    btnClose: TBitBtn;
    dsChemical: TDataSource;
    cxGridDBBTV: TcxGridDBBandedTableView;
    cxGridDBBTVCreate_Date: TcxGridDBBandedColumn;
    cxGridDBBTVChemical_Type: TcxGridDBBandedColumn;
    cxGridDBBTVChemical_ID: TcxGridDBBandedColumn;
    cxGridDBBTVChemical_Name: TcxGridDBBandedColumn;
    cxGridDBBTVLast_Remain: TcxGridDBBandedColumn;
    cxGridDBBTVLast_Remain_Money: TcxGridDBBandedColumn;
    cxGridDBBTVIn_Qty: TcxGridDBBandedColumn;
    cxGridDBBTVIn_Money: TcxGridDBBandedColumn;
    cxGridDBBTVIn_Sum: TcxGridDBBandedColumn;
    cxGridDBBTVIn_Sum_Money: TcxGridDBBandedColumn;
    cxGridDBBTVOut_Qty: TcxGridDBBandedColumn;
    cxGridDBBTVOur_Money: TcxGridDBBandedColumn;
    cxGridDBBTVOut_Sum: TcxGridDBBandedColumn;
    cxGridDBBTVOut_Sum_Money: TcxGridDBBandedColumn;
    cxGridDBBTVRemain: TcxGridDBBandedColumn;
    cxGridDBBTVRemain_Money: TcxGridDBBandedColumn;
    cxGridDBBTVPrice: TcxGridDBBandedColumn;
    cxGridPopupMenu1: TcxGridPopupMenu;
    cxGridDBBTVOut_Theory_Qty: TcxGridDBBandedColumn;
    cxGridDBBTVOur_Theory_Money: TcxGridDBBandedColumn;
    cxGridDBBTVOut_Theory_Sum: TcxGridDBBandedColumn;
    cxGridDBBTVOur_Theory_Sum_Money: TcxGridDBBandedColumn;
    cxGridDBBTVDiff: TcxGridDBBandedColumn;
    cxGridDBBTDiff_Money: TcxGridDBBandedColumn;
    cxGridDBBTVOracle_Code: TcxGridDBBandedColumn;
    cdsChemical: TClientDataSet;
    procedure btnQueryClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxGridDBBTVOut_QtyCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChemicalQueryForm: TChemicalQueryForm;

implementation

uses ServerDllPub, UShowMessage, uAppOption,uLogin,uGlobal,uDictionary, uGridDecorator;

{$R *.dfm}

procedure TChemicalQueryForm.btnQueryClick(Sender: TObject);
var
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  try
    ShowMsg('正在获取数据稍等！',crHourGlass);
    sCondition := QuotedStr(DateToStr(dtpQueryDate.Date))+','+QuotedStr(Login.CurrentDepartment)+','+IntToStr(1);
    FNMServerObj.GetQueryData(vData,'GetChemicalInfo',sCondition,sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsChemical.Data := vData;
    cxGridDBBTV.ApplyBestFit(nil);
  finally
    ShowMsg('',crDefault);
  end;
end;

procedure TChemicalQueryForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TChemicalQueryForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TChemicalQueryForm.FormCreate(Sender: TObject);
begin
  inherited;
  dtpQueryDate.Date := Date()-1;
end;

procedure TChemicalQueryForm.FormDestroy(Sender: TObject);
begin
  inherited;
  ChemicalQueryForm := nil;
end;

procedure TChemicalQueryForm.cxGridDBBTVOut_QtyCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Font.Color := clRed;
end;

end.

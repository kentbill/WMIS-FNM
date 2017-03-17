unit frmCPBWIP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, StdCtrls, Buttons, ExtCtrls,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  DBClient;

type
  TCPBWIPForm = class(TBaseForm)
    dsCPBWIP: TDataSource;
    cdsCPBWIP: TClientDataSet;
    cxgridWIP: TcxGrid;
    cxgridtvCPBWIP: TcxGridDBTableView;
    cxGridlWIP: TcxGridLevel;
    pnlTop: TPanel;
    lbl1: TLabel;
    cbbCurrentDept: TComboBox;
    btnClose: TSpeedButton;
    btnRefresh: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxgridtvCPBWIPCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnCloseClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetCPBWIPInfo();
  public
    { Public declarations }
  end;

var
  CPBWIPForm: TCPBWIPForm;

implementation

uses  ServerDllPub, uGlobal, uShowMessage, uFNMResource, uGridDecorator, uAppOption, uLogin,
  frmMain,uDictionary;
{$R *.dfm}

procedure TCPBWIPForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TCPBWIPForm.FormDestroy(Sender: TObject);
begin
  inherited;
  CPBWIPForm := nil;
end;

procedure TCPBWIPForm.FormCreate(Sender: TObject);
begin
  inherited;
  btnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  TGlobal.FillComboBoxFromDataSet(Dictionary.cds_DepartmentList,'Department','Description','->',cbbCurrentDept);
  cbbCurrentDept.Text := FNMMainForm.cbbCurrentDept.Text;
  GetCPBWIPInfo();
end;

procedure TCPBWIPForm.GetCPBWIPInfo();
var vData: OleVariant;
    sCondition,sErrorMsg: WideString;
begin
  try
    Screen.Cursor :=  crHourGlass;
    ShowMsg('正在获取数据稍等！',crHourGlass);
    sCondition := QuotedStr(copy(cbbCurrentDept.Text,1,pos('->',cbbCurrentDept.Text)-1));
    FNMServerObj.GetQueryData(vData, 'CPBWIP', sCondition, sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsCPBWIP.Data := vData;
    GridDecorator.BindCxViewWithDataSource(cxgridtvcpbWIP, dsCPBWIP);
  finally
    Screen.Cursor :=  crDefault;
    ShowMsg('',crDefault);
  end;
end;
procedure TCPBWIPForm.cxgridtvCPBWIPCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var col :Integer;
begin
  inherited;
  col := TcxGridDBTableView(Sender).GetColumnByFieldName('RGB').Index;
  if AViewInfo.Item.Caption = 'RGB' then
     if AViewInfo.GridRecord.Values[col] <> NULL then
     begin
       ACanvas.Brush.Color := AViewInfo.GridRecord.Values[col];
       ACanvas.Font.Color := AViewInfo.GridRecord.Values[col];
     end;      
end;

procedure TCPBWIPForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TCPBWIPForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  GetCPBWIPInfo();
end;

end.

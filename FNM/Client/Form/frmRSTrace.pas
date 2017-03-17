unit frmRSTrace;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ComCtrls, DBClient, StdCtrls, Buttons,
  ExtCtrls, cxSplitter;

type
  TRSTraceForm = class(TBaseForm)
    pnlValue: TPanel;
    btnClose: TBitBtn;
    btnQuery: TBitBtn;
    dsRSTrace: TDataSource;
    cdsRSTrace: TClientDataSet;
    cdsEditRsTrace: TClientDataSet;
    dsEditRSTrace: TDataSource;
    cxspl2: TcxSplitter;
    GroupBox1: TGroupBox;
    cxGrid1: TcxGrid;
    cxGridTVRSTrace: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    GroupBox2: TGroupBox;
    Panel2: TPanel;
    btnSave: TBitBtn;
    chbRefresh: TCheckBox;
    cxGrid2: TcxGrid;
    cxGridTVEditRSTrace: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    procedure btnQueryClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure GetRSTraceInfo();
    procedure SaveRSTraceInfo;
  public
    { Public declarations }
  end;

var
  RSTraceForm: TRSTraceForm;

implementation

uses ServerDllPub, UShowMessage, uAppOption,uLogin,uGlobal,uDictionary, uGridDecorator;

{$R *.dfm}

procedure TRSTraceForm.GetRSTraceInfo();
var vData: OleVariant;
    sErrorMsg: WideString;
begin
  try
    ShowMsg('正在获取数据稍等！',crHourGlass);
    FNMServerObj.GetQueryData(vData,'GETRSTraceInfo','',sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsRSTrace.Data := vData[0];
    cdsEditRsTrace.Data := vData[1];
    GridDecorator.BindCxViewWithDataSource(cxGridTVRSTrace,dsRSTrace);
    GridDecorator.BindCxViewWithDataSource(cxGridTVEditRSTrace,dsEditRSTrace);
    cxGridTVEditRSTrace.GetColumnByFieldName('GF_NO').Options.Editing:=False;
    cxGridTVEditRSTrace.GetColumnByFieldName('Job_NO').Options.Editing:=False;
    cxGridTVEditRSTrace.GetColumnByFieldName('GF_ID').Visible:=false;
  finally
    ShowMsg('',crDefault);
  end;
end;

procedure TRSTraceForm.SaveRSTraceInfo;
var
  vData: OleVariant;
  sErrorMsg: WideString;
  i :Integer;
begin
  try
    ShowMsg('正在保存数据稍等！', crHourGlass);
    if TGlobal.DeltaIsNull(cdsEditRsTrace) then Exit;
    TempClientDataSet.Data := cdsEditRsTrace.Delta;
    vData := VarArrayCreate([0, cdsEditRsTrace.ChangeCount - 1], VarVariant);
    i := 0;
    while not TempClientDataSet.Eof do
    begin
      if cdsEditRsTrace.Locate('GF_ID;Job_NO',VarArrayOf([TempClientDataSet.Fieldbyname('GF_ID').AsInteger, TempClientDataSet.Fieldbyname('Job_NO').AsString]),[]) then
      begin
        vData[i] := varArrayOf([cdsEditRsTrace.FieldByName('Times_1').AsString,
                                cdsEditRsTrace.FieldByName('Times_1').AsString,
                                cdsEditRsTrace.FieldByName('Times_1').AsString,
                                Login.LoginName,
                                cdsEditRsTrace.FieldByName('GF_ID').AsString,
                                cdsEditRsTrace.FieldByName('Job_NO').AsString]);
      end;
      TempClientDataSet.Next;
      TempClientDataSet.Next;
      Inc(i);
    end;
    FNMServerObj.SaveRSTraceInfo(vData,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsEditRsTrace.MergeChangeLog;
    TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TRSTraceForm.btnQueryClick(Sender: TObject);
begin
  inherited;
  GetRSTraceInfo();
end;

procedure TRSTraceForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveRSTraceInfo();
  if chbRefresh.Checked then
    GetRSTraceInfo;
end;

procedure TRSTraceForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TRSTraceForm.FormDestroy(Sender: TObject);
begin
  inherited;
  RSTraceForm := nil;
end;

procedure TRSTraceForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

end.

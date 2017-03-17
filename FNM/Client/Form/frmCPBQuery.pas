unit frmCPBQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, MakeSQL, DBClient, Buttons,
  ExtCtrls, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  StdCtrls, Grids, ValEdit, cxSplitter, Menus, ClipBrd;

type
  TCPBQueryForm = class(TBaseForm)
    btnClose: TSpeedButton;
    btnQuery: TSpeedButton;
    cdsCPBQuery: TClientDataSet;
    dsCPBQuery: TDataSource;
    msPublic: TMakeSQL;
    Label1: TLabel;
    edtColorCode: TEdit;
    pnlTop: TPanel;
    dsRecipeDtl: TDataSource;
    cdsRecipeDtl: TClientDataSet;
    Panel1: TPanel;
    cxSplitter2: TcxSplitter;
    cxdbgCPB: TcxGrid;
    cxdbgtvCPBQuery: TcxGridDBTableView;
    cxGridlSelect: TcxGridLevel;
    Panel2: TPanel;
    cxGrid1: TcxGrid;
    cxGridTVRecipeDtl: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    GroupBox1: TGroupBox;
    lbGFNO: TListBox;
    PMCopyGf_No: TPopupMenu;
    NCopyGf_No: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cxdbgtvCPBQueryCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure edtColorCodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxdbgtvCPBQueryDblClick(Sender: TObject);
    procedure NCopyGf_NoClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure UpdateActions; override;  
  public
    { Public declarations }
  end;

var
  CPBQueryForm: TCPBQueryForm;

implementation

uses ServerDllPub, uGlobal, uShowMessage, uFNMResource, uLogin, uGridDecorator,uDictionary,uFNMArtInfo;

{$R *.dfm}

procedure TCPBQueryForm.UpdateActions;
begin
  inherited;
  if Trim(edtColorCode.Text) = '' then
    btnQuery.Caption := '高级(&Q)'
  else
    btnQuery.Caption := '查询(&Q)';
end;

procedure TCPBQueryForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TCPBQueryForm.FormCreate(Sender: TObject);
begin
  btnQuery.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
end;

procedure TCPBQueryForm.FormDestroy(Sender: TObject);
begin
  inherited;
  CPBQueryForm := nil;
end;

procedure TCPBQueryForm.btnQueryClick(Sender: TObject);
var vData: OleVariant;
    sCondition,sSql,sErrorMsg: WideString;
begin
  try
    ShowMsg( '正在获取数据稍等！', crHourGlass);
    if Trim(edtColorCode.Text) <> '' then
      sCondition:='FN_Color_Code LIKE '''+edtColorCode.Text + '%'''
    else
    begin
      sSql := msPublic.GetSql();
      if msPublic.Execute and (sSql <> '') then
        sCondition := sSql
      else
        sCondition :='';
    end;    
    if sCondition = '' then Exit;
    FNMServerObj.GetQueryData(vData, 'CPBQueryColor', sCondition, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsCPBQuery.Data := vData;
    if cdsRecipeDtl.Active then
      cdsRecipeDtl.EmptyDataSet;
    lbGFNO.Clear;  
    if cdsCPBQuery.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('没有相关信息,请检查你的查询条件!',mtInformation);
      edtColorCode.SetFocus;
      Exit;
    end;
  finally
    ShowMsg('', crDefault);
  end;
  GridDecorator.BindCxViewWithDataSource(cxdbgtvCPBQuery, dsCPBQuery);
end;

procedure TCPBQueryForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TCPBQueryForm.cxdbgtvCPBQueryCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var col :Integer;
begin
  inherited;
  col := TcxGridDBTableView(Sender).GetColumnByFieldName('RGB').Index;
  if AViewInfo.Item.Caption = 'RGB' then
  begin
    ACanvas.Brush.Color := AViewInfo.GridRecord.Values[col];
    ACanvas.Font.Color := AViewInfo.GridRecord.Values[col];
  end;
end;

procedure TCPBQueryForm.edtColorCodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key=13 then
    btnQuery.Click;
end;

procedure TCPBQueryForm.cxdbgtvCPBQueryDblClick(Sender: TObject);
var vData: OleVariant;
    sCondition,sErrorMsg: WideString;
begin
  inherited;
  if not cdsCPBQuery.Active then Exit;
  lbGFNO.Clear;
  sCondition := QuotedStr(cdsCPBQuery.FieldByName('FN_Color_Code').AsString);
  FNMServerObj.GetQueryData(vData, 'CPBQueryColorDtl', sCondition, sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  cdsRecipeDtl.Data := vData[0];
  GridDecorator.BindCxViewWithDataSource(cxGridTVRecipeDtl, dsRecipeDtl,True);
  GridDecorator.HideFields(cxGridTVRecipeDtl,['Chemical_ID']);
  TempClientDataSet.Data := vData[1];
  with TempClientDataSet do
  begin
    First;
    while not Eof do
    begin
      lbGFNO.Items.Add(FieldByName('GF_NO').AsString);
      Next;
    end;
  end;
end;

procedure TCPBQueryForm.NCopyGf_NoClick(Sender: TObject);
var ItemIndex:Integer;
    GF_NO:string;
begin
  inherited;
  ItemIndex:=lbGFNO.ItemIndex;
  if ItemIndex<0 then
    TMsgDialog.ShowMsgDialog('请先选择一个大货品名',mtInformation)
  else
  begin
    GF_NO:=lbGFNO.Items[ItemIndex];
    Clipboard.SetTextBuf(pchar(GF_NO)); //复制大货品名
    TMsgDialog.ShowMsgDialog('已复制大货品名'+GF_NO,mtInformation)
  end;
end;

end.

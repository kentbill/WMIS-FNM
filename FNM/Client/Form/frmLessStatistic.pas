unit frmLessStatistic;

interface

uses
  Windows, Messages, Classes, Controls, Graphics, ComCtrls, Forms,
  StdCtrls, Buttons, ExtCtrls, cxSpinEdit, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxButtonEdit, DB, Grids, ValEdit, DBClient, Menus,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,DateUtils,
  cxGridBandedTableView, cxGridDBBandedTableView;

type
  TLessStatisticForm = class(TForm)
    cxgrid_LessStatistic: TcxGrid;
    cxGridl_LessStatistic: TcxGridLevel;
    cdsLessStatistic: TClientDataSet;
    dsLessStatistic: TDataSource;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    btnQuery: TButton;
    Button1: TButton;
    btnSave: TButton;
    GroupBox3: TGroupBox;
    lblBeginDate: TLabel;
    lblEndDate: TLabel;
    dtpBegin: TDateTimePicker;
    dtpEnd: TDateTimePicker;
    btnGetData: TButton;
    cdsChange: TClientDataSet;
    Label1: TLabel;
    edtPlanDate: TEdit;
    Label2: TLabel;
    edtGroup: TEdit;
    Label3: TLabel;
    edtRemark: TEdit;
    cxgridtv_LessStatistic: TcxGridDBBandedTableView;
    cbGroup: TComboBox;
    procedure btnQueryClick(Sender: TObject);
    procedure RefreshData();
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGetDataClick(Sender: TObject);
    procedure GetData();
    procedure Button1Click(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure cxgridtv_LessStatisticEditChanged(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
    procedure SaveData();
    procedure FormCreate(Sender: TObject);
    procedure cxgridtv_LessStatisticCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgridtv_LessStatisticCellClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LessStatisticForm: TLessStatisticForm;

implementation

uses SysUtils, Variants, StrUtils, uDictionary, UAppOption,
    uFNMArtInfo, Dialogs, uGlobal, ServerDllPub, uFNMResource,
    uLogin, uShowMessage,uGridDecorator;

{$R *.dfm}

procedure TLessStatisticForm.btnQueryClick(Sender: TObject);
begin
  RefreshData;
end;

procedure TLessStatisticForm.GetData();
var
  sSQL,sErrMsg:WideString;
  vData:OleVariant;
begin
  sSQL := QuotedStr(DateTimeToStr(dtpBegin.Date)) + ',' + QuotedStr(DateTimeToStr(dtpEnd.Date)) + ',' + QuotedStr(Login.CurrentDepartment) + ',' + QuotedStr(Login.LoginID) ;
  FNMServerObj.GetQueryData(vData,'CreateLessStatistic',sSQL,sErrMsg);
  if sErrMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  RefreshData;
end;

procedure TLessStatisticForm.RefreshData();
var
  sSQL,sErrMsg:WideString;
  vData,vTemp:OleVariant;
  i:Integer;
begin
  sSQL := QuotedStr(DateTimeToStr(dtpBegin.Date)) + ',' + QuotedStr(DateTimeToStr(dtpEnd.Date)) + ',' + QuotedStr(Login.CurrentDepartment) + ','''',' + '2';
  FNMServerObj.GetQueryData(vData, 'CreateLessStatistic',sSQL ,sErrMsg);
  if sErrMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  cdsLessStatistic.Data := vData;

  GridDecorator.BindCxViewWithDataSource(cxgridtv_LessStatistic, dsLessStatistic);
  GridDecorator.HideFields(cxgridtv_LessStatistic,['iden']);

  cxgridtv_LessStatistic.ApplyBestFit();
  i:=0;
  while i < cxgridtv_LessStatistic.ColumnCount do
  begin
    cxgridtv_LessStatistic.Columns[i].Options.Editing := False;
    cxgridtv_LessStatistic.Bands.Add();
    cxgridtv_LessStatistic.Columns[i].Position.BandIndex := i;
    cxgridtv_LessStatistic.Bands.Items[0].FixedKind:=fkLeft;
    if (i=8) or (i=9) or (i=10)  or (i=11) then
       cxgridtv_LessStatistic.Columns[i].Width := 200;
    i:= i + 1;
  end;
  cxgridtv_LessStatistic.Bands.Items[0].Visible := False;
  cxgridtv_LessStatistic.Bands.Items[1].FixedKind:=fkLeft;
  cxgridtv_LessStatistic.Bands.Items[2].FixedKind:=fkLeft;
  cxgridtv_LessStatistic.Bands.Items[3].FixedKind:=fkLeft;

  //cxgridtv_LessStatistic.GetColumnByFieldName('Expected_Finished_Date').Options.Editing := True;
  //cxgridtv_LessStatistic.GetColumnByFieldName('Processing_Group').Options.Editing := True;
  //cxgridtv_LessStatistic.GetColumnByFieldName('Remark').Options.Editing := True;
  //cxgridtvScrapInfo.Columns[4].Options.Editing := True;

  //cxgridtvScrapInfo.GetColumnByFieldName('Quantity').Options.Editing:=true;
  //cxgridtvScrapInfo.GetColumnByFieldName('Margin').Options.Editing:=true;
end;

procedure TLessStatisticForm.SaveData();
var
  sIden,sDate,sRemark,sGroup,sSQL:string;
  sErrorMsg:WideString;
  vData:OleVariant;
begin
  with cxgridtv_LessStatistic do
  begin
    sIden := VarToStr(Controller.SelectedRows[0].Values[GetColumnByFieldName('iden').Index]);
    //sDate := VarToStr(Controller.SelectedRows[0].Values[GetColumnByFieldName('Expected_Finished_Date').Index]);
    sDate := edtPlanDate.Text;
    //sGroup := edtGroup.Text;
    sGroup := cbGroup.Text;
    sRemark := edtRemark.Text;
  end;

  if Length(sDate) > 8 then
  begin
    TMsgDialog.ShowMsgDialog('Expected_Finished_Date 格式不正确！', mtInformation);
    Exit;
  end;

//    if cdsLessStatistic.Locate('iden',sIden,[]) then
//    begin
//      with cdsLessStatistic do
//      begin
//        Edit;
//        FieldByName('Expected_Finished_Date').AsString :=  VarToStr(Controller.SelectedRows[0].Values[GetColumnByFieldName('Expected_Finished_Date').Index]);
//        FieldByName('Processing_Group').AsString :=  VarToStr(Controller.SelectedRows[0].Values[GetColumnByFieldName('Processing_Group').Index]);
//        FieldByName('remark').AsString :=  VarToStr(Controller.SelectedRows[0].Values[GetColumnByFieldName('remark').Index]);
//        Post;
//      end;
//    end;
//  end;
//  vData := cdsLessStatistic.Delta;
//  FNMServerObj.SaveBaseTableInfo(vData,'fnLessStatistic','iden',sErrorMsg);

  //保存备注
  sSQL := QuotedStr('') + ',' + QuotedStr('')  + ',' + QuotedStr('')  + ',' +
          QuotedStr(login.LoginID) + ',3,0,' +
          QuotedStr(sIden) + ',' + QuotedStr(sRemark) + ',' +
          QuotedStr(sDate) + ',' + QuotedStr(sGroup);
  FNMServerObj.SaveDataBySQL('CreateLessStatistic',sSQL,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
    Exit;
  end;
  TMsgDialog.ShowMsgDialog('保存成功！', mtInformation);
  
  btnSave.Enabled := True;;
end;

procedure TLessStatisticForm.FormDestroy(Sender: TObject);
begin
  LessStatisticForm := nil;
end;

procedure TLessStatisticForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TLessStatisticForm.btnGetDataClick(Sender: TObject);
begin
  if TMsgDialog.ShowMsgDialog('重新获取数据会删除之前的数据，是否继续？', mtConfirmation, [mebYes, mebNo], mebYes)= mrYes then
    GetData;
end;

procedure TLessStatisticForm.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TLessStatisticForm.btnSaveClick(Sender: TObject);
var
  sIden:string;
begin
  SaveData;
  RefreshData;
end;

procedure TLessStatisticForm.cxgridtv_LessStatisticEditChanged(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
begin
  btnSave.Enabled := True;
end;

procedure TLessStatisticForm.FormCreate(Sender: TObject);
var
  sUID:string;
begin
  dtpBegin.Date := Date - 90;
  dtpEnd.Date := Date - 1;
  sUID := Login.LoginID;
  if (sUID = 'hehp') or (sUID = 'luwel') or (sUID = 'tanhz') then
     GroupBox3.Visible := True;
end;

procedure TLessStatisticForm.cxgridtv_LessStatisticCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  with cxgridtv_LessStatistic do
  begin
    if Controller.SelectedRowCount <=0 then Exit;
    if VarIsNull(Controller.SelectedRows[0].Values[getcolumnbyfieldname('Expected_Finished_Date').index]) then
      edtPlanDate.Text := ''
    else
      edtPlanDate.Text := Controller.SelectedRows[0].Values[getcolumnbyfieldname('Expected_Finished_Date').index];
    //edtGroup.Text :=  Controller.SelectedRows[0].Values[getcolumnbyfieldname('Processing_Group').index];
    cbGroup.Text := Controller.SelectedRows[0].Values[getcolumnbyfieldname('Processing_Group').index];
    //edtRemark.Text :=  Controller.SelectedRows[0].Values[getcolumnbyfieldname('Remark').index];
  end;
end;

procedure TLessStatisticForm.cxgridtv_LessStatisticCellClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  with cxgridtv_LessStatistic do
  begin
    if Controller.SelectedRowCount <=0 then Exit;

    if VarIsNull(Controller.SelectedRows[0].Values[getcolumnbyfieldname('Expected_Finished_Date').index]) then
      edtPlanDate.Text := ''
    else
      edtPlanDate.Text := Controller.SelectedRows[0].Values[getcolumnbyfieldname('Expected_Finished_Date').index];
    //edtGroup.Text :=  Controller.SelectedRows[0].Values[getcolumnbyfieldname('Processing_Group').index];
    //edtPlanDate.Text := '';
    cbGroup.Text := Controller.SelectedRows[0].Values[getcolumnbyfieldname('Processing_Group').index];
    edtRemark.Text :=  '';
  end;
end;

end.

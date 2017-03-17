unit frmReceiveCPBBulkFabric;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, MakeSQL, DBClient, Buttons,
  ExtCtrls, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  StdCtrls, Grids, ValEdit, cxSplitter, Menus, ClipBrd;

type
  TReceiveCPBBulkFabricForm = class(TBaseForm)
    PanelLeft: TPanel;
    PanelRight: TPanel;
    PanelHead: TPanel;
    PanelBody: TPanel;
    lbGF_NO: TLabel;
    EdtQryGF_NO: TEdit;
    btSearch: TButton;
    cdsReceiveCPBFabricTask: TClientDataSet;
    dsReceiveCPBFabricTask: TDataSource;
    cxGridReceiveCPBFabricTask: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    Label1: TLabel;
    edtFN_Color_Code: TEdit;
    Label2: TLabel;
    edtRGB: TEdit;
    Label3: TLabel;
    edtGF_NO: TEdit;
    Label4: TLabel;
    edtConstruction: TEdit;
    Label5: TLabel;
    edtCustomer: TEdit;
    Label6: TLabel;
    edtQty: TEdit;
    Label7: TLabel;
    edtDelivery_Date: TEdit;
    Label8: TLabel;
    edtLast_End_Time: TEdit;
    Label9: TLabel;
    edtReceiveTime: TEdit;
    Label10: TLabel;
    edtReceiveQuantity: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    edtCHM_Rate: TEdit;
    edtwhiteness: TEdit;
    Label14: TLabel;
    edtHairEffectLeft: TEdit;
    Label15: TLabel;
    edtHairEffectEentre: TEdit;
    Label16: TLabel;
    edtHairEffectRight: TEdit;
    Label17: TLabel;
    edtFluorescenceQty: TEdit;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    edtOperator_Time: TEdit;
    cbReceiver: TComboBox;
    cbOperator: TComboBox;
    edtRemark: TMemo;
    btSave: TButton;
    Splitter1: TSplitter;
    procedure btSearchClick(Sender: TObject);
    procedure EdtQryGF_NOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsReceiveCPBFabricTaskAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure cxGridReceiveCPBFabricTaskCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btExcelClick(Sender: TObject);
  private
    FGF_NO: string;
    isLoadData:Boolean;
    procedure SetGF_NO(const Value: string);
    { Private declarations }

    procedure GetReceiveCPBFabricTask();
    procedure ShowTaskInfo();
    procedure SaveReceiveCPBFabric();
  public
    { Public declarations }
    property GF_NO:string read FGF_NO write SetGF_NO;
  end;

var
  ReceiveCPBBulkFabricForm: TReceiveCPBBulkFabricForm;

implementation

uses ServerDllPub, uGlobal, uExportActions, uShowMessage, uFNMResource, uLogin, uGridDecorator,uDictionary,uFNMArtInfo;

{$R *.dfm}

{ TReceiveCPBBulkFabricForm }

procedure TReceiveCPBBulkFabricForm.SetGF_NO(const Value: string);
begin
  FGF_NO := Value;
  GetReceiveCPBFabricTask;
end;

procedure TReceiveCPBBulkFabricForm.btSearchClick(Sender: TObject);
begin
  inherited;
  GF_NO:=EdtQryGF_NO.Text;
end;

{-------------------------------------------------------------------------------
  过程名:    TReceiveCPBBulkFabricForm.GetReceiveCPBFabricTask
  作者:      Danny duda
  日期:      2015.02.11 11:04:25
  参数:      无
  返回值:    无
  描述:      读取复版布信息，来源是DPB WIP,
  修改内容:
-------------------------------------------------------------------------------}
procedure TReceiveCPBBulkFabricForm.GetReceiveCPBFabricTask;
var vData: OleVariant;
    sCondition,sErrorMsg: WideString;
begin
  try
    isLoadData:=True;
    ShowMsg( '正在获取数据稍等！', crHourGlass);
    sCondition:=QuotedStr(GF_NO);
    FNMServerObj.GetQueryData(vData, 'ReceiveCPBFabricTask', sCondition, sErrorMsg);
    cdsReceiveCPBFabricTask.Data:=vData;
    GridDecorator.BindCxViewWithDataSource(cxGridReceiveCPBFabricTask, dsReceiveCPBFabricTask,True);
    if cdsReceiveCPBFabricTask.IsEmpty then
      TMsgDialog.ShowMsgDialog('没有相关信息,请检查你的查询条件!',mtInformation);

    ShowTaskInfo;
  except
    on e:Exception do
    begin
      isLoadData:=False;
      TMsgDialog.ShowMsgDialog('查询出错!'+char(13)+e.Message,mtInformation);
    end;
  end;
  ShowMsg('', crDefault);
  isLoadData:=False;
end;

procedure TReceiveCPBBulkFabricForm.EdtQryGF_NOKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key=Windows.VK_RETURN then
  begin
    btSearchClick(Sender);
  end;
end;

procedure TReceiveCPBBulkFabricForm.ShowTaskInfo;
var Quantity:Double;
    bk:TBookmark;
begin
  Quantity:=0;
  try
    isLoadData:=True;
    if not cdsReceiveCPBFabricTask.IsEmpty then
    begin
      FGF_NO:=cdsReceiveCPBFabricTask.FieldByName('品名').AsString;

      cdsReceiveCPBFabricTask.DisableControls;
      bk:=cdsReceiveCPBFabricTask.GetBookmark;
      cdsReceiveCPBFabricTask.First;
      while not cdsReceiveCPBFabricTask.Eof do
      begin

        if (cdsReceiveCPBFabricTask.FieldByName('品名').AsString=FGF_NO) and (not cdsReceiveCPBFabricTask.FieldByName('Quantity').IsNull)  then
          Quantity:=Quantity+cdsReceiveCPBFabricTask.FieldByName('Quantity').AsFloat;
        cdsReceiveCPBFabricTask.Next;
      end;
      cdsReceiveCPBFabricTask.GotoBookmark(bk);
      cdsReceiveCPBFabricTask.FreeBookmark(bk);

      edtFN_Color_Code.Text:=cdsReceiveCPBFabricTask.FieldByName('色号').AsString;
      edtRGB.Text:=cdsReceiveCPBFabricTask.FieldByName('RGB').AsString;
      edtGF_NO.Text:=FGF_NO;
      edtConstruction.Text:=cdsReceiveCPBFabricTask.FieldByName('结构').AsString;
      edtCustomer.Text:=cdsReceiveCPBFabricTask.FieldByName('客户').AsString;
      edtqty.Text:=FloatToStr(Quantity);
      edtDelivery_Date.Text:=cdsReceiveCPBFabricTask.FieldByName('交期').AsString;
      edtLast_End_Time.Text:=cdsReceiveCPBFabricTask.fieldByName('上工序时间').AsString;
      edtReceiveQuantity.Text:=cdsReceiveCPBFabricTask.fieldByName('收布码长').AsString;
      edtCHM_Rate.Text:=cdsReceiveCPBFabricTask.fieldByName('轧余率').AsString;
      cbReceiver.Text:=cdsReceiveCPBFabricTask.fieldByName('收布人').AsString;
      edtReceiveTime.Text:=cdsReceiveCPBFabricTask.fieldByName('收布时间').AsString;
      edtwhiteness.Text:=cdsReceiveCPBFabricTask.fieldByName('白度').AsString;
      edtHairEffectLeft.Text:=cdsReceiveCPBFabricTask.fieldByName('毛效左').AsString;
      edtHairEffectEentre.Text:=cdsReceiveCPBFabricTask.fieldByName('毛效中').AsString;
      edtHairEffectRight.Text:=cdsReceiveCPBFabricTask.fieldByName('毛效右').AsString;
      edtFluorescenceQty.Text:=cdsReceiveCPBFabricTask.fieldByName('荧光量').AsString;
      cbOperator.Text:=cdsReceiveCPBFabricTask.fieldByName('录入人').AsString;
      edtOperator_Time.Text:=cdsReceiveCPBFabricTask.fieldByName('录入时间').AsString;
      edtRemark.Lines.Text:= cdsReceiveCPBFabricTask.fieldByName('备注').AsString;
    end else
    begin
      FGF_NO:='';
      edtFN_Color_Code.Text:='';
      edtRGB.Text:='';
      edtGF_NO.Text:='';
      edtConstruction.Text:='';
      edtCustomer.Text:='';
      edtqty.Text:='';
      edtDelivery_Date.Text:='';
      edtReceiveQuantity.Text:='';
      edtCHM_Rate.Text:='';
      cbReceiver.Text:='';
      edtReceiveTime.Text:='';
      edtwhiteness.Text:='';
      edtHairEffectLeft.Text:='';
      edtHairEffectEentre.Text:='';
      edtHairEffectRight.Text:='';
      edtFluorescenceQty.Text:='';
      cbOperator.Text:='';
      edtOperator_Time.Text:='';
      edtRemark.Lines.Clear;
    end;
  except

  end;
  isLoadData:=False;
  cdsReceiveCPBFabricTask.EnableControls;
end;

procedure TReceiveCPBBulkFabricForm.cdsReceiveCPBFabricTaskAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  if isLoadData or cdsReceiveCPBFabricTask.ControlsDisabled then Exit;
  ShowTaskInfo;
end;

procedure TReceiveCPBBulkFabricForm.FormShow(Sender: TObject);
begin
  inherited;
  cbReceiver.Items.Text := Dictionary.GetItemList('CPB调色师',Login.CurrentDepartment,'');
  cbOperator.Items.Text := cbReceiver.Items.Text;
end;

procedure TReceiveCPBBulkFabricForm.btSaveClick(Sender: TObject);
begin
  inherited;
  if edtReceiveTime.Text='' then
  begin
    edtReceiveTime.Text:=FormatDateTime('yyyy/MM/dd HH:mm:ss', Now);    
  end;
  edtOperator_Time.Text:=FormatDateTime('yyyy/MM/dd HH:mm:ss', Now);
  SaveReceiveCPBFabric();
end;

procedure TReceiveCPBBulkFabricForm.SaveReceiveCPBFabric;
var sCondition, sErrorMsg: WideString;
   f:Double;
   FN_Card_No, Job_No:string;
begin
  try
    //if edtReceiveQuantity.Text='' then edtReceiveQuantity.Text:='0';
    if not TryStrToFloat(edtReceiveQuantity.Text, f) then
    begin
      edtReceiveQuantity.SetFocus;
      TMsgDialog.ShowMsgDialog('码长不是数值格式',mtInformation);
      Exit;
    end;
    FN_Card_No:=cdsReceiveCPBFabricTask.FieldByName('卡号').AsString;
    Job_No:=cdsReceiveCPBFabricTask.FieldByName('排单').AsString;
    sCondition:=QuotedStr(FN_Card_No)+','+
                QuotedStr(Job_No)+','+
                QuotedStr(GF_NO)+','+
                QuotedStr(edtFN_Color_Code.Text)+','+
                QuotedStr(edtRGB.Text)+','+
                QuotedStr(edtConstruction.Text)+','+
                QuotedStr(edtCustomer.Text)+','+
                QuotedStr(edtDelivery_Date.Text)+','+
                QuotedStr(edtLast_End_Time.Text)+','+
                QuotedStr(edtReceiveTime.Text)+','+
                QuotedStr(cbReceiver.Text)+','+
                QuotedStr(edtReceiveQuantity.Text)+','+
                QuotedStr(edtCHM_Rate.Text)+','+
                QuotedStr(edtwhiteness.Text)+','+
                QuotedStr(edtHairEffectLeft.Text)+','+
                QuotedStr(edtHairEffectEentre.Text)+','+
                QuotedStr(edtHairEffectRight.Text)+','+
                QuotedStr(edtFluorescenceQty.Text)+','+
                QuotedStr(edtRemark.Lines.Text)+','+
                QuotedStr(cbOperator.Text)+','+
                QuotedStr(edtOperator_Time.Text);
     ShowMsg('正在保存数据稍等！', crHourGlass);
     FNMServerObj.SaveDataBySQL('SaveReceiveCPBFabric',sCondition,sErrorMsg);

     if sErrorMsg<>'' then
     begin
       TMsgDialog.ShowMsgDialog('保存出错!'+char(13)+sErrorMsg,mtInformation);
     end else
     begin
       btSearchClick(nil);
       cdsReceiveCPBFabricTask.Locate('卡号', FN_Card_No,[]);
     end;
   except
      on e:Exception do
      begin
        TMsgDialog.ShowMsgDialog('保存出错!'+char(13)+e.Message,mtInformation);
      end;
  end;
   ShowMsg('', crDefault);
end;

procedure TReceiveCPBBulkFabricForm.cxGridReceiveCPBFabricTaskCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var s:String;
begin
  inherited;
//  s:=AViewInfo.GridRecord.Values[42];
//  OutputDebugString(PChar(s));
//  s:=AViewInfo.GridRecord.Values[31];
//  OutputDebugString(PChar(s));
//  s:=AViewInfo.GridRecord.Values[34] ;
//  OutputDebugString(PChar(s));
//  s:=AViewInfo.GridRecord.Values[35] ;
//  OutputDebugString(PChar(s));
//  s:=AViewInfo.GridRecord.Values[36]  ;
//  OutputDebugString(PChar(s));
//  s:=AViewInfo.GridRecord.Values[37] ;
//  OutputDebugString(PChar(s));
  if (AViewInfo.GridRecord.Values[42] <> Null) and
     (AViewInfo.GridRecord.Values[31] <> '') and //轧余率
     (AViewInfo.GridRecord.Values[34] <> '') and //白度
     (AViewInfo.GridRecord.Values[35] <> '') and//毛效左	毛效中	毛效右
     (AViewInfo.GridRecord.Values[36] <> '') and
     (AViewInfo.GridRecord.Values[37] <> '') 
     //(AViewInfo.GridRecord.Values[38] <> '') and//荧光量
     then
  begin
    ACanvas.Font.Color:=clRed;
    //ADone:=True;
  end;
end;

procedure TReceiveCPBBulkFabricForm.btExcelClick(Sender: TObject);
var SaveFileName:string;
begin
  inherited;
  //TExportAction.Create(Self).ExecuteTarget(cxGrid1);
//  SaveFileName:=GetSaveFileName('*.xls');
end;

end.

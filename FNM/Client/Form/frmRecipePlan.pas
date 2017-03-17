unit frmRecipePlan;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmRecipe.pas                                                 }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 lvzd                                                          }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  开化料单                                                     }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Dialogs, Math,
  Classes, Graphics, Controls, Forms, StdCtrls, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit, ComCtrls, ExtCtrls, Buttons,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridLevel, cxGrid, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxGridDBTableView, DB, DBClient, cxDBData,
  cxSplitter;

type
  TRecipePlanForm = class(TForm)
    btn_Exit: TSpeedButton;
    cds_NoFinishRecipe: TClientDataSet;
    ds_NoFinishRecipe: TDataSource;
    pnl2: TPanel;
    cxGrid2: TcxGrid;
    cxgtv_RecipeNOs: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cds_BatchList: TClientDataSet;
    ds_BatchList: TDataSource;
    spl1: TSplitter;
    txt2: TStaticText;
    cbb_VatCode: TComboBox;
    btn_NewRecipe: TSpeedButton;
    btn_DeleteRecipe: TSpeedButton;
    cxGrid1: TcxGrid;
    cxgtv_RecipeNOBatch: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    btn_SplitRecipe: TSpeedButton;
    btn_DeleteBatch: TSpeedButton;
    StaticText1: TStaticText;
    edt_BatchVolume: TEdit;
    btn_Refresh: TSpeedButton;
    btn_PrintPreview: TSpeedButton;
    btn_EditBaseVolume: TSpeedButton;
    cxsplBottom: TcxSplitter;
    grp1: TGroupBox;
    cxgridRecipeInfo: TcxGrid;
    cxgridtvRecipeInfo: TcxGridDBTableView;
    cxGridl1: TcxGridLevel;
    sclbVat: TScrollBox;
    btnVat: TBitBtn;
    cdsVatInfo: TClientDataSet;
    tmr1: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure KeyDownAControl(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure ClickAButton(Sender: TObject);
    procedure AfterScrollADataSet(DataSet: TDataSet);
    procedure cbb_VatCodeChange(Sender: TObject);
    procedure Btn_EditBaseVolumeClick(Sender: TObject);
    procedure cxgtv_RecipeNOBatchCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxsplBottomAfterOpen(Sender: TObject);
    procedure cxsplBottomAfterClose(Sender: TObject);
    procedure btnVatClick(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
  private
    { private declarations }
    RunFrist: Boolean;
    procedure GetNoFinishRecipeBatch;
    procedure GetNoFinishRecipe;
    procedure SplitRecipe;
    procedure DelCurBatch;
    procedure DelCurRecipe;

    procedure DrawVatState;
  public
    { Public declarations }
 end;

var
  RecipePlanForm: TRecipePlanForm;

implementation

uses StrUtils, Variants, UAppOption, uLogin, UFNMResource,
  ServerDllPub, uShowMessage, uFNMArtInfo, uGlobal, uDictionary,
  frmCreateRecipe, UGridDecorator, rptRecipe, rptCPB;

{$R *.dfm}

procedure TRecipePlanForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TRecipePlanForm.FormDestroy(Sender: TObject);
begin
  RecipePlanForm:=nil;
  if CreateRecipeForm <> nil then
    FreeAndNil(CreateRecipeForm);
end;

procedure TRecipePlanForm.FormActivate(Sender: TObject);
begin
  OnActivate:=nil;
  Application.ProcessMessages;

  cxsplBottom.CloseSplitter;
  //刷新界面数据
  PostMessage(Handle, WM_KEYDOWN, VK_F5, 0);
end;

procedure TRecipePlanForm.FormCreate(Sender: TObject);
var
  EditStyle: Longint;
begin
  RunFrist:=True;
  //加载图标
  btn_Exit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  btn_NewRecipe.Glyph.LoadFromResourceName(HInstance, RES_NEW);
  btn_Refresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btn_SplitRecipe.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btn_DeleteBatch.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  btn_DeleteRecipe.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  btn_PrintPreview.Glyph.LoadFromResourceName(HInstance, RES_PREVIEW);
  btn_EditBaseVolume.Glyph.LoadFromResourceName(HInstance, RES_EDIT);
  
  EditStyle:=GetWindowLong(edt_BatchVolume.Handle, GWL_STYLE);
  SetWindowLong(edt_BatchVolume.Handle, GWL_STYLE, EditStyle or ES_NUMBER);

  //界面布置
  //btn_PrintPreview.Enabled:=false;
  btn_SplitRecipe.Enabled:=false;
  //TListView的双击事件
  cxgtv_RecipeNOs.OnDblClick:=TGlobal.DblClickAWinControl;
end;

procedure TRecipePlanForm.KeyDownAControl(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Sender = Self then
  case Key of
    VK_F5: btn_Refresh.Click;
  end;
end;

procedure TRecipePlanForm.GetNoFinishRecipe;
var
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  try
    cds_NoFinishRecipe.DisableControls;
    sCondition := QuotedStr(Login.CurrentDepartment)+',1';
    FNMServerObj.GetQueryData(vData, 'RCPGetRecipeTaskInfo', sCondition, sErrorMsg);
//    FNMServerArtObj.GetNoFinishRecipe(Login.CurrentDepartment, vData, sErrorMsg);
    if sErrorMsg <> '' then
      raise ExceptionEx.CreateResFmt(@ERR_GetNoFinishRecipe, [sErrorMsg]);

    cds_NoFinishRecipe.Data:=vData;
    if cds_NoFinishRecipe.IsEmpty then
      raise Exception.CreateRes(@EMP_NoFinishRecipe);

    GridDecorator.BindCxViewWithDataSource(cxgtv_RecipeNOs, ds_NoFinishRecipe);
  finally
    cds_NoFinishRecipe.EnableControls;
    cds_NoFinishRecipe.AfterScroll(cds_NoFinishRecipe);
  end;   
end;

procedure TRecipePlanForm.GetNoFinishRecipeBatch;
var
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  try
    cds_BatchList.DisableControls;
    sCondition := QuotedStr(Login.CurrentDepartment)+',2';
    FNMServerObj.GetQueryData(vData, 'RCPGetRecipeTaskInfo', sCondition, sErrorMsg);
//   FNMServerArtObj.GetNoFinishRecipeBatch(Login.CurrentDepartment, vData, sErrorMsg);
    if sErrorMsg <> '' then
      raise ExceptionEx.CreateResFmt(@ERR_GetNoFinishRecipe, [sErrorMsg]);

    cds_BatchList.Data:=vData;
    GridDecorator.BindCxViewWithDataSource(cxgtv_RecipeNOBatch, ds_BatchList);
  finally
    cds_BatchList.EnableControls;
    cds_BatchList.AfterScroll(cds_BatchList);
  end;   
end;

procedure TRecipePlanForm.SplitRecipe;
var
  Volume, i: integer;
  vData: OleVariant;
  sBatch_NO,sCondition,sErrorMsg: WideString;
  VatCode, RecipeNO: String;
begin
  //提示将立即保存
  if RunFrist then
  begin
    //提示将立即保存
    RunFrist:= False;
  end;

  //已经分完缸了
  if not cds_NoFinishRecipe.Active then Exit;
  if cds_NoFinishRecipe['Batch_Volume'] >= cds_NoFinishRecipe['Sum_Volume'] then Exit;
  RecipeNO:=cds_NoFinishRecipe['Recipe_NO'];

  //取缸号
  VatCode:=LeftStr(cbb_VatCode.Text, 8);
  if (VatCode = '') or (not cds_BatchList.Active) then Exit;

  if (StrToInt(edt_BatchVolume.Text) > edt_BatchVolume.Tag) or (StrToInt(edt_BatchVolume.Text) < 50) then
    raise Exception.Create('ERR_输入的体积比化料缸的体积大或体积过小!');

  sCondition := QuotedStr(RecipeNO)+ ','+ QuotedStr(VatCode)+','+ QuotedStr(edt_BatchVolume.Text)+','+ QuotedStr(Login.LoginName);
  FNMServerObj.SaveDataBySQLEx('RCPSplitRecipeInfo',sCondition,sBatch_NO,sErrorMsg);
//  FNMServerArtObj.SaveSplitRecipe(RecipeNO, VatCode, edt_BatchVolume.Text, Login.LoginName, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveSplitRecipe, [sErrorMsg]);

  sCondition := QuotedStr(sBatch_NO)+',2';
  FNMServerObj.GetQueryData(vData, 'RCPGetRecipeTaskInfo', sCondition, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveSplitRecipe, [sErrorMsg]);

  TempClientDataSet.Data:=vData;
  cds_BatchList.Insert;
  for i := 0 to cds_BatchList.FieldCount - 2 do
    cds_BatchList.Fields.Fields[i].Value:=TempClientDataSet.Fields.Fields[i].Value;
  cds_BatchList.CheckBrowseMode;
  //将返回的纪录插入到当前数据集中。
  Volume:=TempClientDataSet['Volume'];
  TempClientDataSet.Close;
  cds_NoFinishRecipe.Edit;
  cds_NoFinishRecipe['Batch_Volume']:=cds_NoFinishRecipe['Batch_Volume'] + Volume;

  cds_BatchList.AfterScroll(cds_BatchList);
  cds_NoFinishRecipe.AfterScroll(cds_NoFinishRecipe);
end;

procedure TRecipePlanForm.DelCurBatch;
var
  Volume: integer;
  sCondition,sErrorMsg: WideString;
  RecipeNO, BatchNO: String;
begin
  if (not cds_BatchList.Active) or (cds_BatchList.IsEmpty) or (cds_BatchList['Status'] <> 0) then Exit;

  BatchNO:=cds_BatchList['Batch_NO'];
  Volume:=cds_BatchList['Volume'];
  RecipeNO:=cds_BatchList['Recipe_NO'];
  //Save Info
  sCondition := QuotedStr(BatchNO)+ ','+ QuotedStr(Login.LoginName);
  FNMServerObj.SaveDataBySQL('RCPDeleteBatchInfo',sCondition,sErrorMsg);
  //FNMServerArtObj.SaveDelABatch(BatchNO, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveSaveDelABatch, [sErrorMsg]);

  cds_BatchList.Delete;
  if not cds_NoFinishRecipe.Locate('Recipe_NO', RecipeNO, []) then Exit;
  cds_NoFinishRecipe.Edit;
  cds_NoFinishRecipe['Batch_Volume']:=cds_NoFinishRecipe['Batch_Volume'] - Volume;

  cds_BatchList.AfterScroll(cds_BatchList);
  cds_NoFinishRecipe.AfterScroll(cds_NoFinishRecipe);
end;

procedure TRecipePlanForm.DelCurRecipe;
var
  RecipeNO: String;
  sCondition,sErrorMsg: WideString;
begin
  if cds_NoFinishRecipe.IsEmpty then exit;
  RecipeNO:=cds_NoFinishRecipe['Recipe_NO'];
  //除化工料
  sCondition := QuotedStr(RecipeNO)+ ','+ QuotedStr(Login.LoginName)+','+QuotedStr('0');
  FNMServerObj.SaveDataBySQL('RCPDeleteRecipeInfo',sCondition,sErrorMsg);
//  FNMServerArtObj.SaveDelRecipe(RecipeNO, '0', sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveDelRecipe, [sErrorMsg]);

  cds_NoFinishRecipe.Delete;
  ShowMsgDialog(@MSG_SaveDelRecipeSuccess, mtInformation);
end;

procedure TRecipePlanForm.ClickAButton(Sender: TObject);
var
  RecipeNO: String;
begin
  if Sender = btn_Refresh then
  begin
    GetNoFinishRecipe;
    GetNoFinishRecipeBatch;
  end;

  if Sender = btn_SplitRecipe then
    SplitRecipe;

  if Sender = btn_DeleteBatch then
    DelCurBatch;

  if Sender = btn_PrintPreview then
  begin
    if cds_NoFinishRecipe.IsEmpty then exit;
    RecipeNO:=cds_NoFinishRecipe['Recipe_NO'];
    if LeftStr(RecipeNO,2) = 'PD' then   //打吟CPB配方
    begin
      if not Assigned(CPBReport) then
        CPBReport := TCPBReport.Create(nil);
      CPBReport.PreviewReport(RecipeNO,False);
    end else
      PreViewRecipeReport(RecipeNO,False);
  end;

  if Sender = btn_DeleteRecipe then
    DelCurRecipe;

  if Sender = btn_NewRecipe then
  begin
    CreateANewRecipe;
    GetNoFinishRecipe;
  end;

  if Sender = btn_Exit then
    Close;
end;

procedure TRecipePlanForm.AfterScrollADataSet(DataSet: TDataSet);
begin
  if DataSet.ControlsDisabled or DataSet.IsEmpty then Exit;

  if DataSet = cds_NoFinishRecipe then
  begin
    btn_SplitRecipe.Enabled:=DataSet['Batch_Volume'] < DataSet['Sum_Volume'];
    btn_PrintPreview.Enabled:=DataSet['Batch_Volume'] >= DataSet['Sum_Volume'];
    btn_DeleteRecipe.Enabled:=(DataSet['Batch_Volume'] = 0) and (DataSet['Fact_Volume'] = 0);
    cds_BatchList.Filter:=Format('Machine_ID = ''%s''', [DataSet['Machine_ID']]);
    cds_BatchList.Filtered:=True;
    //填充化料缸
    with Dictionary.cds_VatList do
    try
      Filter:=Format('Vat_Code LIKE ''%s'' and Machine_ID = ''%s''', [Login.CurrentDepartment + '%', DataSet['Machine_ID']]);
      Filtered:=True;
      FillItemsFromDataSet(Dictionary.cds_VatList, 'Vat_Code', 'Machine_ID', '', '->', cbb_VatCode.Items);
    finally
      Filtered:=False;
    end;
    if ssOpened = cxsplBottom.State  then
      DrawVatState;
  end;

  if DataSet = cds_BatchList then
    btn_DeleteBatch.Enabled:=DataSet['Status'] = 0;
end;

procedure TRecipePlanForm.cbb_VatCodeChange(Sender: TObject);
var
  VatCode: String;
begin
  //填充化料缸
  VatCode:=LeftStr(cbb_VatCode.Text, 8);
  with Dictionary, Dictionary.cds_VatList do
  if Locate('Vat_Code', VatCode, []) then
  begin
    edt_BatchVolume.Text:=cds_VatList['Vat_Cubage'];
    edt_BatchVolume.Tag:=cds_VatList['Vat_Cubage'];
  end
end;

procedure TRecipePlanForm.Btn_EditBaseVolumeClick(Sender: TObject);
var
  OffsetVol: Integer;
  sErrorMsg: WideString;
  RecipeNO, OffsetVolume: String;
begin
  if cds_NoFinishRecipe.IsEmpty then exit;
  RecipeNO:=cds_NoFinishRecipe['Recipe_NO'];

  OffsetVolume:=InputBox('化料体积修改', '增加量:', '0');
  if OffsetVolume = '0' then Exit;
  if not TryStrToInt(OffsetVolume, OffsetVol) then
    raise Exception.Create('请输入整数');
  if (cds_NoFinishRecipe['Sum_Volume'] + OffsetVol) < 50 then
    raise Exception.Create('修改后的体积小于50L');

  FNMServerArtObj.SaveNewRecipeVol(RecipeNO, OffsetVolume, sErrorMsg);
  
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveNewRecipeVol, [sErrorMsg]);

  cds_NoFinishRecipe.FieldByName('Sum_Volume').ReadOnly:=False;
  cds_NoFinishRecipe.Edit;
  cds_NoFinishRecipe['Sum_Volume']:=cds_NoFinishRecipe['Sum_Volume'] + OffsetVol;
  ShowMsgDialog(@MSG_SaveNewRecipeVolSuccess, mtInformation);
  cds_NoFinishRecipe.AfterScroll(cds_NoFinishRecipe);
end;

procedure TRecipePlanForm.cxgtv_RecipeNOBatchCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  col: Integer;
begin
  if AViewInfo.Focused then Exit;

  cds_BatchList.AfterScroll := nil;
  try
    col := TcxGridDBTableView(Sender).GetColumnByFieldName('Status').Index;
    if AViewInfo.GridRecord.Values[col] = 1 then
    begin
      ACanvas.Brush.Color:=clWhite;
      ACanvas.Font.Color:=clRed; //已经开始化料
    end;

    if AViewInfo.GridRecord.Values[col] = 2 then
    begin
      ACanvas.Brush.Color:=clWhite;
      ACanvas.Font.Color:=clBlue;  //已经完成化料
    end;
  finally
    cds_BatchList.AfterScroll := AfterScrollADataSet;
  end;
end;

procedure TRecipePlanForm.btnVatClick(Sender: TObject);
begin
  DrawVatState;
end;

procedure TRecipePlanForm.cxsplBottomAfterClose(Sender: TObject);
begin   
  tmr1.Enabled := False;
end;

procedure TRecipePlanForm.cxsplBottomAfterOpen(Sender: TObject);
begin
  tmr1.Enabled := True;
  btnVat.Click;
end;

procedure TRecipePlanForm.DrawVatState;
var
  pnl: TPanel;
  lbl: TLabel;
//  FontColor: TColor;
  C, R: Double;
  gWidth, gHeight, iRecordCount, i, j, W, H: Integer;
//  Status_CN: string;
  vData: Olevariant;
  sMachineID, sCondition, sErrorMsg: WideString;
begin
  sclbVat.Visible := False;

  sMachineID := cds_NoFinishRecipe.FieldByName('Machine_ID').AsString;
  sCondition := QuotedStr(Login.CurrentDepartment)+','+QuotedStr(sMachineID);
  FNMServerObj.GetQueryData(vData, 'RCPGetCSVatStatus', sCondition, sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  cdsVatInfo.Data := vData;
  if cdsVatInfo.IsEmpty then Exit;

  //设置Panel大小
  gWidth := 220;
  gHeight := 100;
  W := 10; //Panel的Left
  H := 10; //Panel的Top
  iRecordCount := cdsVatInfo.RecordCount;

  //第一次画
  if sclbVat.ControlCount<>iRecordCount then
  begin
    if sclbVat.ControlCount>0 then
    begin
      for i:= sclbVat.ControlCount-1 downto 0 do
        sclbVat.Controls[i].Destroy;
    end;
    // 一行显示的个数,列数
    C := Int((sclbVat.Width - 20) / gWidth);
    if C = 0 then C := 1;

    //计算行数
    if Frac(iRecordCount / C) > 0 then
      R := Int(iRecordCount / C) + 1
    else
      R := Int(iRecordCount / C);

    with cdsVatInfo do
    begin
      First;
      for i := 0 to Floor(R) - 1 do
      begin
        for j := 0 to Floor(C) - 1 do
        begin
          if Eof then break;
          //创建Panel
          pnl := TPanel.Create(self);
          pnl.Parent := sclbVat;
          pnl.Left := W;
          pnl.Top := H;
          pnl.Width := gWidth;
          pnl.Height := gHeight;
          pnl.BorderStyle := bsSingle;
          pnl.BevelInner := bvRaised;

          //向架位上放入Label显示架位信息
          lbl := TLabel.Create(self);
          lbl.Parent := pnl;
          lbl.Align := alClient;
          lbl.Alignment := taLeftJustify;
          lbl.Font.Size := 15;
          lbl.Font.Style := [fsBold];
        //  lbl.Font.Color := FontColor;
          lbl.Caption := '';
          W := W + gWidth;
          if Eof then break else Next;
        end;
        H := H + gHeight;
        W := W - Floor(C) * gWidth;
      end
    end;
  end;

  //赋值
  cdsVatInfo.First;
  for i := sclbVat.ControlCount - 1 downto 0 do
  begin

    if TPanel(sclbVat.Controls[i]).Controls[0].ClassName= 'TLabel' then
    begin
      with TLabel(TPanel(sclbVat.Controls[i]).Controls[0]) do
      begin
        Caption := cdsVatInfo.FieldByName('Caption').AsString;
        Font.Color := StringToColor(cdsVatInfo.FieldByName('Font_Color').AsString);
        Color := StringToColor(cdsVatInfo.FieldByName('Color').AsString);
        Hint :=Caption + cdsVatInfo.FieldByName('Remark').AsString;
        ShowHint := True;
      end;

      if not cdsVatInfo.Eof then
        cdsVatInfo.Next;
    end;
  end;

  sclbVat.Visible := True;
end;

procedure TRecipePlanForm.tmr1Timer(Sender: TObject);
begin
  DrawVatState;
end;

end.


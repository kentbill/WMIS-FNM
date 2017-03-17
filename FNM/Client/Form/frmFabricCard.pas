unit frmFabricCard;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmFabricCard.pas                                             }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  拆卡组卡                                                     }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Buttons,uFNMResource, DB, DBClient,frmBase,Math,StrUtils;

type
  TDirection = (dUp, dDown);
  TFabricCardForm = class(TBaseForm)
    pgcSplitCardFabric: TPageControl;
    tsFabric: TTabSheet;
    tsCard: TTabSheet;
    Panel1: TPanel;
    pnl1: TPanel;
    grp1: TGroupBox;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl17: TLabel;
    lbl18: TLabel;
    lbl19: TLabel;
    lbl20: TLabel;
    edtQuantity: TEdit;
    edtFN_Card: TEdit;
    edtWarpWeft_Density: TEdit;
    edtGF_ID: TEdit;
    edtGF_NO: TEdit;
    edtJob_NO: TEdit;
    edtPPO_NO: TEdit;
    edtCustomer: TEdit;
    edtDelivery_Date: TEdit;
    edtSource: TEdit;
    edtremark: TEdit;
    edtSplit_Quantity: TEdit;
    edtWarpWeft_Count: TEdit;
    edtCar_NO: TEdit;
    edtReceive_Date: TEdit;
    grp2: TGroupBox;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    edtOld_Fabric_NO: TEdit;
    edtOld_Quantity: TEdit;
    edtNew_Fabric_NO: TEdit;
    edtNew_Quantity: TEdit;
    Panel2: TPanel;
    btnSaveFabric: TButton;
    btnClose: TButton;
    grp4: TGroupBox;
    lvSourceCard: TListView;
    grp3: TGroupBox;
    lvDestinate: TListView;
    pnl4: TPanel;
    lbl24: TLabel;
    btnQueryCard: TBitBtn;
    edtFN_Card_Layer: TEdit;
    pnl5: TPanel;
    lbl1: TLabel;
    edtFabric_NO: TEdit;
    btnQueryFabric: TBitBtn;
    grp5: TGroupBox;
    lstFNCard: TListBox;
    pnl2: TPanel;
    lbl21: TLabel;
    edtQuantity_FNCard: TEdit;
    spl1: TSplitter;
    cdsPublic: TClientDataSet;
    btnCancelFabric: TButton;
    pnl3: TPanel;
    lbl22: TLabel;
    lblCar_NO: TLabel;
    lbl23: TLabel;
    edtQuantity_Fabric: TEdit;
    edtCar: TEdit;
    edtNew_FN_Card_Layer: TEdit;
    btnSaveCard: TButton;
    btnPrint: TButton;
    btnExit: TButton;
    btnDown: TSpeedButton;
    btnDownAll: TSpeedButton;
    btnUp: TSpeedButton;
    btnUpAll: TSpeedButton;
    Label1: TLabel;
    edt_Reason: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtFabric_NOEnter(Sender: TObject);
    procedure edtFabric_NOExit(Sender: TObject);
    procedure edtFN_Card_LayerEnter(Sender: TObject);
    procedure edtFN_Card_LayerExit(Sender: TObject);
    procedure btnQueryFabricClick(Sender: TObject);
    procedure edtSplit_QuantityKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSaveFabricClick(Sender: TObject);
    procedure btnCancelFabricClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnQueryCardClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnDownAllClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnUpAllClick(Sender: TObject);
    procedure lvSourceCardChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvDestinateChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvSourceCardDblClick(Sender: TObject);
    procedure lvDestinateDblClick(Sender: TObject);
    procedure btnSaveCardClick(Sender: TObject);
    procedure lvSourceCardKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvDestinateKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExitClick(Sender: TObject);
  private
     procedure Initialize;
     //*拆分布号相关过程函数
     procedure GetSplitFabricInfo;
     procedure SaveSplitFabricInfo;
     procedure SetEditText;
     procedure SetFabricButton(iType:integer);
     procedure ClearEditText;
     function checkFabricData:boolean;
     //*拆卡、组卡相关过程函数
     procedure GetUnionFNCardInfo;
     procedure MoveUpSingle;
     procedure MoveUpAll;
     procedure MoveDownSingle;
     procedure MoveDownAll;
     procedure MoveData(lv0: TListView; edt0: TEdit;
       lv2: TListView; edt2: TEdit; Index: Integer;
       Direction: TDirection; aAll: Boolean = False);
     procedure RefreshSplitCardList();
     procedure MoveExistFabric(cds:TClientDataSet);
     procedure SaveUnionFNCardInfo;
     function  CheckCardData(lv: TListView): Boolean;
  end;

var
  FabricCardForm: TFabricCardForm;

implementation

uses uShowMessage, ServerDllPub, uLogin, uGlobal;

{$R *.dfm}

procedure TFabricCardForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFabricCardForm.FormDestroy(Sender: TObject);
begin
 FabricCardForm:=nil;
end;

procedure TFabricCardForm.Initialize;
begin
  //设置BUTTON图片
  btnDown.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btnDownAll.Glyph.LoadFromResourceName(HInstance, RES_DOWNALL);
  btnQueryCard.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  btnQueryFabric.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  btnUp.Glyph.LoadFromResourceName(HInstance, RES_UP);
  btnUpAll.Glyph.LoadFromResourceName(HInstance, RES_UPALL);

  pgcSplitCardFabric.ActivePageIndex:=0;
  SetFabricButton(0);
  edtSplit_Quantity.Text := '0.0';
  edtSplit_Quantity.Enabled :=false;
  edtQuantity_FNCard.Text := '0.0';
  edtQuantity_Fabric.Text := '0.0';
  edtQuantity.Text := '0.0';
  SetWindowLong(edtSplit_Quantity.Handle,GWL_STYLE,GetWindowLong(edtSplit_Quantity.Handle,GWL_STYLE) or ES_NUMBER);

  lvSourceCard.Items.Clear;
  lvDestinate.Items.Clear;
end;

procedure TFabricCardForm.FormCreate(Sender: TObject);
begin
  Initialize;
end;

procedure TFabricCardForm.edtFabric_NOEnter(Sender: TObject);
begin
  btnQueryFabric.Default :=true;
end;

procedure TFabricCardForm.edtFabric_NOExit(Sender: TObject);
begin
  btnQueryFabric.Default:=false;
end;

procedure TFabricCardForm.edtFN_Card_LayerEnter(Sender: TObject);
begin
  btnQueryCard.Default:=true;
end;

procedure TFabricCardForm.edtFN_Card_LayerExit(Sender: TObject);
begin
  btnQueryCard.Default :=false;
end;

procedure TFabricCardForm.GetSplitFabricInfo;
var vData: OleVariant;
   sCondition,sFabric_NO, sErrorMsg: WideString;
begin
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
    sFabric_NO := Trim(edtFabric_NO.Text);
    sCondition := 'a.Fabric_NO = '+QuotedStr(sFabric_NO)+' AND a.Current_Department='+ QuotedStr(Login.CurrentDepartment);
    FNMServerObj.GetQueryData(vData,'GetSplitFabric',sCondition,sErrorMsg);
//    FNMServerObj.GetSplitFabricInfo(vData, sFabric_NO, Login.CurrentDepartment, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsPublic.Data := vData;
    SetEditText;
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TFabricCardForm.SetEditText;
begin
  with cdsPublic do
  begin
    if not Active or (RecordCount = 0) then
    begin
      TMsgDialog.ShowMsgDialog('请检查你输入布号', 2);
      edtFabric_NO.SelectAll;
      edtFabric_NO.SetFocus;
      Exit;
    end;
    edtFabric_NO.Enabled := False;
    edtQuantity.Text := FloatToStr(FieldByName('Quantity').AsFloat);
    edtSplit_Quantity.Text := '0.0';
    edtSplit_Quantity.Enabled :=true;
    edtCar_NO.Text := FieldByName('Car_NO').AsString;
    edtGF_ID.Text := IntToStr(FieldByName('GF_ID').AsInteger);
    edtGF_NO.Text := FieldByName('GF_NO').AsString;
    edtJob_NO.Text := FieldByName('Job_NO').AsString;
    edtPPO_NO.Text := FieldByName('PPO_NO').AsString;
    edtCustomer.Text := FieldByName('Customer').AsString;
    edtDelivery_Date.Text := FieldByName('Delivery_Date').AsString;
    edtSource.Text := FieldByName('Source').AsString;
    edtReceive_Date.Text := FieldByName('Receive_Date').AsString;
    edtWarpWeft_Density.Text := FieldByName('WarpWeft_Density').AsString;
    edtWarpWeft_Count.Text := FieldByName('WarpWeft_Count').AsString;
    edtFN_Card.Text := FieldByName('FN_Card').AsString;
    edtremark.Text := FieldByName('Remark').AsString;
    edtOld_Fabric_NO.Text := edtFabric_NO.Text;
    edtOld_Quantity.Text := edtQuantity.Text;
    SetFabricButton(1);
  end;
  edtSplit_Quantity.SetFocus;
end;

procedure TFabricCardForm.btnQueryFabricClick(Sender: TObject);
begin
   GetSplitFabricInfo;
end;

procedure TFabricCardForm.edtSplit_QuantityKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if not TGlobal.CheckValueIsNumeric(edtSplit_Quantity.Text) then Exit;
       edtOld_Quantity.Text := FloatToStr(StrToFloat(edtQuantity.Text) - StrToFloat(edtSplit_Quantity.Text));
       edtNew_Quantity.Text := edtSplit_Quantity.Text;
end;

function TFabricCardForm.checkFabricData: boolean;
begin
  Result := True;
  if not TGLobal.IsBetweenFixedValue(edtSplit_Quantity.Text ,0.01,strtofloat(edtQuantity.Text)-0.01) then
  begin
    TMsgDialog.ShowMsgDialog('请确认拆分出的数量在大于0小于'+edtQuantity.Text ,mtWarning);
    edtSplit_Quantity.SetFocus ;
    Result := False;
  end
end;

procedure TFabricCardForm.btnSaveFabricClick(Sender: TObject);
begin
  if checkFabricData then
    self.SaveSplitFabricInfo ;
end;

procedure TFabricCardForm.ClearEditText;
begin
    edtQuantity.Text := '0.0';
    edtSplit_Quantity.Text := '0.0';
    edtSplit_Quantity.Enabled :=false;
    edtCar_NO.Text := '';
    edtGF_ID.Text := '';
    edtGF_NO.Text := '';
    edtJob_NO.Text := '';
    edtPPO_NO.Text := '';
    edtCustomer.Text := '';
    edtDelivery_Date.Text := '';
    edtSource.Text := '';
    edtReceive_Date.Text := '';
    edtWarpWeft_Density.Text := '';
    edtWarpWeft_Count.Text := '';
    edtFN_Card.Text := '';
    edtremark.Text := '';
    edtOld_Fabric_NO.Text := '';
    edtOld_Quantity.Text := '';
    edtFabric_No.Text :='';
    edtNew_Fabric_NO.Text :='';
    edtFabric_No.Enabled :=true;
    edtFabric_No.SetFocus ;
end;

procedure TFabricCardForm.btnCancelFabricClick(Sender: TObject);
begin
  ClearEditText;
  SetFabricButton(0);
end;

procedure TFabricCardForm.SaveSplitFabricInfo;
var sFabric_NO: WideString;
 // dSplit_Quantity: Double;
  sCondition,sNew_Fabric_NO, sErrorMsg: WideString;
begin
    //变量赋值
    sFabric_NO := Trim(edtFabric_NO.Text);
  //  dSplit_Quantity := StrToFloat(edtSplit_Quantity.Text);
  try
    ShowMsg( '正在保存数据稍等！', crHourGlass);
   //保存分布信息
    sCondition := QuotedStr(sFabric_NO)+',' + QuotedStr(edtSplit_Quantity.Text)+','+ QuotedStr(Login.CurrentDepartment)+',' +
                 QuotedStr(Login.LoginName);
    FNMServerObj.SaveDataBySQLEx('SaveSplitFabric',sCondition,sNew_Fabric_NO,sErrorMsg);
//    FNMServerObj.SaveSplitFabricInfo(sFabric_NO, dSplit_Quantity, Login.CurrentDepartment,Login.LoginName, sNew_Fabric_NO, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    edtNew_Fabric_NO.Text := sNew_Fabric_NO;
    TMsgDialog.ShowMsgDialog('保存数据成功!', mtInformation);
    SetFabricButton(2);

  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TFabricCardForm.SetFabricButton(iType: integer);
begin
  if iType=0 then  //初始状态
  begin
    btnSaveFabric.Enabled :=false;
    btnCancelFabric.Enabled :=false;
    btnCancelFabric.Caption :='取消(&C)';
  end;

  if iType=1 then //调出布号信息
  begin
    btnSaveFabric.Enabled :=true;
    btnCancelFabric.Enabled :=true;
    btnCancelFabric.Caption :='取消(&C)';
  end;

  if iType=2 then //保存拆分信息后状态
  begin
    btnSaveFabric.Enabled :=false;
    btnCancelFabric.Enabled :=true;
    btnCancelFabric.Caption :='继续(&C)';
    btnCancelFabric.SetFocus ;
  end;
end;

procedure TFabricCardForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFabricCardForm.GetUnionFNCardInfo;
var vData: OleVariant;
  sCondition,sFNCard, sErrorMsg: WideString;
begin
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
    sFNCard := Trim(edtFN_Card_Layer.Text);
    //if lstFNCard.Items.IndexOf(sFNCard)<>-1 then Exit;
    sCondition := QuotedStr(sFNCard)+','+QuotedStr(Login.CurrentDepartment)+','+IntToStr(0);
    FNMServerObj.GetQueryData(vData,'GetUnionFNCard',sCondition,sErrorMsg);
  //  FNMServerObj.GetUnionFNCardInfo(vData, sFNCard, Login.CurrentDepartment, 0, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsPublic.Data := vData;
    if cdsPublic.RecordCount <=0 then
    Begin
      TMsgDialog.ShowMsgDialog('请检查输入的卡号是否有效，或是否是你部门的卡号！',mtwarning);
    end;
    MoveExistFabric(cdsPublic);
    TGlobal.FillItemsFromDataSet(cdsPublic,'Quantity',['Fabric_NO','Material_Quality','Quantity','Operation_CHN','Fact_Art_ID','GF_ID','GF_NO','Job_NO','FN_Card'],nil,edtQuantity_FNCard,lvSourceCard.Items);
    TGlobal.SetButtonState(btnDown, btnDownAll, btnUp, btnUpAll, lvSourceCard, lvDestinate);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TFabricCardForm.btnQueryCardClick(Sender: TObject);
begin
  GetUnionFNCardInfo;
  if lvSourceCard.Items.Count >0 then
    lvSourceCard.SetFocus ;
end;

procedure TFabricCardForm.btnDownClick(Sender: TObject);
begin
  MoveDownSingle;
end;

procedure TFabricCardForm.btnDownAllClick(Sender: TObject);
begin
  MoveDownAll;
end;

procedure TFabricCardForm.btnUpClick(Sender: TObject);
begin
  MoveUpSingle;
end;

procedure TFabricCardForm.btnUpAllClick(Sender: TObject);
begin
  MoveUpAll;
end;

procedure TFabricCardForm.MoveData(lv0: TListView; edt0: TEdit;
   lv2: TListView; edt2: TEdit; Index: Integer;
  Direction: TDirection; aAll: Boolean);
begin
  if Direction = dDown then
     TGlobal.MoveDataEx(lv0,lv2,index,nil,edt0,nil,edt2,aAll)
  else
     TGlobal.MoveDataEx(lv0,lv2,index,nil,edt0,nil,edt2,aAll);
  RefreshSplitCardList;
end;

procedure TFabricCardForm.lvSourceCardChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
   TGlobal.SetButtonState(btnDown, btnDownAll, btnUp, btnUpAll, lvSourceCard, lvDestinate);
end;

procedure TFabricCardForm.lvDestinateChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  TGlobal.SetButtonState(btnDown, btnDownAll, btnUp, btnUpAll, lvSourceCard, lvDestinate);
end;

procedure TFabricCardForm.MoveDownAll;
begin
  MoveData(lvSourceCard, edtQuantity_FNCard, lvDestinate, edtQuantity_Fabric, 1, dDown,True);
  TGlobal.SetButtonState(btnDown, btnDownAll, btnUp, btnUpAll, lvSourceCard, lvDestinate);
end;

procedure TFabricCardForm.MoveDownSingle;
begin
  MoveData(lvSourceCard, edtQuantity_FNCard,lvDestinate, edtQuantity_Fabric, 1, dDown);
  TGlobal.SetButtonState(btnDown, btnDownAll, btnUp, btnUpAll, lvSourceCard, lvDestinate);
end;

procedure TFabricCardForm.MoveUpAll;
begin
  MoveData(lvDestinate, edtQuantity_Fabric,lvSourceCard, edtQuantity_FNCard,1, dDown,true);
  TGlobal.SetButtonState(btnDown, btnDownAll, btnUp, btnUpAll, lvSourceCard, lvDestinate);
end;

procedure TFabricCardForm.MoveUpSingle;
begin
  MoveData(lvDestinate, edtQuantity_Fabric,lvSourceCard, edtQuantity_FNCard,1, dUp);
  TGlobal.SetButtonState(btnDown, btnDownAll, btnUp, btnUpAll, lvSourceCard, lvDestinate);
end;

procedure TFabricCardForm.lvSourceCardDblClick(Sender: TObject);
begin
  MoveDownSingle;
end;

procedure TFabricCardForm.lvDestinateDblClick(Sender: TObject);
begin
  MoveUpSingle;
end;

procedure TFabricCardForm.RefreshSplitCardList;
var i:integer;
  sTempCard:string;
begin
   lstFnCard.Items.Clear ;
   for i:=0 to lvDestinate.Items.Count -1 do
   begin
     sTempCard:=lvDestinate.Items[i].SubItems[7];
     if lstFnCard.Items.IndexOf(sTempCard)<0 then
       lstFnCard.Items.Add(sTempCard);
   end;
end;

procedure TFabricCardForm.MoveExistFabric(cds:TClientDataSet);
var j:integer;
  tempFabric:string;
  bDelete:Boolean;
begin
   cds.First;
   while not cds.eof   do
   begin
     tempFabric:=cds.fieldbyname('Fabric_No').AsString ;
     bDelete:=false;
     for j:=0 to lvDestinate.Items.Count -1 do
     begin
        if tempFabric=lvDestinate.items[j].Caption then
        begin
          cds.Delete;
          bDelete:=true;
          break;
        end;
     end;
     if not bDelete then cds.Next;
   end;
   cds.First;
end;

procedure TFabricCardForm.SaveUnionFNCardInfo;
var sFabric_NO_List, sFN_Card_Layer, sCar_NO: WideString;
  i, iType: Integer;
  sCondition,sNew_FN_Card_Layer, sErrorMsg: WideString;
begin
  if lvDestinate.Items.Count = 0 then Exit;
  if not CheckCardData(lvDestinate) then Exit;
  if edt_Reason.Text = '' then
  begin
    edt_Reason.SetFocus ;
    raise Exception.Create('WAR_请输入拆组卡原因.');
  end;

  if edtNew_FN_Card_Layer.Text ='' then
  begin
   if TMsgDialog.ShowMsgDialog('你没有输入组合卡号，确信需要产生一个新卡号吗？',mtConfirmation,[mebYes,mebNo],mebNo)=mrNo then
   begin
    edtNew_FN_Card_Layer.SetFocus ;
    exit;
   end;
  end else
  begin
    if lstFnCard.Items.IndexOf(edtNew_FN_Card_Layer.Text)>=0 then
    begin
      TMsgDialog.ShowMsgDialog('不能拆组同一个卡！',mtwarning);
      edtNew_FN_Card_Layer.SetFocus ;
      exit;
    end;
  end;

  try
    ShowMsg('正在保存数据稍等！', crHourGlass);

    iType := IfThen(LeftStr(lvDestinate.Items[0].SubItems[7], 1) = 'A', 0, 1);

    sFabric_NO_List := '';
    for i := 0 to lvDestinate.Items.Count - 1 do
      sFabric_NO_List := sFabric_NO_List + lvDestinate.Items[i].Caption + ',';
    sFabric_NO_List := LeftStr(sFabric_NO_List, Length(sFabric_NO_List) - 1);

    sFN_Card_Layer := Trim(edtNew_FN_Card_Layer.Text);
    sCar_NO := Trim(edtCar_NO.Text);
    //保存组卡信息
    sCondition := QuotedStr(sFabric_NO_List)+',' + QuotedStr(sFN_Card_Layer)+','+
                  QuotedStr(sCar_NO)+',' + IntToStr(iType)+','+
                  QuotedStr(edt_Reason.Text)+',' + QuotedStr(Login.CurrentDepartment)+','+
                  QuotedStr(Login.LoginName);
    FNMServerObj.SaveDataBySQLEx('SaveUnionFNCard',sCondition,sNew_FN_Card_Layer,sErrorMsg);
//    FNMServerObj.SaveUnionFNCardInfo(sFabric_NO_List, sFN_Card_Layer, sCar_NO, iType, edt_Reason.Text, Login.CurrentDepartment, Login.LoginName, sNew_FN_Card_Layer, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    edtNew_FN_Card_Layer.Text := sNew_FN_Card_Layer;

    lvDestinate.Items.Clear;
    lstFnCard.Items.Clear ;

    TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('', crDefault);
  end;
end;

function TFabricCardForm.CheckCardData(lv: TListView): Boolean;
var i, iFACT_Art_ID: Integer;
  Material_Quality,Job_NO,FN_Card_Type,Operation_CHN: string;
begin
  Result := True;
  iFACT_Art_ID := StrToInt(lv.Items[0].SubItems[3]);
  Job_NO := lv.Items[0].SubItems[6];
  FN_Card_Type := LeftStr(lv.Items[0].SubItems[7], 1);
  Operation_CHN := lv.Items[0].SubItems[2];
  Material_Quality:=lv.Items[0].SubItems[0];
  for i := 1 to lvDestinate.Items.Count - 1 do
      if
       (Material_Quality<>lv.Items[i].SubItems[0]) or
       (iFACT_Art_ID <> StrToInt(lv.Items[i].SubItems[3])) or
       (Job_NO<>lv.Items[i].SubItems[6]) or
       (FN_Card_Type <> LeftStr(lv.Items[i].SubItems[7], 1)) or
       (Operation_CHN <> lv.Items[i].SubItems[2]) then
    begin
      Result := False;
      TMsgDialog.ShowMsgDialog(
        '正常布与处理布不能放在一张卡上'+char(13)+
        '正常卡和回修卡不能组合到同一张卡上' + char(13) +
        '排单不同不能打印在同一张卡上' +char(13)+
        '工艺不同不能打印在同一张卡上' + char(13) +
        '工序不同不能打印在同一张卡上' + char(13) + '请检查', mtWarning);
      Exit;
    end;  
end;

procedure TFabricCardForm.btnSaveCardClick(Sender: TObject);
begin
  SaveUnionFNCardInfo
end;

procedure TFabricCardForm.lvSourceCardKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    MoveDownSingle;
  end;
end;

procedure TFabricCardForm.lvDestinateKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    MoveUpSingle;
  end;
end;

procedure TFabricCardForm.btnExitClick(Sender: TObject);
begin
  Close;
end;

end.

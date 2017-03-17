unit frmArtControl;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmArtControl.pas                                             }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 lvzd                                                          }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  工艺DIP控制                                                  }
{                                                                              }
{******************************************************************************}

interface

uses
  uFNMArtInfo, Dialogs,
  Windows, Messages, Classes, ComCtrls, Forms, DB, DBClient, StdCtrls,
  Grids, ValEdit, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Controls, ExtCtrls, Buttons, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, cxSplitter, DBGrids,
  cxContainer, cxTextEdit, cxMemo,Graphics;

type
  TArtControlForm = class(TForm)
    cds_OnLineCardList: TClientDataSet;
    ds_OnLineCardList: TDataSource;
    btn3: TSpeedButton;
    btn_Exit: TSpeedButton;
    cxgrid_OnLineCard: TcxGrid;
    cxgridtv_OnLineCard: TcxGridDBTableView;
    cxGridl_OnLineCard: TcxGridLevel;
    pnl_Only: TPanel;
    btn_Save: TSpeedButton;
    grp_Only: TGroupBox;
    lv_DipCard: TListView;
    btn_AddCard: TSpeedButton;
    btn_RemoveCard: TSpeedButton;
    btn_RefreshCard: TSpeedButton;
    cbb_DipPoint: TComboBox;
    pnl_Only2: TPanel;
    cds_FactArtDtl: TClientDataSet;
    ds_FactArtDtl: TDataSource;
    cxGridl_FactArtDtl: TcxGridLevel;
    cxgridtv_FactArtDtl: TcxGridDBTableView;
    cxspl1: TcxSplitter;
    pnl_Only3: TPanel;
    sbModifyWidth: TSpeedButton;
    cbRoll: TCheckBox;
    edtWhite: TEdit;
    edtOneMinute: TEdit;
    lbWhite: TLabel;
    lbOneMinute: TLabel;
    lbControl: TStaticText;
    mmoHint: TMemo;
    cdsCheckCarRollNO: TClientDataSet;
    cbNoWait: TCheckBox;
    cdsPDAs: TClientDataSet;
    dsPDA: TDataSource;
    pnl1: TPanel;
    cxspltrleft: TcxSplitter;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cdsTemp: TClientDataSet;
    edtInfo: TcxMemo;
    pnl2: TPanel;
    txt1: TStaticText;
    edt_GFKeyValue: TEdit;
    edt_Customer: TEdit;
    edt_Grey_Width: TEdit;
    edt_Width: TEdit;
    edt_GreyDensity: TEdit;
    edt_Density: TEdit;
    edt_Anti_Fluorescence: TEdit;
    edt_BR: TEdit;
    pnlColor: TPanel;
    btnTempHold: TSpeedButton;
    cbbColorHoldInfo: TComboBox;
    rb1: TRadioButton;
    rb2: TRadioButton;
    cds1: TClientDataSet;
    cds2: TClientDataSet;
    mmo_Remark: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Add_ReMove_RefreshCard(Sender: TObject);
    procedure btn_SaveDipClick(Sender: TObject);
    procedure KeyDownAControl(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_ShowArtClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbb_DipPointSelect(Sender: TObject);
    procedure cxgridtv_OnLineCardCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure sbModifyWidthClick(Sender: TObject);
    procedure cds_OnLineCardListAfterScroll(DataSet: TDataSet);
    procedure lv_DipCardClick(Sender: TObject);
    procedure cbRollClick(Sender: TObject);
    function SaveArtPara(sFNCard:String):Boolean;
    function CheckCarRollNO(FNCard:String):Boolean;
    procedure btnTempHoldClick(Sender: TObject);
    procedure GetPDAInfo();
    procedure cxgridtv_OnLineCardMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure cxgridtv_OnLineCardFocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
  private
    { Private declarations }
    Cur_GF_NO,cbb_DipPoint1: string;
    procedure RefreshFNCardList;
    {* 刷新卡号列表}
    procedure SaveDipCard;
    {* DIP Card}
    procedure OpenFactArt(GFID, FactArtID: Integer);
    procedure OpenFactArt2(GFID,FactArtID: Integer;FactRemark:string);
    //数据节点被展开
    procedure DetailExpanding(ADataController: TcxCustomDataController; ARecordIndex: Integer; var AAllow: Boolean);

    //显示 C-DIP界面增加显示,以FG/FA当前进入系统内，右上角显示每台机的待加工总量　上机和待上机
    procedure doShowMachineQuantityInfo(Operation_Code: String);
  protected
    procedure UpdateActions;override;
  public
    { Public declarations }
  end;

var
  ArtControlForm: TArtControlForm;

implementation

uses SysUtils, StrUtils, Variants, cxGridDBDataDefinitions, uDictionary, UAppOption,
    uFNMResource, ServerDllPub, uShowMessage, uLogin, uGlobal,
    UGridDecorator, uCADInfo, frmInput, frmCheckArt;

{$R *.dfm}

procedure TArtControlForm.UpdateActions;
var isVisible : Boolean;
begin
  inherited;
  // mmoHint.Visible := (mmoHint.Lines.Text) <> '';
   //mmoHint.Visible :=  False;
  isVisible := (LeftStr(cbb_DipPoint.Text, 3) = '015') and
               (lv_DipCard.Items.Count > 0) and
               (pos('PD',lv_DipCard.Items[0].SubItems[1])>0);
  lbWhite.Visible := isVisible;
  edtWhite.Visible := isVisible;
  lbOneMinute.Visible := isVisible;
  edtOneMinute.Visible := isVisible;
end;

procedure TArtControlForm.RefreshFNCardList;
var
  Operation_Code: String;
begin
  if cbb_DipPoint.ItemIndex = -1 then exit;

  Operation_Code:=LeftStr(cbb_DipPoint.text, Pos('-', cbb_DipPoint.text) -1);
  GetOnLineCardByOperation(Operation_Code, Login.CurrentDepartment, cds_OnLineCardList);

  cds_OnLineCardList.Filter:='NOT FN_Card LIKE ''N%''';
  cds_OnLineCardList.Filtered:=Operation_Code = '999';
  if cds_OnLineCardList.RecordCount = 0 then exit;
  GridDecorator.BindCxViewWithDataSource(cxgridtv_OnLineCard, ds_OnLineCardList);
  //on 2014-10-28 add by vinson for 预缩机需求
  cxgridtv_OnLineCard.GetColumnByFieldName('Car_NO').Caption := '车/卷号';

  btn_AddCard.Enabled:=cxgridtv_OnLineCard.DataController.DataSet.RecordCount <> 0;

  //add by vinson
  doShowMachineQuantityInfo(Operation_Code);
end;

procedure TArtControlForm.SaveDipCard;
var
  i: Integer;
  sCondition,sErrorMsg: WideString;
  SelectCardList,RollInfoList,White,One_Minute,Is_NoWait: string;
  NeedRoll: WideString;
  sSQL,sSQL1,sSQL2,sErrMsg: WideString;
  vData,vData1,vData2:OleVariant;
  n:word;
  remark:string;
begin
  //构造选中卡的列表,注意不要去掉字符窜最后的一个逗号
  SelectCardList:='';
  RollInfoList :='';
  if  LeftStr(cbb_DipPoint.Text, 3) ='999'  then
  begin
   for i := 0 to lv_DipCard.Items.Count - 1 do
      begin
        sSQL:=' exec usp_Samplingdo '+QuotedStr(lv_DipCard.Items[i].Caption)+','+''''''+','+'4';
        FNMServerObj.GetQueryBySQL(vData, sSQL,sErrMsg);
        if sErrMsg <> '' then
        Raise Exception.Create(sErrMsg);
        cds2.Data:= vData;
        if cds2.RecordCount=0 then
        begin
           remark:=lv_DipCard.Items[i].Caption+'该卡999的前一工序取样0.3码？';
           n:=messagedlg(remark,mtconfirmation,[mbyes,mbno],1);
          if n=mryes
             then
              begin
                 sSQL1:=' exec usp_Samplingdo '+QuotedStr(lv_DipCard.Items[i].Caption)+','+''''''+','+'5';
                 FNMServerObj.GetQueryBySQL(vData1, sSQL1,sErrMsg);
                  if sErrMsg <> '' then
                     Raise Exception.Create(sErrMsg);
                  end

          else
              begin
                sSQL2:=' exec usp_Samplingdo '+QuotedStr(lv_DipCard.Items[i].Caption)+','+''''''+','+'6';
                FNMServerObj.GetQueryBySQL(vData2, sSQL2,sErrMsg);
                if sErrMsg <> '' then
                  Raise Exception.Create(sErrMsg);
              end;
        end;
      end;
  end;
  //Exit;
  for i := 0 to lv_DipCard.Items.Count - 1 do
  begin
    SelectCardList:=SelectCardList + lv_DipCard.Items[i].Caption + ',';
    if LeftStr(cbb_DipPoint.Text, 3) ='007' then   //预缩复版
      RollInfoList := RollInfoList + lv_DipCard.Items[i].SubItems[0] + ',';
    if (LeftStr(cbb_DipPoint.Text, 3) ='999') and  lv_DipCard.Items[i].Checked then //送布确认
      RollInfoList := RollInfoList + lv_DipCard.Items[i].Caption + ',';
  end;
  System.Delete(SelectCardList,Length(SelectCardList),1);
  System.Delete(RollInfoList,Length(RollInfoList),1);

  //预缩复版
  if LeftStr(cbb_DipPoint.Text, 3) ='007' then
  begin
  {
    //2011-9-29 取消卷装提示
    FNMServerArtObj.CheckNeedRoll(RollInfoList,NeedRoll,sErrorMsg);
    if sErrorMsg <> '' then
     raise ExceptionEx.CreateResFmt(@ERR_SaveDipInfo, [sErrorMsg]);

    if NeedRoll = 'Y' then
      if TMsgDialog.ShowMsgDialog('是否需要卷装？',mtConfirmation,[mebYes,mebNo],mebYes)=mrNO then
          RollInfoList := '';
  }
    RollInfoList := '';
  end;

  //
  //DIP Card
  White := '';
  One_Minute := '';
  if LeftStr(cbb_DipPoint.Text, 3) = '015' then //丝光复版
  begin
    White := Trim(edtWhite.Text);
    One_Minute := Trim(edtOneMinute.Text);
  end;

  //2011-9-16
  if not SaveArtPara(RollInfoList) then Exit;

  //2012-7-20 加 是否不等测试卷布
  Is_NoWait := '1';
  if cbNoWait.Checked then
  begin
    Is_NoWait := '0';
    cbNoWait.Checked := False;
  end;
  sCondition := QuotedStr(LeftStr(cbb_DipPoint.Text, 3))+ ','+ QuotedStr(SelectCardList)+','+
                QuotedStr(RollInfoList)+','+QuotedStr(White)+','+ QuotedStr(One_Minute)+','+QuotedStr(Login.LoginName)+','+Is_NoWait;
  FNMServerObj.SaveDataBySQL('SetDipOperation',sCondition,sErrorMsg);
//  FNMServerArtObj.SaveDipCardList(LeftStr(cbb_DipPoint.Text, 3), SelectCardList, RollInfoList,Login.LoginName, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveDipInfo, [sErrorMsg]);
  lv_DipCard.Items.Clear;
  with cds_OnLineCardList do
  try
    DisableControls;
    First;
    for I := RecordCount - 1 downto 0 do
    begin
      if pos(cds_OnLineCardList['FN_Card'], SelectCardList) <> 0 then
        Delete
      else
        Next;
    end;

    raise Exception.CreateRes(@MSG_SaveArtControlSuccess);
  finally
    MergeChangeLog;
    EnableControls;
    CheckBrowseMode;
  end;
end;

procedure TArtControlForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TArtControlForm.FormDestroy(Sender: TObject);
begin
  ArtControlForm:=nil;
end;

procedure TArtControlForm.DetailExpanding(ADataController: TcxCustomDataController; ARecordIndex: Integer; var AAllow: Boolean);
var
  FactArtID, GFID,FactRemark: Variant;
begin
  with ADataController as TcxGridDBDataController do
  begin
    FocusedRecordIndex:=ARecordIndex;
    FactArtID:=Values[ARecordIndex, GetItemByFieldName('Fact_Art_ID').Index];
    GFID:=Values[ARecordIndex, GetItemByFieldName('GF_ID').Index];
    FactRemark:=Values[ARecordIndex, GetItemByFieldName('Remark').Index];
    OpenFactArt2(GFID, FactArtID,FactRemark)
  end;
end;

procedure TArtControlForm.FormCreate(Sender: TObject);
begin
  //加载图标
  btn_Save.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btn_Exit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  btn_AddCard.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btn_RemoveCard.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  btn_RefreshCard.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  //展开工艺
  cxgridtv_OnLineCard.DataController.OnDetailExpanding:=DetailExpanding;
  //布置界面
  Cur_GF_NO := '';
  btn_Save.Enabled:=false;
  btn_AddCard.Enabled:=false;
  btn_RemoveCard.Enabled:=false;
  cxspltrleft.CloseSplitter;
end;

procedure TArtControlForm.Add_ReMove_RefreshCard(Sender: TObject);
var
  i,j: Integer;
  sOperateType, sFNCard, sFN_Card, sFactArtID, sNewFactArtID,sGFNO,sNewGFNO,PPO_Type,Big_Weft,sNewStep:String;
  sOldGFNO,sOldStep:string;
begin
  if sender = btn_AddCard then
  with cxgridtv_OnLineCard do
  begin
    sFactArtID := '';
    sFNCard := '';
    sGFNO:= '';
    if lv_DipCard.Items.Count>0 then
    begin
      sFactArtID := lv_DipCard.Items[0].SubItems[2];
      sGFNO:=lv_DipCard.Items[0].SubItems[1];
    end;

    sOperateType := LeftStr(cbb_DipPoint.Text, 3);

    if (sOperateType= '007') or (sOperateType= '999') or (sOperateType= '022') then
    begin
      for i := 0 to Controller.SelectedRowCount - 1 do
      begin
        //请帮忙在S-DIP/C-DIP和送布确认时对于符合以下条件的品种弹出提示框,提示语句"纬向大花型,缩水按偏0控制,门幅不可过宽或过窄"
        Big_Weft := Controller.SelectedRows[i].Values[GetColumnByFieldName('weft_big').Index];
        if (Big_Weft = '1') then
        begin
          TMsgDialog.ShowMsgDialog('纬向大花型,缩水按偏0控制,门幅不可过宽或过窄！',mtWarning);
        end;
      end;
    end;

    if (sOperateType= '007') or (sOperateType= '999') then    //or (sOperateType= '022')
    begin
      for i := 0 to Controller.SelectedRowCount - 1 do
      begin
        sFN_Card := Controller.SelectedRows[i].Values[GetColumnByFieldName('FN_Card').Index];
        sNewFactArtID := Controller.SelectedRows[i].Values[GetColumnByFieldName('FACT_Art_ID').Index];
        sNewGFNO:=Controller.SelectedRows[i].Values[GetColumnByFieldName('GF_NO').Index];
        PPO_Type:=Controller.SelectedRows[i].Values[GetColumnByFieldName('PPO_TYPE').Index];

        for j:=0 to lv_DipCard.Items.Count -1 do
        begin
          if PPO_Type <> lv_DipCard.Items[j].SubItems[6] then
          begin
            TMsgDialog.ShowMsgDialog('不同PPO_TYPE不能一起DIP！',mtInformation);
            Exit;
          end;
        end;
        //if (sNewFactArtID<>sFactArtID) and (sFactArtID<>'')then
        if lv_DipCard.Items.Count>0 then
        begin
          if (sNewGFNO<>sGFNO) and (sFactArtID<>'')then
          begin
              if (PPO_Type <> '式样') and (LeftStr(sFN_Card,1) <> 'F') then
              begin
                TMsgDialog.ShowMsgDialog('品名不同、只有式样或返工布才能一起DIP！',mtInformation);
                Exit;
              end;
          end;
        end;
        sFactArtID := sNewFactArtID;
        sFNCard:= sFNCard+sFN_Card+'+';
      end;
      //如若前工序不为同一卷号或车号,但选择"机台"不一致时,不能保存.并提示"前工序不为同一卷号或车号"
      //if (sFNCard<>sFN_Card+'+') and (sOperateType<> '999') then
      if (sFNCard<>sFN_Card+'+') then
      begin
        if not CheckCarRollNO(sFNCard) then
          Exit;
      end
    end;

    //定型工序同一品名相同加工工序 可一起DIP
    if (sOperateType= '022') then
    begin
      for i := 0 to Controller.SelectedRowCount - 1 do
      begin
        sNewGFNO:=Controller.SelectedRows[i].Values[GetColumnByFieldName('GF_NO').Index];
        sNewStep:=Controller.SelectedRows[i].Values[GetColumnByFieldName('Step_NO').Index];
        if (sOldGFNO <> '') and (sOldStep <> '') then
        begin
          if (sOldGFNO <> sNewGFNO) or (sOldStep <> sNewStep) then
          begin
            TMsgDialog.ShowMsgDialog('不同品名不同步骤，不能一起DIP！',mtInformation);
            Exit;
          end;
        end;

        for j:=0 to lv_DipCard.Items.Count -1 do
        begin
          if (sNewGFNO <> sGFNO) or (sNewStep <> lv_DipCard.Items[0].SubItems[3]) then
          begin
            TMsgDialog.ShowMsgDialog('不同品名不同步骤，不能一起DIP！',mtInformation);
            Exit;
          end;
        end;
        sOldGFNO := sNewGFNO;
        sOldStep := sNewStep;
      end;
    end;

    for i := 0 to Controller.SelectedRowCount - 1 do
    begin
      with lv_DipCard.Items.Add do
      begin
        if LeftStr(cbb_DipPoint.Text, 3) ='999' then
          Checked := Controller.SelectedRows[i].Values[GetColumnByFieldName('Roll').Index] = '卷';
        Caption := Controller.SelectedRows[i].Values[GetColumnByFieldName('FN_Card').Index];
        SubItems.Add(Controller.SelectedRows[i].Values[GetColumnByFieldName('GF_ID').Index]);
        SubItems.Add(Controller.SelectedRows[i].Values[GetColumnByFieldName('GF_NO').Index]);
        SubItems.Add(Controller.SelectedRows[i].Values[GetColumnByFieldName('FACT_Art_ID').Index]);
        SubItems.Add(Controller.SelectedRows[i].Values[GetColumnByFieldName('Step_NO').Index]);
        SubItems.Add(Controller.SelectedRows[i].Values[GetColumnByFieldName('Quantity').Index]);
        SubItems.Add(Controller.SelectedRows[i].Values[GetColumnByFieldName('Next_Operation').Index]);
        SubItems.Add(Controller.SelectedRows[i].Values[GetColumnByFieldName('PPO_TYPE').Index]);
      end;

    end;
    DataController.ClearSelection;
  end;
  if sender = btn_RemoveCard then
    lv_DipCard.DeleteSelected;

  if sender = btn_RefreshCard then
    RefreshFNCardList;

  btn_Save.Enabled:=lv_DipCard.Items.Count <> 0;
  btn_RemoveCard.Enabled:=lv_DipCard.Items.Count <> 0;
end;

procedure TArtControlForm.btn_SaveDipClick(Sender: TObject);
begin
  if lv_DipCard.Items.Count = 0 then exit;

  SaveDipCard;
end;

procedure TArtControlForm.KeyDownAControl(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Sender = Self then
  case Key of
    VK_F5: btn_RefreshCard.Click;
  end;

  if Sender = cbb_DipPoint then
  case Key of
    VK_RETURN: btn_RefreshCard.Click;
  end;
end;

procedure TArtControlForm.btn_ShowArtClick(Sender: TObject);
begin
  btn_Save.Enabled:=true;
end;

procedure DataSetApplyBestFit(DataSet: TDataSet; FieldName: String = '');
  procedure SetFieldBestFitWidth(Field: TField);
  var
    i: Integer;
    TmpDisplayText, MaxLenDispLayText: String;
  begin
    DataSet.First;
    MaxLenDispLayText:=Field.DisplayLabel;
    for i := 0 to DataSet.RecordCount- 1 do
    begin
      TmpDisplayText:=Field.DisplayText;
      if Length(MaxLenDispLayText) < Length(TmpDisplayText) then
        MaxLenDispLayText:=TmpDisplayText;
      DataSet.Next;
    end;
    Field.DisplayWidth:=Length(MaxLenDispLayText);
  end;
var
  i: Integer;
  CurBookMark: String;
begin
  DataSet.DisableControls;
  try
    CurBookMark:=DataSet.Bookmark;
    if FieldName = '' then
    begin
      for i := 0 to DataSet.FieldCount - 1 do
        SetFieldBestFitWidth(DataSet.Fields[i]);
    end
    else
      SetFieldBestFitWidth(DataSet.FieldByName(FieldName));
  finally
    DataSet.Bookmark:=CurBookMark;
    DataSet.EnableControls;
  end; 
end;

procedure TArtControlForm.OpenFactArt(GFID, FactArtID: Integer);
  procedure MergeSameDataSet(FirstDataSet, SendDataSet: TDataSet);
  var
    i, j: Integer;
  begin
    if FirstDataSet.FieldCount <> SendDataSet.FieldCount then
      raise Exception.Create('数据不能匹配!');

    for i := 0 to FirstDataSet.FieldCount - 1 do    
      FirstDataSet.Fields.Fields[i].ReadOnly:=false;

    SendDataSet.First;
    for i := 0 to SendDataSet.RecordCount - 1 do
    begin
      FirstDataSet.Append;
      for j := 0 to SendDataSet.FieldCount - 1 do
      begin
        FirstDataSet.Edit;
        FirstDataSet.Fields.Fields[j].Value:=SendDataSet.Fields.Fields[j].Value;
      end;
      SendDataSet.Next;
    end;    
  end;
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  //取工艺明细
  if (not cds_FactArtDtl.Active) or (not cds_FactArtDtl.Locate('Fact_Art_ID', FactArtID, [])) then
  begin
    FNMServerArtObj.GetFactArtDtl(FactArtID, vData, sErrorMsg);
    if sErrorMsg <> '' then
      raise ExceptionEx.CreateResFmt(@ERR_GetFactArtDtl, [sErrorMsg]);
    if not cds_FactArtDtl.Active then
    begin
      cds_FactArtDtl.Data:=vData;
      GridDecorator.BindCxViewWithDataSource(cxgridtv_FactArtDtl, ds_FactArtDtl);
      cxgridtv_FactArtDtl.GetColumnByFieldName('Fact_Art_ID').Visible:=false;
    end
    else
    begin
      TempClientDataSet.Data:=vData;
      MergeSameDataSet(cds_FactArtDtl, TempClientDataSet);
    end;
    DataSetApplyBestFit(cds_FactArtDtl);
  end;

  //显示CAD信息
  CADInfo.OrgGFKeyValue:=IntToStr(GFID);
  with CADInfo do
  begin
    edt_Width.Text:=Width;
    edt_BR.Text:=BRUnitUsage;
    edt_Density.Text:=Density;
    edt_GFKeyValue.Text:=GF_NO;
    edt_Grey_Width.Text:=GreyWidth;
    edt_Customer.Text:=Customer_Code;
    edt_GreyDensity.Text:=GreyDensity;
    edt_Anti_Fluorescence.Text:=FluorescencePercent;
  end;
  //显示花型控件
  AutoShowCADPicture(CADInfo.OrgGFKeyValue);
end;

procedure TArtControlForm.OpenFactArt2(GFID,FactArtID: Integer;FactRemark:string);
  procedure MergeSameDataSet(FirstDataSet, SendDataSet: TDataSet);
  var
    i, j: Integer;
  begin
    if FirstDataSet.FieldCount <> SendDataSet.FieldCount then
      raise Exception.Create('数据不能匹配!');

    for i := 0 to FirstDataSet.FieldCount - 1 do    
      FirstDataSet.Fields.Fields[i].ReadOnly:=false;

    SendDataSet.First;
    for i := 0 to SendDataSet.RecordCount - 1 do
    begin
      FirstDataSet.Append;
      for j := 0 to SendDataSet.FieldCount - 1 do
      begin
        FirstDataSet.Edit;
        FirstDataSet.Fields.Fields[j].Value:=SendDataSet.Fields.Fields[j].Value;
      end;
      SendDataSet.Next;
    end;    
  end;
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  //取工艺明细
  if (not cds_FactArtDtl.Active) or (not cds_FactArtDtl.Locate('Fact_Art_ID', FactArtID, [])) then
  begin
    FNMServerArtObj.GetFactArtDtl(FactArtID, vData, sErrorMsg);
    if sErrorMsg <> '' then
      raise ExceptionEx.CreateResFmt(@ERR_GetFactArtDtl, [sErrorMsg]);
    if not cds_FactArtDtl.Active then
    begin
      cds_FactArtDtl.Data:=vData;
      GridDecorator.BindCxViewWithDataSource(cxgridtv_FactArtDtl, ds_FactArtDtl);
      cxgridtv_FactArtDtl.GetColumnByFieldName('Fact_Art_ID').Visible:=false;
    end
    else
    begin
      TempClientDataSet.Data:=vData;
      MergeSameDataSet(cds_FactArtDtl, TempClientDataSet);
    end;
    DataSetApplyBestFit(cds_FactArtDtl);
  end;

  //显示CAD信息
  CADInfo.OrgGFKeyValue:=IntToStr(GFID);
  with CADInfo do
  begin
    edt_Width.Text:=Width;
    edt_BR.Text:=BRUnitUsage;
    edt_Density.Text:=Density;
    edt_GFKeyValue.Text:=GF_NO;
    edt_Grey_Width.Text:=GreyWidth;
    edt_Customer.Text:=Customer_Code;
    edt_GreyDensity.Text:=GreyDensity;
    edt_Anti_Fluorescence.Text:=FluorescencePercent;
  end;
  //显示花型控件
  AutoShowCADPicture(CADInfo.OrgGFKeyValue);

  //显示用户新增的要求（测试方法，水洗方式，交地，强力标准）
  if(FactRemark<>'') then
  begin
        mmo_Remark.Text:='测试方法:'+CADInfo.Shrinkage+#13#10+FactRemark;
  end;
end;

procedure TArtControlForm.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TArtControlForm.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
  //刷新界面数据
  PostMessage(Handle, WM_KEYDOWN, VK_F5, 0);
  //加载DIP工序
  with Dictionary.cds_OperationHdrList do
  try
    Filter:='Operation_Type = ''Art_Dip''';
    Filtered:=true;
    FillItemsFromDataSet(Dictionary.cds_OperationHdrList, 'Operation_Code', 'Operation_CHN', '','-', cbb_DipPoint.Items);
  finally
    Filtered:=false;
  end;
  cbb_DipPoint.DropDownCount := cbb_DipPoint.Items.Count;
  OnActivate:=nil;
end;

procedure TArtControlForm.cbb_DipPointSelect(Sender: TObject);
begin
  if cds_OnLineCardList.Active then
    cds_OnLineCardList.Close;
  lv_DipCard.Items.Clear;
  cbb_DipPoint1:=cbb_DipPoint.Text;
  lv_DipCard.Checkboxes := Pos('999',cbb_DipPoint.Text) > 0;
  cbRoll.Visible := lv_DipCard.Checkboxes;
  cbNoWait.Visible := lv_DipCard.Checkboxes;
  sbModifyWidth.Visible := lv_DipCard.Checkboxes;
  {if (Pos('091',cbb_DipPoint.Text) > 0 ) or (Pos('009',cbb_DipPoint.Text) > 0 ) or
     (Pos('022',cbb_DipPoint.Text) > 0 ) or (Pos('058',cbb_DipPoint.Text) > 0 ) or
     (Pos('112',cbb_DipPoint.Text) > 0 ) or (Pos('072',cbb_DipPoint.Text) > 0 ) or
     (Pos('050',cbb_DipPoint.Text) > 0 ) or (Pos('005',cbb_DipPoint.Text) > 0 ) or
     (Pos('999',cbb_DipPoint.Text) > 0 ) or (Pos('007',cbb_DipPoint.Text) > 0 ) or
     (Pos('113',cbb_DipPoint.Text) > 0 )
    then  begin
               rb1.Visible:=True;
               rb1.Font.Color:=clRed;
               rb2.Visible:=True;
           end
     else
     begin
       rb1.Visible:=False;
       rb2.Visible:=False;
     end; }
  Cur_GF_NO := '';

  //add by vinson
  doShowMachineQuantityInfo('');
end;

procedure TArtControlForm.cxgridtv_OnLineCardCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.Focused then Exit;
  GridDecorator.CustomerDraw(Sender, ACanvas, AViewInfo, False);
end;

procedure TArtControlForm.sbModifyWidthClick(Sender: TObject);
begin
  if ModifyProductWidth(Cur_GF_NO) then
    TMsgDialog.ShowMsgDialog('修改门幅成功',mtInformation)
end;

procedure TArtControlForm.cds_OnLineCardListAfterScroll(DataSet: TDataSet);
begin
  Cur_GF_NO := DataSet.FieldByName('GF_NO').AsString;
  mmoHint.Lines.Text := DataSet.FieldByName('Hint').AsString;
end;

procedure TArtControlForm.lv_DipCardClick(Sender: TObject);
begin
  if lv_DipCard.ItemIndex = -1 then Exit;
  Cur_GF_NO := lv_DipCard.Items[lv_DipCard.ItemIndex].SubItems[1];
end;

procedure TArtControlForm.cbRollClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0  to lv_DipCard.Items.Count - 1 do
    lv_DipCard.Items[i].Checked := cbRoll.Checked;
end;

function TArtControlForm.SaveArtPara(sFNCard:String): Boolean;
var
  i,j: Integer;
  sNextOperation, sOperateType, sFN_Card, sFactArtID,sGFNO:String;
begin
  Result := False;
  if lv_DipCard.Items.Count=0 then Exit;
  sOperateType := LeftStr(cbb_DipPoint.Text, 3);
  sGFNO := lv_DipCard.Items[0].SubItems[1];

  //多个实际工艺ID一起DIP ，重复的不取
  for j:=0 to lv_DipCard.Items.Count - 1 do
  begin
    //品名
    if Pos(lv_DipCard.Items[j].SubItems[1],sGFNO) = 0 then
    begin
      if sGFNO = '' then
        sGFNO := lv_DipCard.Items[j].SubItems[1]
      else
        sGFNO := sGFNO + ',' + lv_DipCard.Items[j].SubItems[1];
    end;
    //实际工艺ID
    if Pos(lv_DipCard.Items[j].SubItems[2],sFactArtID) = 0 then
    begin
      if sFactArtID = '' then
        sFactArtID := lv_DipCard.Items[j].SubItems[2]
      else
        sFactArtID := sFactArtID + ',' + lv_DipCard.Items[j].SubItems[2];
    end;
    //卡号
    if Pos(lv_DipCard.Items[j].Caption,sFN_Card) = 0 then
    begin
      if sFN_Card = '' then
        sFN_Card:= lv_DipCard.Items[j].Caption
      else
        sFN_Card := sFN_Card + ',' + lv_DipCard.Items[j].Caption;
    end;
  end;
  //送布时不同品名不弹参数窗口
  if ((sOperateType= '007') or (sOperateType= '022')) or ((sOperateType= '999' ) and (Pos(',',sGFNO) = 0)) then //or (sOperateType= '022') then
  begin
    //2011-11-4预缩只针对008
    sNextOperation := lv_DipCard.Items[0].SubItems[5];
    if (sOperateType= '007') and (sNextOperation<>'008') then
    begin
      Result := True;
      Exit;
    end;

    //弹出确认界面
    if not Assigned(CheckArtForm) then
      CheckArtForm:= TCheckArtForm.Create(Self);

//    if (sOperateType= '999') then
//      sFN_Card := sFNCard;

    CheckArtForm.SetInitializeParam(sOperateType, '1', sFN_Card, sFactArtID,sGFNO);
    //多个品名时才检查，防止重复检查
    if Pos(',',sGFNO) <> 0 then
    begin
      if not CheckArtForm.DataQuery('') then Exit;
    end;
    //不OK退出
    if CheckArtForm.ShowModal<> mrOK then
      Exit;
  end;
  Result := True;
end;

function TArtControlForm.CheckCarRollNO(FNCard: String): Boolean;
var
  vData: OleVariant;
  sSQL, sErrMsg: WideString;
begin
  Result := True;
  if FNCard= '' then Exit;
  sSQL := QuotedStr(FNCard);
  FNMServerObj.GetQueryData(vData,'CheckCarRollNO',sSQL,sErrMsg);
  if sErrMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg,mtWarning);
    Result := False;
    Exit;
  end;
  cdsCheckCarRollNO.Data := vData;
  if cdsCheckCarRollNO.FieldByName('Result').AsString<>'OK' then
  begin
    TMsgDialog.ShowMsgDialog(cdsCheckCarRollNO.FieldByName('Result').AsString,mtWarning);
    Result := False;
    Exit;
  end;
end;

procedure TArtControlForm.btnTempHoldClick(Sender: TObject);
var
  i:Integer;
  vData: OleVariant;
  sSQL, sErrMsg: WideString;
  sFnCard:string;
begin
  if cxgridtv_OnLineCard.Controller.SelectedRowCount <= 0 then exit;
  if cbbColorHoldInfo.Text = '' then
  begin
     TMsgDialog.ShowMsgDialog('请选择Hold信息！',mtWarning);
     Exit;
  end;

  with cxgridtv_OnLineCard do
  begin
     for i:=0 to Controller.SelectedRowCount - 1 do
     begin
       sFnCard := sFnCard + Controller.SelectedRows[i].Values[GetColumnByFieldName('FN_Card').Index] + ',';
     end;
     sSQL := QuotedStr(sFnCard) + ',' + QuotedStr(cbbColorHoldInfo.Text) + ',' + QuotedStr(login.LoginID);
     FNMServerObj.GetQueryData(vData,'SaveColorHoldInfo',sSQL,sErrMsg);
     if sErrMsg <> '' then
     begin
       TMsgDialog.ShowMsgDialog(sErrMsg,mtWarning);
       Exit;
     end;
     TMsgDialog.ShowMsgDialog('保存成功',mtWarning);
  end;
end;

procedure TArtControlForm.GetPDAInfo();
var
  sGFNO:string;
  sCondition,sErrorMsg:WideString;
  vDataPDA:OleVariant;
begin
//  with cxgridtv_OnLineCard do
//  BEGIN
//    sGFNO := Controller.SelectedRows[0].Values[GetColumnByFieldName('GF_NO').Index];
//  END;
  sGFNO:= cds_OnLineCardList.FieldByName('GF_NO').AsString;
  //获取PDA信息
  sCondition := QuotedStr(Trim(sGFNO)) + ',2';
  FNMServerObj.GetQueryData(vDataPDA,'GetColorInfo',sCondition,sErrorMsg);

  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  cdsPDAs.Data := vDataPDA;

  //dbgrd1.DataSource :=  cdsPDAs.DataSource;
  GridDecorator.BindCxViewWithDataSource(cxGrid1DBTableView1, dsPDA,False);

  if cdsPDAs.IsEmpty then
  begin
    //cxspltrleft.CloseSplitter;
    cxGrid1DBTableView1.Focused := false;
    cxgridtv_OnLineCard.Focused := True;
  end
  else
  begin
    //cxspltrleft.OpenSplitter;
    cxGrid1DBTableView1.Focused := false;
    cxgridtv_OnLineCard.Focused := True;
  end;
end;

procedure TArtControlForm.cxgridtv_OnLineCardMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  GetPDAInfo;
end;

procedure TArtControlForm.doShowMachineQuantityInfo(Operation_Code: String);
var
  sMsg, sSQL, sErrMsg: WideString;
  vData:OleVariant;
begin
  edtInfo.Text := '';
  //C-DIP：控制点->"007-预缩复版”
  if Operation_Code <> '007' then
    Exit;
  
  sSQL := 'select sMsg= FNMDB.dbo.udf_fnGetMachineQuantityInfo('
        + QuotedStr(Login.CurrentDepartment)+')';
  FNMServerObj.GetQueryBySQL(vData, sSQL,sErrMsg);
  if sErrMsg <> '' then
    Raise Exception.Create(sErrMsg);
  cdsTemp.Data := vData;
  sMsg := '';
  if not cdsTemp.IsEmpty then
  begin
    sMsg := cdsTemp.FieldByName('sMsg').AsString;
    edtInfo.Text := sMsg;
  end;
end;

procedure TArtControlForm.cxgridtv_OnLineCardFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord;
  ANewItemRecordFocusingChanged: Boolean);
  var
  sSQL,sErrMsg: WideString;
  vData:OleVariant;
  cbb_DipPoint2:string;
begin
   //ShowMessage(cds_OnLineCardList.FieldByName('fn_card').AsString);
   cbb_DipPoint2:=LeftStr(cbb_DipPoint1,3) ;
   sSQL:='exec usp_IFSampling '+QuotedStr(cds_OnLineCardList.FieldByName('fn_card').AsString)+','+QUotedStr(cbb_DipPoint2);
   FNMServerObj.GetQueryBySQL(vData, sSQL,sErrMsg);
   if sErrMsg <> '' then
   Raise Exception.Create(sErrMsg);
   cds1.Data:=vData;
   if ((Pos('091',cbb_DipPoint1) > 0 ) or (Pos('009',cbb_DipPoint1) > 0 ) or
     (Pos('022',cbb_DipPoint1) > 0 ) or (Pos('058',cbb_DipPoint1) > 0 ) or
     (Pos('112',cbb_DipPoint1) > 0 ) or (Pos('072',cbb_DipPoint1) > 0 ) or
     (Pos('050',cbb_DipPoint1) > 0 ) or (Pos('005',cbb_DipPoint1) > 0 ) or
     (Pos('999',cbb_DipPoint1) > 0 ) or (Pos('007',cbb_DipPoint1) > 0 ) or
     (Pos('113',cbb_DipPoint1) > 0 ) ) and (cds1.RecordCount<>0 )
    then  begin
               if cds1.FieldByName('is_choose').AsInteger=0 then
               begin
                 rb1.Visible:=True;
                 rb2.Font.Color:=clRed;
                 rb2.Visible:=True;
                 rb2.Checked:=True;
               end ;
               if cds1.FieldByName('is_choose').AsInteger=1 then
               begin
                 rb1.Visible:=True;
                 rb2.Visible:=True;
                 rb1.Checked:=True;
               end;


           end
     else
     begin
       rb1.Visible:=False;
       rb2.Visible:=False;
     end;
end;

end.

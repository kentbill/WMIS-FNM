unit frmAccident;
{*|<PRE>*****************************************************************************
                                                                             
       软件名称 FNM CLIENT MODEL
       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                              
       单元名称 frmAccident.pas
       创建日期 2004-9-8 9:10:10
       创建人员 lvzd                                                           
       修改人员                                                                
       修改日期                                                                
       修改原因                                                                
       对应用例                                                                
       字段描述
       相关数据库表
       调用重要函数/SQL对象说明                                                
       功能描述 建立处理单
                                                                              
******************************************************************************}

interface

uses
  Windows, Messages, Classes, Controls, Graphics, ComCtrls, Forms,
  StdCtrls, Buttons, ExtCtrls, cxSpinEdit, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxButtonEdit, DB, Grids, ValEdit, DBClient, Menus;

type
  TAccidentForm = class(TForm)
    pnl_Only: TPanel;
    cxbe_GFKeyValue: TcxButtonEdit;
    pnl_Only2: TPanel;
    cbb_GFKeyValue: TComboBox;
    grp1: TGroupBox;
    lv_CardList: TListView;
    lbl1: TLabel;
    edt_AccidentNO: TEdit;
    cbb_Class: TComboBox;
    cbb_ReasonType: TComboBox;
    edt_SumQuantity: TEdit;
    cbbReasonName: TComboBox;
    edt_Operation: TEdit;
    cbb_Operator: TComboBox;
    cbb_Machine: TComboBox;
    cbb_BeforeAfter: TComboBox;
    Panel1: TPanel;
    btn_SaveAccident: TButton;
    btn_Cancel: TButton;
    GroupBox1: TGroupBox;
    vle_Par: TValueListEditor;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    cbb_PreAccidentNO: TComboBox;
    btn_Query: TButton;
    cdsPreAccidents: TClientDataSet;
    cdsTmp: TClientDataSet;
    cds_CardList: TClientDataSet;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxbe_GFKeyValueKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btn_SaveAccidentClick(Sender: TObject);
    procedure cxbe_GFKeyValuePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btn_CancelClick(Sender: TObject);
    procedure lv_CardListMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lv_CardListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lv_CardListCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure OnAccidentDataChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure AComboBoxSelect(Sender: TObject);
    procedure lv_CardListEnter(Sender: TObject);
    procedure cbb_GFKeyValueSelect(Sender: TObject);
    procedure btn_QueryClick(Sender: TObject);
    procedure cbb_PreAccidentNOSelect(Sender: TObject);
    procedure lv_CardListClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
   
  private
    { Private declarations }
    TheCardDataSet: TDataSet;
    procedure RefreshFinishCardList(GF_KeyValue: String);
    function CheckInputData: Boolean;
    procedure SaveAccidentInfo;
    function CheckVle:Boolean;
    procedure GetPreAccident;
    procedure FillPreAccident;
    procedure SetStatus;
    function FormatAccidentString(cdsPre:TClientDataSet;cdsDtl:TClientDataSet) : WideString;
    procedure CreateColor(cdsTemp:TClientDataSet);
  public
    { Public declarations }
  end;                     

procedure CreateNewAccident(CardDataSet: TDataSet = nil; Machine: String = ''; Operators: String = '');

implementation

uses SysUtils, Variants, StrUtils, uDictionary, UAppOption,
    uFNMArtInfo, Dialogs, uGlobal, ServerDllPub, uFNMResource,
    uLogin, uShowMessage, frmMachineTerminal,frmAccidentTimeSelect,
  frmSuspend;

{$R *.dfm}
var
  AccidentForm: TAccidentForm;
  sColor:array of string;  //listview每行颜色的数组
  sPreFNCard:string;

procedure CreateNewAccident(CardDataSet: TDataSet = nil; Machine: String = ''; Operators: String = '');
begin
  if AccidentForm = nil then
    AccidentForm:=TAccidentForm.Create(Application);

  sPreFNCard := '';

  with AccidentForm do
  begin
    if CardDataSet = nil then
    begin
      cbb_Machine.Style:=csDropDownList;
      FillAllOperationToItems(Login.DefaultDepartment, cbb_Machine.Items);
      cbb_Machine.Enabled:=True;

      cbb_Operator.Style:=csDropDown;
      cbb_Operator.Text:=Login.LoginID;
      cbb_Operator.Enabled:=False;
    end
    else
    begin
      TheCardDataSet:=CardDataSet;
      cbb_Machine.Style:=csDropDown;
      cbb_Machine.Text:=Machine;
      cbb_Machine.Enabled:=False;

      cbb_Operator.Items.Text:=Operators;
      cbb_Operator.Style:=csDropDownList;
      cbb_Operator.Enabled:=True;
      TGlobal.FillItemsFromDataSet(CardDataSet, 'Operation_CHN', 'GF_NO', '->', cbb_GFKeyValue.Items);
    end;
  
    cxbe_GFKeyValue.Visible:=CardDataSet = nil;
    cbb_GFKeyValue.Visible:=CardDataSet <> nil;
    ShowModal;
  end;
end;

procedure TAccidentForm.RefreshFinishCardList(GF_KeyValue: String);
begin
  //刷新卡号列表。
  if GF_KeyValue = '' then exit;
  lv_CardList.Items.Clear;
  edt_SumQuantity.Text:= '0';
  
  GetOnLineCardByGFKeyValue(GF_KeyValue, Login.CurrentDepartment, TempClientDataSet);

  if TempClientDataSet.IsEmpty then  exit;

  //设置listview每一行的颜色 放在数组sColor里
  CreateColor(TempClientDataSet);

  pnl_Only.Tag:=TempClientDataSet.FieldByName('GF_ID').AsInteger;
  //FillListItemsFromDataSet(TempClientDataSet, 'FN_Card', '', ['Quantity'], lv_CardList.Items);
  FillListItemsFromDataSet(TempClientDataSet, 'FN_Card', '', ['Quantity','Fabric_no','fabric_qty'], lv_CardList.Items);
  edt_SumQuantity.Text:='0';

  lv_CardList.Enabled:=true;
  lv_CardList.Selected:=lv_CardList.Items.Item[0];
  lv_CardList.Selected.Focused:=true;
  lv_CardList.SetFocus;
  SetStatus;
end;

procedure TAccidentForm.FormDestroy(Sender: TObject);
begin
  AccidentForm:=nil;
end;

procedure TAccidentForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TAccidentForm.cxbe_GFKeyValueKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN: cxbe_GFKeyValue.Properties.OnButtonClick(Sender, 0);
  end;
end;

procedure TAccidentForm.FormCreate(Sender: TObject);
begin
  sPreFNCard := '';
  cxbe_GFKeyValue.Properties.Buttons.Items[0].Glyph.LoadFromResourceName(HInstance, RES_QUERYSMALL);
end;

procedure TAccidentForm.btn_SaveAccidentClick(Sender: TObject);
begin
  SaveAccidentInfo;
end;

procedure TAccidentForm.SaveAccidentInfo;
var
  i: Integer;
  CardList, Operator ,sFabricNos,sReasonCode: String;
  sErrorMsg: WideString;
  AccidentData: OleVariant;
  Quantity:Integer;
  sBeginTime:string;
  sEndTime:string;
  sCondition: WideString;
begin
  if not CheckInputData then exit;

  if not CheckVle then EXIT;

  Operator:=cbb_Operator.Text;
  if Pos(')->', Operator) <> 0 then
    Operator:=MidStr(Operator, 9, Pos(')->', Operator) - 9);

  CardList:='';
  if edt_AccidentNO.Text = '' then
  begin
    for i := 0 to lv_CardList.Items.Count - 1 do
    begin
      if lv_CardList.Items.Item[i].Checked and (Pos(lv_CardList.Items[i].Caption,CardList)<= 0) then
        CardList:=CardList + lv_CardList.Items.Item[i].Caption + ',';
      if lv_CardList.Items.Item[i].Checked then
      begin
        if lv_CardList.Items.Item[i].SubItems.Strings[1] <> '' then
          sFabricNos := sFabricNos + LeftStr(lv_CardList.Items.Item[i].SubItems.Strings[1],8)  + ',';
      end;
    end;
  end;

  //增加 reason_code字段
  AccidentData:=VarArrayOf([edt_AccidentNO.text, pnl_Only.Tag, LeftStr(edt_Operation.text, 3),
                            edt_SumQuantity.text, MidStr(cbbReasonName.text, Pos('->', cbbReasonName.text) + 2, MAXINT),
                            cbb_Class.text, LeftStr(cbb_Machine.Text, 4), cbb_BeforeAfter.Text,MidStr(cbbReasonName.text,1,  Pos('->', cbbReasonName.text)-1),sFabricNos]);
  with TempClientDataSet do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('Item_Name', ftString, 10);
    FieldDefs.Add('Item_Value', ftString, 20);   //10 改为20 Support 2015-5-25
    CreateDataSet;
    for I := 0 to vle_Par.Strings.Count - 1 do
    begin
      //判断码长必须为数字
      if vle_Par.Cells[0, i + 1] = '码长' then
      begin
        try
          Quantity := StrToInt(vle_Par.Cells[1, i + 1]);
        except
          sErrorMsg:= '码长必须为数字！';
          raise ExceptionEx.CreateResFmt(@ERR_SaveAccidentInfo, [sErrorMsg]);
        end;
      end;
      AppendRecord([vle_Par.Cells[0, i + 1], vle_Par.Cells[1, i + 1]]);
    end;
  end;

  FNMServerArtObj.SaveAccidentInfo(CardList, AccidentData, TempClientDataSet.Data, Login.CurrentDepartment, Operator, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveAccidentInfo, [sErrorMsg]);

  sReasonCode := MidStr(cbbReasonName.text,0,Pos('->', cbbReasonName.text)-1);

  if sReasonCode = 'FR184' then
  begin
    AccidentTimeSelectFrom := TAccidentTimeSelectFrom.Create(nil);
    try
      if AccidentTimeSelectFrom.ShowModal = mrOK then
      begin
        sBeginTime := AccidentTimeSelectFrom.sBegin_Time;
        sEndTime := AccidentTimeSelectFrom.sEnd_Time;
      end;
    finally
      AccidentTimeSelectFrom.Free;
    end;
    TempClientDataSet.Data:=AccidentData;
    sCondition := TempClientDataSet.Fields.Fields[0].AsString;
    sCondition := QuotedStr(TempClientDataSet.Fields.Fields[0].AsString) + ',' +
                  QuotedStr(sBeginTime) + ',' +
                  QuotedStr(sEndTime) + ',' +
                  QuotedStr(Operator);

    FNMServerObj.SaveDataBySQL('SaveShutDownTime',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
  end;
  TempClientDataSet.Data:=AccidentData;
  edt_AccidentNO.Text:=TempClientDataSet.Fields.Fields[0].AsString;
  btn_SaveAccident.Enabled:=false;
  ShowMsgDialog(@MSG_SaveAccidentInfoSuccess, mtInformation);
  Self.Close;
end;

procedure TAccidentForm.cxbe_GFKeyValuePropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  if Trim(cxbe_GFKeyValue.Text) = '' then exit;

  RefreshFinishCardList(Trim(cxbe_GFKeyValue.Text));
end;

function TAccidentForm.CheckInputData: Boolean;
begin
  result := False;
  if (edt_SumQuantity.Text = '') or (edt_SumQuantity.Text = '0') then
  begin
    lv_CardList.SetFocus;
    raise Exception.CreateRes(@INV_NOSelectFNCardFoAccident);
  end;

  if cbb_ReasonType.Text = '' then
  begin
    cbb_ReasonType.SetFocus;
    raise Exception.CreateRes(@INV_NoChoiceReasonType);
  end;

  if cbbReasonName.Text = '' then
  begin
    cbbReasonName.SetFocus;
    raise Exception.CreateRes(@INV_NoChoiceReasonName);
  end;

  if cbb_Operator.Text = ''  then
  begin
    cbb_Operator.SetFocus;
    raise Exception.Create('WAR_请选择写单人');
  end;

  if cbb_Machine.Text = ''  then
  begin
    cbb_Machine.SetFocus;
    raise Exception.Create('WAR_请选择机台');
  end;
  if cbb_PreAccidentNO.Text<>'' then
  begin
    if cdsPreAccidents.Locate('Accident_NO',cbb_PreAccidentNO.Text,[]) then
    begin
      if cdsPreAccidents.FieldByName('Dispose_Info').AsString= 'OK' then
      begin
        if TMsgDialog.ShowMsgDialog('上工序该类型问题已经处理ＯＫ，是否还要开单',mtConfirmation, [mebYes, mebCancel], mebCancel)= mrCancel then
        begin
          Exit;
        end;
      end;
    end;
  end;
  result := True;
end;

procedure TAccidentForm.btn_CancelClick(Sender: TObject);
begin
  Close
end;

procedure TAccidentForm.lv_CardListMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  DownListItem: TListItem;
begin
  if htOnStateIcon in (Sender as TListView).GetHitTestInfoAt(X, Y) then
  begin
    DownListItem:=(Sender as TListView).GetItemAt(X, Y);
    if Integer(DownListItem.SubItems.Objects[0]) <> 0 then
    begin
      DownListItem.Checked:=false;
      Exit;
    end;

    if DownListItem.Checked then
    begin
      if DownListItem.SubItems.Strings[2] <> '' then
        edt_SumQuantity.Text:=FloatToStr(StrTOFloat(edt_SumQuantity.Text) + StrToFloat(DownListItem.SubItems.Strings[2]))
      else
        edt_SumQuantity.Text:=FloatToStr(StrTOFloat(edt_SumQuantity.Text) + StrToFloat(DownListItem.SubItems.Strings[0]));
    end
    else
    begin
      if DownListItem.SubItems.Strings[2] <> '' then
        edt_SumQuantity.Text:=FloatToStr(StrTOFloat(edt_SumQuantity.Text) - StrToFloat(DownListItem.SubItems.Strings[2]))
      else
        edt_SumQuantity.Text:=FloatToStr(StrTOFloat(edt_SumQuantity.Text) - StrToFloat(DownListItem.SubItems.Strings[0]));
    end;
  end;
end;

procedure TAccidentForm.lv_CardListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  with (Sender as TListView) do
  if key = Word(' ') then
  begin
    if (Selected = nil) or (not Selected.Focused)then exit;

    if Integer(Selected.SubItems.Objects[0]) <> 0 then
    begin
      Selected.Checked:=true;
      Exit;
    end;

    if Selected.Checked then
      edt_SumQuantity.Text:=FloatToStr(StrTOFloat(edt_SumQuantity.Text) - StrToFloat(Selected.SubItems.Strings[0]))
    else
      edt_SumQuantity.Text:=FloatToStr(StrTOFloat(edt_SumQuantity.Text) + StrToFloat(Selected.SubItems.Strings[0]));
  end;
end;

procedure TAccidentForm.lv_CardListCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  sCard,sType:string;
begin
  if Item = nil then exit;

  if Integer(Item.SubItems.Objects[0]) <> 0 then
    Sender.Canvas.Font.Color:= clGrayText
  else
    Sender.Canvas.Font.Color:= clWindowText;

  if sColor[Item.Index] = '1' then
    Sender.Canvas.Font.Color:= clBlack
  else
    Sender.Canvas.Font.Color:= clGray;

end;

procedure TAccidentForm.OnAccidentDataChange(Sender: TObject);
begin
  btn_SaveAccident.Enabled:=true;
end;

procedure TAccidentForm.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
  //填入疵点分类
  FillItemsFromDataSet(Dictionary.cds_RepairReasonList, 'Reason_Type', '', '','', cbb_ReasonType.Items);
  OnActivate:=nil;
end;

procedure TAccidentForm.AComboBoxSelect(Sender: TObject);
var
  i: Integer;
begin
  if Sender = cbb_Machine then
    btn_QueryClick(Sender);

  if Sender = cbb_ReasonType then
  begin
    if cbb_ReasonType.ItemIndex = -1 then exit;

    with Dictionary, Dictionary.cds_RepairReasonList do
    try
      Filter:=Format('Reason_Type = ''%s''', [cbb_ReasonType.Text]);
      Filtered:=true;
      FillItemsFromDataSet(cds_RepairReasonList, 'Reason_Code', 'Reason_Info', '', '->', cbbReasonName.Items);
    finally
      Filtered:=False;
    end;
    vle_Par.Strings.Clear;
    cbb_Class.ItemIndex:=-1;
  end;

  if Sender = cbbReasonName then
  begin
    if cbbReasonName.ItemIndex = -1 then exit;

    with Dictionary, Dictionary.cds_RepairReasonList do
    try
      Filter:=Format('Reason_Code = ''%s''', [ LeftStr(cbbReasonName.text, 5)]);
      Filtered:=true;
      vle_Par.Strings.Clear;
      if cds_RepairReasonList.RecordCount <> 0 then
      begin
        TGlobal.SetComboBoxValue(cbb_Class, cds_RepairReasonList['Quality_Type']);
        for i := 0 to cds_RepairReasonList.RecordCount - 1 do
        begin
          vle_Par.Strings.Add(Format('%s=%s', [cds_RepairReasonList['Item_Name'], '']));
          if cds_RepairReasonList['Enum_Value'] <> '' then
          begin
            vle_Par.ItemProps[cds_RepairReasonList['Item_Name']].EditStyle:=esPickList;
            vle_Par.ItemProps[cds_RepairReasonList['Item_Name']].PickList.Text:=StringReplace(cds_RepairReasonList['Enum_Value'], '/', #13, [rfReplaceAll]);
          end;
          next;
        end;
      end
    finally
      Filtered:=False;
    end;
  end;
end;

procedure TAccidentForm.lv_CardListEnter(Sender: TObject);
begin
  if (lv_CardList.Items.Count <> 0) and (lv_CardList.Selected = nil) then
  begin
    lv_CardList.Selected:=lv_CardList.Items.Item[0];
    lv_CardList.Selected.Focused:=true;
  end;
end;

//设置listview每一行的颜色 放在数组sColor里
procedure TAccidentForm.CreateColor(cdsTemp:TClientDataSet);
var
  i:Integer;
  sLastCardNo,sCardNo:string;
begin
  with cdsTemp do
  begin
    SetLength(sColor,RecordCount);
    First;
    for i:=0 to RecordCount -1 do
    begin
      if i = 0 then
      begin
        sColor[i] := '1';
        sLastCardNo := cdsTemp['FN_CARD'];
      end
      else
      begin
        sCardNo := cdsTemp['FN_CARD'];
        if sCardNo = sLastCardNo then
          sColor[i] := sColor[i - 1]
        else
        begin
          if sColor[i-1] = '1' then
            sColor[i] := '0'
          else
            sColor[i] := '1';
        end;
        sLastCardNo := sCardNo;
      end;
      Next;
    end;
    First;
  end;
end;

procedure TAccidentForm.cbb_GFKeyValueSelect(Sender: TObject);
var
  vData:OleVariant;
  sSQL,sErrMsg,sFNCard,sGFNO:WideString;
  i:Integer;
begin
  try
    edt_SumQuantity.Text:= '0';
    TheCardDataSet.DisableControls;
    TheCardDataSet.Filter:='Operation_CHN = ''' + StringReplace(cbb_GFKeyValue.Text, '->', ''' AND GF_NO = ''', [rfReplaceAll]) + '''';
    TheCardDataSet.Filtered:=True;

    pnl_Only.Tag:=TheCardDataSet['GF_ID'];
    edt_Operation.Text:=TheCardDataSet['Operation_Code'] + '->' + TheCardDataSet['Operation_CHN'];
    //FillListItemsFromDataSet(TheCardDataSet, 'FN_Card', '', ['Quantity'], lv_CardList.Items);

    sGFNO:= MidStr(cbb_GFKeyValue.Text,Pos('->',cbb_GFKeyValue.Text) + 2,Length(cbb_GFKeyValue.Text)- Pos('->',cbb_GFKeyValue.Text)-1) ;
    cds_CardList.DisableControls;
    GetOnLineCardByGFKeyValue(sGFNO, Login.CurrentDepartment, cds_CardList);

//    cds_CardList.Filter:= 'Operation_CHN = ''' + StringReplace(cbb_GFKeyValue.Text, '->', ''' AND GF_NO = ''', [rfReplaceAll]) + '''';
//    cds_CardList.Filtered:=True;
//    if cds_CardList.RecordCount <=0 then
//    begin
      cds_CardList.Filtered:=False;
      cds_CardList.Filter:= 'Operation_CHN = ''' + LeftStr(cbb_GFKeyValue.Text,Pos('->',cbb_GFKeyValue.Text) -1)+ '''' + ' OR Operation_CHN like ''%' + LeftStr(cbb_GFKeyValue.Text,Pos('->',cbb_GFKeyValue.Text) -1)+ '%''';
      cds_CardList.Filtered:=True;
   // end;

    //设置listview每一行的颜色 放在数组sColor里
    CreateColor(cds_CardList);
    //如果没有刷新出数据，则刷新一次已完成的品名  chengg 2016-1-12写入
    if cds_CardList.RecordCount <=0 then
       RefreshFinishCardList(Trim(sGFNO));
    if cds_CardList.RecordCount <=0 then
       Exit;

    if cds_CardList.RecordCount >0 then
      FillListItemsFromDataSet(cds_CardList, 'FN_Card', '', ['Quantity','Fabric_no','fabric_qty'], lv_CardList.Items)
    else
      FillListItemsFromDataSet(TheCardDataSet, 'FN_Card', '', ['Quantity','GF_NO','Quantity'], lv_CardList.Items);

  finally
    cds_CardList.Filtered := False;
    cds_CardList.EnableControls;
    TheCardDataSet.Filtered:=False;
    TheCardDataSet.EnableControls;
    SetStatus;
  end;
end;

function TAccidentForm.CheckVle: Boolean;
var
  sItemValue: string;
  i,iCount:Integer;
begin

  Result := False;
  iCount := vle_Par.Strings.Count;
  if iCount=0 then Exit;

  for i := 1 to iCount do
  begin
    sItemValue := vle_Par.Values[vle_Par.Keys[i]];

    if sItemValue='' then
    begin
      TMsgDialog.ShowMsgDialog('属性不能为空!',mtWarning);
      Exit;
    end;
  end;

  Result := True;
end;

procedure TAccidentForm.GetPreAccident;
var
  sSQL,sErrMsg:WideString;
  vData:OleVariant;
  i:Integer;
begin
  try
    sSQL := '';
    {
    for i:=0 to lv_CardList.Items.Count-1 do
    begin
      if lv_CardList.Items[i].Checked then
        sSQL := sSQL+ lv_CardList.Items[i].Caption + ',';
    end;
    }
    sSQL := QuotedStr(Login.CurrentDepartment)+','
          + QuotedStr(IntToStr(pnl_Only.Tag))+','
          + QuotedStr(LeftStr(cbb_Machine.Text, 4));
    if sSQL= '' then EXIT;
    FNMServerObj.GetQueryData(vData,'fnGetPreAccidents', sSQL, sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    cdsPreAccidents.Data := vData[0];
    cdsTmp.Data := vData[1];
  finally
    SetStatus;
  end;
end;

procedure TAccidentForm.SetStatus;
begin
  btn_Query.Enabled := lv_CardList.SelCount>0;
  cbb_PreAccidentNO.Enabled := cbb_PreAccidentNO.Items.Count>0;
end;

procedure TAccidentForm.FillPreAccident;
var
  i:Integer;
begin
  if not cdsPreAccidents.Active then Exit;
  if cdsPreAccidents.IsEmpty or cdsTmp.IsEmpty then Exit;
  if cbb_PreAccidentNO.Text= '' then Exit;

  if cdsPreAccidents.Locate('Accident_NO', cbb_PreAccidentNO.Text, []) then
  begin
    TGlobal.SetComboBoxValue(cbb_ReasonType,cdsPreAccidents.FieldByName('Reason_Type').AsString);
    TGlobal.SetComboBoxValue(cbbReasonName,cdsPreAccidents.FieldByName('Defect_Name').AsString);
    TGlobal.SetComboBoxValue(cbb_BeforeAfter,cdsPreAccidents.FieldByName('Before_After').AsString);
    TGlobal.SetComboBoxValue(cbb_Class,cdsPreAccidents.FieldByName('Quality_Type').AsString);
    cdsTmp.Filtered := False;
    cdsTmp.Filter := 'Accident_NO= '+ QuotedStr(cbb_PreAccidentNO.Text);
    cdsTmp.Filtered := True;
    for i:=0 to vle_Par.RowCount-1 do
    begin
      if cdsTmp.Locate('Item_Name', vle_Par.Keys[i],[]) then
        vle_Par.Values[vle_Par.Keys[i]] := cdsTmp.FieldByName('Item_Value').AsString;
    end;
  end;
end;

procedure TAccidentForm.btn_QueryClick(Sender: TObject);
begin
  GetPreAccident;
end;

procedure TAccidentForm.cbb_PreAccidentNOSelect(Sender: TObject);
var
  WStr:WideString;
begin
  //FillPreAccident;
  cdsPreAccidents.Filter := Format('Accident_NO = ''%s''', [cbb_PreAccidentNO.Text]);
  cdsPreAccidents.Filtered:=True;
  WStr:=FormatAccidentString(cdsPreAccidents,cdsTmp);
  TMsgDialog.ShowMsgDialog(WStr, mtConfirmation);
end;

function TAccidentForm.FormatAccidentString(cdsPre:TClientDataSet;cdsDtl:TClientDataSet) : WideString ;
var
  wStr: WideString;
begin
  if cdsPre.RecordCount > 0 then
  begin
    wStr:= '疵点名： ' + cdsPre.FieldByName('Defect_Name').AsString + #13 +
          '机  台： ' + cdsPre.FieldByName('Machine_ID').AsString + #13 +
          '工  序： ' + cdsPre.FieldByName('Operation_CHN').AsString + #13 + #13;
    wStr:= wStr + '详细：' + #13;

    cdsDtl.Filter := Format('Accident_NO = ''%s''', [cdsPre.FieldByName('Accident_NO').AsString]);
    cdsDtl.Filtered := True;
    if cdsDtl.RecordCount > 0 then
    begin
      cdsDtl.First;
      while not cdsDtl.Eof do
      begin
       wStr:= wStr + cdsDtl.FieldByName('item_name').AsString + ' : ' + cdsDtl.FieldByName('item_value').AsString + #13;
       cdsDtl.Next;
      end;
    end;
    Result:= wStr;
    cdsDtl.Filtered := False;
  end;
end;


procedure TAccidentForm.lv_CardListClick(Sender: TObject);
var
  sSQL,sErrMsg:WideString;
  sCard:string;
  vData:OleVariant;
  i:Integer;
begin
  try
    sSQL := '';
    sCard:= '';

    for i:=0 to lv_CardList.Items.Count-1 do
    begin
      if lv_CardList.Items[i].Selected then
        sCard :=  lv_CardList.Items[i].Caption;
    end;
    if scard = '' then exit ;
    //TMsgDialog.ShowMsgDialog(scard, mtConfirmation);
    sSQL := QuotedStr(Login.CurrentDepartment)+','
          + QuotedStr(sCard)+','
          + QuotedStr('000');
    if sSQL= '' then EXIT;
    FNMServerObj.GetQueryData(vData,'fnGetPreAccidents', sSQL, sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    cdsPreAccidents.Data := vData[0];
    cdsTmp.Data := vData[1];
    if (sPreFNCard = '') or (sPreFNCard <> sCard)  then
    begin
      if cdsPreAccidents.RecordCount > 0 then
        TMsgDialog.ShowMsgDialog(scard + '在前工序有过处理单，右下角选择查看详细。', mtWarning);
    end;
    sPreFNCard := sCard;

    cbb_PreAccidentNO.Items.Clear;
    cdsPreAccidents.Filtered := False;
    FillItemsFromDataSet(cdsPreAccidents, 'accident_no', '', '','', cbb_PreAccidentNO.Items);

  finally
    SetStatus;
  end;
end;

procedure TAccidentForm.N1Click(Sender: TObject);
var
  i:Integer;
begin

  for i:=0 to lv_CardList.Items.Count -1 do
  begin
    if lv_CardList.Items[i].Selected = True then
    begin
      if not lv_CardList.Items[i].Checked then
      begin
        if lv_CardList.Items[i].SubItems.Strings[2] <> '' then
          edt_SumQuantity.Text:=FloatToStr(StrTOFloat(edt_SumQuantity.Text) + StrToFloat(lv_CardList.Items[i].SubItems.Strings[2]))
        else
          edt_SumQuantity.Text:=FloatToStr(StrTOFloat(edt_SumQuantity.Text) + StrToFloat(lv_CardList.Items[i].SubItems.Strings[0]));
      end;
      lv_CardList.Items[i].Checked := True;
    end;
  end;
end;

procedure TAccidentForm.N2Click(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to lv_CardList.Items.Count -1 do
  begin
    if lv_CardList.Items[i].Selected = True then
    begin
      if lv_CardList.Items[i].Checked then
      begin
        if lv_CardList.Items[i].SubItems.Strings[2] <> '' then
          edt_SumQuantity.Text:=FloatToStr(StrTOFloat(edt_SumQuantity.Text) - StrToFloat(lv_CardList.Items[i].SubItems.Strings[2]))
        else
          edt_SumQuantity.Text:=FloatToStr(StrTOFloat(edt_SumQuantity.Text) - StrToFloat(lv_CardList.Items[i].SubItems.Strings[0]));
      end;
      lv_CardList.Items[i].Checked := False;
    end;
  end;
end;

end.

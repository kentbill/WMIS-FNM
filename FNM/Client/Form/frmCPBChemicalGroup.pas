unit frmCPBChemicalGroup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, Buttons, ExtCtrls, DB, DBClient, StdCtrls, ComCtrls,
  Grids, ValEdit;

type
  TCPBChemicalGroupForm = class(TBaseForm)
    pnl_Only: TPanel;
    btn_Query: TSpeedButton;
    btn_Save: TSpeedButton;
    btn_Exit: TSpeedButton;
    btn_Delete: TSpeedButton;
    cdsCPB: TClientDataSet;
    pnl2: TPanel;
    grpLeft1: TGroupBox;
    vleChemicallist: TValueListEditor;
    btnDown: TSpeedButton;
    btnUp: TSpeedButton;
    grpGroup: TGroupBox;
    cdsGroup: TClientDataSet;
    cbbGroup: TComboBox;
    pnlChemical: TPanel;
    grp1: TGroupBox;
    pgc1: TPageControl;
    ts1: TTabSheet;
    tvChemical: TTreeView;
    ts2: TTabSheet;
    cbbChemicalName: TComboBox;
    btnAdd: TSpeedButton;
    btnDel: TSpeedButton;
    pnlGroupEdit: TPanel;
    btnNew: TSpeedButton;
    btnSaveAS: TSpeedButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btn_QueryClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure tvChemicalKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbbChemicalNameDblClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnUpDblClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure vleChemicallistKeyPress(Sender: TObject; var Key: Char);
    procedure vleChemicallistValidate(Sender: TObject; ACol, ARow: Integer;
      const KeyName, KeyValue: String);
    procedure btnUpClick(Sender: TObject);
    procedure cbbGroupKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbbGroupClick(Sender: TObject);
    procedure UpdateActions; override;
    procedure btnSaveASClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure vleChemicallistStringsChange(Sender: TObject);
    procedure cbbGroupDblClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetBtnState;
    procedure DataRefresh;
    procedure DataAdd;
    procedure DataDelete;
    procedure DataSave(sType, GroupName:String);
    procedure DataSaveAS;
    procedure DataCancel;
    procedure DataQuery;
    function CloseQuery:Boolean;
    procedure CalcAuxiliaries;
    function CheckChemmicalData(var AChemicalStr:string; var AUnitQtyStr: string): Boolean;
    procedure ShowGroup;
    function GetChemmicalData(var AChemicalStr:string; var AUnitQtyStr: string): Boolean;
  public
    { Public declarations }
    IsModal:boolean;
    IsModified:boolean;
    function SetModel:String;
  end;

var
  CPBChemicalGroupForm: TCPBChemicalGroupForm;

implementation

uses ServerDllPub, uGlobal, uShowMessage, uLogin, uGridDecorator, uDictionary, uFNMArtInfo, uFNMResource;

{$R *.dfm}

{ TCPBChemicalGroupForm }

procedure TCPBChemicalGroupForm.btn_DeleteClick(Sender: TObject);
begin
  DataDelete;
end;

procedure TCPBChemicalGroupForm.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TCPBChemicalGroupForm.btn_QueryClick(Sender: TObject);
begin
  DataRefresh;
end;

procedure TCPBChemicalGroupForm.btn_SaveClick(Sender: TObject);
begin
  DataSave('U','');
end;

function TCPBChemicalGroupForm.CloseQuery: Boolean;
begin
  if IsModified then
  begin
    if TMsgDialog.ShowMsgDialog('数据未保存，是否保存！', mtConfirmation, [mebYes, mebNo], mebYes)= mrNo then
      Result := false;
  end
  else
    Result := False;
end;

procedure TCPBChemicalGroupForm.DataCancel;
begin
//  cdsCPB.CancelUpdates;
end;

procedure TCPBChemicalGroupForm.DataQuery;
var
  vData:OleVariant;
  sErrMsg:WideString;
begin
  try
    ShowMsg('正在查询稍等！', crHourGlass);

    if cdsCPB.Active then
      cdsCPB.EmptyDataSet;

    FNMServerObj.GetBaseTableInfo(vData, 'CPBChemical', sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    cdsCPB.Data := vData;

    if cdsCPB.IsEmpty then
      Exit;

    FillItemsFromDataSet(cdsCPB, 'Chemical_Short_Name', '', 'Chemical_ID', '', cbbChemicalName.Items);
    FillTreeItemsFromDataSetByClassField(cdsCPB,'Chemical_Name', 'Chemical_Type','Chemical_ID', '', tvChemical.Items);
    tvChemical.FullExpand;
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCPBChemicalGroupForm.DataRefresh;
var
  vData:OleVariant;
  sErrMsg:WideString;
begin
  try
    ShowMsg('正在查询稍等！', crHourGlass);

    FNMServerObj.GetBaseTableInfo(vData,'dlCPBChemicalGroup',sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg,mtError);
      Exit;
    end;
    cdsGroup.Data := vData;
    if cdsGroup.IsEmpty then
      Exit;
    FillItemsFromDataSet(cdsGroup, 'Group_Name','','','',cbbGroup.Items);
  finally
    IsModified := False;
    ShowMsg('', crDefault);
  end;
end;

procedure TCPBChemicalGroupForm.DataSave(sType, GroupName:String);
var
  vData: OleVariant;
  sSQL, sErrMsg: WideString;
  ChemicalStr, UnitQtyStr: string;
begin
  try
    ShowMsg('', crHourGlass);

    if (sType= 'U') and (cbbGroup.Text='') then
      sType := 'I';

    if (GroupName= '') then
    begin
      if (sType= 'I') then
      begin
        InputQuery('新组合名称输入','请输入新组合名称',GroupName);
        GroupName := UpperCase(Trim(GroupName));
        if GroupName='' then
        begin                                                             
          TMsgDialog.ShowMsgDialog('组合名称不能为空!',mtInformation);
          Exit;
        end;
      end
      else if (sType= 'D') then
      begin
        TMsgDialog.ShowMsgDialog('请选择要删除的组合名称!',mtInformation);
        Exit;
      end
      else if (sType= 'U') then
        GroupName :=  cbbGroup.Text;
    end;

    if not GetChemmicalData(ChemicalStr, UnitQtyStr) then Exit;

    sSQL := QuotedStr(sType)+','+ QuotedStr(GroupName)+','
          +QuotedStr(ChemicalStr)+','+QuotedStr(UnitQtyStr);
    //保存数据
    FNMServerObj.SaveDataBySQL('cpbSaveChemicalGroup', sSQL, sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    DataRefresh;
    cbbGroup.Text := GroupName;
    IsModified := False;

    if sType='D' then
    begin
      vleChemicallist.OnStringsChange := nil;
      vleChemicallist.Strings.Clear;
      vleChemicallist.OnStringsChange := vleChemicallistStringsChange;
    end
    else
    begin
      if sType= 'I' then
        cbbGroup.Items.IndexOf(GroupName);

      TMsgDialog.ShowMsgDialog('保存成功!',mtInformation);
    end;
  finally
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TCPBChemicalGroupForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TCPBChemicalGroupForm.FormCreate(Sender: TObject);
begin
  //btnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnAdd.Glyph.LoadFromResourceName(HInstance, RES_LEFT);
  btnUp.Glyph.LoadFromResourceName(HInstance, RES_UP);
  btnDown.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btnDel.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  //btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  //btnExit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  cbbChemicalName.Align := alClient;
  IsModified := False;
  DataQuery;
  DataRefresh;
end;

procedure TCPBChemicalGroupForm.FormDestroy(Sender: TObject);
begin
  CPBChemicalGroupForm := nil;
end;

procedure TCPBChemicalGroupForm.SetBtnState;
begin
  btn_Save.Enabled := IsModified;
  btn_Delete.Enabled := cbbGroup.Text<>'';
  btnSaveAS.Enabled := (vleChemicallist.Strings.Count>1) and btn_Delete.Enabled;
end;

procedure TCPBChemicalGroupForm.btnAddClick(Sender: TObject);
var
  Chemical_ID: Integer;
begin
  inherited;
  if (tvChemical.Selected = nil) or (tvChemical.Selected.Level = 0) then exit;
  Chemical_ID:=Integer(tvChemical.Selected.Data);
  if vleChemicallist.Strings.IndexOfObject(TObject(Chemical_ID)) = -1 then
  begin
    if vleChemicallist.RowCount = 2 then
       vleChemicallist.Strings.AddObject(tvChemical.Selected.Text + '=0.00', TObject(Chemical_ID))
     else
       vleChemicallist.Strings.InsertObject(vleChemicallist.Row, tvChemical.Selected.Text + '=0.00', TObject(Chemical_ID));
  end  
end;

procedure TCPBChemicalGroupForm.tvChemicalKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    btnAdd.Click;
end;

procedure TCPBChemicalGroupForm.cbbChemicalNameDblClick(Sender: TObject);
var
  Chemical_ID: Integer;
begin
  inherited;
  with cbbChemicalName do
  begin
    if Text = '' then Exit;
    Chemical_ID := Integer(Items.Objects[Items.IndexOf(Text)]);
  end;
  if vleChemicallist.Strings.IndexOfObject(TObject(Chemical_ID)) = -1 then
     vleChemicallist.Strings.AddObject(cbbChemicalName.Items[cbbChemicalName.ItemIndex] + '=0.00', TObject(Chemical_ID));
end;

procedure TCPBChemicalGroupForm.btnDelClick(Sender: TObject);
begin
  inherited;
  if vleChemicallist.Strings.Text <> '' then
  begin
    vleChemicallist.DeleteRow(vleChemicallist.Row);
  end;
end;

procedure TCPBChemicalGroupForm.btnUpDblClick(Sender: TObject);
begin
  inherited;
  if (vleChemicallist.Strings.Text <>'') and (vleChemicallist.Row >1) then
     vleChemicallist.Strings.Exchange(vleChemicallist.Row-1,vleChemicallist.Row-2);
end;

procedure TCPBChemicalGroupForm.btnDownClick(Sender: TObject);
var
  iRow:Integer;
begin
  inherited;
  if (vleChemicallist.Strings.Text <>'') and (vleChemicallist.Row <vleChemicallist.RowCount-1) then
  begin
    vleChemicallist.Strings.Exchange(vleChemicallist.Row-1,vleChemicallist.Row);
    SendMessage(vleChemicallist.Handle, WM_KEYDOWN, VK_DOWN, 0);
  end;
end;

procedure TCPBChemicalGroupForm.CalcAuxiliaries;
var
  ChemicalStr, UnitQtyStr: string;
  vData: OleVariant;
  sCondition: string;
  sErrorMsg: WideString;
begin
  ChemicalStr := '';
  UnitQtyStr := '';
  if not CheckChemmicalData(ChemicalStr,UnitQtyStr) then Exit;
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取数据稍等！',crHourGlass);
    sCondition := QuotedStr(ChemicalStr)+','+QuotedStr(UnitQtyStr);
    FNMServerObj.GetQueryData(vData,'CPBCalcAuxiliaries',sCondition,sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TempClientDataSet.Data := vData;
    if TempClientDataSet.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('没有相关信息,请检查你的查询条件!',mtInformation);
      Exit;
    end;
    FillItemsFromDataSet(TempClientDataSet, 'Chemical_Name', 'Unit_QTY', 'Chemical_ID', '=', vleChemicallist.Strings);
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

procedure TCPBChemicalGroupForm.vleChemicallistKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#13) then
  begin
    SendMessage(TWinControl(Sender).Handle, WM_KEYDOWN, VK_DOWN, 0);
  end;
end;

procedure TCPBChemicalGroupForm.vleChemicallistValidate(Sender: TObject;
  ACol, ARow: Integer; const KeyName, KeyValue: String);
var
  tempe: Extended;
  Unit_QTY: string;
begin
  inherited;
  if KeyName ='' then Exit;
  Unit_QTY := StringReplace(KeyValue, ' ', '', [rfReplaceAll]);

  if not TryStrToFloat(Unit_QTY, tempe)then
    raise Exception.CreateResFmt(@INV_NOItemValue, ['Numeric', 'Numeric']);

  if tempe < 0 then
    raise Exception.CreateResFmt(@INV_ValueIsLessThenZero, ['']);
end;

function TCPBChemicalGroupForm.CheckChemmicalData(var AChemicalStr,
  AUnitQtyStr: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  if vleChemicallist.Strings.Text <> '' then
  begin
    for i := 1 to vleChemicallist.RowCount - 1 do
    begin
      AChemicalStr := AChemicalStr + IntTostr(Integer(vleChemicallist.Strings.Objects[i-1])) + '+';
      AUnitQtyStr := AUnitQtyStr + vleChemicallist.Values[vleChemicallist.Keys[i]] + '+';
    end;
  end;
  Result := (AChemicalStr<>'') and (AUnitQtyStr<>'');
end;

procedure TCPBChemicalGroupForm.btnUpClick(Sender: TObject);
begin
  inherited;
  if (vleChemicallist.Strings.Text <>'') and (vleChemicallist.Row >1) then
  begin
     vleChemicallist.Strings.Exchange(vleChemicallist.Row-1,vleChemicallist.Row-2);
     SendMessage(vleChemicallist.Handle, WM_KEYDOWN, VK_UP, 0);
  end;
end;

function TCPBChemicalGroupForm.SetModel:String;
var
  CPBForm:TCPBChemicalGroupForm;
begin
  Result:= '';
  CPBForm:= TCPBChemicalGroupForm.Create(nil);

  with CPBForm do
  begin
    IsModal := True;
    Height := 320;
    Width := 450;
    cbbGroup.Height := 285;
    pnlChemical.Visible := False;
    pnlGroupEdit.Visible := pnlChemical.Visible;
    pnl_Only.Visible := pnlChemical.Visible;

    if ShowModal= mrOK then
      Result := cbbGroup.Text;
  end;
end;

procedure TCPBChemicalGroupForm.ShowGroup;
var
  Chemical_ID,GroupName: string;
  i,ChemicalCount:Integer;
begin
  inherited;
  vleChemicallist.OnStringsChange := nil;
  vleChemicallist.Strings.Clear;

  GroupName := cbbGroup.Text;
  with cdsGroup do
  try
    Filter:=Format('Group_Name = ''%s''', [GroupName]);
    Filtered:=true;
    First;
    while not Eof do
    begin
      vleChemicallist.Strings.InsertObject(0,FieldByName('Chemical_Name').AsString+'=0.0',TObject(FieldByName('Chemical_ID').AsInteger));
      Next;
    end;
  finally
    vleChemicallist.OnStringsChange := vleChemicallistStringsChange;
    Filtered:=False;
  end;
end;

procedure TCPBChemicalGroupForm.cbbGroupKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key= 13 then
  begin
    //cuijf 2009-11-20 如果是查看模式返回选中的组合名称
    if IsModal then
    begin
      ModalResult := mrOK;
      IsModal:= False;
    end
    else
    begin
      ShowGroup;
    end;
  end
end;

procedure TCPBChemicalGroupForm.cbbGroupClick(Sender: TObject);
begin
  inherited;
  ShowGroup;
end;

procedure TCPBChemicalGroupForm.DataAdd;
begin
  cbbGroup.Text := '';
  vleChemicallist.OnStringsChange := nil;
  vleChemicallist.Strings.Clear;
  vleChemicallist.OnStringsChange := vleChemicallistStringsChange;
end;

procedure TCPBChemicalGroupForm.DataDelete;
var
  sName:String;
begin
  try
    ShowMsg('',crHourGlass);
    sName := Trim(cbbGroup.Text);
    if sName='' then
    begin
      TMsgDialog.ShowMsgDialog('请选择要删除的组合名!',mtInformation);
      Exit;
    end;
    if TMsgDialog.ShowMsgDialog('是否要删除组合：'+sName, mtConfirmation, [mebYes, mebNo], mebYes)= mrNo then
      Exit;
      
    DataSave('D', sName);
    cbbGroup.Text := '';
    TMsgDialog.ShowMsgDialog('删除成功!',mtInformation);
  finally

    ShowMsg('',crDefault);
  end;
end;

procedure TCPBChemicalGroupForm.DataSaveAS;
var
  sName:String;
begin
  InputQuery('新组合名称输入','请输入新组合名称',sName);
  sName := UpperCase(Trim(sName));
  if sName= '' then
  begin
    TMsgDialog.ShowMsgDialog('新组合名称输入不正确!',mtWarning);
    Exit;
  end;
  DataSave('I',sName);
end;

procedure TCPBChemicalGroupForm.UpdateActions;
begin
  inherited;
  SetBtnState;
end;

procedure TCPBChemicalGroupForm.btnSaveASClick(Sender: TObject);
begin
  inherited;
  DataSaveAS;
end;

procedure TCPBChemicalGroupForm.btnNewClick(Sender: TObject);
begin
  inherited;
  DataAdd;
end;

function TCPBChemicalGroupForm.GetChemmicalData(var AChemicalStr,
  AUnitQtyStr: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  if vleChemicallist.Strings.Text <> '' then
  begin
    for i := 1 to vleChemicallist.RowCount - 1 do
    begin
      AChemicalStr := AChemicalStr + IntTostr(Integer(vleChemicallist.Strings.Objects[i-1])) + '+';
      AUnitQtyStr := AUnitQtyStr + vleChemicallist.Values[vleChemicallist.Keys[i]] + '+';
    end;
  end;
  Result := (AChemicalStr<>'') and (AUnitQtyStr<>'');
end;

procedure TCPBChemicalGroupForm.vleChemicallistStringsChange(
  Sender: TObject);
begin
  inherited;
  IsModified := True;
end;

procedure TCPBChemicalGroupForm.cbbGroupDblClick(Sender: TObject);
begin
  inherited;
  //cuijf 2009-11-19 如果是查看模式返回选中的组合名称
  if IsModal then
  begin
    ModalResult := mrOK;
    IsModal:= False;
  end;
end;

end.

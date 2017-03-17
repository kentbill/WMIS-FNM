unit frmFNMQuery;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmFNMQuery;pas                                               }
{       创建日期 2005-4-2618:12:43                                             }
{       创建人员 lvzd                                                          }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  后整理通用查询                                               }
{                                                                              }
{******************************************************************************}


interface

uses
  DB, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uQueryControl, uConditionEditor, cxControls, cxSplitter,
  Buttons, ExtCtrls, ComCtrls, ImgList, DBClient;

type
  TFNMQueryForm = class(TForm)
    btn_Help: TSpeedButton;
    btn_Exit: TSpeedButton;
    cxspl1: TcxSplitter;
    pnl_Only: TPanel;
    tv_QueryList: TTreeView;
    ImageList2: TImageList;
    cdsRole: TClientDataSet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tv_QueryListExpanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure tv_QueryListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    sReadRole: Boolean;
    procedure CheckUserRole;//检查是否是查询组
  public
    { Public declarations }
    mcc_Only: TMakeConditionController;
    AdminModle: Boolean;
    MDGridView: TMDGridViewPanel;

    procedure FillQueryClassIntoTreeView(TreeItems: TTreeNodes; ANode: TTreeNode; ParentClass: integer);
    procedure GetDetailQueryData(QueryIden: Integer; vCondition: Variant; var vDataSet: OleVariant);
    procedure ReQueryData(QueryIden: Integer; PreDeclareVarString, ConditionString: String; var QueryData: OleVariant);
    procedure BeforeCreateColumn(ADataSet: TDataSet);
  end;

var
  FNMQueryForm: TFNMQueryForm;

implementation

uses
  ActiveX, StrUtils, cxGridCustomView, cxGridCustomTableView, cxGridDBDataDefinitions,
  cxGridLevel,  uLogin, uFNMArtInfo, uShowMessage,
  ServerDllPub, uGlobal, uCADInfo, uQueryDictionary, uFNMResource, uAppOption, uGridDecorator;
{$R *.dfm}

procedure TFNMQueryForm.FillQueryClassIntoTreeView(TreeItems: TTreeNodes; ANode: TTreeNode; ParentClass: integer);
var
  NewNode: TTreeNode;
  i, NodeIden: Integer;
  s,NodeText, DetailQueryIdens: String;
begin
  try
    TreeItems.BeginUpdate;
    if (ParentClass < 0) and (ParentClass <> -1)then
    with QyDictionary.cds_QueryList do
    if Locate('Query_Iden', Abs(ParentClass), []) then
    begin
      DetailQueryIdens:=FieldByName('Detail_Query').AsString;
      if DetailQueryIdens <> '' then
      begin
        Filter:='Query_Iden = ' + StringReplace(DetailQueryIdens, ',', ' OR Query_Iden = ', [rfReplaceAll]);
        Filtered:=true;
        for i := 0 to RecordCount - 1 do
        begin
          NodeIden:=FieldByName('Query_Iden').AsInteger;
          NodeText:=FieldByName('Query_Title_CHN').AsString;
          NewNode:=TreeItems.AddChildObject(ANode, NodeText, TObject(-NodeIden));
          NewNode.HasChildren:=AdminModle and (FieldByName('Detail_Query').AsString <> '');
          NewNode.ImageIndex := 3;
          NewNode.SelectedIndex := 3;
          Next;
        end;
      end;
    end;

    with QyDictionary.cds_QueryList do
    begin
      if sReadRole then
        Filter:=Format('Class_Iden = %d AND Query_Class = 0 AND Is_Active = 1', [ParentClass])
      else
        Filter:=Format('Class_Iden = %d AND Query_Class = 0', [ParentClass]);
      Filtered:=True;
      for i := 0 to RecordCount - 1 do
      begin
        NodeIden:=FieldByName('Query_Iden').AsInteger;
        NodeText:=FieldByName('Query_Title_CHN').AsString;
        NewNode:=TreeItems.AddChildObject(ANode, NodeText, TObject(-NodeIden));
        NewNode.HasChildren:=AdminModle and (FieldByName('Detail_Query').AsString <> '');
        NewNode.ImageIndex := 3;
        NewNode.SelectedIndex := 3;
        Next;
      end;
    end;

    with QyDictionary.cds_QueryClass do
    begin
      Filter:=Format('ParentClass_Iden = %d', [ParentClass]);
      Filtered:=True;
      for i := 0 to RecordCount - 1 do
      begin
        NodeIden:=FieldByName('Class_Iden').AsInteger;
        NodeText:=FieldByName('Class_CHN').AsString;
        NewNode:=TreeItems.AddChildObject(ANode, NodeText, TObject(NodeIden));
        NewNode.HasChildren:=True;
        if ParentClass = -1 then
        begin
          NewNode.ImageIndex := 0;
          NewNode.SelectedIndex := 0;
        end else
        begin
          NewNode.ImageIndex := 1;
          NewNode.SelectedIndex := 2;
        end;
        Next;
      end;
    end;
  finally
    QyDictionary.cds_QueryList.Filtered:=false;
    QyDictionary.cds_QueryClass.Filtered:=false;
    TreeItems.EndUpdate;
  end;
end;

procedure TFNMQueryForm.GetDetailQueryData(QueryIden: Integer; vCondition: Variant; var vDataSet: OleVariant);
var
  sErrorMsg: WideString;
begin
  Screen.Cursor := crHourGlass;
  FNMServerObj.GetQyDetail(Abs(QueryIden), vCondition, vDataSet, sErrorMsg);
  if sErrorMsg <> '' then
    raise Exception.CreateResFmt(@ERR_GetDetailQuery, [sErrorMsg]);
    //释放数据
  // VariantClear(vDataSubQuery)
  Screen.Cursor := crDefault;
end;

procedure TFNMQueryForm.ReQueryData(QueryIden: Integer;
  PreDeclareVarString, ConditionString: String; var QueryData: OleVariant);
var
  sErrorMsg: WideString;
begin
  Screen.Cursor := crHourGlass;
  FNMServerObj.GetQyMaster(Abs(QueryIden), PreDeclareVarString, ConditionString, QueryData, sErrorMsg);
  if sErrorMsg <> '' then
    raise Exception.CreateResFmt(@ERR_GetQyMaster, ['', sErrorMsg]);
  Screen.Cursor := crDefault;
end;

procedure TFNMQueryForm.BeforeCreateColumn(ADataSet: TDataSet);
begin
  if AppOption.IfQueryShowCHN then
    GridDecorator.SetDataSetColumnToChinese(ADataSet);
end;

procedure TFNMQueryForm.tv_QueryListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  function GetConditioinType(TypeString: String): TConditionType;
  begin
    result:=ctString;
    if TypeString = 'ctNumber' then
      result:=ctNumber;

    if TypeString = 'ctDate' then
      result:=ctDate;

    if TypeString = 'ctDateTime' then
      result:=ctDateTime;

    if TypeString = 'ctBoolean' then
      result:=ctBoolean;
  end;
var
  i, QueryIden: Integer;
  SelectNode: TTreeNode;
  sErrorMsg: WideString;
  vData: OleVariant;
  ConditionString, PreDeclareVarString: String;
begin
  if Key = VK_RETURN then
  begin
    SelectNode := tv_QueryList.Selected;
    if SelectNode = nil then  exit;

    QueryIden:=Integer(SelectNode.Data);
    if QueryIden > 0 then exit;
    QueryIden:=Abs(QueryIden);
    mcc_Only.ConditionItems.Clear;
    with QyDictionary.cds_QueryMaster do
    try
      Filter:=Format('Query_Iden = %d', [QueryIden]);
      Filtered:=True;
      for i := 0 to RecordCount - 1 do
      begin
        with mcc_Only.ConditionItems.Add as TConditionItem do
        begin
          ConditionName:=FieldByName('Condition_Name').AsString;
          ConditionCaption:=FieldByName('Condition_Caption_CHN').AsString;
          ConditionType:=GetConditioinType(FieldByName('Condition_Type').AsString);
          ConditionHint:=FieldByName('Condition_Hint_CHN').AsString;
          DefaultValue:=FieldByName('Default_Value').Text;
          EmunItem:=FieldByName('Enum_Value').AsString;
        end;
        Next;
      end;
    finally
      Filtered:=False;
    end;
    
    ConditionString:=''; PreDeclareVarString:='';
    if mcc_Only.ConditionItems.Count <> 0 then
    begin
      mcc_Only.Title:=SelectNode.Text + '--条件编辑器';
      if mcc_Only.Execute then
      begin
        ConditionString:=mcc_Only.ConditionString;
        PreDeclareVarString:=mcc_Only.PreDeclareString;
      end
      else
        exit;

      if (ConditionString + PreDeclareVarString) = '' then
        Exit;
    end;
    Screen.Cursor := crHourGlass;
    FNMServerObj.GetQyMaster(Abs(QueryIden), PreDeclareVarString, ConditionString, vData, sErrorMsg);
    if sErrorMsg <> '' then
      raise Exception.CreateResFmt(@ERR_GetQyMaster, [SelectNode.Text, sErrorMsg]);

    MDGridView.CreateMasterQuery(Abs(Integer(SelectNode.Data)), ConditionString + ' | '+ PreDeclareVarString, vData);
    Screen.Cursor := crDefault;
  end;
end;

procedure TFNMQueryForm.tv_QueryListExpanding(Sender: TObject;
  Node: TTreeNode; var AllowExpansion: Boolean);
begin
  if (Node <> nil) and (Node.Count = 0) then
  FillQueryClassIntoTreeView(tv_QueryList.Items, Node, Integer(Node.Data));
end;

procedure TFNMQueryForm.FormCreate(Sender: TObject);
begin
  tv_QueryList.OnDblClick:=TGlobal.DblClickATreeview;
  AdminModle:=false;
  MDGridView:=TMDGridViewPanel.Create(Self);
  with MDGridView do
  begin
    Name:='MDGridViewPanel';
    Parent:=Self;
    Align:=alClient;
    OnOpenDetail:=GetDetailQueryData;
    MDGridView.ReQueryEvent:=ReQueryData;
    OnAfterOpenDataSet:=BeforeCreateColumn;
  end;

  mcc_Only:=TMakeConditionController.Create(Self);
end;

procedure TFNMQueryForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TFNMQueryForm.FormDestroy(Sender: TObject);
begin
  FNMQueryForm:=nil;
end;

procedure TFNMQueryForm.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
  //刷新界面数据
  PostMessage(Handle, WM_KEYDOWN, VK_F5, 0);
  CheckUserRole;
  FillQueryClassIntoTreeView(tv_QueryList.Items, nil, -1);
  if tv_QueryList.Items.Count <> 0 then
    tv_QueryList.Items.Item[0].Expand(false);
    
  OnActivate:=nil;
end;

procedure TFNMQueryForm.btn_ExitClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFNMQueryForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  SendMessage(ActiveControl.Handle, WM_KEYDOWN, Key, 0);
end;

procedure TFNMQueryForm.CheckUserRole;
var         
  vData: OleVariant;
  sSQL,sErrMsg:WideString;
begin
  sReadRole := False;
  sSQL := QuotedStr(login.LoginID);
  FNMServerObj.GetQueryData(vData, 'fnCheckQueryRight', sSQL, sErrMsg);
  if sErrMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  cdsRole.Data := vData;
  if cdsRole.IsEmpty then
  begin
    sReadRole := True;
    Exit;
  end;

  if cdsRole.FieldByName('Filter').AsString= '1' then
    sReadRole := True;

end;

end.

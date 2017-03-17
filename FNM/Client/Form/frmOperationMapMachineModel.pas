unit frmOperationMapMachineModel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, StdCtrls, ComCtrls, ImgList, cxControls,
  cxContainer, cxTreeView;

type
  TOperationMapMachineModelForm = class(TForm)
    grp1: TGroupBox;
    cbbOperationList: TComboBox;
    btnRefresh: TSpeedButton;
    btnDelete: TSpeedButton;
    btnExit: TSpeedButton;
    btnSave: TSpeedButton;
    btnAdd: TSpeedButton;
    ImageList2: TImageList;
    A: TPanel;
    tvColorList: TcxTreeView;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbbOperationListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure Add;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OperationMapMachineModelForm: TOperationMapMachineModelForm;

implementation

uses  ServerDllPub, uFNMResource ,uDictionary, uShowMessage, uLogin,
      uGlobal;

{$R *.dfm}

procedure TOperationMapMachineModelForm.FormCreate(Sender: TObject);
begin
  btnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnAdd.Glyph.LoadFromResourceName(HInstance, RES_LEFT);
  btnDelete.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnExit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  (cbbOperationList as TControl).Align:=alClient;
  TGlobal.FillComboBoxFromDataSet(Dictionary.cds_OperationHdrList,'Operation_Code', 'Operation_CHN','--',cbbOperationList);
end;

procedure TOperationMapMachineModelForm.FormDestroy(Sender: TObject);
begin
  OperationMapMachineModelForm := nil;
end;

procedure TOperationMapMachineModelForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TOperationMapMachineModelForm.btnRefreshClick(Sender: TObject);
var vData: OleVariant;
    sCondition,sErrorMsg: WideString;
    MachineModel: string;
    Node: TTreeNode;
    i: Integer;
begin
  inherited;
  sCondition := QuotedStr('')+','+ QuotedStr('')+',0';
  FNMServerObj.GetQueryData(vData,'SaveOperationMapMachineModel',sCondition,sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  TempClientDataSet.Data:=vData;
  MachineModel := '';
  tvColorList.Items.Clear;
  Node := nil;
  i := 0 ;
  tvColorList.Items.BeginUpdate;
  with TempClientDataSet do
  begin
    First;
    while not Eof do
    begin
      if MachineModel <> FieldByName('Machine_Model').AsString then
      begin
        if (i<>0) and (Node <> nil) then
        begin
          Node.Data := pointer(i);
          Node.Text := Node.Text + '¡¾'+IntToStr(Integer(Node.Data))+'¡¿';
          i := 0;
        end;
        MachineModel := FieldByName('Machine_Model').AsString;
        Node := tvColorList.Items.AddChild(nil,MachineModel);
        Node.ImageIndex := 0;
        Node.SelectedIndex := 1;
      end;
      with tvColorList.Items.AddChild(Node,FieldByName('Operation_Code').AsString) do
      begin
        inc(i);
        ImageIndex := 2;
        SelectedIndex := 2;
      end;
      Next;
      if Eof then
      begin
        Node.Data := pointer(i);
        Node.Text := Node.Text + '¡¾'+IntToStr(Integer(Node.Data))+'¡¿';
      end;
    end;
  end;
  tvColorList.Items.EndUpdate;
end;

procedure TOperationMapMachineModelForm.btnAddClick(Sender: TObject);
begin
  Add;
end;

procedure TOperationMapMachineModelForm.Add;
var
  Node: TTreeNode;
begin
  if tvColorList.Selected = nil then Exit;
  if cbbOperationList.ItemIndex = -1 then Exit;
  Node := tvColorList.Selected;
  if tvColorList.Selected.Level = 1 then
     Node := tvColorList.Selected.Parent;
  with tvColorList.Items.AddChild(Node,cbbOperationList.Text) do
  begin
    ImageIndex := 2;
    SelectedIndex := 2;
  end;
end;

procedure TOperationMapMachineModelForm.btnDeleteClick(Sender: TObject);
begin
  if tvColorList.Selected = nil then Exit;
  if tvColorList.Selected.Level = 0 then Exit;
  tvColorList.Items.Delete(tvColorList.Selected);
end;

procedure TOperationMapMachineModelForm.btnSaveClick(Sender: TObject);
var sCondition,sErrorMsg: WideString;
    MachineModelStr,OperationCodeStr: string;
    ATreeNode: TTreeNode;
    i: Integer;
begin
  inherited;
  MachineModelStr :='';
  OperationCodeStr := '';
  ATreeNode:=tvColorList.Items.GetFirstNode;
  while ATreeNode<>nil do
  begin
    if not ATreeNode.HasChildren then
    begin
       MachineModelStr := MachineModelStr + Copy(ATreeNode.Parent.Text,1,2) +',';
       OperationCodeStr := OperationCodeStr + Copy(ATreeNode.Text,1,3) +',';
     end;
    ATreeNode:=ATreeNode.GetNext;
  end;
  sCondition := QuotedStr(MachineModelStr)+','+ QuotedStr(OperationCodeStr)+',1';
  FNMServerObj.SaveDataBySQL('SaveOperationMapMachineModel',sCondition,sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
end;

procedure TOperationMapMachineModelForm.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TOperationMapMachineModelForm.FormActivate(Sender: TObject);
begin
  btnRefreshcLICK(SELF);
end;

procedure TOperationMapMachineModelForm.cbbOperationListKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if key=13 then
  add;
end;

end.

unit frmReceiveFromGI;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmReceiveFromIG.pas                                            }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{           读：FNMDB..fnStock表中所有的字段                                   }
{           写：FNMDB..fnStock表中的字段FN_Card和Layer                         }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  接收坯布                                             }
{                                                                              }
{******************************************************************************}


interface

uses
  uFNMResource, Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,Dialogs, frmBase, ExtCtrls, OleCtrls, StdCtrls, Buttons,
  DB, DBClient, StrUtils, ComCtrls, GFCADLib_TLB, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxSplitter;

type
  TReceiveFromGIForm = class(TBaseForm)
    cdsUnSelect: TClientDataSet;
    dsUnSelect: TDataSource;
    dsSelect: TDataSource;
    cdsSelect: TClientDataSet;
    pnlCard: TPanel;
    pnl2: TPanel;
    btnAdd: TSpeedButton;
    btnUp: TSpeedButton;
    btnCancel: TSpeedButton;
    btnDown: TSpeedButton;
    cxdbgSelect: TcxGrid;
    cxdbgtvSelect: TcxGridDBTableView;
    cxGridlSelect: TcxGridLevel;
    cxSplitter1: TcxSplitter;
    cxdbgUnSelect: TcxGrid;
    cxdbgtvUnSelect: TcxGridDBTableView;
    cxGridlUnSelect: TcxGridLevel;
    pnlClient: TPanel;
    lstFabricNO: TListBox;
    btnSave: TSpeedButton;
    btnClose: TSpeedButton;
    btnRefresh: TSpeedButton;
    lbl2: TLabel;
    cbbSource: TComboBox;
    lbl1: TLabel;
    cbbCurrentDept: TComboBox;
    cbFinish: TCheckBox;
    reFormula: TRichEdit;
    cxSpLeft: TcxSplitter;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure cxdbgtvUnSelectKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxdbgtvSelectKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsUnSelectFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure cdsSelectFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure cxdbgtvUnSelectCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxSpLeftMoved(Sender: TObject);
  private
    { Private declarations }
    sSource: string;
    procedure Add;
    procedure Cancel;
    procedure GetGIInfo();
    procedure SaveGIInfo;
  public
    { Public declarations }
    procedure PublicQuery; override;
    procedure PublicSave; override;
    procedure PublicExport; override;
  end;

var
  ReceiveFromGIForm: TReceiveFromGIForm;
implementation

uses ServerDllPub, uGlobal, frmMain, uShowMessage, uLogin, uGridDecorator,
  uAppOption, uCADInfo, uDictionary;

{$R *.dfm}

procedure TReceiveFromGIForm.PublicQuery;
begin
  GetGIInfo;
end;

procedure TReceiveFromGIForm.PublicSave;
begin
  SaveGIInfo;
end;

procedure TReceiveFromGIForm.PublicExport;
begin
  TGlobal.SaveDataToFile(cdsUnSelect, sftXLS)
end;

procedure TReceiveFromGIForm.GetGIInfo();
var vData: OleVariant;
    sCondition,sQuerySource,sCurrentDepartment,sErrorMsg: WideString;
    iType: Integer;
begin
  try
    ShowMsg('正在获取数据稍等!', crHourGlass);
    lstFabricNO.Items.Clear;
    sQuerySource := copy(cbbSource.Text,1,pos('->',cbbSource.Text)-1);
    sCurrentDepartment := copy(cbbCurrentDept.Text,1,pos('->',cbbCurrentDept.Text)-1);
    iType := 0;
    if cbFinish.Checked then
       iType := 1;
    sCondition := QuotedStr(sQuerySource)+','+QuotedStr(sCurrentDepartment) +',' + IntToStr(iType);
    FNMServerObj.GetQueryData(vData,'GetGIInfo',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
    cdsUnSelect.Data := vData;
    cdsSelect.Data := vData;
    cdsUnSelect.Filtered := False;
    if cdsUnSelect.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('没有待接收的坯布数据', 2);
      Exit;
    end;
    if sQuerySource <> 'ALL' then
    begin
      cdsUnSelect.Filter := 'Current_Department = ' + QuotedStr(sQuerySource);
      cdsUnSelect.Filtered := True;
    end;
    cdsSelect.Filtered := True;
  finally
    ShowMsg('', crDefault);
  end;
  GridDecorator.BindCxViewWithDataSource(cxdbgtvUnSelect, dsUnSelect);
  GridDecorator.BindCxViewWithDataSource(cxdbgtvSelect, dsSelect);
  GridDecorator.HideFields(cxdbgtvUnSelect,['GF_ID','Is_Cut_Cloth','Is_Hold','WV_IsFinished']);
  GridDecorator.HideFields(cxdbgtvSelect,['GF_ID','Is_Cut_Cloth','Is_Hold','WV_IsFinished']);
end;

procedure TReceiveFromGIForm.Add;
var
  i: Integer;
  sCanReceived, sSourceDepartment,sFabric_NO: string;
begin
  if (not cdsUnSelect.Active) or (cdsUnSelect.IsEmpty) then Exit;
  for i :=cxdbgtvUnSelect.Controller.SelectedRowCount - 1 downto 0 do
  begin
    with cxdbgtvUnSelect do
    begin
      sFabric_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Fabric_NO').Index];
      sSourceDepartment := Controller.SelectedRows[i].Values[GetColumnByFieldName('Current_Department').Index];
      sCanReceived := Controller.SelectedRows[i].Values[GetColumnByFieldName('CanReceived').Index];
    end;
    if sCanReceived<>'可接收' then
    begin
      if sCanReceived= '坯布Hold' then
      begin
        TMsgDialog.ShowMsgDialog('坯布Hold不能接收',mtWarning);
        Exit;
      end;

      if TMsgDialog.ShowMsgDialog(sFabric_NO+'不在可接收状态,是否接收？',
           mtConfirmation, [mebYes, mebNo], mebNo)=mrNO then
        Exit;
    end;

    if sSource = '' then
      sSource := sSourceDepartment;
    if (sSource <> '') and (sSource <> sSourceDepartment) then
    begin
      TMsgDialog.ShowMsgDialog('来源部门不同的数据不能打在一张单上',mtWarning);
      Exit;
    end;
    lstFabricNO.Items.Add(sFabric_NO);
  end;
  cdsUnSelect.Filtered := False;
  cdsUnSelect.Filtered := True;
  cdsSelect.Filtered := False;
  cdsSelect.Filtered := True;
end;

procedure TReceiveFromGIForm.Cancel;
var i,Index: Integer;
    sFabric_NO: string;
begin
  if (not cdsSelect.Active) or (cdsSelect.IsEmpty) then Exit;
  for i :=cxdbgtvSelect.Controller.SelectedRowCount - 1 downto 0 do
  begin
    with cxdbgtvSelect do
      sFabric_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Fabric_NO').Index];
    Index := lstFabricNO.Items.IndexOf(sFabric_NO);
    if Index <> -1 then
      lstFabricNO.Items.Delete(Index);
  end;
  if lstFabricNO.Items.Count = 0 then
     sSource := '';
  cdsUnSelect.Filtered := False;
  cdsUnSelect.Filtered := True;
  cdsSelect.Filtered := False;
  cdsSelect.Filtered := True;
end;

procedure TReceiveFromGIForm.SaveGIInfo;
var
  sCurrentDepartment,sFabricNOStr, sErrorMsg: WideString;
  i: integer;
begin
  try
    ShowMsg('正在保存数据稍等！', crHourGlass);
    if lstFabricNO.Items.Count = 0 then Exit;
    if sSource = '' then Exit;
    sCurrentDepartment := copy(cbbCurrentDept.Text,1,pos('->',cbbCurrentDept.Text)-1);

   //变量赋值及保存卡号记录
    sFabricNOStr := StringReplace(lstFabricNO.Items.Text,#13#10,',',[rfReplaceAll]);
    FNMServerObj.SaveGIInfo(sFabricNOStr,sSource,sCurrentDepartment,Login.LoginName,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
    for i := 0 to lstFabricNO.Items.Count -1 do
    begin
      cdsUnSelect.Filtered := False;
      while cdsUnSelect.Locate('Fabric_NO',lstFabricNO.Items[i],[]) do
        cdsUnSelect.Delete;
      cdsUnSelect.Filtered := True;
      cdsSelect.Filtered := False;
      while cdsSelect.Locate('Fabric_NO',lstFabricNO.Items[i],[]) do
        cdsSelect.Delete;
      cdsSelect.Filtered := True;
    end;
    lstFabricNO.Items.Clear;
    TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TReceiveFromGIForm.FormCreate(Sender: TObject);
begin
  inherited;
  // 坯布来源
  Dictionary.cds_MaterialFlowList.Filtered := False;
  Dictionary.cds_MaterialFlowList.Filter := 'Current_Department=' + QuotedStr(Login.CurrentDepartment) + ' AND Flow_Description=' + QuotedStr('坯布来源')+' AND Parent_Operation = ' + QuotedStr('GI');
  Dictionary.cds_MaterialFlowList.Filtered := True;
  TGlobal.FillItemsFromDataSet(Dictionary.cds_MaterialFlowList, 'Relation_Department', 'Relation_Department_CHN', '->',cbbSource.Items);

  btnAdd.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btnCancel.Glyph.LoadFromResourceName(HInstance, RES_UP);
  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  btnDown.Glyph.LoadFromResourceName(HInstance, RES_DOWNALL);
  btnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnUp.Glyph.LoadFromResourceName(HInstance, RES_UPALL);
  cbbSource.Items.Insert(0,'ALL->坯布车间');
  cbbSource.ItemIndex := 0;
  lstFabricNO.Items.Clear;
  sSource := '';
  cxdbgtvUnSelect.OnDblClick := TGlobal.DblClickAWinControl;
  cxdbgtvSelect.OnDblClick := TGlobal.DblClickAWinControl;
  if FileExists(ExtractFilePath(Application.ExeName)+'坯布自动计划安排规则.rtf') then
    reFormula.Lines.LoadFromFile(ExtractFilePath(Application.ExeName)+'坯布自动计划安排规则.rtf');
end;

procedure TReceiveFromGIForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TReceiveFromGIForm.FormDestroy(Sender: TObject);
begin
  inherited;
  ReceiveFromGIForm := nil;
end;

procedure TReceiveFromGIForm.btnSaveClick(Sender: TObject);
begin
  SaveGIInfo;
end;

procedure TReceiveFromGIForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TReceiveFromGIForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  GetGIInfo;
end;

procedure TReceiveFromGIForm.btnAddClick(Sender: TObject);
begin
  inherited;
  Add;
end;

procedure TReceiveFromGIForm.btnDownClick(Sender: TObject);
begin
  inherited;
  cxdbgtvUnSelect.DataController.SelectAll;
  Add;
end;

procedure TReceiveFromGIForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  Cancel;
end;

procedure TReceiveFromGIForm.btnUpClick(Sender: TObject);
begin
  inherited;
  cxdbgtvSelect.DataController.SelectAll;
  Cancel;
end;

procedure TReceiveFromGIForm.cxdbgtvUnSelectKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = vk_Return then
    Add;
end;

procedure TReceiveFromGIForm.cxdbgtvSelectKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = vk_Return then
    Cancel;
end;

procedure TReceiveFromGIForm.cdsUnSelectFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept := Pos(DataSet.FieldByName('Fabric_NO').AsString,lstFabricNO.Items.Text) = 0;
end;

procedure TReceiveFromGIForm.cdsSelectFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept := Pos(DataSet.FieldByName('Fabric_NO').AsString,lstFabricNO.Items.Text) > 0;
end;

procedure TReceiveFromGIForm.FormActivate(Sender: TObject);
begin
  inherited;
  OnActivate:=nil;
  Application.ProcessMessages;

  TGlobal.FillComboBoxFromDataSet(Dictionary.cds_DepartmentList,'Department','Description','->',cbbCurrentDept);
  cbbCurrentDept.Text := FNMMainForm.cbbCurrentDept.Text;
end;

procedure TReceiveFromGIForm.cxdbgtvUnSelectCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  sUrgent_Type, sWV_IsFinished: string;
  bIs_Cut_Cloth: Boolean;
  iColor, iIs_Hold: Integer;
begin
  inherited;
  if AViewInfo.Focused then Exit;
  sUrgent_Type := Trim(AViewInfo.GridRecord.Values[TcxGridDBTableView(Sender).GetColumnByFieldName('Urgent_Type').Index]);
  sWV_IsFinished := AViewInfo.GridRecord.Values[TcxGridDBTableView(Sender).GetColumnByFieldName('WV_IsFinished').Index];
  bIs_Cut_Cloth := AViewInfo.GridRecord.Values[TcxGridDBTableView(Sender).GetColumnByFieldName('Is_Cut_Cloth').Index];
  iIs_Hold := AViewInfo.GridRecord.Values[TcxGridDBTableView(Sender).GetColumnByFieldName('Is_Hold').Index];
  iColor := TGlobal.GetColorByID(sWV_IsFinished, sUrgent_Type, bIs_Cut_Cloth, iIs_Hold,0);
  if $000000 <> iColor then
     ACanvas.Font.Color := iColor;
end;

procedure TReceiveFromGIForm.cxSpLeftMoved(Sender: TObject);
begin
  inherited;
  reFormula.Refresh;
end;

end.


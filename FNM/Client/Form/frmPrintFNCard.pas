unit frmPrintFNCard;
{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmPrintFNCard.pas                                            }
{       �������� 2004-8-26 13:50:57                                            }
{       ������Ա zhangjy                                                       }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{           ����FNMDB..fnStock�������е��ֶ�                                   }
{           ����FNMDB..fnUrgent���е��ֶ�                                      }
{           ����FNMDB..fnHold���е��ֶ�                                        }
{           д��FNMDB..fnStock���е��ֶ�FN_Card��Layer                         }
{           д��FNMDB..���е��ֶ�Finished //���䲼                             }
{       ������Ҫ����/SQL����˵��                                               }
{       ��������  ����򿨼�¼                                                 }
{                                                                              }
{******************************************************************************}


interface

uses
  uFNMResource, Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, frmBase, ExtCtrls, OleCtrls, StdCtrls, Buttons,
  DB, DBClient, StrUtils, ComCtrls, GFCADLib_TLB, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Math,
  cxSplitter, MakeSQL;

type
  TPrintFNCardForm = class(TBaseForm)
    cdsNormal: TClientDataSet;
    dsNormal: TDataSource;
    dsFabricPrintCard: TDataSource;
    cdsFabricPrintCard: TClientDataSet;
    pnl5: TPanel;
    pnl3: TPanel;
    btn_Save: TSpeedButton;
    btnClose: TSpeedButton;
    lblCar_NO: TLabel;
    edtNormalCar_NO: TEdit;
    pnlCard: TPanel;
    pnl2: TPanel;
    btnAdd: TSpeedButton;
    btnUp: TSpeedButton;
    btnCancel: TSpeedButton;
    btnDown: TSpeedButton;
    cxgridFabricPrintCard: TcxGrid;
    cxdbgtvFabricPrintCard: TcxGridDBTableView;
    cxGridlFabricPrintCard: TcxGridLevel;
    cxspl1: TcxSplitter;
    cxgrid_Fabric_NO: TcxGrid;
    cxgridtv_Fabric_NO: TcxGridDBTableView;
    cxGridl_Fabric_NO: TcxGridLevel;
    sqmmk1: TMakeSQL;
    btn_Query: TSpeedButton;
    btn_Refresh: TSpeedButton;
    rb_Normal: TRadioButton;
    rb_Repair: TRadioButton;
    cbbNormal: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cxgridtv_Fabric_NOCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgridtv_Fabric_NOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxdbgtvFabricPrintCardKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure cbbNormalEnter(Sender: TObject);
    procedure rb_NormalClick(Sender: TObject);

  private
    { Private declarations }
    function CheckData: Boolean;
    procedure Add;
    procedure Cancel;
    procedure Query;
    procedure Refresh;
    procedure SaveFNCardInfo;
    procedure GetNormalFNCardInfo(Condition: string);
  public
    { Public declarations }
    procedure PublicQuery; override;
    procedure PublicSave; override;
    procedure PublicExport; override;
  end;

var
  PrintFNCardForm: TPrintFNCardForm;

implementation

uses ServerDllPub, uGlobal, frmMain, uShowMessage, uLogin, uGridDecorator,
  uAppOption, uDictionary, rptFNCard, uCADInfo;
  

{$R *.dfm}
procedure TPrintFNCardForm.PublicQuery;
Begin
  Refresh
End;

procedure TPrintFNCardForm.PublicSave;
begin
  SaveFNCardInfo;
end;

procedure TPrintFNCardForm.PublicExport;
begin
//  if pgcCard.ActivePageIndex = 0 then
//    TGlobal.SaveDataToFile(cdsNormal, sftXLS)
//  else
//    TGlobal.SaveDataToFile(cdsRepair, sftXLS);
end;

procedure TPrintFNCardForm.Refresh;
var
  RefreshCondition: string;
  iPos: integer;
Begin
  iPos := Pos('-', cbbNormal.Items[1]) - 1;
  RefreshCondition:='';
  if rb_Normal.Checked and (cbbNormal.ItemIndex <> 0) then
    RefreshCondition :='Source = ' +QuotedStr(LeftStr(cbbNormal.Items[cbbNormal.ItemIndex], iPos));
  GetNormalFNCardInfo(RefreshCondition);
End;

procedure TPrintFNCardForm.Query;
var
  QueryCondition: string;
Begin
  QueryCondition := sqmmk1.GetSql;
  if QueryCondition = '' then exit;
  GetNormalFNCardInfo(QueryCondition);
End;

procedure TPrintFNCardForm.GetNormalFNCardInfo (Condition: string);
var
  PrintType: integer;
  vData: OleVariant;
  sCondition, sErrorMsg: WideString;
begin
  try
    ShowMsg('���ڻ�ȡ�����Եȣ�', crHourGlass);
    //��ȡ���򿨵Ŀ�����Ϣ
    PrintType:=ifthen(rb_Repair.Checked, 1, 0);
    sCondition := QuotedStr(Login.CurrentDepartment)+','+ QuotedStr(Condition)+','+IntToStr(PrintType);
    FNMServerObj.GetQueryData(vData,'GetPrintFNCardInfo',sCondition,sErrorMsg);
//    FNMServerObj.GetPrintFNCardInfo(Login.CurrentDepartment, Condition, PrintType, vData, sErrorMsg);
    if sErrorMsg <> '' then
      raise ExceptionEx.CreateResFmt(@ERR_GetPrintFNCardInfo, [sErrorMsg]);

    cdsNormal.Data := vData;
    if cdsNormal.IsEmpty then
      raise Exception.CreateRes(@EMP_PrintFNCardInfo);
    cdsNormal.Filter:='Print_Card = 0';
    cdsNormal.Filtered:=true;

    //copy cdsNormal�Ŀ�ܸ�cdsFabricPrintCard
    cdsFabricPrintCard.Close;
    cdsFabricPrintCard.FieldDefs := cdsNormal.FieldDefs;
    cdsFabricPrintCard.CreateDataSet;
  finally
    ShowMsg('', crDefault);
    cdsNormal.EnableControls;
  end;
  GridDecorator.BindCxViewWithDataSource(cxgridtv_Fabric_NO, dsNormal,True);
  GridDecorator.BindCxViewWithDataSource(cxdbgtvFabricPrintCard, dsFabricPrintCard,True);
end;

procedure TPrintFNCardForm.Add;
  var i, j: Integer;
    sFabric_NO: string;
Begin
  if cxgridtv_Fabric_NO.Controller.SelectedRowCount = 0 then exit;
  if not CheckData then Exit;

  try
    cdsNormal.DisableControls;
    for i :=cxgridtv_Fabric_NO.Controller.SelectedRowCount - 1 downto 0 do
    begin
      with cxgridtv_Fabric_NO do
         sFabric_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Fabric_NO').Index];

      if cdsNormal.Locate('Fabric_NO', sFabric_NO, []) then
      begin
        cdsFabricPrintCard.Append;
        for j:= 0 to cdsNormal.FieldCount - 1 do
          cdsFabricPrintCard.Fields[j].Value := cdsNormal.Fields[j].Value;
        cdsNormal.Edit;
        cdsNormal.FieldByName('Print_Card').Value := 1;
      end
      else
        TMsgDialog.ShowMsgDialog('���ܶ�λ������ţ�', mtWarning);
    end;
  finally
    cdsNormal.EnableControls;
  end;
  cdsNormal.FindNext;
  cdsFabricPrintCard.CheckBrowseMode;

  //�����ƺ��ȸ�һ��ֵ
  // edtNormalCar_NO.Text := Controller.SelectedRows[0].Values[GetColumnByFieldName('Car_NO').Index];
  edtNormalCar_NO.Text:=cdsFabricPrintCard['Car_NO'];
  with cxgridtv_Fabric_NO do
    DataController.ClearSelection;
  rb_Normal.Enabled:=cdsFabricPrintCard.IsEmpty;
  cbbNormal.Enabled:=cdsFabricPrintCard.IsEmpty;
  rb_Repair.Enabled:=cdsFabricPrintCard.IsEmpty;
  btn_Query.Enabled:=cdsFabricPrintCard.IsEmpty;
  btn_Refresh.Enabled:=cdsFabricPrintCard.IsEmpty;
End;

procedure TPrintFNCardForm.Cancel;
  var sFabric_NO: string;
      i: integer;
Begin
  if cxdbgtvFabricPrintCard.Controller.SelectedRowCount = 0 then exit;

  with cdsNormal do
  try
    DisableControls;
    Filtered := false;
    for i := cxdbgtvFabricPrintCard.Controller.SelectedRowCount - 1 downto 0 do
    begin
      with cxdbgtvFabricPrintCard do
         sFabric_NO := Controller.SelectedRows[i].Values[GetColumnByFieldName('Fabric_NO').Index];

      if cdsFabricPrintCard.Locate('Fabric_NO', sFabric_NO, []) then
        cdsFabricPrintCard.Delete;

      if Locate('Fabric_NO', sFabric_NO, []) then
      begin
        Edit;
        FieldByName('Print_Card').Value := 0;
      end;
    end;
  finally
    Filtered := true;
    EnableControls;
  end;
  //�����ƺ��ȸ�һ��ֵ
  with cdsFabricPrintCard do
    edtNormalCar_NO.Text:=ifthen(RecordCount > 0, FieldByName('Car_NO').AsString, '');
  rb_Normal.Enabled:=cdsFabricPrintCard.IsEmpty;
  cbbNormal.Enabled:=cdsFabricPrintCard.IsEmpty;
  rb_Repair.Enabled:=cdsFabricPrintCard.IsEmpty;
  btn_Query.Enabled:=cdsFabricPrintCard.IsEmpty;
  btn_Refresh.Enabled:=cdsFabricPrintCard.IsEmpty;
End;

//�ж�ѡ��Ĳ����ܷ��ӡ��ͬһ�ſ���
function TPrintFNCardForm.CheckData: Boolean;
var i, iSTD_Art_ID, iGF_ID, iSTD_Art_ID_Multi, iGF_ID_Multi: Integer;
    sDepartment, sDepartment_Multi, sJob_NO, sJob_NO_Multi, sMaterial_Quality,
    sMaterial_Quality_Multi,sShade,sShade_Multi, sYarn, sYarn_Multi, sYarnLot, sYarnLot_Multi,sIs_Repair,sIs_Repair_Multi: string;

  function CompareValue(Material_Quality,Shade,Job_NO, sYarn_Multi, sYarnLot_Multi:String; GF_ID, STD_Art_ID: Integer; Department: string;Is_Repair:string): Boolean;
  begin
    if sMaterial_Quality <> Material_Quality then
      raise Exception.CreateResFmt(@INV_UnionCard, ['�������Ͳ�ƥ��']);
     if sShade <> Shade then
      raise Exception.CreateResFmt(@INV_UnionCard, ['��ͬ����ɫ��']);
    if STD_Art_ID = 0 then
      raise Exception.CreateResFmt(@INV_UnionCard, ['û�б�׼����']);
    if sJob_NO <> Job_NO then
      raise Exception.CreateResFmt(@INV_UnionCard, ['��ͬ�ŵ�']);
    if iGF_ID <> GF_ID then
      raise Exception.CreateResFmt(@INV_UnionCard, ['��ͬƷ��']);
    if iSTD_Art_ID <> STD_Art_ID then
      raise Exception.CreateResFmt(@INV_UnionCard, ['��ͬ����']);
    if rb_Repair.Checked and (sDepartment <> Department) then
      raise Exception.CreateResFmt(@INV_UnionCard, ['����ԭ��ͬ���β���']);
    if (sYarn<> sYarn_Multi) and ((Pos('ɴ����',sYarn)>0) or (Pos('ɴ����',sYarn_Multi)>0)) then
      raise Exception.CreateResFmt(@INV_UnionCard, ['���ײ���ͬ��Ʒ�ֲ��ܴ���ͬһ����']);
    if sIs_Repair <> Is_Repair then
      raise Exception.CreateResFmt(@INV_UnionCard, ['�����벻���޲���ͬʱ��']);
    Result := true;
  end;

begin
  Result := False;
  with cxgridtv_Fabric_NO, cxgridtv_Fabric_NO.Controller do
  begin
    if SelectedRecordCount  = 0 then exit;

    iGF_ID := SelectedRows[0].Values[GetColumnByFieldName('GF_ID').Index];
    iSTD_Art_ID := SelectedRows[0].Values[GetColumnByFieldName('STD_Art_ID').Index];
    sJob_NO := SelectedRows[0].Values[GetColumnByFieldName('Job_NO').Index];
    sMaterial_Quality := SelectedRows[0].Values[GetColumnByFieldName('Material_Quality').Index];
    sShade := SelectedRows[0].Values[GetColumnByFieldName('Shade').Index];
    sYarn := SelectedRows[0].Values[GetColumnByFieldName('FN_Special_Yarn').Index];
    sYarnLot := SelectedRows[0].Values[GetColumnByFieldName('Yarn_Lot').Index];
    sIs_Repair := SelectedRows[0].Values[GetColumnByFieldName('Is_Repair').Index];

    if rb_Repair.Checked then
      sDepartment:=SelectedRows[0].Values[GetColumnByFieldName('Department').Index];

    //�ж�ѡ������ĵ�һ����¼�Ƿ���Դ�
    if iSTD_Art_ID = 0 then
      raise Exception.CreateResFmt(@INV_UnionCard, ['û�б�׼����']);

    //�ж�ѡ�������ڲ����Ƿ�����鿨
    for i := 1 to SelectedRowCount - 1 do
    begin
      iGF_ID_Multi := SelectedRows[i].Values[GetColumnByFieldName('GF_ID').Index];
      iSTD_Art_ID_Multi := SelectedRows[i].Values[GetColumnByFieldName('STD_Art_ID').Index];
      sJob_NO_Multi := SelectedRows[i].Values[GetColumnByFieldName('Job_NO').Index];
      sMaterial_Quality_Multi := SelectedRows[i].Values[GetColumnByFieldName('Material_Quality').Index];
      sShade_Multi := SelectedRows[i].Values[GetColumnByFieldName('Shade').Index];
      sYarn_Multi := SelectedRows[i].Values[GetColumnByFieldName('FN_Special_Yarn').Index];
      sYarnLot_Multi := SelectedRows[i].Values[GetColumnByFieldName('Yarn_Lot').Index];
      if rb_Repair.Checked then
        sDepartment_Multi:=SelectedRows[0].Values[GetColumnByFieldName('Department').Index];
      sIs_Repair_Multi := SelectedRows[i].Values[GetColumnByFieldName('Is_Repair').Index];

      if not CompareValue(sMaterial_Quality_Multi,sShade_Multi,sJob_NO_Multi, sYarn_Multi, sYarnLot_Multi, iGF_ID_Multi, iSTD_Art_ID_Multi, sDepartment_Multi,sIs_Repair_Multi) then
        exit;
    end;
  end;

  //�ж��Ƿ���Ժ���ѡ�Ŀ��鿨
  with cdsFabricPrintCard do
  begin
    if Active and (not IsEmpty) then
    begin
      sMaterial_Quality_Multi := FieldByName('Material_Quality').Value;
      sJob_NO_Multi := FieldByName('Job_NO').Value;
      sShade_Multi :=  FieldByName('Shade').Value;
      iGF_ID_Multi := FieldByName('GF_ID').Value;
      iSTD_Art_ID_Multi := FieldByName('STD_Art_ID').Value;
      sYarn_Multi := FieldByName('FN_Special_Yarn').Value;
      sYarnLot_Multi := FieldByName('Yarn_Lot').Value;
      if rb_Repair.Checked then
        sDepartment_Multi:=FieldByName('Department').Value;
      sIs_Repair_Multi := FieldByName('Is_Repair').Value;

      if not CompareValue (sMaterial_Quality_Multi,sShade_Multi,sJob_NO_Multi, sYarn_Multi, sYarnLot_Multi, iGF_ID_Multi, iSTD_Art_ID_Multi, sDepartment_Multi,sIs_Repair_Multi) then Exit;
    end
  end;
  Result := true;
end;

procedure TPrintFNCardForm.SaveFNCardInfo;
var
  RecNO, i, iIsCutCloth, iIsRepairCard: integer;
  sFabric_NO_List, sCar_NO, GF_NO: String;
  sCondition,sFN_Card, sErrorMsg: WideString;
begin
  try
    if cdsFabricPrintCard.RecordCount = 0 then Exit;
    RecNO := cdsNormal.RecNo;
    ShowMsg('���ڱ��������Եȣ�', crHourGlass);
    //��⳵������
    sCar_NO := Trim(edtNormalCar_NO.Text);
    if rb_Normal.Checked and (sCar_NO = '') then
      raise Exception.CreateRes(@INV_CardCarNO);
    iIsCutCloth := IfThen(cdsFabricPrintCard.FieldByName('CutCloth').AsString = '', 0, 1);
    iIsRepairCard:= Ifthen(rb_Normal.Checked, 0, 1);
    //���������б�
    sFabric_NO_List := '';
    with cdsFabricPrintCard do
    begin
      First;
      while not eof do
      begin
        sFabric_NO_List := sFabric_NO_List + FieldByName('Fabric_NO').AsString + ',';
        Next;
      end;
    end;
    sCondition := QuotedStr(sFabric_NO_List)+',' + QuotedStr(sCar_NO)+',' +
                  IntToStr(iIsCutCloth)+','+IntToStr(iIsRepairCard)+','+
                 QuotedStr(Login.LoginName);
    FNMServerObj.SaveDataBySQLEx('SavePrintFNCardInfo',sCondition,sFN_Card,sErrorMsg);
//    FNMServerObj.SavePrintFNCardInfo(sFabric_NO_List, sCar_NO, iIsCutCloth, iIsRepairCard, Login.LoginName, sFN_Card, sErrorMsg);
    if sErrorMsg <> '' then
      raise ExceptionEx.CreateResFmt(@ERR_SaveSavePrintFNCardInfo, [sErrorMsg]);
    //ɾ�����䲼��־
    GF_NO:=cdsFabricPrintCard['GF_NO'];
    cdsFabricPrintCard.EmptyDataSet;
    cdsNormal.DisableControls;
    RecNO:=cdsNormal.RecNo;
    cdsNormal.First;
    for i := 0 to cdsNormal.RecordCount - 1 do
    begin
      if cdsNormal['GF_NO'] = GF_NO then
      begin
        cdsNormal.Edit;
        cdsNormal['CutCloth'] := '';
      end;
      cdsNormal.Next
    end;
    TMsgDialog.ShowMsgDialog('�������ݳɹ�', mtInformation);
  finally
    cdsNormal.RecNo := RecNO;
    cdsNormal.EnableControls;
    ShowMsg('', crDefault);
  end;

  rb_Normal.Enabled:=cdsFabricPrintCard.IsEmpty;
  cbbNormal.Enabled:=cdsFabricPrintCard.IsEmpty;
  rb_Repair.Enabled:=cdsFabricPrintCard.IsEmpty;
  btn_Query.Enabled:=cdsFabricPrintCard.IsEmpty;
  btn_Refresh.Enabled:=cdsFabricPrintCard.IsEmpty;
  //��
  if rb_Normal.Checked then
    rptFNCard.PrintFNCard(sFN_Card, sCar_NO, 2, False)
  else
    raise Exception.CreateResFmt(@MSG_SavePrintFNCardInfoSuccess, [sFN_Card]);
end;

procedure TPrintFNCardForm.FormCreate(Sender: TObject);
begin
  inherited;
  btn_Refresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btn_Query.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  btnAdd.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btnDown.Glyph.LoadFromResourceName(HInstance, RES_DOWNALL);
  btnCancel.Glyph.LoadFromResourceName(HInstance, RES_UP);
  btnUp.Glyph.LoadFromResourceName(HInstance, RES_UPALL);
  btn_Save.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);

  cxgridtv_Fabric_NO.OnDblClick := tGlobal.DblClickAWinControl;
  cxdbgtvFabricPrintCard.OnDblClick := tGlobal.DblClickAWinControl;
  rb_Normal.Checked:=true;
end;

procedure TPrintFNCardForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TPrintFNCardForm.FormDestroy(Sender: TObject);
begin
  inherited;
  PrintFNCardForm := nil;
end;

procedure TPrintFNCardForm.btn_SaveClick(Sender: TObject);
begin
  SaveFNCardInfo;
end;

procedure TPrintFNCardForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TPrintFNCardForm.btn_RefreshClick(Sender: TObject);
begin
  inherited;
  if Sender = btn_Refresh then
    Refresh;
  if Sender = btn_Query then
    Query;
end;

procedure TPrintFNCardForm.btnAddClick(Sender: TObject);
begin
  inherited;
  if Sender = btnDown then
    cxgridtv_Fabric_NO.DataController.SelectAll;

  Add;
end;

procedure TPrintFNCardForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  if Sender = btnUp then
    cxdbgtvFabricPrintCard.DataController.SelectAll;
  Cancel;
end;

procedure TPrintFNCardForm.cxgridtv_Fabric_NOCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  col, STD_Art_ID: integer;
  Urgent, CutCloth, Hold, R_Finish: string;
begin
  inherited;
  if AViewInfo.Focused then
    exit;

  col := cxgridtv_Fabric_NO.GetColumnByFieldName('STD_Art_ID').Index;
  STD_Art_ID := AViewInfo.GridRecord.Values[col];
  if STD_Art_ID = 0 then
  begin
    ACanvas.Brush.Color := clInfoBk;
    ACanvas.Font.Color := clInfoBk xor $000FFFFFF;
  end;

  col := cxgridtv_Fabric_NO.GetColumnByFieldName('Urgent').Index;
  Urgent := AViewInfo.GridRecord.Values[col];
  if Urgent <> '' then
    ACanvas.Font.Color:=RGB(255,0,0);

  col := cxgridtv_Fabric_NO.GetColumnByFieldName('CutCloth').Index;
  CutCloth := AViewInfo.GridRecord.Values[col];
  if Urgent = '��' then
    ACanvas.Font.Color:=RGB(0,255,255);

  col := cxgridtv_Fabric_NO.GetColumnByFieldName('Hold').Index;
  Hold := AViewInfo.GridRecord.Values[col];
  if Urgent = 'Hold' then
    ACanvas.Font.Color:=RGB(0,0,255);

  col := cxgridtv_Fabric_NO.GetColumnByFieldName('R_Finish').Index;
  R_Finish := AViewInfo.GridRecord.Values[col];
  if R_Finish = 'N' then
    ACanvas.Font.Color:=RGB(255,0,255);
end;

procedure TPrintFNCardForm.cxgridtv_Fabric_NOKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if key = vk_Return then
    Add;
end;

procedure TPrintFNCardForm.cxdbgtvFabricPrintCardKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = vk_Return then
    Cancel;
end;

procedure TPrintFNCardForm.cbbNormalEnter(Sender: TObject);
begin
  inherited;
  rb_Normal.Checked;
end;

procedure TPrintFNCardForm.FormActivate(Sender: TObject);
begin
  inherited;
  Application.ProcessMessages;
  //ˢ�½�������
  PostMessage(Handle, WM_KEYDOWN, VK_F5, 0);
  //���������Դ
  with Dictionary.cds_MaterialFlowList do
  try
    Filter := 'Current_Department=' + QuotedStr(Login.CurrentDepartment) + ' AND Flow_Description=' + QuotedStr('������Դ');
    Filtered := True;
    TGlobal.FillItemsFromDataSet(Dictionary.cds_MaterialFlowList, 'Relation_Department', 'Relation_Department_CHN', '-', cbbNormal.Items);
  finally 
    Filtered := false;
  end;
  cbbNormal.Items.Insert(0, 'ȫ��');
  cbbNormal.ItemIndex := 0;
  OnActivate:=nil;
end;

procedure TPrintFNCardForm.rb_NormalClick(Sender: TObject);
begin
  inherited;
  cbbNormal.Enabled := Sender = rb_Normal;
  if Sender = rb_Normal then
  begin
    btn_Save.Caption:='��ӡ(&P)';
    cbbNormal.Color := clWindow;
  end;
  if Sender = rb_Repair then
  begin
    btn_Save.Caption:='����(&S)';
    cbbNormal.Color := clMenu;
  end;
  if cdsNormal.Active then
    cdsNormal.EmptyDataSet;
  if cdsFabricPrintCard.Active then
    cdsFabricPrintCard.EmptyDataSet;
end;

end.


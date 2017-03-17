unit frmPlan;
{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmPlan.pas                                                   }
{       �������� 2004-10-7 16:49:44                                            }
{       ������Ա zhangjy                                                       }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{       ������Ҫ����/SQL����˵��                                               }
{       �������� ���Ż�̨�ƻ�                                                  }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxSplitter, ExtCtrls, StdCtrls, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, DateUtils,
  cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  DBClient, StrUtils, Menus, frmBase, ComCtrls, ToolWin, uFNMArtInfo, uGTT,
  ADODB, Math, Buttons, Mask, cxGridCustomPopupMenu, cxGridPopupMenu,
  ImgList, Grids, DBGrids, CheckLst, cxGridBandedTableView,
  cxGridDBBandedTableView;

type
  TFNCard = class(TTask)
  private
    FWhite_Type: string; //�ذ�/Ư��
    FSeconds: Double; //������ʱ
    FPrepare_Type: string; //׼������
    FPrepare_Minute: Integer; //׼��ʱ��
    FGF_ID: Integer;
    FGF_NO: string;
    FJob_NO: string;
    FPpo_NO: string;
    FCustomer: string;
    FDelivery_Date: TDateTime;
//  FLayer: Integer;
    FQuantity: Double;
    FStep_NO: Integer;
    FOperation_Code: string;
    FOperation_CHN: string;
    FWV_IsFinished: string;
    FUrgent_Type: string;
    FIs_Cut_Cloth: Boolean;
    FIs_Hold: Integer;
    FFact_Art_ID: Integer;
    FStatus: string;
    FFact_Begin_Time: TDateTime;
  published
    property White_Type: string read FWhite_Type write FWhite_Type;
    property Seconds: Double read FSeconds write FSeconds;
    property Prepare_Type: string read FPrepare_Type write FPrepare_Type;
    property Prepare_Minute: Integer read FPrepare_Minute write FPrepare_Minute;
    property GF_ID: Integer read FGF_ID write FGF_ID;
    property GF_NO: string read FGF_NO write FGF_NO;
    property Job_NO: string read FJob_NO write FJob_NO;
    property Ppo_NO: string read FPpo_NO write FPpo_NO;
    property Customer: string read FCustomer write FCustomer;
    property Delivery_Date: TDateTime read FDelivery_Date write FDelivery_Date;
//    property Layer: Integer read FLayer write FLayer;
    property Quantity: Double read FQuantity write FQuantity;
    property Step_NO: Integer read FStep_NO write FStep_NO;
    property Operation_Code: string read FOperation_Code write FOperation_Code;
    property Operation_CHN: string read FOperation_CHN write FOperation_CHN;
    property WV_IsFinished: string read FWV_IsFinished write FWV_IsFinished;
    property Urgent_Type: string read FUrgent_Type write FUrgent_Type;
    property Is_Cut_Cloth: Boolean read FIs_Cut_Cloth write FIs_Cut_Cloth;
    property Is_Hold: Integer read FIs_Hold write FIs_Hold;
    property Fact_Art_ID: Integer read FFact_Art_ID write FFact_Art_ID;
    property Status: string read FStatus write FStatus;
    property Fact_Begin_Time: TDateTime read FFact_Begin_Time write FFact_Begin_Time;
  end;
  TPlanForm = class(TBaseForm)
    pnlLeft: TPanel;
    cxsplLeft: TcxSplitter;
    pnlClient: TPanel;
    grpPlanTask: TGroupBox;
    dsPlanTaskInfo: TDataSource;
    cdsPlanTaskInfo: TClientDataSet;
    cdsPlanListInfo: TClientDataSet;
    cdsPlanInfo: TClientDataSet;
    pgcPlanList: TPageControl;
    tsPlanListChart: TTabSheet;
    tsPlanListTable: TTabSheet;
    grpPlanList: TGroupBox;
    cxgridPlanListInfo: TcxGrid;
    cxgridtvPlanListInfo: TcxGridDBTableView;
    cxGridlPlanListInfo: TcxGridLevel;
    dsPlanListInfo: TDataSource;
    pmFNCard: TPopupMenu;
    gttFNCard: TGTT;
    pnlBottom: TPanel;
    btnSave: TButton;
    btnClose: TButton;
    btnRefresh: TButton;
    cxgdbcPlanListInfoGF_ID1: TcxGridDBColumn;
    cxgdbcPlanListInfoGF_NO1: TcxGridDBColumn;
    cxgdbcPlanListInfoJob_NO1: TcxGridDBColumn;
    cxgdbcPlanListInfoDelivery_Date1: TcxGridDBColumn;
    cxgdbcPlanListInfoMachine_ID1: TcxGridDBColumn;
    cxgdbcPlanListInfoFN_Card1: TcxGridDBColumn;
    cxgdbcPlanListInfoIs_Cut_Cloth1: TcxGridDBColumn;
    cxgdbcPlanListInfoIs_Hold1: TcxGridDBColumn;
    cxgdbcPlanListInfoCar_NO1: TcxGridDBColumn;
    cxgdbcPlanListInfoQuantity1: TcxGridDBColumn;
    cxgdbcPlanListInfoOperation_CHN1: TcxGridDBColumn;
    cxgdbcPlanListInfoType1: TcxGridDBColumn;
    cxgdbcPlanListInfoSeconds1: TcxGridDBColumn;
    cxgdbcPlanListInfoPrepare_Type1: TcxGridDBColumn;
    cxgdbcPlanListInfoPrepare_Minute1: TcxGridDBColumn;
    cxgdbcPlanListInfoWV_IsFinished1: TcxGridDBColumn;
    cxgdbcPlanListInfoFact_Begin_Time1: TcxGridDBColumn;
    cxgdbcPlanListInfoPlan_Begin_Time1: TcxGridDBColumn;
    cxgdbcPlanListInfoPlan_End_Time1: TcxGridDBColumn;
    cxgdbcPlanListInfoPlanner1: TcxGridDBColumn;
    cxgdbcPlanListInfoPlan_Time1: TcxGridDBColumn;
    cxgridPlanTaskInfo: TcxGrid;
    cxGridlPlanTaskInfo: TcxGridLevel;
    lblFNCard: TLabel;
    btnFind: TButton;
    cxgpmPlanList: TcxGridPopupMenu;
    edtFNCard: TEdit;
    cxgdbcPlanListInfoUrgent_Type1: TcxGridDBColumn;
    btnSort: TButton;
    btnExit: TButton;
    btnArrange: TSpeedButton;
    GroupBox1: TGroupBox;
    lstMachineModel: TListBox;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    edtGFNO: TEdit;
    btnQuery: TButton;
    GroupBox2: TGroupBox;
    clbFNCardList: TCheckListBox;
    chbAll: TCheckBox;
    Label1: TLabel;
    btnDelete: TButton;
    Label2: TLabel;
    lblMachine: TLabel;
    cxgridtvPlanTaskInfo: TcxGridDBBandedTableView;
    btnAutoPlan: TButton;
    cdsAutoPlan: TClientDataSet;
    cdsRoll: TClientDataSet;
    cxgdbcPlanListInfoWhite_Type: TcxGridDBColumn;
    cdsAlertRemark: TClientDataSet;
    cxgdbcPlanListInfoHoldByAff: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure gttFNCardTaskDblClick(Task: TTask);
    procedure btnRefreshClick(Sender: TObject);
    procedure cxgridtvPlanListInfoCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgridtvPlanTaskInfoCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure gttFNCardMachineDragDrop(Machine: TMachine;
      posTime: TDateTime);
//    procedure btnRefreshTaskClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure gttFNCardBeforeChangeMachine(task: TTask;
      newMachine: TMachine; newBeginTime: TDateTime; var Action: Boolean);
    procedure btnAutoArrangeCurTaskClick(Sender: TObject);
//    procedure btnAutoArrangeAllTaskClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure gttFNCardBeforeTaskMove(task: TTask; newBeginTime: TDateTime;
      var Action: Boolean);
    procedure pmFNCardPopup(Sender: TObject);
    procedure edtFNCardEnter(Sender: TObject);
    procedure edtFNCardExit(Sender: TObject);
    procedure btnSortClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnArrangeClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure lstMachineModelDblClick(Sender: TObject);
    procedure lstMachineModelClick(Sender: TObject);
    procedure chbAllClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnAutoPlanClick(Sender: TObject);
    procedure cxgridtvPlanTaskInfoDblClick(Sender: TObject);
  private
    { Private declarations }
    CurMachine_Model: string; //��ǰ��̨����
    CurFNCard: TFNCard; //��ǰ����
    CurMachine_ID: string; //��ǰ��̨
    procedure AddSubMenuItem(aMenuItem: TMenuItem; aCaption: string;
      aOnClick: TNotifyEvent; aTag: Integer; aHint: string = ''; aAutoCheck: Boolean = False; aRadioItem: Boolean = False);
    procedure FNCardMenuClick(Sender: TObject);
    procedure CreateFNCardPopupMenu(cds: TClientDataSet; Machine_Model: string);
    function CheckAllowDrop(Machine: TMachine; Operation_Code: string): Boolean;
    procedure AddMachineToTaskChart(gtt: TGTT);
    function AddFNCardToTaskChart(cds: TClientDataSet; Begin_Time: TDatetime;
      UseTime: Integer; var pm: TPopupMenu; gtt: TGTT; IsNew: Boolean = False): TFNCard;
    procedure FindTask(AFN_Card: string);
    procedure LocateLastTask(Machine_Model: string);
    function GetChangeData(var cdsPlan: TClientDataSet; gtt: TGTT; var vData: OleVariant): Boolean;
    procedure ShowFNCardPropertyForm;
    procedure LoadPlanListInfo;
//    function GetMaxFactBeginTime(Machine:TMachine):TDateTime;
    procedure InsertFNCardToTaskChart(Machine: TMachine; InsertTime: TDateTime);
    procedure Initialize;
    procedure GetPlanListInfo();
    procedure GetPlanTaskInfo();
    procedure GetData(Index: Integer);
    procedure RefreshData(Index: Integer);
    procedure GetCurrentValue(Task: TComponent); //(Task: TTask);
    procedure SavePlanInfo();
    procedure SaveData();
    procedure SignMachine(Machine_Model: string);
    procedure AutoPlan(sType:string);
    function CheckRoll(sFNCard, sOperationCode:string):Boolean;
//    procedure AutoArrangePlan(sOperation_Code: string);
  public
    { Public declarations }
    IsColorChanged: Boolean; //��ɫ�Ƿ�ı�
    procedure PublicQuery; override;
    procedure PublicExport; override;
    procedure PublicSave; override;
    procedure GetAlert();
  end;

var
  PlanForm: TPlanForm;
implementation

uses frmFNCardProperty, ServerDllPub, uGlobal, frmMain, UShowMessage, uLogin, uGridDecorator,
  uAppOption, uDictionary, frmAutoPlanShift;

{$R *.dfm}

procedure TPlanForm.PublicQuery;
begin
  RefreshData(0);
end;

procedure TPlanForm.PublicExport;
begin
  TGlobal.SaveDataToFile(cdsPlanTaskInfo, sftXLS);
end;

procedure TPlanForm.PublicSave;
begin
  SaveData();
end;

function TPlanForm.CheckAllowDrop(Machine: TMachine; Operation_Code: string): Boolean;
begin
  Result := Dictionary.cds_OperationMapMachineModel.Locate('Machine_Model;Operation_Code', VarArrayOf([LeftStr(Machine.Name, 2), Operation_Code]), []);
  if not Result then
    TMsgDialog.ShowMsgDialog('��ǰ�����ܲ�����϶���' + #13#10 + Machine.Caption + #13#10 + '����!', 2);
end;

procedure TPlanForm.AddSubMenuItem(aMenuItem: TMenuItem; aCaption: string;
  aOnClick: TNotifyEvent; aTag: Integer; aHint: string; aAutoCheck: Boolean; aRadioItem: Boolean);
var MenuItem: TMenuItem;
begin
  MenuItem := TMenuItem.Create(Self);
  MenuItem.Caption := aCaption;
  MenuItem.AutoCheck := aAutoCheck;
  MenuItem.RadioItem := aRadioItem;
  MenuItem.OnClick := aOnClick;
  MenuItem.Tag := aTag;
  MenuItem.Hint := aHint;
  aMenuItem.Add(MenuItem);
end;

procedure TPlanForm.ShowFNCardPropertyForm;
begin
  try
    FNCardPropertyForm := TFNCardPropertyForm.Create(Self);
    with FNCardPropertyForm.FNCardRec do
    begin
      FN_Card := CurFNCard.Name;
      Machine_ID := CurFNCard.MachineName;
      Machine_Name := CurFNCard.MachineName;
      Step_NO := CurFNCard.Step_NO;
      Operation_Code := CurFNCard.Operation_Code;
//      Operation_ENG := CurFNCard.Operation_ENG;
      Operation_CHN := CurFNCard.Operation_CHN;
      GF_ID := CurFNCard.GF_ID;
      GF_NO := CurFNCard.GF_NO;
      Job_NO := CurFNCard.Job_NO;
      Ppo_NO := CurFNCard.Ppo_NO;
      Customer := CurFNCard.Customer;
      Delivery_Date := CurFNCard.Delivery_Date;
      Quantity := CurFNCard.Quantity;
      White_Type := CurFNCard.White_Type;
      Urgent_Type := CurFNCard.Urgent_Type;
      Is_Cut_Cloth := CurFNCard.Is_Cut_Cloth;
      Is_Hold := CurFNCard.Is_Hold;
      Fact_Art_ID := CurFNCard.Fact_Art_ID;
      Status := CurFNCard.Status;
      Plan_Begin_Time := CurFNCard.BeginTime;
      Plan_End_Time := CurFNCard.EndTime;
      Fact_Begin_Time := CurFNCard.Fact_Begin_Time;
    end;
    if FNCardPropertyForm.ShowModal = mrOK then
      FNCardPropertyForm.Free;
  finally
    FreeAndNil(FNCardPropertyForm);
  end;
end;

procedure TPlanForm.FNCardMenuClick(Sender: TObject);
begin
  if pgcPlanList.ActivePageIndex = 1 then
    CurFNCard := TFNCard(gttFNCard.GetTaskByName(cdsPlanListInfo.FieldValues['FN_Card']));
  case TMenuItem(Sender).Tag of
    0: ;
    1: RefreshData(0);
    2: begin
        gttFNCard.DeleteTask(CurFNCard);
        if cdsPlanListInfo.Locate('FN_Card', CurFNCard.Name, []) then
          cdsPlanListInfo.Delete;
       end;
    3: if TMsgDialog.ShowMsgDialog('�Ƿ�ȷ�������ǰ��̨[' + CurFNCard.MachineName + ']�����п���?', mtConfirmation, [mebYes, mebNo], mebYes) = mrYes then
        gttFNCard.DeleteMachineTask(CurFNCard.Machine);
    4: if TMsgDialog.ShowMsgDialog('�Ƿ�ȷ��������п���?', mtConfirmation, [mebYes, mebNo], mebYes) = mrYes then
        gttFNCard.DeleteAllTask;
    5: SaveData;
    6: begin
        if CurFNCard.Prepare_Type <> LeftStr(TMenuItem(Sender).Caption, Pos('(', TMenuItem(Sender).Caption) - 1) then
        begin
          if Dictionary.cds_PrepareTypeList.Locate('Prepare_Type', CurFNCard.Prepare_Type, []) then
            CurFNCard.UseTime := CurFNCard.UseTime - Dictionary.cds_PrepareTypeList.FieldByName('Prepare_Minute').AsInteger +
              StrToInt(TMenuItem(Sender).Hint)
          else
            CurFNCard.UseTime := CurFNCard.UseTime + StrToInt(TMenuItem(Sender).Hint);
          CurFNCard.Prepare_Type := LeftStr(TMenuItem(Sender).Caption, Pos('(', TMenuItem(Sender).Caption) - 1);
          CurFNCard.Prepare_Minute := StrToInt(TMenuItem(Sender).Hint);
        end;
       end;
    7: ShowFNCardPropertyForm;
  else ;
  end;
end;

procedure TPlanForm.CreateFNCardPopupMenu(cds: TClientDataSet; Machine_Model: string);
begin
  with cds do
  begin
    try
      pmFNCard.Items.Clear;
      AddSubMenuItem(pmFNCard.Items, 'ˢ��(&R)...', FNCardMenuClick, 1);
      AddSubMenuItem(pmFNCard.Items, '-', nil, 0);
      AddSubMenuItem(pmFNCard.Items, 'ɾ����ǰ���żƻ�(&D)...', FNCardMenuClick, 2);
      AddSubMenuItem(pmFNCard.Items, '�����ǰ��̨���п���(&E)...', FNCardMenuClick, 3);
      AddSubMenuItem(pmFNCard.Items, '������п���(&A)...', FNCardMenuClick, 4);
      AddSubMenuItem(pmFNCard.Items, '����(&S)...', FNCardMenuClick, 5);
      AddSubMenuItem(pmFNCard.Items, '-', nil, 0);
      Filtered := False;
      Filter := 'Machine_Model = ' + QuotedStr(Machine_Model);
      Filtered := True;
      if not IsEmpty then
      begin
        AddSubMenuItem(pmFNCard.Items, '׼������(&T)', nil, 0);
        First;
        while not Eof do
        begin
          AddSubMenuItem(pmFNCard.Items[7], FieldByName('Prepare_Type').AsString +
            '(' + FieldByName('Prepare_Minute').AsString + '����)', FNCardMenuClick, 6, FieldByName('Prepare_Minute').AsString, True, True);
          Next;
        end;
      end;
      AddSubMenuItem(pmFNCard.Items, '����(&P)...', FNCardMenuClick, 7);
    except
      raise;
    end;
  end;
end;

function TPlanForm.GetChangeData(var cdsPlan: TClientDataSet; gtt: TGTT; var vData: OleVariant): Boolean;
var i: Integer;
begin
  Result := False;
  with cdsPlan do
  begin
    if not Active then Exit;
    with gtt do
    begin
      if (GetTaskList(dsAdd).Count > 0) then
      begin
        for i := 0 to GetTaskList(dsAdd).Count - 1 do
        begin
          Append;
          FieldValues['GF_ID'] := TFNCard(GetTaskList(dsAdd).Items[i]).GF_ID;
          FieldValues['Job_NO'] := TFNCard(GetTaskList(dsAdd).Items[i]).Job_NO;
          FieldValues['FN_Card'] := TFNCard(GetTaskList(dsAdd).Items[i]).Name;
//          FieldValues['Layer'] := TFNCard(GetTaskList(dsAdd).Items[i]).Layer;
          FieldValues['Quantity'] := TFNCard(GetTaskList(dsAdd).Items[i]).Quantity;
          FieldValues['Step_NO'] := TFNCard(GetTaskList(dsAdd).Items[i]).Step_NO;
          FieldValues['Operation_Code'] := TFNCard(GetTaskList(dsAdd).Items[i]).Operation_Code;
          FieldValues['Machine_ID'] := TFNCard(GetTaskList(dsAdd).Items[i]).MachineName;
          FieldValues['White_Type'] := TFNCard(GetTaskList(dsAdd).Items[i]).White_Type;
          FieldValues['Seconds'] := TFNCard(GetTaskList(dsAdd).Items[i]).Seconds;
          FieldValues['Prepare_Type'] := TFNCard(GetTaskList(dsAdd).Items[i]).Prepare_Type;
          FieldValues['Prepare_Minute'] := TFNCard(GetTaskList(dsAdd).Items[i]).Prepare_Minute;
          FieldValues['Current_Department'] := Login.CurrentDepartment;
          FieldValues['Plan_Begin_Time'] := TFNCard(GetTaskList(dsAdd).Items[i]).BeginTime;
          FieldValues['Plan_End_Time'] := TFNCard(GetTaskList(dsAdd).Items[i]).EndTime;
          FieldValues['Planner'] := Login.LoginName;
          FieldValues['Plan_Time'] := TGlobal.GetServerTime;
        end;
      end;
      if (GetTaskList(dsUpdate).Count > 0) then
      begin
        for i := 0 to GetTaskList(dsUpdate).Count - 1 do
        begin
          if Locate('FN_Card', TTask(GetTaskList(dsUpdate).Items[i]).Name, []) then
          begin
            Edit;
            FieldValues['Machine_ID'] := TTask(GetTaskList(dsUpdate).Items[i]).MachineName;
            FieldValues['Plan_Begin_Time'] := TTask(GetTaskList(dsUpdate).Items[i]).BeginTime;
            // FieldValues['Plan_End_Time'] := TTask(GetTaskList(dsUpdate).Items[i]).EndTime;
            FieldValues['Plan_End_Time'] := IncMinute(TTask(GetTaskList(dsUpdate).Items[i]).BeginTime, TTask(GetTaskList(dsUpdate).Items[i]).UseTime);
            FieldValues['Prepare_Type'] := TFNCard(GetTaskList(dsUpdate).Items[i]).Prepare_Type;
            FieldValues['Prepare_Minute'] := TFNCard(GetTaskList(dsUpdate).Items[i]).Prepare_Minute;
            cdsPlan.Post;
          end;
        end;
      end;
      if (GetTaskList(dsDelete).Count > 0) then
      begin
        for i := 0 to GetTaskList(dsDelete).Count - 1 do
          if cdsPlan.Locate('FN_Card', TTask(GetTaskList(dsDelete).Items[i]).Name, []) then
            cdsPlan.Delete;
      end;
    end;
    if cdsPlan.State in [dsInsert, dsEdit] then cdsPlan.Post;
    Result := (ChangeCount > 0);

    if Result then
      vData := Delta
    else
      gttFNCard.Post(dsAll); //����������仰 Added by wlx
  end;
end;

procedure TPlanForm.Initialize;
var
  dNow: TDateTime;
begin
  dNow := TGlobal.GetServerTime;
  gttFNCard.UCurrentTime := dNow;
  gttFNCard.UStartAt := IncMinute(dNow, -1);
  gttFNCard.UEndAt := IncHour(dNow, 72);
  IsColorChanged := False;
  CurMachine_Model := '';
  CurFNCard := nil;
  pgcPlanList.ActivePageIndex := 0;
  lstMachineModel.Items.Text := Dictionary.GetItemList('��̨����',Login.CurrentDepartment,'');
  AddMachineToTaskChart(gttFNCard); //��ʼ��ʱ���ػ���
  LoadPlanListInfo; //������������
end;

procedure TPlanForm.GetPlanTaskInfo();
var vData0, vData1, vData2: OleVariant;
  sErrorMsg: WideString;
  i: Integer;
begin
  try
    ShowMsg('���ڻ�ȡ�����Եȣ�', crHourGlass);
    //��ȡ���ſ�������
    FNMServerObj.GetPlanInfo(vData0, vData1, vData2, CurMachine_Model, Login.CurrentDepartment, 0, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
    cdsPlanTaskInfo.Data := vData0;
    //���cxGrid
    GridDecorator.BindCxViewWithDataSource(cxgridtvPlanTaskInfo, dsPlanTaskInfo, True);
    GridDecorator.HideFields(cxgridtvPlanTaskInfo,['GF_ID','Times','Is_Cut_Cloth','Is_Hold','WV_IsFinished','Fact_Art_ID','Step_NO','Status','Operation_Code','Operation_CHN']);
    //set band index
    with cxgridtvPlanTaskInfo do
    begin
      for i := 0 to ColumnCount - 1 do
      begin
        if (Columns[i].DataBinding.FieldName <> 'GF_NO') and (Columns[i].DataBinding.FieldName <> 'FN_Card')
           and (Columns[i].DataBinding.FieldName <> 'Quantity') then
          cxgridtvPlanTaskInfo.Columns[i].Position.BandIndex := 1;
        if Columns[i].DataBinding.FieldName = 'Operation_CHN' then
         Columns[i].GroupIndex := 0;
      end;
      ViewData.Expand(true);
      ApplyBestFit(nil);
    end;
    GridDecorator.AddGroupFooter(cxgridtvPlanTaskInfo, 0, ['FN_Card','Quantity'],[skCount,skSum]);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TPlanForm.GetPlanListInfo();
var vData0, vData1, vData2: OleVariant;
  sErrorMsg: WideString;
begin
  try
    ShowMsg('���ڻ�ȡ�����Եȣ�', crHourGlass);
    FNMServerObj.GetPlanInfo(vData0, vData1, vData2, '', Login.CurrentDepartment, 1, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
    cdsPlanListInfo.Data := vData0;
    cdsPlanInfo.Data := vData1;
    cxgridtvPlanListInfo.DataController.Groups.FullExpand;
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TPlanForm.GetData(Index: Integer);
begin
  Screen.Cursor := crHourGlass;
  case Index of
    0: GetPlanListInfo;
    1: GetPlanTaskInfo;
  end;
  Screen.Cursor :=  crDefault
end;

procedure TPlanForm.RefreshData(Index: Integer);
begin
  ShowMsg('���ڶ�ȡ���ݡ�����', crHourGlass);
  try
    case Index of
      0: begin
          with gttFNCard do
          begin
            if (GetTaskList(dsAdd).Count > 0) or (GetTaskList(dsUpdate).Count > 0) or (GetTaskList(dsDelete).Count > 0) then
              if TMsgDialog.ShowMsgDialog('ϵͳ��⵽�������񱻸Ķ�������Ҫ�������ˢ��������', mtConfirmation, [mebYes, mebNo], mebYes) = mrYes then
                SaveData;
            LoadPlanListInfo;
          end;
        end;
      1: begin
          if lstMachineModel.ItemIndex = -1 then Exit;
          with gttFNCard do
          begin
            if (GetTaskList(dsAdd).Count > 0) or (GetTaskList(dsUpdate).Count > 0) or (GetTaskList(dsDelete).Count > 0) then
              if TMsgDialog.ShowMsgDialog('ϵͳ��⵽�������񱻸Ķ�������Ҫ�������ˢ��������', mtConfirmation, [mebYes, mebNo], mebYes) = mrYes then
                SaveData;
          //  if GetTaskList(dsAdd).Count > 0 then
          //    LoadPlanListInfo;
            GetData(1);
          end;
        end;
    else ;
    end;
  finally
    ShowMsg('', crDefault);
  end;
end;

{procedure TPlanForm.AutoArrangePlan(sOperation_Code: string);
var
  sErrorMsg: WideString;
begin
  try
    ShowMsg('ϵͳ�����Զ����żƻ�,���Եȣ�', crHourGlass);
    FNMServerObj.AutoArrangePlan(sOperation_Code,Login.CurrentDepartment,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TMsgDialog.ShowMsgDialog('�Զ����żƻ��ɹ�', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;
 }

procedure TPlanForm.SavePlanInfo();
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  try
    ShowMsg('���ڱ��������Եȣ�', crHourGlass);
    if not GetChangeData(cdsPlanInfo, gttFNCard, vData) then
      Exit;

    if MessageBox(0, '���Ƿ�ȷ���������ݣ�', 'ϵͳȷ��', MB_OKCANCEL + MB_ICONQUESTION + MB_DEFBUTTON2) = IDCANCEL then Exit;
    FNMServerObj.SaveBaseTableInfo(vData, 'fnPlan', 'FN_Card,Step_NO', sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
    cdsPlanInfo.MergeChangeLog;
    gttFNCard.Post(dsAll);
    TMsgDialog.ShowMsgDialog('�������ݳɹ�', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TPlanForm.SaveData();
begin
  SavePlanInfo();
end;

procedure TPlanForm.AddMachineToTaskChart(gtt: TGTT);
var Machine: TMachine;
begin
  with Dictionary.cds_FinishMachineList do
  begin
    if not Active then Exit;
    Filter := 'Department=' + QuotedStr(Login.CurrentDepartment);
    Filtered := True;
    First;
    gtt.DeleteAllMachine;
    try
      while not Eof do
      begin
        Machine := TMachine.Create(Self);
        Machine.Name := FieldByName('Machine_ID').AsString;
        Machine.Caption := FieldByName('Machine_Model_CHN').AsString;
        Machine.ShowHint := True;
        Machine.Tag := FieldByName('Status').AsInteger;
        Machine.Enabled := Machine.Tag = 0;
        if Machine.Tag  <> 0 then
        begin
          Machine.Hint := 'ͣ��';
          Machine.Font.Color := clRed;
        end;
        gtt.AddMachine(Machine);
        Next;
      end;
    except
      raise;
    end;
  end;
end;

procedure TPlanForm.LoadPlanListInfo;
var StartAt, EndAt: TDateTime;
begin
  GetData(0);
  with cdsPlanListInfo do
  begin
    gttFNCard.DeleteAllTask; //������п���
    if not Active or IsEmpty() then Exit;
    First;
    //Revised BY WLX
    {
      ���Fact_Begin_Time is null ��ô Plan_Begin_Time>CurrentTime ,�ں�̨�Ѿ������ˡ�
      ������� Fact_Begin_Time is not null ��ô���ܴ��� Plan_Begin_Time<CurrentTime �ÿ��ܣ���̨û�е����������
    }
    if FieldByName('Plan_Begin_Time').AsDateTime < FieldByName('CurrentTime').AsDateTime then
      StartAt := FieldByName('Plan_Begin_Time').AsDateTime
    else
      StartAt := FieldByName('CurrentTime').AsDateTime;
    gttFNCard.UCurrentTime := FieldByName('CurrentTime').AsDateTime;
    gttFNCard.UStartAt := StartAt;
    EndAt := IncMinute(FieldByName('CurrentTime').AsDateTime, 2 * 24 * 60); //Ĭ�Ͻ���ʱ��Ϊ��ǰʱ�������

    while not Eof do
    begin
      AddFNCardToTaskChart(cdsPlanListInfo,
        FieldByName('Plan_Begin_Time').AsDateTime,
        MinutesBetween(FieldByName('Plan_Begin_Time').AsDateTime, FieldByName('Plan_End_Time').AsDateTime),
        pmFNCard, gttFNCard);
      if FieldByName('Plan_End_Time').AsDateTime > EndAt then //Revised BY WLX
        EndAt := FieldByName('Plan_End_Time').AsDateTime;
      Next;
    end;
    gttFNCard.UEndAt := EndAt; //Revised BY WLX   ���ܴ���ĳ���������ʱ�䳬����ǰʱ���һ�죬����...
  end;
  gttFNCard.Post(dsAll);
end;

function TPlanForm.AddFNCardToTaskChart(cds: TClientDataSet; Begin_Time: TDatetime;
  UseTime: Integer; var pm: TPopupMenu; gtt: TGTT; IsNew: Boolean): TFNCard;
var Seconds: Double;
  Machine_ID, Prepare_Type: string;
  Prepare_Minute: Integer;
  DataStatus: TDataStatus;
  Fact_Begin_Time: TDateTime;
begin
  Result := nil;
  if IsNew then
  begin
    DataStatus := dsAdd;
    Seconds := UseTime;
    Prepare_Type := '';
    Prepare_Minute := 0;
    Machine_ID := CurMachine_ID;
    Fact_Begin_Time := StrToDateTime('1899-12-30');
  end else
  begin
    DataStatus := dsNone;
    Seconds := cds.FieldByName('Seconds').ASFloat;
    Prepare_Type := cds.FieldByName('Prepare_Type').AsString;
    Prepare_Minute := cds.FieldByName('Prepare_Minute').AsInteger;
    Machine_ID := cds.FieldByName('Machine_ID').AsString;
    Fact_Begin_Time := cds.FieldByName('Fact_Begin_Time').AsDateTime;
  end;
  with cds do
  begin
    if not Active or IsEmpty then Exit;
    try
      Result := TFNCard.Create(nil);
      Result.Name := FieldByName('FN_Card').AsString;
      Result.Caption := FieldByName('FN_Card').AsString;
      Result.White_Type := Trim(FieldByName('White_Type').AsString);
      if Result.White_Type = '�ذ�' then
        Result.BorderColor := clLime;
      Result.Seconds := Seconds;
      Result.Prepare_Type := Prepare_Type;
      Result.Prepare_Minute := Prepare_Minute;
      Result.GF_ID := FieldByName('GF_ID').AsInteger;
      Result.GF_NO := FieldByName('GF_NO').AsString;
      Result.Job_NO := FieldByName('Job_NO').AsString;
      Result.Ppo_NO := FieldByName('Ppo_NO').AsString;
      Result.Customer := FieldByName('Customer').AsString;
      Result.Delivery_Date := FieldByName('Delivery_Date').AsDateTime;
      Result.Quantity := FieldByName('Quantity').AsFloat;
      Result.Step_NO := FieldByName('Step_NO').AsInteger;
      Result.Operation_Code := FieldByName('Operation_Code').AsString;
      Result.Operation_CHN := FieldByName('Operation_CHN').AsString;
      Result.WV_IsFinished := FieldByName('WV_IsFinished').AsString;
      Result.Urgent_Type := FieldByName('Urgent_Type').AsString;
      Result.Is_Cut_Cloth := FieldByName('Is_Cut_Cloth').AsBoolean;
      Result.Is_Hold := FieldByName('Is_Hold').AsInteger;
      Result.Fact_Art_ID := FieldByName('Fact_Art_ID').AsInteger;
      Result.Status := FieldByName('Status').AsString;
      Result.Fact_Begin_Time := Fact_Begin_Time;
      Result.DataStatus := DataStatus;
      Result.Color := TGlobal.GetColorByID(FieldByName('WV_IsFinished').AsString,
        FieldByName('Urgent_Type').AsString,
        FieldByName('Is_Cut_Cloth').AsBoolean,
        FieldByName('Is_Hold').AsInteger,0);
      Result.FontColor := clWhite;
      Result.BeginTime := Begin_Time;
      Result.UseTime := IfThen(UseTime < 5, 5, UseTime);
      Result.PopupMenu := pm;
      Result.Hint := FieldByName('FN_Card').AsString + '(' +
        FieldByName('Operation_CHN').AsString + '  ' +
        FieldByName('Status').AsString + ')' + #13 +
        FieldByName('GF_NO').AsString + #13 +
        FieldByName('White_Type').AsString;
      Result.ShowHint := True;
      gtt.AddTask(Result, Machine_ID);
    except
      raise;
    end;
  end;
end;

procedure TPlanForm.GetCurrentValue(Task: TComponent);
begin
  if CurFNCard <> TFNCard(Task) then
  begin
    CurFNCard := TFNCard(Task);
    if CurMachine_Model <> LeftStr(CurFNCard.MachineName, 2) then
    begin
      CurMachine_Model := LeftStr(CurFNCard.MachineName, 2);
      CreateFNCardPopupMenu(Dictionary.cds_PrepareTypeList, CurMachine_Model);
    end;
  end;
end;

{function TPlanForm.GetMaxFactBeginTime(Machine:TMachine):TDateTime;
var i: Integer;
begin
  Result := EncodeDateTime(1899,1,1,1,1,1,1);
  for i := 0 to Machine.GetAllTask.Count-1 do
    if TFNCard(Machine.GetAllTask.Items[i]).Status ='���ϻ�' then
       if CompareDateTime(Result,TFNCard(Machine.GetAllTask.Items[i]).Fact_Begin_Time) < 0 then
       begin
         Result := TFNCard(Machine.GetAllTask.Items[i]).Fact_Begin_Time;
         Exit;
       end
end;}

procedure TPlanForm.InsertFNCardToTaskChart(Machine: TMachine;
  InsertTime: TDateTime);
var i: Integer;
  sSpeed, sFN_Card, sOperation_Code: string;
  UseTime: Integer;
  BeginTime: TDateTime;
  FN_Card: TFNCard;
begin
  if cxgridtvPlanTaskInfo.Controller.SelectedRowCount = 0 then Exit;
  if (not cdsPlanTaskInfo.Active) or cdsPlanTaskInfo.IsEmpty then Exit;
  BeginTime := InsertTime;
  cdsPlanTaskInfo.DisableControls;
  for i := 0 to cxgridtvPlanTaskInfo.Controller.SelectedRowCount - 1 do
  begin
    sFN_Card := cxgridtvPlanTaskInfo.Controller.SelectedRows[i].Values[cxgridtvPlanTaskInfo.GetColumnByFieldName('FN_Card').Index];
    sOperation_Code := cxgridtvPlanTaskInfo.Controller.SelectedRows[i].Values[cxgridtvPlanTaskInfo.GetColumnByFieldName('Operation_Code').Index];

    //2011-5-26 ����
    if not CheckRoll(sFN_Card, sOperation_Code) then Exit;

    if not CheckAllowDrop(Machine, sOperation_Code) then Exit;

    if cxgridtvPlanTaskInfo.Controller.SelectedRows[i].Values[cxgridtvPlanTaskInfo.GetColumnByFieldName('Is_Hold').Index] > 0 then
    begin
      if cxgridtvPlanTaskInfo.Controller.SelectedRows[i].Values[cxgridtvPlanTaskInfo.GetColumnByFieldName('Is_Hold').Index] = 9999 then
      begin
        TMsgDialog.ShowMsgDialog('�˿��ţ�' + sFN_Card+' ��HOLD��δ����ʵ�ʹ���', mtInformation);
        break;
      end;
      TMsgDialog.ShowMsgDialog('�˿��ţ�' + sFN_Card+'�Ѿ�Hold ,���Ƚ��Hold���Ż�', mtInformation);
      break;
    end;

    // cuijf 2008-6-4 ���ӱ����ظ���ӡ�and not (gttFNCard.SelectTask(sFN_Card))
    if (cdsPlanTaskInfo.Locate('FN_Card', sFN_Card, [])) and not (gttFNCard.SelectTask(sFN_Card)) then
    begin
      UseTime := 5;
      if sFN_Card[1] <> 'N' then
      begin
        sSpeed := Trim(cdsPlanTaskInfo.FieldByName('Speed').AsString);
        if (sSpeed = '') or (StrToFloat(sSpeed) < 10) then sSpeed := InputBox('����', '�����복��:', '80.0');
        if StrToFloat(sSpeed) < 1.0 then Exit; //����/����*�ӹ�����
        UseTime := Ceil(cdsPlanTaskInfo.FieldByName('Quantity').AsFloat / StrToFloat(sSpeed)) * cdsPlanTaskInfo.FieldByName('Times').AsInteger;
        if UseTime < 5 then UseTime := 5; //Added BY WLX
      end;
      CurMachine_ID := Machine.Name;
      FN_Card := AddFNCardToTaskChart(cdsPlanTaskInfo, BeginTime,
        UseTime, pmFNCard, gttFNCard, True);
//      BeginTime := IncMinute(FN_Card.EndTime,5);
      BeginTime := FN_Card.EndTime;
      cdsPlanTaskInfo.Delete;
    end;
  end;
  cdsPlanTaskInfo.EnableControls;
end;

procedure TPlanForm.FindTask(AFN_Card: string);
begin
  AFN_Card := Trim(AFN_Card);
  if AFN_Card = '' then Exit;
  if not gttFNCard.SelectTask(AFN_Card) then
  begin
    TMsgDialog.ShowMsgDialog('�Ҳ�����Ӧ���ţ�' + AFN_Card, mtInformation);
    Exit;
  end;
  with cdsPlanListInfo do
  begin
    if not Active or IsEmpty then Exit;
    Locate('FN_Card', AFN_Card, [loPartialKey]);
  end;
end;

procedure TPlanForm.LocateLastTask(Machine_Model: string);
var i:Integer;
  tempMachine: TMachine;
  lastTask: TTask;
begin
  lastTask := nil;
  for i := 0 to gttFNCard.GetAllMachine.Count - 1 do
  begin
    tempMachine := gttFNCard.GetAllMachine.Items[i];
    if (leftstr(tempMachine.Name, 2) = Machine_Model) = (tempMachine.Tag = 0) then
    begin  //Ѱ������Ķ�λ��
      if tempMachine.GetAllTask.Count > 0 then
      begin
        if lAstTask = nil then
          lastTask := TTask(tempMachine.GetAllTask.Last)
        else
          if lastTask.EndTime > TTask(tempMachine.GetAllTask.Last).EndTime then
            lastTask := TTask(tempMachine.GetAllTask.Last)
      end else  //�����������̨û�κ�����,ֱ�Ӷ�λ����ǰʱ��
      begin
        gttFNCard.ScrollToCurrentTime;
        Exit;
      end;
    end;
  end;
  if lastTask = nil then
    gttFNCard.ScrollToCurrentTime
  else
    if not gttFNCard.SelectTask(lastTask) then
       gttFNCard.ScrollToCurrentTime;
end;

procedure TPlanForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TPlanForm.FormDestroy(Sender: TObject);
begin
  PlanForm := nil;
end;

procedure TPlanForm.btnSaveClick(Sender: TObject);
begin
  SaveData;
end;

procedure TPlanForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TPlanForm.gttFNCardTaskDblClick(Task: TTask);
begin
  GetCurrentValue(Task);
  ShowFNCardPropertyForm;
end;

procedure TPlanForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  RefreshData(0);
end;

procedure TPlanForm.cxgridtvPlanListInfoCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if AViewInfo.Focused then Exit;
  GridDecorator.CustomerDraw(Sender, ACanvas, AViewInfo);
end;


procedure TPlanForm.cxgridtvPlanTaskInfoCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if AViewInfo.Focused then Exit;
  GridDecorator.CustomerDraw(Sender, ACanvas, AViewInfo, False);
end;

procedure TPlanForm.gttFNCardMachineDragDrop(Machine: TMachine;
  posTime: TDateTime);
begin
  inherited;
  if posTime < gttFNCard.UCurrentTime then
  begin
    TMsgDialog.ShowMsgDialog('�Ż��ƻ�ʱ��Ӧ�ô��ڵ�ǰʱ�䣬����!', mtWarning);
    Exit;
  end;
  InsertFNCardToTaskChart(Machine, posTime);
end;

procedure TPlanForm.btnFindClick(Sender: TObject);
begin
  inherited;
  FindTask(edtFNCard.Text);
end;

procedure TPlanForm.gttFNCardBeforeChangeMachine(task: TTask;
  newMachine: TMachine; newBeginTime: TDateTime; var Action: Boolean);
begin
  inherited;
  Action := CheckAllowDrop(newMachine, TFNCard(Task).Operation_Code);
end;

procedure TPlanForm.gttFNCardBeforeTaskMove(task: TTask;
  newBeginTime: TDateTime; var Action: Boolean);
begin
  inherited;
  Action := CompareDateTime(newBeginTime, gttFNCard.UCurrentTime) > 0;
  if not Action then
  begin
    TMsgDialog.ShowMsgDialog('�Ż�ʱ��Ӧ���ڵ�ǰʱ�䣬�����϶���', mtWarning);
   //luoty TMsgDialog.ShowMsgDialog('��ǰ��(���ϻ�)״̬,���������϶�,����!',mtWarning);
    Exit;
  end;
  Action := TFNCard(task).Status = 'δ�ϻ�';
  if not Action then
    TMsgDialog.ShowMsgDialog('��ǰ��(���ϻ�)״̬,���������϶�,����!', mtWarning);
end;

procedure TPlanForm.btnAutoArrangeCurTaskClick(Sender: TObject);
begin
  inherited;
  RefreshData(0);
end;

procedure TPlanForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if (gttFNCard.GetTaskList(dsAdd).Count > 0)
    or (gttFNCard.GetTaskList(dsUpdate).Count > 0)
    or (gttFNCard.GetTaskList(dsDelete).Count > 0) then
    if TMsgDialog.ShowMsgDialog('ϵͳ��⵽�������񱻸Ķ�������Ҫ�������ݺ����˳���', mtConfirmation, [mebYes, mebNo], mebYes) = mrYes then
      SaveData();
end;

procedure TPlanForm.pmFNCardPopup(Sender: TObject);
begin
  inherited;
  GetCurrentValue(pmFNCard.PopupComponent);
end;

procedure TPlanForm.edtFNCardEnter(Sender: TObject);
begin
  inherited;
  btnFind.Default := true;
end;

procedure TPlanForm.edtFNCardExit(Sender: TObject);
begin
  inherited;
  btnFind.Default := false;
end;

procedure TPlanForm.btnSortClick(Sender: TObject);
begin
  inherited;
  GttFNCard.AutoSortTask;
end;

procedure TPlanForm.btnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TPlanForm.btnArrangeClick(Sender: TObject);
begin
  inherited;
  if pnlLeft.Align = alLeft then
  begin
    pnlLeft.Align := alTop;
    cxsplLeft.AlignSplitter := salTop;
    grpPlanTask.Align := alClient;
  end else
  begin
    cxsplLeft.AlignSplitter := salLeft;
    pnlLeft.Align := alLeft;
  end;
end;

procedure TPlanForm.SignMachine(Machine_Model: string);
var i: integer;
    tempMachine: TMachine;
begin
  //��ԭ���л�̨��ɫ
  for i := 0 to gttfncard.GetAllMachine.Count - 1 do
  begin
    tempMachine := gttFnCard.GetAllMachine.Items[i];
    tempMachine.Font.Color := clWindowText;
  end;

  for i := 0 to gttFNCard.GetAllMachine.Count - 1 do
  begin
    tempMachine := gttFNCard.GetAllMachine.Items[i];
    if leftstr(tempMachine.Name, 2) = Machine_Model then
      tempMachine.Font.Color := clBlue;
    if tempMachine.Tag  <> 0 then
    begin
      tempMachine.Hint := 'ͣ��';
      tempMachine.Font.Color := clRed;
    end;
  end;
end;

procedure TPlanForm.FormActivate(Sender: TObject);
begin
  inherited;
  OnActivate := nil;
  Application.ProcessMessages;
  Initialize;
end;

procedure TPlanForm.lstMachineModelDblClick(Sender: TObject);
begin
  inherited;
  RefreshData(1);
  LocateLastTask(CurMachine_Model);
end;

procedure TPlanForm.lstMachineModelClick(Sender: TObject);
begin
  inherited;
  CurMachine_Model := MidStr(lstMachineModel.Items[lstMachineModel.ItemIndex],Pos('[',lstMachineModel.Items[lstMachineModel.ItemIndex])+1,2);
  lblMachine.Caption :=' ' + MidStr(lstMachineModel.Items[lstMachineModel.ItemIndex],1,Pos('[',lstMachineModel.Items[lstMachineModel.ItemIndex])-1);
  SignMachine(CurMachine_Model);
end;

procedure TPlanForm.chbAllClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  for i := 0 to clbFNCardList.Count - 1 do
    clbFNCardList.Checked[i] := chbAll.Checked;
end;

procedure TPlanForm.btnQueryClick(Sender: TObject);
var
  i, j: Integer;
  FNCard: TFNCard;
begin
  inherited;
  if  Trim(edtGFNO.Text) = '' then Exit;
  clbFNCardList.Clear;
  for i := 0 to gttFNCard.GetAllMachine.Count - 1 do
  begin
    for j := 0 to TMachine(gttFNCard.GetAllMachine.Items[i]).GetAllTask.Count -1 do
    begin
      FNCard := TFNCard(TMachine(gttFNCard.GetAllMachine.Items[i]).GetAllTask.Items[j]);
      if UpperCase(FNCard.GF_NO) = Trim(edtGFNO.Text) then
        clbFNCardList.Items.Add(FNCard.Name + ' ' + FNCard.Operation_CHN);
    end;
  end;
  if clbFNCardList.Count > 0 then
    for i := 0 to clbFNCardList.Count - 1 do
      clbFNCardList.Checked[i] := True;
end;

procedure TPlanForm.btnDeleteClick(Sender: TObject);
var
  i: Integer;
  aTask: TTask;
begin
  inherited;
  for i := 0 to clbFNCardList.Count - 1 do
  begin
    if clbFNCardList.Checked[i] then
    begin
      aTask := gttFNCard.GetTaskByName(LeftStr(clbFNCardList.Items[i],9));
      if aTask <> nil then
         gttFNCard.DeleteTask(aTask);
      with cdsPlanListInfo do
      begin
        if not Active or IsEmpty then Exit;
        if Locate('FN_Card', aTask.Name, []) then
           Delete;
      end;
    end;
  end;
  clbFNCardList.Clear;
end;

procedure TPlanForm.btnAutoPlanClick(Sender: TObject);
begin
  inherited;
  AutoPlan('');
end;

//���ݻ�̨���ͣ��Զ��ŵ�
procedure TPlanForm.AutoPlan(sType: string);
var
  vData: OleVariant;
  sSQL, sErrorMsg: WideString;
begin
  if cdsPlanListInfo.IsEmpty then Exit;

  //û�д����͵ĸ��ݵ�ǰѡ������
  if (sType= '') then
  begin
    if lstMachineModel.ItemIndex = -1 then Exit;

    sType := CurMachine_Model;
  end;
  
  if not Assigned(AutoPlanShiftForm) then
    AutoPlanShiftForm:= TAutoPlanShiftForm.Create(Application);
  AutoPlanShiftForm.GetAutoPlanShift(sType);

  ShowMsg('���ڴ������ݣ����Ժ�...', crHourGlass);
  cdsPlanTaskInfo.DisableControls;
  try

    //���ݲ��š���̨���ں�̨�ƻ�
    sSQL := QuotedStr(login.CurrentDepartment)+ ','+ QuotedStr(sType);

    FNMServerObj.GetQueryData(vData, 'AutoPlan', sSQL, sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsAutoPlan.Data := vData;

    if cdsAutoPlan.IsEmpty then Exit;
    //�Զ��ŵ�ǰ��ˢ������
    RefreshData(0);

    //����̨�Զ��ŵļƻ���ӵ�ͼ������ʾ
    with cdsAutoPlan do
    begin
      Data := vData;
      if IsEmpty then Exit;

      First;
      while not Eof do
      begin
        //��ӵ��ĸ���̨
        CurMachine_ID := FieldByName('Machine_ID').AsString;

        if cdsPlanTaskInfo.Active then
          if cdsPlanTaskInfo.Locate('FN_card', FieldByName('FN_Card').AsString,[]) then
            cdsPlanTaskInfo.Delete;

        //�Ѿ���ӵĲ����ظ����
        if not gttFNCard.SelectTask(FieldByName('FN_Card').AsString) then
        begin
          AddFNCardToTaskChart(cdsAutoPlan, FieldByName('Plan_Begin_Time').AsDateTime,
            FieldByName('Seconds').AsInteger,
            pmFNCard, gttFNCard, True);
        end;

        Next;
      end;
    end;
  finally
    cdsPlanTaskInfo.EnableControls;
    ShowMsg('', crDefault);
  end;
end;

function TPlanForm.CheckRoll(sFNCard, sOperationCode: string):Boolean;
var
  vData:OleVariant;
  sSQL,sErrMsg:WideString;
  Msg:String;
begin
  //�����Ƿ񱻾����ڲ�
  result := false;
  sSQL := QuotedStr(sFNCard)+ ','+ QuotedStr(sOperationCode)+ ','+ QuotedStr(Login.CurrentDepartment);
  FNMServerObj.GetQueryData(vData,'fnCheckRoll',sSQL,sErrMsg);
  if sErrMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  cdsRoll.Data := vData;
  if not cdsRoll.IsEmpty then
  begin
    //�����Ʒ�������š�״̬���볤��Ϣ
    Msg:= cdsRoll.FieldByName('Msg').AsString;
    if Msg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(Msg, mtError);
      Exit;
    end
  end;
  result := true;
end;

procedure TPlanForm.cxgridtvPlanTaskInfoDblClick(Sender: TObject);
begin
  inherited;
  GetAlert();

end;

procedure TPlanForm.GetAlert();
var
  Is_holdAff,sFNCard:string;
  vData:OleVariant;
  sSQL,sErrMsg,sAlert:WideString;
begin
  if cxgridtvPlanTaskInfo.Controller.SelectedRowCount > 0 then
  begin
    Is_holdAff := cxgridtvPlanTaskInfo.Controller.SelectedRows[0].Values[cxgridtvPlanTaskInfo.GetColumnByFieldName('Is_HoldByAffirm').Index];
    sFNCard := cxgridtvPlanTaskInfo.Controller.SelectedRows[0].Values[cxgridtvPlanTaskInfo.GetColumnByFieldName('FN_Card').Index];
    if Is_holdAff = '1' then
    begin
      sSQL := QuotedStr(sFNCard);
      FNMServerObj.GetQueryData(vData,'GetAffirmRmark',sSQL,sErrMsg);
      if sErrMsg <> '' then
      begin
        TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
        Exit;
      end;
      cdsAlertRemark.Data := vData;
      if not cdsAlertRemark.IsEmpty then
      begin
        sAlert := cdsAlertRemark.FieldByName('Remark').AsString;
        if sAlert<>'' then
        begin
          TMsgDialog.ShowMsgDialog(sAlert,mtWarning);
          Exit;
        end
      end;
    end;
  end;
end;

end.


unit frmMain;
{*|<PRE>*****************************************************************************

       软件名称 FNM CLIENT MODEL
       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT
       单元名称 frmMain.pas
       创建日期 2004-8-9 11:37:12
       创建人员 Zhangjy,Lvzd
       修改人员
       修改日期
       修改原因
       功能描述 主窗体单元
******************************************************************************}

interface

uses
  Messages, Forms, Windows, SysUtils, Controls, Classes, WinSkinData,
  ImgList, cxHint, cxLookAndFeels, Menus, StdActns, ActnList, StdCtrls,
  ExtCtrls, ComCtrls, ToolWin, Buttons, DB, DBClient;

type
  TFNMMainForm = class(TForm)
    actionList: TActionList;
    btn2: TToolButton;
    btn3: TToolButton;
    btnCalu: TToolButton;
    btnClose: TToolButton;
    btnCopy: TToolButton;
    btnCut: TToolButton;
    btnExcel: TToolButton;
    btnPaste: TToolButton;
    cbbCurrentDept: TComboBox;
    clbr_Only: TCoolBar;
    cxhsc1: TcxHintStyleController;
    cxlfc1: TcxLookAndFeelController;
    EditCopy: TEditCopy;
    EditCut: TEditCut;
    EditDelete: TEditDelete;
    EditPaste: TEditPaste;
    EditUndo: TEditUndo;
    FilePrintSetup: TFilePrintSetup;
    il_Common: TImageList;
    MainStatusBar: TStatusBar;
    Panel1: TPanel;
    tlbMainToolBar: TToolBar;
    WindowArrange: TWindowArrange;
    WindowCascade: TWindowCascade;
    WindowClose: TWindowClose;
    WindowMinimizeAll: TWindowMinimizeAll;
    WindowTileHorizontal: TWindowTileHorizontal;
    WindowTileVertical: TWindowTileVertical;
    btn_ShowWebInfo: TToolButton;
    btn_ShowGroupByBox: TToolButton;
    pmPattern: TPopupMenu;
    NPattern: TMenuItem;
    mainMenu: TMainMenu;
    FSetup: TMenuItem;
    FN9: TMenuItem;
    FN10: TMenuItem;
    FN15: TMenuItem;
    OtherOption: TMenuItem;
    Dic: TMenuItem;
    N25: TMenuItem;
    N3: TMenuItem;
    N8: TMenuItem;
    FToolMenu: TMenuItem;
    FStatusMenu: TMenuItem;
    N24: TMenuItem;
    FN11: TMenuItem;
    MFNM6: TMenuItem;
    MFNM612: TMenuItem;
    MFNM601: TMenuItem;
    MFNM609: TMenuItem;
    MFNM602: TMenuItem;
    N17: TMenuItem;
    MFNM603: TMenuItem;
    MFNM604: TMenuItem;
    N18: TMenuItem;
    MFNM607: TMenuItem;
    N5: TMenuItem;
    MFNM608: TMenuItem;
    MFNM611: TMenuItem;
    N6: TMenuItem;
    MFNM610: TMenuItem;
    MFNM613: TMenuItem;
    MFNM614: TMenuItem;
    MFNM615: TMenuItem;
    MFNM1: TMenuItem;
    MFNM101: TMenuItem;
    MFNM102: TMenuItem;
    MFNM103: TMenuItem;
    N1: TMenuItem;
    MFNM104: TMenuItem;
    N4: TMenuItem;
    MFNM105: TMenuItem;
    MFNM106: TMenuItem;
    N19: TMenuItem;
    MFNM107: TMenuItem;
    MFNM109: TMenuItem;
    MFNM2: TMenuItem;
    MFNM201: TMenuItem;
    MFNM202: TMenuItem;
    N28: TMenuItem;
    MFNM203: TMenuItem;
    MFNM204: TMenuItem;
    N27: TMenuItem;
    MFNM205: TMenuItem;
    mniN12: TMenuItem;
    MFNM206: TMenuItem;
    MFNM3: TMenuItem;
    MFNM314: TMenuItem;
    MFNM303: TMenuItem;
    MFNM313: TMenuItem;
    MFNM301: TMenuItem;
    N32: TMenuItem;
    MFNM304: TMenuItem;
    MFNM305: TMenuItem;
    N33: TMenuItem;
    MFNM315: TMenuItem;
    MFNM306: TMenuItem;
    MFNM307: TMenuItem;
    N2: TMenuItem;
    MFNM311: TMenuItem;
    MFNM312: TMenuItem;
    N34: TMenuItem;
    MFNM308: TMenuItem;
    MFNM309: TMenuItem;
    MFNM310: TMenuItem;
    MFNM4: TMenuItem;
    MFNM401: TMenuItem;
    MFNM402: TMenuItem;
    MFNM403: TMenuItem;
    MFNM404: TMenuItem;
    MFNM5: TMenuItem;
    MFNM501: TMenuItem;
    MFNM502: TMenuItem;
    MFNM503: TMenuItem;
    N10: TMenuItem;
    MFNM505: TMenuItem;
    MFNM506: TMenuItem;
    FWindows: TMenuItem;
    FArrange1: TMenuItem;
    N21: TMenuItem;
    FMinimizeAll1: TMenuItem;
    N22: TMenuItem;
    FCascade1: TMenuItem;
    FArrange2: TMenuItem;
    FileVertically1: TMenuItem;
    FHelp: TMenuItem;
    N9: TMenuItem;
    ShowAppServer: TMenuItem;
    N11: TMenuItem;
    About: TMenuItem;
    MFNM316: TMenuItem;
    N12: TMenuItem;
    MFNM110: TMenuItem;
    MFNM207: TMenuItem;
    MFNM616: TMenuItem;
    N13: TMenuItem;
    MFNM407: TMenuItem;
    MFNM405: TMenuItem;
    MFNM406: TMenuItem;
    MFNM317: TMenuItem;
    act_ShowCADPic: TAction;
    MFNM7: TMenuItem;
    MFNM701: TMenuItem;
    MFNM702: TMenuItem;
    MFNM703: TMenuItem;
    MFNM704: TMenuItem;
    MFNM705: TMenuItem;
    MFNM318: TMenuItem;
    MFNM319: TMenuItem;
    MFNM112: TMenuItem;
    MFNM208: TMenuItem;
    MFNM320: TMenuItem;
    N14: TMenuItem;
    MFNM706: TMenuItem;
    N15: TMenuItem;
    MFNM408: TMenuItem;
    MFNM209: TMenuItem;
    MFNM409: TMenuItem;
    N16: TMenuItem;
    MFNM411: TMenuItem;
    MFNM412: TMenuItem;
    MFNM410: TMenuItem;
    MFNM413: TMenuItem;
    MFNM414: TMenuItem;
    MFNM321: TMenuItem;
    btn_RefresDir: TSpeedButton;
    N7: TMenuItem;
    MFNM415: TMenuItem;
    SpeedButton1: TSpeedButton;
    MFNM3020: TMenuItem;
    N20: TMenuItem;
    MFNM416: TMenuItem;
    MFNM417: TMenuItem;
    N23: TMenuItem;
    MFNM322: TMenuItem;
    btnUpload: TButton;
    TimerUpload: TTimer;
    MFNM707: TMenuItem;
    MFNM708: TMenuItem;
    MFNM323: TMenuItem;
    N26: TMenuItem;
    MFNM324: TMenuItem;
    tmrCheckVersion: TTimer;
    N29: TMenuItem;
    MFNM709: TMenuItem;
    MFNM210: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N35: TMenuItem;
    MFNM211: TMenuItem;
    MFNM333: TMenuItem;
    MFNM212: TMenuItem;
    MFNM334: TMenuItem;
    MFNM507: TMenuItem;
    MFNM223: TMenuItem;
    MFNM508: TMenuItem;
    MFNM509: TMenuItem;
    MFNM120: TMenuItem;
    MFNM510: TMenuItem;
    MFNM511: TMenuItem;
    MFNM3071: TMenuItem;
    MFNM3072: TMenuItem;
    MFNM3073: TMenuItem;
    MFNM711: TMenuItem;
    MFNM710: TMenuItem;
    MFNM617: TMenuItem;
    MFNM618: TMenuItem;
    MFNM619: TMenuItem;
    MFNM620: TMenuItem;
    N36: TMenuItem;
    MFNM621: TMenuItem;
    MFNM622: TMenuItem;
    MFNM623: TMenuItem;
    MFNM624: TMenuItem;
    MFNM625: TMenuItem;
    MFNM626: TMenuItem;
    MFNM627: TMenuItem;
    mniMFNM628: TMenuItem;
    MFNM628: TMenuItem;
    N37: TMenuItem;
    MFNM418: TMenuItem;
    MFNM419: TMenuItem;
    MFNM420: TMenuItem;
    MFNM712: TMenuItem;
    MFNM6201: TMenuItem;
    N38: TMenuItem;
    MFNM632: TMenuItem;
    MFNM631: TMenuItem;
    MFNM630: TMenuItem;
    MFNM113: TMenuItem;

    procedure MFNM601Click(Sender: TObject);
    procedure MFNM602Click(Sender: TObject);
    procedure MFNM603Click(Sender: TObject);
    procedure MFNM604Click(Sender: TObject);
    procedure MFNM605Click(Sender: TObject);
    procedure MFNM606Click(Sender: TObject);
    procedure MFNM607Click(Sender: TObject);
    procedure MFNM608Click(Sender: TObject);
    procedure MFNM609Click(Sender: TObject);
    procedure MFNM610Click(Sender: TObject);
    procedure MFNM101Click(Sender: TObject);
    procedure MFNM102Click(Sender: TObject);
    procedure MFNM103Click(Sender: TObject);
    procedure MFNM104Click(Sender: TObject);
    procedure MFNM105Click(Sender: TObject);
    procedure MFNM106Click(Sender: TObject);
    procedure MFNM107Click(Sender: TObject);
    procedure MFNM109Click(Sender: TObject);
    procedure MFNM201Click(Sender: TObject);
    procedure MFNM202Click(Sender: TObject);
    procedure MFNM203Click(Sender: TObject);
    procedure MFNM204Click(Sender: TObject);
    procedure MFNM205Click(Sender: TObject);
    procedure MFNM301Click(Sender: TObject);
    procedure MFNM303Click(Sender: TObject);
    procedure MFNM304Click(Sender: TObject);
    procedure MFNM305Click(Sender: TObject);
    procedure MFNM306Click(Sender: TObject);
    procedure MFNM307Click(Sender: TObject);
    procedure MFNM308Click(Sender: TObject);
    procedure MFNM309Click(Sender: TObject);
    procedure MFNM310Click(Sender: TObject);
    procedure MFNM401Click(Sender: TObject);
    procedure MFNM402Click(Sender: TObject);
    procedure MFNM403Click(Sender: TObject);
    procedure MFNM315Click(Sender: TObject);
    procedure MFNM501Click(Sender: TObject);
    procedure MFNM502Click(Sender: TObject);
    procedure MFNM503Click(Sender: TObject);
    procedure MFNM505Click(Sender: TObject);
    procedure MFNM611Click(Sender: TObject);
    procedure MFNM612Click(Sender: TObject);
    procedure MFNM311Click(Sender: TObject);
    procedure MFNM312Click(Sender: TObject);
    procedure MFNM313Click(Sender: TObject);
    procedure MFNM110Click(Sender: TObject);
    procedure MFNM613Click(Sender: TObject);
    procedure MFNM404Click(Sender: TObject);
    procedure NPatternClick(Sender: TObject);
    procedure MFNM314Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tbiExitApplicationClick(Sender: TObject);
    procedure AboutClick(Sender: TObject);
    procedure FToolMenuClick(Sender: TObject);
    procedure FStatusMenuClick(Sender: TObject);
    procedure btnCaluClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure OtherOptionClick(Sender: TObject);
    procedure FN10Click(Sender: TObject);
    procedure DicClick(Sender: TObject);
    procedure btn_RefresDirClick(Sender: TObject);
    procedure ShowAppServerClick(Sender: TObject);
    procedure cbbCurrentDeptChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sdXPStyleFormSkin(Sender: TObject; aName: String; var DoSkin: Boolean);
    procedure WindowCloseUpdate(Sender: TObject);
    procedure WindowCloseExecute(Sender: TObject);
    procedure MFNM614Click(Sender: TObject);
    procedure MFNM615Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure MFNM206Click(Sender: TObject);
    procedure MFNM316Click(Sender: TObject);
    procedure MFNM207Click(Sender: TObject);
    procedure MFNM616Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure MFNM407Click(Sender: TObject);
    procedure MFNM405Click(Sender: TObject);
    procedure MFNM406Click(Sender: TObject);
    procedure MFNM317Click(Sender: TObject);
    procedure act_ShowCADPicExecute(Sender: TObject);
    procedure act_ShowCADPicUpdate(Sender: TObject);
    procedure MFNM701Click(Sender: TObject);
    procedure MFNM703Click(Sender: TObject);
    procedure MFNM704Click(Sender: TObject);
    procedure MFNM705Click(Sender: TObject);
    procedure MFNM318Click(Sender: TObject);
    procedure MFNM319Click(Sender: TObject);
    procedure MFNM112Click(Sender: TObject);
    procedure MFNM208Click(Sender: TObject);
    procedure MFNM320Click(Sender: TObject);
    procedure MFNM706Click(Sender: TObject);
    procedure MFNM408Click(Sender: TObject);
    procedure MFNM209Click(Sender: TObject);
    procedure MFNM412Click(Sender: TObject);
    procedure MFNM409Click(Sender: TObject);
    procedure MFNM411Click(Sender: TObject);
    procedure MFNM410Click(Sender: TObject);
    procedure MFNM413Click(Sender: TObject);
    procedure MFNM414Click(Sender: TObject);
    procedure MFNM321Click(Sender: TObject);
    procedure MFNM415Click(Sender: TObject);
    procedure MFNM3020Click(Sender: TObject);
    procedure MFNM416Click(Sender: TObject);
    procedure MFNM417Click(Sender: TObject);
    procedure MFNM322Click(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
    procedure TimerUploadTimer(Sender: TObject);
    procedure MFNM707Click(Sender: TObject);
    procedure MFNM708Click(Sender: TObject);
    procedure MFNM323Click(Sender: TObject);
    procedure MFNM324Click(Sender: TObject);
    procedure tmrCheckVersionTimer(Sender: TObject);
    procedure MFNM709Click(Sender: TObject);
    procedure MFNM210Click(Sender: TObject);
    procedure N30Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure N35Click(Sender: TObject);
    procedure MFNM211Click(Sender: TObject);
    procedure MFNM333Click(Sender: TObject);
    procedure MFNM212Click(Sender: TObject);
    procedure MFNM334Click(Sender: TObject);
    procedure MFNM507Click(Sender: TObject);
    procedure MFNM223Click(Sender: TObject);
    procedure MFNM508Click(Sender: TObject);
    procedure MFNM509Click(Sender: TObject);
    procedure MFNM120Click(Sender: TObject);
    procedure MFNM511Click(Sender: TObject);
    procedure MFNM3073Click(Sender: TObject);
    procedure MFNM3071Click(Sender: TObject);
    procedure MFNM3072Click(Sender: TObject);
    procedure MFNM711Click(Sender: TObject);
    procedure MFNM710Click(Sender: TObject);
    procedure MFNM617Click(Sender: TObject);
    procedure MFNM618Click(Sender: TObject);
    procedure MFNM619Click(Sender: TObject);
    procedure MFNM620Click(Sender: TObject);
    procedure MFNM621Click(Sender: TObject);
    procedure MFNM622Click(Sender: TObject);
    procedure MFNM623Click(Sender: TObject);
    procedure MFNM624Click(Sender: TObject);
    procedure MFNM625Click(Sender: TObject);
    procedure MFNM626Click(Sender: TObject);
    procedure MFNM627Click(Sender: TObject);
    procedure mniMFNM628Click(Sender: TObject);
    procedure MFNM628Click(Sender: TObject);
    procedure MFNM418Click(Sender: TObject);
    procedure MFNM419Click(Sender: TObject);
    procedure MFNM420Click(Sender: TObject);
    procedure MFNM712Click(Sender: TObject);
    procedure MFNM6201Click(Sender: TObject);
    procedure MFNM631Click(Sender: TObject);
    procedure MFNM630Click(Sender: TObject);
    procedure MFNM113Click(Sender: TObject);
    procedure MFNM632Click(Sender: TObject);
    
  private
    { private declarations }
    sdXPStyle: TSkinData;
    {* }
  
    {* 当前用户选择的部门的ItemIndex}
//    DepartmentItemIndex: Integer;
    {* 设定工具条，状态条显示}
    procedure SetToolBarShow;
    {检查当前选定的部门是否正确的部门，在MenuItem Click中调用}
    function CheckIsCorrectDepartment(MenuID: string): Boolean;
    {初始化cbbCurrentDept及用户的使用部门，在MainForm.Initialize中调用 }
    procedure OperationDeptInitialize;

    procedure UploadDelat;
    procedure ReadDelat(const INSERTSQL: string;FileName: string);

  public
    { public procedures }
    procedure Initialize;
    {* 初始化主Form}
    procedure LoadFormStyle;
    {* 根据配置文件设定窗体显示}
    procedure SetPermission;
    {* 根据当前的Login对象来设置系统权限}
    procedure SetStatusBar;
    {* 设置主窗体的状态栏}
    procedure LoadFieldList;
    {* 初始化配置文件（纪录了字段中英对照表）}
    procedure ChangeSkinFile;
    {* 更改XP界面皮肤文件，切换界面风格}
    //文件版本
    function GetVersion(FileName:string): string;
    procedure CheckVersion(LocalVersion:String);
  end;

var
  FNMMainForm: TFNMMainForm;
  //全局对象,该对象为皮肤控件. initialization部分初始化,frmWelcome负责激活
  lsdXPStyle: TSkinData;

implementation

uses uGlobal, UExportActions, ShellAPI, StrUtils, Dialogs, frmBase,
  UAppOption, ULogin, UVersionInfo, frmOption, UGridDecorator, uShowMessage,
  uCADInfo, uDictionary, uQueryDictionary,
  frmDictionary, frmWelcome, frmReceiveInfo, frmReceiveGIRepairInfo,
  frmPrintFNCard, frmFabricCard, frmSendInfo, frmRePrintNoteNO, frmCancelPrintFNCard,
  frmStdArtInfo, frmFactArtInfo, frmRepairArtInfo, frmArtReview, frmHLManage,
  frmHLArtInfo, frmWorker, frmWorkerStation, frmEditOTD, frmPlan, frmHold,
  frmAccident, frmDisposeAccident, frmAnalysisQuality, frmWorkerPrize,
  frmDistributeTerminal, frmMachineTerminal,
  frmHandRecipe,frmRecipe,frmRecipePlan,  frmRecipeTerminal,
  frmFabricReport, frmOTD, frmWIPQuery, frmFNMQuery, frmManageSC, frmCancelSendInfo,
  frmReceiveFromGI, frmCutCloth, frmOperationAddr,
  frmQualityRemark, frmJobTrace, frmChangeGFNO, frmPlanControl, frmArtControl,
  frmAdjustJobTraceDtl, frmChangeDepartment, frmChangeMaterialType,
  frmManageSample,  frmShrinkageAnalysis, frmSupplyRecipe,  frmCancelFI, frmMachineEfficiency,
  frmCPBRecipe, frmCPBCheck, frmCPBManage, frmChemical, frmChemicalQuery, frmArtAnalysis,
  frmRepairReason, frmOTDReason, frmReceiveBenchMark, frmMutexChemical,
  frmInnerRepairCheck, frmFIDuty, frmCSState, frmSDTrace, frmRSTrace,
  frmDisposeAccidentTrace, frmChemicalRatio, frmWorkerStationTurn,
  frmCPBColor, frmCPBStock, frmCPBFormat, frmCPBQuery, frmCPBWIP, frmCPBDirect,
  frmCPBSign, frmTraceRepair, frmAnalysisOTD, frmCPBChemicalGroup,
  frmCPBCustomerGroup, frmSOPDefect, ServerDllPub,
  frmAffirmCardOperationMap, frmOperationMapMachineModel, frmAffirmCard,
  frmAccidentRecord, frmBaseData, frmCPBChangeGFNO,frmWeigh, frmColorInfo,frmSendInfoManage,
  frmLessStatistic,frmTrackOnline,frmMachineRules,frmSuspendApproval,frmEnergyQuery,
  frmPlanAnalysis,frmOTDTrace,frmScanInventory,frmColorInfoEdit,frmMFQuery,frmAddPrice,frmDisposePrice,
  frmProductionParameter, frmProductionList, frmReceiveGreyCloth,
  frmPrintFNCardGreyCloth, frmReturnGreyCloth,frmCheckSCParam,
  frmPrintFNCardAndLabel, frmGIWorkerOption, frmOutGoFabric, frmFNEditCarNo, frmOutGoFabricRules,
  frmPrepareFabric,frmEditCarNoByFNCard,
  frmOutRework,frmSectionFabric, frmReceiveCPBBulkFabric, frmCPBDyeDetail,
  frmCPBHLRpt, frmStdChemicalGroup, frmSendSCInfo,
  frmModifyFactory, frmCheckModifyFactory, frmSetCapacity,frmFactoryRate;
  

{$R *.dfm}

procedure TFNMMainForm.sdXPStyleFormSkin(Sender: TObject; aName: String; var DoSkin: Boolean);
begin
   if aName= 'TQRStandardPreview' then DoSkin:= false;
end;

procedure TFNMMainForm.OperationDeptInitialize;
var
  sDept:string;
begin
  {加载用户可操作数据的部门列表}
  if login.UserDepartments.Active then
  begin
    cbbCurrentDept.Clear;
    with login.UserDepartments do
    begin
      First;
      while not Eof do
      begin
        sDept := Fieldbyname('Department').AsString + '->'
          + Fieldbyname('Department_Description').AsString;
        cbbCurrentDept.Items.Add(sDept);
        Next;
      end;
    end;
    cbbCurrentDept.Sorted := True;
  end;
  {初始化用户的便用部门}
  if cbbCurrentDept.Items.Count > 0 then
  begin
    if Login.DefaultDepartment <> '' then
    begin
      if Login.UserDepartments.Locate('Department', login.DefaultDepartment, [])
        then
      begin
        sDept := login.DefaultDepartment + '->' +
          Login.UserDepartments.fieldbyname('Department_Description').AsString;
        cbbCurrentDept.ItemIndex := cbbCurrentDept.Items.IndexOf(sDept);
      end;
    end;
    if cbbCurrentDept.ItemIndex = -1 then
      cbbCurrentDept.ItemIndex := 0;
    {初始化Login.CurrentDepartment}
    if Pos('->',cbbCurrentDept.Text) >0 then
      Login.CurrentDepartment := Copy(cbbCurrentDept.Text,1,Pos('->',cbbCurrentDept.Text)-1)
    else
      Login.CurrentDepartment := cbbCurrentDept.Text;
  end;
  MFNM211.Enabled := true;
  //MFNM212.Enabled := true;
  MFNM333.Enabled := true;
  MFNM223.Enabled := true;
  MFNM507.Enabled := true;
  MFNM508.Enabled := True;
  MFNM509.Enabled := True;
  MFNM120.Enabled := True;
  MFNM511.Enabled := True;
  MFNM620.Enabled := True;
  //MFNM6201.Enabled := True;
  //MFNM628.Enabled := True;
end;

function TFNMMainForm.CheckIsCorrectDepartment(
  MenuID: string): Boolean;
var
  NewDept_Desc,Current_Dept,Current_DeptDesc,Menu_Operation: string;
begin
  Current_Dept := Login.CurrentDepartment;
  Current_DeptDesc := cbbCurrentDept.Text;
  {取MENUItem对应的Operation}
  if Login.SysMenus.Locate('MenuID', MenuID, []) then
    Menu_Operation := Login.SysMenus.fieldbyname('Operation').AsString
  else
    Menu_Operation := '';
  {Menu_Operation为空说明该模块不需对部门进行控制}
  if Menu_Operation = '' then
  begin
    Result := True;
    Exit;
  end;
  {取当前所选部门的相关信息,如果当前部门与Menu对应的Operation是否一致，如一致也返回TRUE}
  if (Current_Dept<>'') and (Login.UserDepartments.Locate('Department', Current_Dept, [])) then
  begin
    if Login.UserDepartments.FieldByName('Operation').AsString = Menu_Operation then
    begin
      result := true;
      Exit;
    end;
  end;
  {判断合法Operation对于用户来说，只有一个部门且没有活动ChildForm，如是则自动选择为当前}
  if Login.UserDepartments.Locate('Operation', Menu_Operation, []) then
  begin
    if (FNMMainForm.MDIChildCount = 0)
      and (Login.UserDepartments.FieldByName('Department_Count').AsInteger = 1)
        then
    begin
      NewDept_Desc := Login.UserDepartments.Fieldbyname('Department').AsString
        + '->'
        + Login.UserDepartments.Fieldbyname('Department_Description').AsString;
      cbbCurrentDept.ItemIndex := cbbCurrentDept.Items.IndexOf(NewDept_Desc);
      Login.CurrentDepartment :=
        Login.UserDepartments.Fieldbyname('Department').AsString;
      Result := True;
      Exit;
    end
  end;
  TMsgDialog.ShowMsgDialog('所选择部门错误，请重新选择！', 2);
  Result := False;

end;

procedure TFNMMainForm.SetPermission;
var
  MenuList: TStringList;
  i: Integer;
begin
  MenuList:=nil;
  try
    MenuList:= TStringList.Create;
    MenuList.Text := Login.GetPermission();

    Login.SetPermissionWhenLogin:= True;
    if not Login.SetPermissionWhenLogin then
      Exit;

    for I:= 0 to ComponentCount - 1 do
    begin
      if (Components[i] is TMenuItem) then
      with Components[i] as TMenuItem do
      begin
        if (Name[1] = 'M') and (Count = 0) then
          Enabled:=MenuList.IndexOf(Name) <> -1;
      end;
    end;
  finally
    FreeAndNil(MenuList);
  end;    
end;

procedure TFNMMainForm.SetStatusBar;
var
  LocalVersion:String;
begin
  MainStatusBar.Panels[1].Text:= '【用户名】'+ Login.LoginName;
  MainStatusBar.Panels[2].Text:= '【登录时间】'+ FormatDateTime('yy-mm-dd hh:mm',Login.LoginTime);
 // MainStatusBar.Panels[3].Text:= '【工作站】'+ Login.WorkStation;
  MainStatusBar.Panels[3].Text:='【应用服务器】'+ Login.ComPlusServer;
  LocalVersion:= GetVersion(ParamStr(0));
  MainStatusBar.Panels[4].Text:='【版本】'+  LocalVersion;
 if not (HiWord(GetKeyState(VK_CONTROL)) <> 0)then
   CheckVersion(LocalVersion);
end;

procedure TFNMMainForm.FormDestroy(Sender: TObject);
begin
  {$Message '为了调试方便，避免重复登陆，注释了下面的语句，在交付使用时去掉注释'}
  if Login.ComPlusServer <> '' then
    Login.Logoff;
end;

procedure TFNMMainForm.Initialize;
begin
  SetPermission;
  SetStatusBar;
  LoadFieldList;
  Caption:= Login.SystemFullName;
  {初始化可操作的部门}
  OperationDeptInitialize;
//  Login.CurrentDepartment:= Login.DefaultDepartment;
end;

procedure TFNMMainForm.tbiExitApplicationClick(Sender: TObject);
begin
  Close;
end;

procedure TFNMMainForm.AboutClick(Sender: TObject);
var
  VerObject:TExeVersionInfo;
  pv:PChar;
begin
  VerObject:= TExeVersionInfo.Create(Application.ExeName);
  pv:= PChar('广东溢达IT部保留所有权利.版本:'+Trim(VerObject.ProductVersion));//(2004-2005)
  shellabout(Handle, PChar(Caption), pv, Application.Icon.Handle);
end;

procedure TFNMMainForm.FToolMenuClick(Sender: TObject);
begin
  FToolMenu.Checked:= not FToolMenu.Checked;
  clbr_Only.Visible:= FToolMenu.Checked;
  AppOption.ShowToolBar:= FToolMenu.Checked;
end;

procedure TFNMMainForm.FStatusMenuClick(Sender: TObject);
begin
  FStatusMenu.Checked:= not FStatusMenu.Checked;
  MainStatusBar.Visible:= FStatusMenu.Checked;
  AppOption.ShowStatusBar:= FStatusMenu.Checked;
end;

procedure TFNMMainForm.btnCaluClick(Sender: TObject);
begin
  Winexec('CALC.EXE', sw_Normal);
end;

procedure TFNMMainForm.N1Click(Sender: TObject);
begin
 if not Assigned(ReceiveInfoForm) then
   ReceiveInfoForm:= TReceiveInfoForm.Create(Self);
 ReceiveInfoForm.Show;
end;

procedure TFNMMainForm.btnFindClick(Sender: TObject);
begin
 if ActiveMDIChild is TBaseForm then
   TBaseForm(ActiveMDIChild).ActionType:= atQuery;
end;

procedure TFNMMainForm.btnSaveClick(Sender: TObject);
begin
 if ActiveMDIChild is TBaseForm then
   TBaseForm(ActiveMDIChild).ActionType:= atSave;
end;

procedure TFNMMainForm.btnPrintClick(Sender: TObject);
begin
 if ActiveMDIChild is TBaseForm then
   TBaseForm(ActiveMDIChild).ActionType:= atPrint;
end;

procedure TFNMMainForm.btnPreviewClick(Sender: TObject);
begin
 if ActiveMDIChild is TBaseForm then
   TBaseForm(ActiveMDIChild).ActionType:= atPrintPreview;
end;

procedure TFNMMainForm.OtherOptionClick(Sender: TObject);
begin
 if not Assigned(OptionForm) then
     OptionForm:= TOptionForm.Create(Application);
  OptionForm.SetControlStatus(AppOption);
  OptionForm.ShowModal;
end;

procedure TFNMMainForm.LoadFieldList;
var fileName:string;
begin
  fileName:=  Login.UpdatePath+SYSTEMNAME +'.xml';
  GridDecorator.LoadFieldInfoFromFile(fileName);
end;

procedure TFNMMainForm.FN10Click(Sender: TObject);
begin
 WinExec('RunDLL32.exe Shell32.dll,Control_RunDLL desk.cpl,,3', SW_SHOWNORMAL);
end;

procedure TFNMMainForm.ChangeSkinFile;
begin
  sdXPStyle.SkinFile:= AppOption.SkinFileFullName;
  sdXPStyle.Active:= AppOption.UseXPStyle;
end;

procedure TFNMMainForm.LoadFormStyle;
begin
  SetToolBarShow;//设置工具条，状态条显示
  ChangeSkinFile; //设置XP风格
end;

procedure TFNMMainForm.DicClick(Sender: TObject);
begin
  if not Assigned(WebQueryForm) then
     WebQueryForm:= TWebQueryForm.Create(Application);
  WebQueryForm.Show;
end;

procedure TFNMMainForm.SetToolBarShow;
begin
  clbr_Only.Visible:= AppOption.ShowToolBar;
  MainStatusBar.Visible:= AppOption.ShowStatusBar;
  FToolMenu.Checked:= clbr_Only.Visible;
  FStatusMenu.Checked:= MainStatusBar.Visible;
end;

procedure TFNMMainForm.FormCreate(Sender: TObject);
begin
  sdXPStyle:=lsdXPStyle;
  sdXPStyle.OnFormSkin:= sdXPStyleFormSkin;

  btnUpload.Visible := DirectoryExists('D:\xriteData\');
  TimerUpload.Enabled := btnUpload.Visible;

  if FNMWelcome = nil then
    FNMWelcome:= TFNMWelcome.Create(Application);
  FNMWelcome.Enabled:=false;
  FNMWelcome.Show;
  FNMWelcome.ShowProcessMessage('获取用户权限...');

  Initialize;

  FNMWelcome.ShowProcessMessage('');

  FNMWelcome.Close;
  FreeAndNil(FNMWelcome);

  Application.Title:= Caption;
  Application.Icon:= Icon;
  btnExcel.Action:=TExportAction.Create(Self);
  btnExcel.ImageIndex:=11;
  btn_ShowGroupByBox.Action:=TShowcxGridGroupByBox.Create(Self);
  btn_ShowGroupByBox.ImageIndex:=42;

  MFNM418.Enabled:=True;
  MFNM419.Enabled:=True;
  MFNM420.Enabled:=True;

end;

//接收坯布
procedure TFNMMainForm.MFNM601Click(Sender: TObject);
begin
  if not Assigned(ReceiveInfoForm) then
    ReceiveInfoForm:= TReceiveInfoForm.Create(Self);
  ReceiveInfoForm.Show;
end;
//回收挑修布
procedure TFNMMainForm.MFNM602Click(Sender: TObject);
begin
  if not Assigned(ReceiveGIRepairInfoForm) then
    ReceiveGIRepairInfoForm:= TReceiveGIRepairInfoForm.Create(Self);
  ReceiveGIRepairInfoForm.Show;
end;
//打卡
procedure TFNMMainForm.MFNM603Click(Sender: TObject);
begin
  if not Assigned(PrintFNCardForm) then
    PrintFNCardForm:= TPrintFNCardForm.Create(Self);
  PrintFNCardForm.Show;
end;

//组卡
procedure TFNMMainForm.MFNM604Click(Sender: TObject);
begin

  if not Assigned(FabricCardForm) then
    FabricCardForm:= TFabricCardForm.Create(Self);
  FabricCardForm.Show;
end;

//拆分布号
procedure TFNMMainForm.MFNM605Click(Sender: TObject);
begin
//  if not Assigned(SplitFabricNOForm) then
//    SplitFabricNOForm:= TSplitFabricNOForm.Create(Self);
//  SplitFabricNOForm.ShowModal;
end;

//送布确认
procedure TFNMMainForm.MFNM606Click(Sender: TObject);
begin
end;

//送布
procedure TFNMMainForm.MFNM607Click(Sender: TObject);
begin
  if not Assigned(SendInfoForm) then
    SendInfoForm:= TSendInfoForm.Create(Self);
  SendInfoForm.Show;
end;

//单据重打
procedure TFNMMainForm.MFNM610Click(Sender: TObject);
begin
  if not Assigned(RePrintNoteNOForm) then
    RePrintNoteNOForm:= TRePrintNoteNOForm.Create(Self);
  RePrintNoteNOForm.ShowModal;
end;

//修改品名
procedure TFNMMainForm.MFNM613Click(Sender: TObject);
begin
  if not Assigned(ChangeGFNOForm) then
    ChangeGFNOForm:= TChangeGFNOForm.Create(Self);
  ChangeGFNOForm.Show;
end;

//库存布转加工部门
procedure TFNMMainForm.MFNM614Click(Sender: TObject);
begin
  if not Assigned(ChangeDepartmentForm) then
    ChangeDepartmentForm:= TChangeDepartmentForm.Create(Self);
  ChangeDepartmentForm.Show;
end;

procedure TFNMMainForm.MFNM615Click(Sender: TObject);
begin
  if not Assigned(ChangeMaterialTypeForm) then
    ChangeMaterialTypeForm:= TChangeMaterialTypeForm.Create(Self);
  ChangeMaterialTypeForm.Show;
end;

//取消打卡
procedure TFNMMainForm.MFNM611Click(Sender: TObject);
begin
  if not Assigned(CancePrintFNCardForm) then
    CancePrintFNCardForm:= TCancePrintFNCardForm.Create(Self);
  CancePrintFNCardForm.Show;
end;
//接收坯布
procedure TFNMMainForm.MFNM612Click(Sender: TObject);
begin
  if not Assigned(ReceiveFromGIForm) then
    ReceiveFromGIForm:= TReceiveFromGIForm.Create(Self);
  ReceiveFromGIForm.Show;
end;

//制定标准工艺
procedure TFNMMainForm.MFNM101Click(Sender: TObject);
begin
  if not Assigned(StdArtInfoForm) then
    StdArtInfoForm:= TStdArtInfoForm.Create(Self);
  StdArtInfoForm.Show;
end;

//修改实际工艺
procedure TFNMMainForm.MFNM102Click(Sender: TObject);
begin
  TGlobal.FormShow(TFactArtInfoForm);
end;

//制定回修工艺
procedure TFNMMainForm.MFNM103Click(Sender: TObject);
begin
  if not Assigned(RepairArtInfoForm) then
    RepairArtInfoForm:= TRepairArtInfoForm.Create(Self);
  RepairArtInfoForm.Show;
end;

//补化料单
procedure TFNMMainForm.MFNM110Click(Sender: TObject);
begin
{  if not Assigned(SupplyRecipeForm) then
    SupplyRecipeForm:= TSupplyRecipeForm.Create(Self);
  SupplyRecipeForm.ShowModal; }
  if not Assigned(RecipeForm) then
    RecipeForm:= TRecipeForm.Create(Self);
  RecipeForm.Show;
end;

//输入工艺回顾
procedure TFNMMainForm.MFNM104Click(Sender: TObject);
begin
  if not Assigned(ArtReviewForm) then
    ArtReviewForm:= TArtReviewForm.Create(Self);
  ArtReviewForm.Show;
end;

//手织板收付
procedure TFNMMainForm.MFNM105Click(Sender: TObject);
begin
  if not Assigned(HLManageForm) then
    HLManageForm:= THLManageForm.Create(Self);
  HLManageForm.ShowModal;
end;

//手织板工艺
procedure TFNMMainForm.MFNM106Click(Sender: TObject);
begin
  if not Assigned(HLArtForm) then
    HLArtForm:= THLArtForm.Create(Self);
  HLArtForm.Show;
end;

//开标准处方单
procedure TFNMMainForm.MFNM107Click(Sender: TObject);
begin
  if not Assigned(HandRecipeForm) then
    HandRecipeForm:= THandRecipeForm.Create(Self);
  HandRecipeForm.Show;
end;

//开化料单
procedure TFNMMainForm.MFNM109Click(Sender: TObject);
begin
  if not Assigned(RecipePlanForm) then
    RecipePlanForm:= TRecipePlanForm.Create(Self);
  RecipePlanForm.Show;
end;

//工人及组别维护
procedure TFNMMainForm.MFNM201Click(Sender: TObject);
begin
  if not Assigned(WorkerForm) then
    WorkerForm:= TWorkerForm.Create(Self);
  WorkerForm.Show;
end;

//安排机台员工
procedure TFNMMainForm.MFNM202Click(Sender: TObject);
begin
  if not Assigned(WorkerStationForm) then
    WorkerStationForm:= TWorkerStationForm.Create(Self);
  WorkerStationForm.Show;
end;

//编辑OTD
procedure TFNMMainForm.MFNM203Click(Sender: TObject);
begin
  if not Assigned(EditOTDForm) then
    EditOTDForm:= TEditOTDForm.Create(Self);
  EditOTDForm.Show;
end;

//加工优先级
procedure TFNMMainForm.MFNM204Click(Sender: TObject);
begin
 if not Assigned(CutClothForm) then
    CutClothForm := TCutClothForm.Create(Self);
  CutClothForm.Show;
end;

//安排机台计划
procedure TFNMMainForm.MFNM205Click(Sender: TObject);
begin
  if not Assigned(PlanForm) then
    PlanForm:= TPlanForm.Create(Self);
  PlanForm.Show;
end;

//生产HOLD
procedure TFNMMainForm.MFNM301Click(Sender: TObject);
begin
  if not Assigned(HoldForm) then
    HoldForm:= THoldForm.Create(Self);
  HoldForm.ShowModal;
end;

//计划控制
procedure TFNMMainForm.MFNM314Click(Sender: TObject);
begin
  if not Assigned(PlanControlForm) then
    PlanControlForm:= TPlanControlForm.Create(Self);
  PlanControlForm.Show;
end;

//产量车速调整
procedure TFNMMainForm.MFNM315Click(Sender: TObject);
begin
  if not Assigned(AdjustJobTraceDtlForm) then
    AdjustJobTraceDtlForm:= TAdjustJobTraceDtlForm.Create(Self);
  AdjustJobTraceDtlForm.Show;
end;

//工艺控制
procedure TFNMMainForm.MFNM303Click(Sender: TObject);
begin
  if not Assigned(ArtControlForm) then
    ArtControlForm:= TArtControlForm.Create(Self);
  ArtControlForm.Show;
end;

//输入处理单
procedure TFNMMainForm.MFNM304Click(Sender: TObject);
begin
  CreateNewAccident;
end;

//处理处理单
procedure TFNMMainForm.MFNM305Click(Sender: TObject);
begin
  if not Assigned(DisposeAccidentForm) then
    DisposeAccidentForm:= TDisposeAccidentForm.Create(Self);
  DisposeAccidentForm.Show;
end;

//分析质量责任
procedure TFNMMainForm.MFNM306Click(Sender: TObject);
begin
  if not Assigned(AnalysisQualityForm) then
    AnalysisQualityForm:= TAnalysisQualityForm.Create(Self);
  AnalysisQualityForm.Show;
end;

//缩水率异常分析
procedure TFNMMainForm.MFNM316Click(Sender: TObject);
begin
  if not Assigned(ShrinkageAnalysiForm) then
    ShrinkageAnalysiForm:= TShrinkageAnalysiForm.Create(Self);
  ShrinkageAnalysiForm.Show;
end;

//奖罚记录
procedure TFNMMainForm.MFNM307Click(Sender: TObject);
begin
  //if not Assigned(WorkerPrizeForm) then
  //  WorkerPrizeForm:= TWorkerPrizeForm.Create(Self);
  //WorkerPrizeForm.Show;
end;

//加工地点修改
procedure TFNMMainForm.MFNM311Click(Sender: TObject);
begin
  TGlobal.FormShow(TOperationAddrForm);
end;

//质量备注录入
procedure TFNMMainForm.MFNM312Click(Sender: TObject);
begin
  TGlobal.FormShow(TQualityRemarkForm, true);
end;

//分布终端
procedure TFNMMainForm.MFNM308Click(Sender: TObject);
begin
  TGlobal.FormShow(TDistributeTerminalForm);
end;

//机台终端
procedure TFNMMainForm.MFNM309Click(Sender: TObject);
begin
  if not Assigned(MachineTerminalForm) then
    MachineTerminalForm:= TMachineTerminalForm.Create(Self);
  MachineTerminalForm.Show;
end;

//化料终端
procedure TFNMMainForm.MFNM310Click(Sender: TObject);
begin
  if not Assigned(RecipeTerminalForm) then
    RecipeTerminalForm:= TRecipeTerminalForm.Create(Self);
  RecipeTerminalForm.Show;
end;

procedure TFNMMainForm.MFNM401Click(Sender: TObject);
begin
  TGlobal.FormShow(TCPBRecipeForm);
end;

procedure TFNMMainForm.MFNM402Click(Sender: TObject);
begin
  TGlobal.FormShow(TCPBSignForm);
end;
//内部OK
procedure TFNMMainForm.MFNM403Click(Sender: TObject);
begin
  if not Assigned(CPBSELFCheckForm) then
    CPBSELFCheckForm:= TCPBCheckForm.Create(Self);
  CPBSELFCheckForm.iType := 1;
  CPBSELFCheckForm.Status_ID := 3;
  CPBSELFCheckForm.Caption := '打样内部CHECK - 标记OK方';
  CPBSELFCheckForm.lbParam.Caption := 'FN色号';
  CPBSELFCheckForm.pnlCaption.Caption := ' 标记OK方';
  CPBSELFCheckForm.gbDeleteShade.Visible := True;
  CPBSELFCheckForm.lbOKType.Visible:= False;
  CPBSELFCheckForm.cbOKType.Visible:= False;
  CPBSELFCheckForm.cbOKType.ItemIndex := -1 ;
  CPBSELFCheckForm.Show;
end;

//客户ok
procedure TFNMMainForm.MFNM404Click(Sender: TObject);
begin
  if not Assigned(CPBCustomerCheckForm) then
    CPBCustomerCheckForm:= TCPBCheckForm.Create(Self);
  CPBCustomerCheckForm.iType := 2;
  CPBCustomerCheckForm.Status_ID := 4;
  CPBCustomerCheckForm.Caption := '打样客户CHECK 客户确认信息';
  CPBCustomerCheckForm.lbParam.Caption := 'FN色号';
  CPBCustomerCheckForm.pnlCaption.Caption := ' 客户确认信息，标记客户OK方';
  CPBCustomerCheckForm.lbOKType.Visible:= True;
  CPBCustomerCheckForm.cbOKType.Visible:= True;
  CPBCustomerCheckForm.cbOKType.ItemIndex := 0 ;
  CPBCustomerCheckForm.Show;
end;

//小样FORMAT
procedure TFNMMainForm.MFNM407Click(Sender: TObject);
begin
  if not Assigned(CPBSampleForm) then
    CPBSampleForm:= TCPBFormatForm.Create(Self);
  CPBSampleForm.iType := 4;
  CPBSampleForm.gbFNCard.Height := 0;
  CPBSampleForm.Caption := '小样复板';
  CPBSampleForm.pnlCaption.Caption := ' 小样复板';
  CPBSampleForm.gbHistory.BringToFront;
  CPBSampleForm.gbHistoryRecipe.Visible := False;
  CPBSampleForm.Show;
end;

procedure TFNMMainForm.MFNM408Click(Sender: TObject);
begin
  if not Assigned(CPBSampleCheckForm) then
    CPBSampleCheckForm:= TCPBCheckForm.Create(Self);
  CPBSampleCheckForm.iType := 3;
  CPBSampleCheckForm.Status_ID := 8;
  CPBSampleCheckForm.Caption := '小样CHECK，标记小样OK方';
  CPBSampleCheckForm.lbParam.Caption := '品名';
  CPBSampleCheckForm.pnlCaption.Caption := ' 小样CHECK，标记小样OK方';
  CPBSampleCheckForm.lbOKType.Visible:= False;
  CPBSampleCheckForm.cbOKType.Visible:= False;
  CPBSampleCheckForm.cbOKType.ItemIndex := -1 ;
  CPBSampleCheckForm.Show;
end;

procedure TFNMMainForm.MFNM415Click(Sender: TObject);
begin
  TGlobal.FormShow(TCPBDirectForm);
end;

 //大货FORMAT
procedure TFNMMainForm.MFNM409Click(Sender: TObject);
begin
  if not Assigned(CPBBulkForm) then
  CPBBulkForm:= TCPBFormatForm.Create(Self);
  CPBBulkForm.iType := 5;
 // CPBBulkForm.gbFNCard.Height := 180;
  CPBBulkForm.gbHistoryRecipe.Visible := True;
  CPBBulkForm.gbFNCard.BringToFront;
  CPBBulkForm.Caption := '大货复板';
  CPBBulkForm.pnlCaption.Caption := ' 大货复板';
  CPBBulkForm.Show;
end;

procedure TFNMMainForm.MFNM410Click(Sender: TObject);
begin
  TGlobal.FormShow(TCPBManageForm);
end;

procedure TFNMMainForm.MFNM411Click(Sender: TObject);
begin
  TGlobal.FormShow(TCPBStockForm);
end;

procedure TFNMMainForm.MFNM412Click(Sender: TObject);
begin
  TGlobal.FormShow(TCPBColorForm);
end;

procedure TFNMMainForm.MFNM413Click(Sender: TObject);
begin
  TGlobal.FormShow(TCPBQueryForm);
end;

procedure TFNMMainForm.MFNM414Click(Sender: TObject);
begin
  TGlobal.FormShow(TCPBWIPForm);
end;

procedure TFNMMainForm.MFNM405Click(Sender: TObject);
begin
  TGlobal.FormShow(TChemicalForm);
end;

procedure TFNMMainForm.MFNM406Click(Sender: TObject);
begin
  TGlobal.FormShow(TChemicalQueryForm);
end;

//日/月报查询
procedure TFNMMainForm.MFNM501Click(Sender: TObject);
begin
  TGlobal.FormShow(TFabricReportForm);
end;

//OTD查询
procedure TFNMMainForm.MFNM502Click(Sender: TObject);
begin
  if not Assigned(OTDForm) then
    OTDForm:= TOTDForm.Create(Self);
  OTDForm.Show;
end;

//大货/试样WIP查询
procedure TFNMMainForm.MFNM503Click(Sender: TObject);
begin
  TGlobal.FormShow(TWIPQueryForm);
end;

procedure TFNMMainForm.MFNM505Click(Sender: TObject);
begin
  TGlobal.FormShow(TFNMQueryForm);
end;

procedure TFNMMainForm.cbbCurrentDeptChange(Sender: TObject);
var
  OldDesc: string;
begin
  if trim(cbbCurrentDept.Text) <> '' then
  begin
    if FNMMainForm.MDIChildCount = 0 then
    begin
      if pos('->', cbbCurrentDept.Text) > 0 then
        login.CurrentDepartment := Copy(cbbCurrentDept.Text, 1, pos('->',
          cbbCurrentDept.Text) - 1)
      else
        login.CurrentDepartment := cbbCurrentDept.Text;
      //刷新字典
      btn_RefresDir.Click;
    end
    else
    begin
      Login.UserDepartments.Locate('Department', Login.CurrentDepartment, []);
      OldDesc := login.CurrentDepartment + '->' +
        Login.UserDepartments.fieldbyname('Department_Description').AsString;
      try
        cbbCurrentDept.OnChange := nil;
        cbbCurrentDept.ItemIndex := cbbCurrentDept.Items.IndexOf(OldDesc);
      finally
        cbbCurrentDept.OnChange := cbbCurrentDeptChange;
      end;
      TMsgDialog.ShowMsgDialog('当前应用程序还有活动的窗体，请先关闭再切换部门！', 1);
    end;
  end;
end;

procedure TFNMMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
begin
  Action:= caNone;
  if MessageBox(Handle, '你确定要退出系统吗?', Pchar(Application.Title), MB_YESNO + MB_ICONQUESTION) <> IDYES then
    exit;

  for i:= 0 to MDIChildCount - 1 do
    MDIChildren[i].Close;

  Action:= caFree;
end;

procedure TFNMMainForm.WindowCloseUpdate(Sender: TObject);
begin
  (Sender as TWindowClose).Enabled:=true;
end;

procedure TFNMMainForm.WindowCloseExecute(Sender: TObject);
begin
  if MDIChildCount = 0 then
    Close
  else
    ActiveMDIChild.Close;
end;

procedure TFNMMainForm.MFNM609Click(Sender: TObject);
begin
   if not Assigned(ManageSCForm) then
    ManageSCForm:= TManageSCForm.Create(Self);
  ManageSCForm.Show;
end;

procedure TFNMMainForm.MFNM608Click(Sender: TObject);
begin
  if not Assigned(CancelSendInfoForm) then
    CancelSendInfoForm:= TCancelSendInfoForm.Create(Self);
  CancelSendInfoForm.Show;
end;

procedure TFNMMainForm.MFNM313Click(Sender: TObject);
begin
  if not Assigned(JobTraceForm) then
    JobTraceForm:= TJobTraceForm.Create(Self);
  JobTraceForm.Show;
end;

procedure TFNMMainForm.MFNM206Click(Sender: TObject);
begin
  if not Assigned(ManageSampleForm) then
    ManageSampleForm:= TManageSampleForm.Create(Self);
  ManageSampleForm.Show;
end;

procedure TFNMMainForm.N13Click(Sender: TObject);
begin
  TGlobal.FormShow(TMachineEfficiencyForm, False);
end;

procedure TFNMMainForm.NPatternClick(Sender: TObject);
var
  GFKeyValue: string;
begin
  if InputQuery('查看花型', '请输入品名或品名ID:', GFKeyValue) then
     ShowCADPicture(GFKeyValue);
end;

procedure TFNMMainForm.btn_RefresDirClick(Sender: TObject);
begin
  Dictionary.CloseAllDataSet;
  QyDictionary.CloseAllDataSet;
end;

procedure TFNMMainForm.ShowAppServerClick(Sender: TObject);
begin
  if ShowAppServer.Checked then
  begin
    MainStatusBar.Panels.Items[3].Text:='【中间层】' +
      ifthen(Login.ComPlusServer = '', Login.WorkStation, Login.ComPlusServer)
  end
  else
    MainStatusBar.Panels.Items[3].Text:='【工作站】' + Login.WorkStation;
end;

procedure TFNMMainForm.N3Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, nil, 'Regsvr.bat', '', '\\getnas\MIS\W.MIS\Setup\', SW_HIDE);
end;

procedure TFNMMainForm.MFNM207Click(Sender: TObject);
begin
  if not Assigned(RSTraceForm) then
    RSTraceForm:= TRSTraceForm.Create(Self);
  RSTraceForm.Show;
end;

procedure TFNMMainForm.MFNM616Click(Sender: TObject);
begin
  if not Assigned(CancelFIForm) then
    CancelFIForm:= TCancelFIForm.Create(Self);
  CancelFIForm.Show;
end;

procedure TFNMMainForm.MFNM317Click(Sender: TObject);
begin
  if not Assigned(ArtAnalysisForm) then
    ArtAnalysisForm:= TArtAnalysisForm.Create(Self);
  ArtAnalysisForm.Show;
end;

procedure TFNMMainForm.act_ShowCADPicExecute(Sender: TObject);
begin
  ShowCADPictureByAControl(Sender, Screen.ActiveControl);
end;

procedure TFNMMainForm.act_ShowCADPicUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled:=True;
end;

procedure TFNMMainForm.MFNM701Click(Sender: TObject);
begin
  if not Assigned(RepairReasonFrm) then
      RepairReasonFrm:= TRepairReasonFrm.Create(Self);
  RepairReasonFrm.ShowModal;
end;

procedure TFNMMainForm.MFNM703Click(Sender: TObject);
begin
  if not Assigned(OTDReasonForm) then
     OTDReasonForm:= TOTDReasonForm.Create(Self);
  OTDReasonForm.ShowModal;
end;

procedure TFNMMainForm.MFNM704Click(Sender: TObject);
begin
  if not Assigned(ReceiveBenchMarkForm) then
     ReceiveBenchMarkForm := TReceiveBenchMarkForm.Create(Self);
  ReceiveBenchMarkForm.ShowModal;
end;

procedure TFNMMainForm.MFNM705Click(Sender: TObject);
begin
  if not Assigned(MutexChemicalkForm) then
     MutexChemicalkForm := TMutexChemicalkForm.Create(Self);
  MutexChemicalkForm.ShowModal;
end;

procedure TFNMMainForm.MFNM318Click(Sender: TObject);
begin
  if not Assigned(InnerRepairCheckForm) then
     InnerRepairCheckForm := TInnerRepairCheckForm.Create(Self);
  InnerRepairCheckForm.Show;
end;

procedure TFNMMainForm.MFNM319Click(Sender: TObject);
begin
  if not Assigned(FIDutyForm) then
    FIDutyForm := TFIDutyForm.Create(Self);
  FIDutyForm.Show;
end;

procedure TFNMMainForm.MFNM112Click(Sender: TObject);
begin
  if not Assigned(CSStateForm) then
    CSStateForm:= TCSStateForm.Create(Self);
  CSStateForm.Show;
end;

procedure TFNMMainForm.MFNM208Click(Sender: TObject);
begin
  if not Assigned(SDTraceForm) then
    SDTraceForm:= TSDTraceForm.Create(Self);
  SDTraceForm.Show;
end;

procedure TFNMMainForm.MFNM320Click(Sender: TObject);
begin
  if not Assigned(DisposeAccidentTraceForm) then
    DisposeAccidentTraceForm:= TDisposeAccidentTraceForm.Create(Self);
  DisposeAccidentTraceForm.Show;
end;

procedure TFNMMainForm.MFNM706Click(Sender: TObject);
begin
  if not Assigned(ChemicalRatioForm) then
    ChemicalRatioForm:= TChemicalRatioForm.Create(Self);
  ChemicalRatioForm.Show;
end;

procedure TFNMMainForm.MFNM708Click(Sender: TObject);
begin
  if not Assigned(OperationMapMachineModelForm) then
     OperationMapMachineModelForm := TOperationMapMachineModelForm.Create(Self);
  OperationMapMachineModelForm.ShowModal;
end;

procedure TFNMMainForm.MFNM209Click(Sender: TObject);
begin
  if not Assigned(WorkerStationTurnForm) then
    WorkerStationTurnForm:= TWorkerStationTurnForm.Create(Self);
  WorkerStationTurnForm.Show;
end;

procedure TFNMMainForm.MFNM321Click(Sender: TObject);
begin
  if not Assigned(TraceRepairForm) then
    TraceRepairForm:= TTraceRepairForm.Create(Self);
  TraceRepairForm.Show;
end;

procedure TFNMMainForm.MFNM3020Click(Sender: TObject);
begin
  if not Assigned(AnalysisOTDForm) then
    AnalysisOTDForm:= TAnalysisOTDForm.Create(Self);
  AnalysisOTDForm.Show;
end;

procedure TFNMMainForm.MFNM416Click(Sender: TObject);
begin
  if not Assigned(CPBChemicalGroupForm) then
    CPBChemicalGroupForm:= TCPBChemicalGroupForm.Create(Self);
  CPBChemicalGroupForm.ShowModal;
end;

procedure TFNMMainForm.MFNM417Click(Sender: TObject);
begin
  if not Assigned(CPBCustomerGroupForm) then
    CPBCustomerGroupForm:= TCPBCustomerGroupForm.Create(Self);
  CPBCustomerGroupForm.ShowModal;
end;

function TFNMMainForm.GetVersion(FileName: string): string;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(FileName), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(FileName), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    Result := IntToStr(dwFileVersionMS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionMS and $FFFF);
    Result := Result + '.' + IntToStr(dwFileVersionLS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionLS and $FFFF);
  end;
  FreeMem(VerInfo, VerInfoSize);
end;

procedure TFNMMainForm.MFNM322Click(Sender: TObject);
begin
  if not Assigned(SOPDefectForm) then
    SOPDefectForm:= TSOPDefectForm.Create(Self);
  SOPDefectForm.sModel := 'I';
  SOPDefectForm.SetBtnState;
  SOPDefectForm.Show;
end;

procedure TFNMMainForm.btnUploadClick(Sender: TObject);
begin
  UploadDelat;
end;

procedure TFNMMainForm.TimerUploadTimer(Sender: TObject);
begin
  UploadDelat;
end;

procedure TFNMMainForm.ReadDelat(const INSERTSQL: string;
  FileName: string);
const TotalLine = 100;
var
  AList: TStringList;
  i,j: Integer;
  SELECTStr: string;
  Stream: TStream;
  sErrorMsg: widestring;
begin
  Stream := nil;
  AList := TStringList.Create;
  try
    Alist.LoadFromFile(FileName);
    Stream := TFileStream.Create(FileName, fmOpenWrite or fmShareDenyWrite);
    j := 0;
    SELECTStr := '';
    for i := 0 to Alist.Count-1 do
    begin
      if Alist.Strings[i] <> '' then
      begin
        j := j + 1;
        if (j < TotalLine) and (i < Alist.Count-1) then
        begin
          SELECTStr := SELECTStr+Alist.Strings[i]+ #13#10;
        end else
        begin
          SELECTStr := SELECTStr+ StringReplace(Alist.Strings[i],'UNION ALL','',[rfReplaceAll]);
          FNMServerObj.SaveSQLData(INSERTSQL+SELECTStr, sErrorMsg);
          if sErrorMsg<>''then
          begin
            ShowMessage(sErrorMsg);
            exit;
          end;
          j := 0;
          SELECTStr := '';
        end;
      end;  
    end;
    Stream.Size :=0;
  finally
    Stream.Free;
    FreeAndNil(AList);
  end;
end;

procedure TFNMMainForm.UploadDelat;
var
  FileName,INSERTSQL:string;
begin
  TimerUpload.Enabled := False;

  FileName := 'D:\xriteData\xriteRecipe.txt';
  INSERTSQL := 'INSERT INTO dbo.xriteRecipe(Item_NO,Step_ID,Chemical_ID,Usage,Current_Department)' + #13#10;
  if FileExists(FileName) then
    ReadDelat(INSERTSQL,FileName);

  FileName := 'D:\xriteData\xriteColor.txt';
  INSERTSQL := 'INSERT INTO dbo.xriteColor(Item_NO,ill,DEcmc_data,DLcmc_data,Da_data,Db_data,DCcmc_data,DHcmc_data,PF,Current_Department)' + #13#10;
  if FileExists(FileName) then
    ReadDelat(INSERTSQL,FileName);
  TMsgdialog.ShowMsgDialog('上传数据成功!', mtInformation);
  
  TimerUpload.Enabled := True;
end;

procedure TFNMMainForm.MFNM707Click(Sender: TObject);
begin        
  if not Assigned(AffirmCardOperationMapForm) then
    AffirmCardOperationMapForm:= TAffirmCardOperationMapForm.Create(Self);
  AffirmCardOperationMapForm.Show;
end;

procedure TFNMMainForm.MFNM323Click(Sender: TObject);
begin
  if not Assigned(AffirmCardForm) then
    AffirmCardForm:= TAffirmCardForm.Create(Self);
  AffirmCardForm.Show;
end;

procedure TFNMMainForm.MFNM324Click(Sender: TObject);
begin
  if not Assigned(AccidentRecordForm) then
    AccidentRecordForm:= TAccidentRecordForm.Create(Self);
  AccidentRecordForm.Show;
end;

procedure TFNMMainForm.CheckVersion(LocalVersion:String);
var
  ServerPath,ServerVersion:string;
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  FNMServerObj.GetQueryData(vData,'GetSystemPath',sCondition,sErrorMsg);
   if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  TempClientDataSet.Data:=vData;
  ServerPath := TempClientDataSet.FieldByName('full_path').AsString;
  //ServerPath:='\\GETNAS\MIS\W.MIS\Update\FNM\FNM.exe';
  ServerVersion := GetVersion(ServerPath);
  if ServerVersion<>LocalVersion then
  begin
    TMsgDialog.ShowMsgDialog('服务器上有新版本,请升级到最新版本,谢谢合作!', mtWarning);
    Application.Terminate;
  end;
end;

procedure TFNMMainForm.tmrCheckVersionTimer(Sender: TObject);
begin
  SetStatusBar;
end;

procedure TFNMMainForm.MFNM709Click(Sender: TObject);
begin
  if not Assigned(BaseDataForm) then
    BaseDataForm:= TBaseDataForm.Create(Self);
  BaseDataForm.Show;
end;

procedure TFNMMainForm.MFNM210Click(Sender: TObject);
begin
  if not Assigned(CPBChangeGFNOForm) then
    CPBChangeGFNOForm:= TCPBChangeGFNOForm.Create(Self);
  CPBChangeGFNOForm.Show;
end;

procedure TFNMMainForm.N30Click(Sender: TObject);
begin
  if not Assigned(WeighForm) then
    WeighForm:= TWeighForm.Create(Self);
  WeighForm.Show;
end;

procedure TFNMMainForm.N31Click(Sender: TObject);
begin
  if not Assigned(ColorInfoForm) then
    ColorInfoForm:= TColorInfoForm.Create(Self);
  ColorInfoForm.Show;
end;

procedure TFNMMainForm.N35Click(Sender: TObject);
begin
  if not Assigned(SendInfoManageForm) then
    SendInfoManageForm:= TSendInfoManageForm.Create(Self);
  SendInfoManageForm.Show;
end;

procedure TFNMMainForm.MFNM211Click(Sender: TObject);
begin
  if not Assigned(LessStatisticForm) then
    LessStatisticForm:= TLessStatisticForm.Create(Self);
  LessStatisticForm.Show;
end;

procedure TFNMMainForm.MFNM333Click(Sender: TObject);
begin
  if not Assigned(TrackOnlineForm) then
    TrackOnlineForm:= TTrackOnlineForm.Create(Self);
  TrackOnlineForm.Show;
end;

procedure TFNMMainForm.MFNM212Click(Sender: TObject);
begin
  if not Assigned(MachineRulesForm) then
    MachineRulesForm:= TMachineRulesForm.Create(Self);
  MachineRulesForm.Show;
end;

procedure TFNMMainForm.MFNM334Click(Sender: TObject);
begin
  if not Assigned(SuspendApprovalForm) then
    SuspendApprovalForm:= TSuspendApprovalForm.Create(Self);
  SuspendApprovalForm.Show;
end;

procedure TFNMMainForm.MFNM507Click(Sender: TObject);
begin
  if not Assigned(EnergyQueryForm) then
    EnergyQueryForm:= TEnergyQueryForm.Create(Self);
  EnergyQueryForm.Show;
end;

procedure TFNMMainForm.MFNM223Click(Sender: TObject);
begin
  if not Assigned(PlanAnalysisForm) then
    PlanAnalysisForm:= TPlanAnalysisForm.Create(Self);
  PlanAnalysisForm.Show;
end;

procedure TFNMMainForm.MFNM508Click(Sender: TObject);
begin
  if not Assigned(OTDTraceForm) then
    OTDTraceForm:= TOTDTraceForm.Create(Self);
  OTDTraceForm.Show;
end;

procedure TFNMMainForm.MFNM509Click(Sender: TObject);
begin
  if not Assigned(scanInventoryForm) then
    scanInventoryForm:= TscanInventoryForm.Create(Self);
  scanInventoryForm.Show;
end;

procedure TFNMMainForm.MFNM120Click(Sender: TObject);
begin
  if not Assigned(ColorInfoEditFrom) then
    ColorInfoEditFrom:= TColorInfoEditFrom.Create(Self);
  ColorInfoEditFrom.Show;
end;

procedure TFNMMainForm.MFNM511Click(Sender: TObject);
begin
if not Assigned(MFQueryForm) then
    MFQueryForm:= TMFQueryForm.Create(Self);
  MFQueryForm.Show;
end;

procedure TFNMMainForm.MFNM3073Click(Sender: TObject);
begin
  if not Assigned(WorkerPrizeForm) then
    WorkerPrizeForm:= TWorkerPrizeForm.Create(Self);
  WorkerPrizeForm.Show;
end;

procedure TFNMMainForm.MFNM3071Click(Sender: TObject);
begin
   if not Assigned(AddPriceForm) then
    AddPriceForm:= TAddPriceForm.Create(Self);
  AddPriceForm.Show;
end;

procedure TFNMMainForm.MFNM3072Click(Sender: TObject);
begin
  if not Assigned(disposePriceForm) then
    disposePriceForm:= TdisposePriceForm.Create(Self);
  disposePriceForm.Show;
end;

procedure TFNMMainForm.MFNM711Click(Sender: TObject);
begin
  if not Assigned(ProductionParameterForm) then
    ProductionParameterForm:= TProductionParameterForm.Create(Self);
  ProductionParameterForm.Show;
end;

procedure TFNMMainForm.MFNM710Click(Sender: TObject);
begin
  if not Assigned(ProductionListForm) then
    ProductionListForm:= TProductionListForm.Create(Self);
  ProductionListForm.Show;
end;

procedure TFNMMainForm.MFNM617Click(Sender: TObject);
begin
  if not Assigned(ReceiveGreyClothForm) then
    ReceiveGreyClothForm:= TReceiveGreyClothForm.Create(Self);
  ReceiveGreyClothForm.Show;
end;

procedure TFNMMainForm.MFNM618Click(Sender: TObject);
begin
  if not Assigned(PrintFNCardGreyClothForm) then
    PrintFNCardGreyClothForm:= TPrintFNCardGreyClothForm.Create(Self);
  PrintFNCardGreyClothForm.Show;
end;

procedure TFNMMainForm.MFNM619Click(Sender: TObject);
begin
  if not Assigned(ReturnGreyClothForm) then
    ReturnGreyClothForm:= TReturnGreyClothForm.Create(Self);
  ReturnGreyClothForm.Show;
end;

procedure TFNMMainForm.MFNM620Click(Sender: TObject);
begin
  if not Assigned(checkscparamForm) then
    checkscparamForm:= TcheckscparamForm.Create(Self);
  checkscparamForm.Show;
end;

procedure TFNMMainForm.MFNM621Click(Sender: TObject);
begin
  if not Assigned(PrintFNCardAndLabelFrom) then
    PrintFNCardAndLabelFrom:= TPrintFNCardAndLabelFrom.Create(Self);
  PrintFNCardAndLabelFrom.Show;
end;

procedure TFNMMainForm.MFNM622Click(Sender: TObject);
begin
  if not Assigned(OutGoFabricForm) then
    OutGoFabricForm:= TOutGoFabricForm.Create(Self);
  OutGoFabricForm.Show;
end;

procedure TFNMMainForm.MFNM623Click(Sender: TObject);
begin
  if not Assigned(FNEditCarNoForm) then
    FNEditCarNoForm:= TFNEditCarNoForm.Create(Self);
  FNEditCarNoForm.Show;  
end;

procedure TFNMMainForm.MFNM624Click(Sender: TObject);
begin
  if not Assigned(WorkerOptionForm) then
    WorkerOptionForm:= TWorkerOptionForm.Create(Self);
  WorkerOptionForm.Show;
end;

procedure TFNMMainForm.MFNM625Click(Sender: TObject);
begin
  if not Assigned(OutGoFabricRulesForm) then
    OutGoFabricRulesForm:= TOutGoFabricRulesForm.Create(Self);
  OutGoFabricRulesForm.Show;
end;

procedure TFNMMainForm.MFNM626Click(Sender: TObject);
begin
  if not Assigned(PrepareFabricForm) then
    PrepareFabricForm:= TPrepareFabricForm.Create(Self);
  PrepareFabricForm.Show;
end;

procedure TFNMMainForm.MFNM627Click(Sender: TObject);
begin
  if not Assigned(EditCarNoByFNCardForm) then
    EditCarNoByFNCardForm:= TEditCarNoByFNCardForm.Create(Self);
  EditCarNoByFNCardForm.Show;
end;

procedure TFNMMainForm.mniMFNM628Click(Sender: TObject);
begin
  if not Assigned(OutReworkFrom) then
    OutReworkFrom:= TOutReworkFrom.Create(Self);
    OutReworkFrom.Show;
end;

procedure TFNMMainForm.MFNM628Click(Sender: TObject);
begin
  if not Assigned(SectionFabricForm) then
    SectionFabricForm:= TSectionFabricForm.Create(Self);
    SectionFabricForm.Show;
end;

procedure TFNMMainForm.MFNM418Click(Sender: TObject);
begin
  if not Assigned(ReceiveCPBBulkFabricForm) then
    ReceiveCPBBulkFabricForm:= TReceiveCPBBulkFabricForm.Create(Self);
    ReceiveCPBBulkFabricForm.Show;
end;

procedure TFNMMainForm.MFNM419Click(Sender: TObject);
begin
  if not Assigned(CPBDyeDetailForm) then
    CPBDyeDetailForm:= TCPBDyeDetailForm.Create(Self);
    CPBDyeDetailForm.Show;
end;


procedure TFNMMainForm.MFNM420Click(Sender: TObject);
begin
if not Assigned(CPBHLRptForm) then
    CPBHLRptForm:= TCPBHLRptForm.Create(Self);
    CPBHLRptForm.Show;
end;

procedure TFNMMainForm.MFNM712Click(Sender: TObject);
begin
if not Assigned(StdChemicalGroupForm) then
    StdChemicalGroupForm:= TStdChemicalGroupForm.Create(Self);
    StdChemicalGroupForm.Show;
end;

procedure TFNMMainForm.MFNM6201Click(Sender: TObject);
begin
  if not Assigned(SendSCInfoForm) then
    SendSCInfoForm:= TSendSCInfoForm.Create(Self);
    SendSCInfoForm.Show;
end;

procedure TFNMMainForm.MFNM630Click(Sender: TObject);
begin
  if not Assigned(ModifyFactoryForm) then
    ModifyFactoryForm:= TModifyFactoryForm.Create(Self);
    ModifyFactoryForm.Show;
end;

procedure TFNMMainForm.MFNM631Click(Sender: TObject);
begin
  if not Assigned(SetCapacityForm) then
    SetCapacityForm:= TSetCapacityForm.Create(Self);
    SetCapacityForm.Show;
end;

procedure TFNMMainForm.MFNM113Click(Sender: TObject);
begin
    if not Assigned(CheckModifyFactoryForm) then
    CheckModifyFactoryForm:= TCheckModifyFactoryForm.Create(Self);
    CheckModifyFactoryForm.Show;
end;

procedure TFNMMainForm.MFNM632Click(Sender: TObject);
begin
    if not Assigned(FactoryRateForm) then
    FactoryRateForm:= TFactoryRateForm.Create(Self);
    FactoryRateForm.Show;
end;

initialization
  //此对象由Application负责释放
  lsdXPStyle:=TSkinData.Create(Application);

end.


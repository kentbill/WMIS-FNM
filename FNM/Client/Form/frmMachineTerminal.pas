unit frmMachineTerminal;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmMachineTerminal.pas                                        }
{       创建日期 2004-9-17 10:56:21                                            }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表  fnJobTraceHdr, fnJobTraceDtl, fnWorkerYield, fnPlan      }
{       调用重要函数/SQL对象说明                                               }
{       功能描述                                                               }
{
{       修改人员 APJ  zhaogang                                                 }
{       修改日期 2014-01-08                                                    }
{       修改原因 下机时增加对坯布小样数据的判断                                }
{        修改描述：在 CanOperationCard 方法中 下机（Index = 2）部分            }
{                 增加对坯布小样数据的判断，如果为坯布小样的数据，则跳过相关的数据检查}

{       修改人员 APJ  zhaogang                                                 }
{       修改日期 2014-01-28                                                    }
{       修改原因 上机时增加对坯布小样数据的判断                                }
{        修改描述：在 CanOperationCard 方法中 上机（Index = 1）部分            }
{                 增加对坯布小样数据的判断，如果为坯布小样的数据，则跳过车速检查}
{******************************************************************************}

interface

{$I Terminal.inc}

uses
  uFNMArtInfo, cxGraphics, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, DB, DBClient, StdCtrls, Buttons, cxSplitter, Grids, 
  ValEdit, OleCtrls, GFCADLib_TLB, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxStyles, cxCustomData, cxFilter, cxData, 
  cxDataStorage, cxEdit, cxDBData, DateUtils, cxContainer, cxTextEdit,
  cxMemo, ADODB,ShellAPI, cxLookAndFeelPainters, cxButtons, cxLabel,
  cxMaskEdit, cxDropDownEdit, DBGrids;

type
  TMachineTerminalForm = class(TForm)
    pnlClient: TPanel;
    dsMachineTaskInfo: TDataSource;
    cdsMachineTaskInfo: TClientDataSet;
    pnlBottom: TPanel;
    tmr1: TTimer;
    pnlRight: TPanel;
    pnlPicture: TPanel;
    pnlLevelClient: TPanel;
    mmoRemark: TMemo;
    grpFNArt: TGroupBox;
    btnSample: TBitBtn;
    btnUp: TBitBtn;
    btnCancel: TBitBtn;
    btnDown: TBitBtn;
    btnClose: TBitBtn;
    chkShowMsg: TCheckBox;
    chkAutoRefresh: TCheckBox;
    lbl1: TLabel;
    cbbMachine_ID: TComboBox;
    lbl2: TLabel;
    edtClass: TEdit;
    lstOperator: TListBox;
    lbl3: TLabel;
    lbl6: TLabel;
    edtSpeed: TEdit;
    edtFN_Card: TEdit;
    lbl7: TLabel;
    lbl4: TLabel;
    edtWidth: TEdit;
    lbl5: TLabel;
    edtCar_NO: TEdit;
    vleArtParam: TValueListEditor;
    cxsplRight: TcxSplitter;
    gfcadPattern: TGFCAD;
    lbl8: TLabel;
    edtInterval: TEdit;
    lbl9: TLabel;
    btn_NewAccident: TBitBtn;
    pnl_Only2: TPanel;
    btnSuspend: TBitBtn;
    btn_ModifyCarNO: TBitBtn;
    btnQuery: TBitBtn;
    grpMachine: TGroupBox;
    cxgridMachineTaskInfo: TcxGrid;
    cxgridtvMachineTaskInfo: TcxGridDBTableView;
    cxGridlMachineTaskInfo: TcxGridLevel;
    btnRefresh: TBitBtn;
    GroupBox1: TGroupBox;
    cxgridRecipeInfo: TcxGrid;
    cxgridtvRecipeInfo: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxsplBottom: TcxSplitter;
    dsRecipeInfo: TDataSource;
    cdsRecipeInfo: TClientDataSet;
    cbbType: TComboBox;
    Label1: TLabel;
    sclbVat: TScrollBox;
    btnVat: TBitBtn;
    cdsVatInfo: TClientDataSet;
    cdsAffirmCardMsg: TClientDataSet;
    pnlMsg: TPanel;
    cxsplTop: TcxSplitter;
    cxmMsg: TcxMemo;
    btnLocation: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    edtRoll: TEdit;
    edtXJ: TEdit;
    dsExportToDS: TADODataSet;
    cdsExportToDS: TClientDataSet;
    cdsTrace: TClientDataSet;
    btnScrap: TBitBtn;
    timerMC: TTimer;
    btnMC: TBitBtn;
    cdsAlertInfo: TClientDataSet;
    lblAlertInfo: TLabel;
    cdsOneAlertInfo: TClientDataSet;
    edtAutoUpDown: TEdit;
    btnPW: TBitBtn;
    cdsMachineDownCache: TClientDataSet;
    pnlCache: TPanel;
    cxsp1: TcxSplitter;
    dsMachineDownCache: TDataSource;
    grpCache: TGroupBox;
    cxgrdCache: TcxGrid;
    cxgvCache: TcxGridDBTableView;
    cxcFN_Card: TcxGridDBColumn;
    cxcCar_NO: TcxGridDBColumn;
    cxglGrid1Level1: TcxGridLevel;
    pnlfooter: TPanel;
    edtCarNO: TcxTextEdit;
    edtRoll2: TcxTextEdit;
    lbl10: TcxLabel;
    cxLabel1: TcxLabel;
    btnSetArt: TcxButton;
    cdsStdArt: TClientDataSet;
    BtnEditCarNo: TButton;
    cbbArea: TcxComboBox;
    lblArea: TLabel;
    dsArea: TClientDataSet;
    CDSquantityinfo: TClientDataSet;
    cdssamping: TClientDataSet;
    tmrCompactingSkewing: TTimer;
    cdsNewAccident: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure cxgridMachineTaskInfoDblClick(Sender: TObject);
    procedure chkAutoRefreshClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnSampleClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure chkShowMsgClick(Sender: TObject);
    procedure cdsMachineTaskInfoAfterScroll(DataSet: TDataSet);
    procedure cxgridtvMachineTaskInfoCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtWidthKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_NewAccidentClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnSuspendClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbbMachine_IDCloseUp(Sender: TObject);
    procedure edtCar_NOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSpeedKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbbMachine_IDExit(Sender: TObject);
    procedure btn_ModifyCarNOClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure cxgridtvRecipeInfoCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure pnlBottomDblClick(Sender: TObject);
    procedure edtRollKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnLocationClick(Sender: TObject);
    procedure edtXJKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure timerMCTimer(Sender: TObject);
    procedure btnMCClick(Sender: TObject);
    procedure btnScrapClick(Sender: TObject);
    procedure edtAutoUpDownChange(Sender: TObject);
    procedure btnPWClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure edtCarNOKeyPress(Sender: TObject; var Key: Char);
    procedure edtRoll2KeyPress(Sender: TObject; var Key: Char);
    procedure btnSetArtClick(Sender: TObject);
    procedure vleArtParamDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure BtnEditCarNoClick(Sender: TObject);
    procedure tmrCompactingSkewingTimer(Sender: TObject);

  private
    { Private declarations }
    Delay: Integer;                  //刷新延时时间
    sCurrent_Department: string;     //当前操作部门
    Cur_Machine_ID: string;          //当前机器ID
    Cur_GF_ID: Integer;              //当前品名ID
    Cur_Fact_Art_ID: Integer;        //当前上机工艺ID
    Cur_Step_NO: Integer;            //当前步骤
    FactArtInfo:TFactArtDtlInfo;
    StdArtData: TSTDArtDtlInfo;      //标准工艺
    //初始化地位号
    procedure initCarLocationInfo;
    procedure Initialize;
    procedure RefreshData;
//    procedure RefreshRecipeInfo;
    procedure GetMachineTaskInfo(Machine_ID: string);
    procedure CanOperationCard(Car_NO: String; Index: Integer; var dSpeed, dWidth: Double);
    procedure SetMachineOperation(Index: Integer);
    procedure SaveSampleInfo(Index: Integer);
    procedure SetFacadeState(DataSet: TDataSet);
    procedure DataSetAfterScroll(DataSet: TDataSet);
    procedure CustomerKeyPress(var Key: Char);
    procedure ShowArtInfo(iGF_ID, iStep_NO, iFact_Art_ID: Integer);
    function CheckIfNeedSample():Boolean;
    function CheckCanBeDown(DataSet: TDataSet):Boolean;
    procedure DrawVatState;
    procedure DrawVatStateN;
    procedure TextClick(Sender: TObject);
    procedure ViewSOPDefect;
    procedure GetAffirmCardMsg;
    function CheckIsTrace():Boolean;
    procedure ViewAlertInfo;
    procedure CheckLF();
    procedure WriteAccidentBill();
    procedure ViewPrice;
    procedure ViewPerformanceSop;

    //on 2014-10-24 add by vinson for 预缩机需求
    //保存下机后的卡号，以便下机后设置车卷号和工艺参数值
    procedure doInsertCache(AType,AStep_NO: Integer;AFN_Card,AUserMachineID,ACurrent_Department,AFactArtID,AGFNO: string);
    procedure doGetMachineDownCache;
    function doSaveCache(ASQL: WideString; APrompt: Boolean = false): Boolean;
    //设置工艺参数
    procedure doSetArt;

    procedure doSetCarNO;
    procedure doSetRollNO;
    procedure doSetValue(AFieldName,AValue: String);
    procedure doOpenStdArtData(AGF_ID,Operation_Code,Current_Department: String);
    procedure doSetCarNOEnable;
    function  IsFileInUse(fName: string): boolean;  //判断文件是否被使用
    procedure UploadCompactingSkewing(Patch:string); //读取预缩机中控文件
    procedure getcsv(FileName:string);

  public
    { Public declarations }
    sDownLF:string;
    sQuantity,sOperation_Code,saLF,sFnCard:string;
  end;

var
  MachineTerminalForm: TMachineTerminalForm;

procedure FillAllOperationToItems(Department: String; AItems: TStrings);

implementation

uses StrUtils, Math, frmMachineSample, uAppOption, uGlobal, uShowMessage, 
     ServerDllPub, uCADInfo, uDictionary, uLogin, uGridDecorator, frmAccident, 
     uFNMResource, frmSuspend,frmDownInfo,frmViewArtDtl, frmModifyCarNO, frmMachineSelect,
     frmSOPDefect, frmLocateCar, frmCheckArt ,frmMCSystem ,frmSaveScrapInfo,frmScrapInfo,frmAlertInfo,
     frmPriceQuery,frmAddPrice, frmEditCarNoByFNCard , frmPerformanceSop
    {$IFDEF TERMINAL}
    , uTerminal
    {$ENDIF};

{$R *.dfm}
procedure FillAllOperationToItems(Department: String; AItems: TStrings);
begin
  with Dictionary do
  try
    with cds_FinishMachineList do
    begin
      Filter := 'Department ='+ QuotedStr(Department);
      Filtered := True;
      TGlobal.FillItemsFromDataSet(cds_FinishMachineList, 'Machine_ID', 'Machine_Model_CHN', '->', AItems);
    end;
    with cds_OperationHdrList do
    begin
      Filter := 'Operation_Type =''Hand_Dip''';
      Filtered := True;
      while not Eof do
      begin
        AItems.Append(FieldByName('Operation_Code').AsString + '->' + FieldByName('Operation_CHN').AsString);
        Next;
      end;
    end;
  finally
    cds_FinishMachineList.Filtered:=false;
    cds_OperationHdrList.Filtered:=false;
  end;
end;

//画缸状态    2007-11-22
procedure TMachineTerminalForm.DrawVatStateN;
var
  pnl: TPanel;
  lbl: TLabel;
  FontColor: TColor;
  C, R: Double;
  gWidth, gHeight, iRecordCount, i, j, W, H: Integer;
  vData: Olevariant;
  sSQL, sErrorMsg: WideString;
begin
  sclbVat.Visible := False;

  sSQL := QuotedStr(Login.CurrentDepartment)+','+QuotedStr(Cur_Machine_ID);
  FNMServerObj.GetQueryData(vData, 'RCPGetCSVatStatus', sSQL, sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  cdsVatInfo.Data := vData;
  if cdsVatInfo.IsEmpty then Exit;

  //设置Panel大小
  gWidth := 220;
  gHeight := 100;
  W := 10; //Panel的Left
  H := 10; //Panel的Top
  iRecordCount := cdsVatInfo.RecordCount;

  //第一次画
  if sclbVat.ControlCount<>iRecordCount then
  begin
    if sclbVat.ControlCount>0 then
    begin
      for i:= sclbVat.ControlCount-1 downto 0 do
        sclbVat.Controls[i].Destroy;
    end;

    // 一行显示的个数,列数
    C := Int((sclbVat.Width - 20) / gWidth);
    if C = 0 then C := 1;

    //计算行数
    if Frac(iRecordCount / C) > 0 then
      R := Int(iRecordCount / C) + 1
    else
      R := Int(iRecordCount / C);

    with cdsVatInfo do
    begin
      First;
      for i := 0 to Floor(R) - 1 do
      begin
        for j := 0 to Floor(C) - 1 do
        begin
          if Eof then break;
          //创建Panel
          pnl := TPanel.Create(self);
          pnl.Parent := sclbVat;
          pnl.Left := W;
          pnl.Top := H;
          pnl.Width := gWidth;
          pnl.Height := gHeight;
          pnl.BorderStyle := bsSingle;
          pnl.BevelInner := bvRaised;

          //向架位上放入Label显示架位信息
          lbl := TLabel.Create(self);
          lbl.Parent := pnl;
          lbl.Align := alClient;
          lbl.Alignment := taLeftJustify;
          lbl.Font.Size := 15;
          lbl.Font.Style := [fsBold];
          lbl.Font.Color := FontColor;
          lbl.Caption := '';
          W := W + gWidth;
          if Eof then break else Next;
        end;
        H := H + gHeight;
        W := W - Floor(C) * gWidth;
      end
    end;
  end;

  //赋值
  cdsVatInfo.First;
  for i := sclbVat.ControlCount - 1 downto 0 do
  begin

    if TPanel(sclbVat.Controls[i]).Controls[0].ClassName= 'TLabel' then
    begin
      with TLabel(TPanel(sclbVat.Controls[i]).Controls[0]) do
      begin
        Caption := cdsVatInfo.FieldByName('Caption').AsString;
        Font.Color := StringToColor(cdsVatInfo.FieldByName('Font_Color').AsString);
        Color := StringToColor(cdsVatInfo.FieldByName('Color').AsString);
        Hint := cdsVatInfo.FieldByName('Remark').AsString;
        OnClick := TextClick;
      end;                                                

      if not cdsVatInfo.Eof then
        cdsVatInfo.Next;
    end;
  end;

  sclbVat.Visible := True;
end;

procedure TMachineTerminalForm.TextClick(Sender: TObject);
begin
  if TLabel(Sender).Hint<>'' then
    TMsgDialog.ShowMsgDialog(TLabel(Sender).Caption+ TLabel(Sender).Hint, 10);
end;

procedure TMachineTerminalForm.DrawVatState;
var
  pnl: TPanel;
  lbl: TLabel;
  FontColor: TColor;
  C, R: Double;
  gWidth, gHeight, iRecordCount, i, j, W, H: Integer;
  Status_CN: string;
begin;
  sclbVat.Visible := False;
  for i := sclbVat.ControlCount - 1 downto 0 do
    if sclbVat.Controls[i].Name <> 'btnVat' then
      sclbVat.Controls[i].Free;
  try
    Dictionary.cds_VatList.Close;
    Dictionary.cds_VatList.Open;
    if not Dictionary.cds_VatList.Active then Exit;
    Dictionary.cds_VatList.Filter := 'Machine_ID = ' + QuotedStr(Cur_Machine_ID) + ' AND Current_Department = ' + QuotedStr(sCurrent_Department);
    Dictionary.cds_VatList.Filtered := True;
    if Dictionary.cds_VatList.IsEmpty then Exit;

    //设置Panel大小
    gWidth := 220;
    gHeight := 100;
    W := 10; //Panel的Left
    H := 10; //Panel的Top

    iRecordCount := Dictionary.cds_VatList.RecordCount;

    Dictionary.cds_VatList.DisableControls;

    // 一行显示的个数,列数
    C := Int((sclbVat.Width - 20) / gWidth);
    if C = 0 then C := 1;
    //计算行数
    if Frac(iRecordCount / C) > 0 then
      R := Int(iRecordCount / C) + 1
    else
      R := Int(iRecordCount / C);

    with Dictionary.cds_VatList do
    begin
      First;
      for i := 0 to Floor(R) - 1 do
      begin
        for j := 0 to Floor(C) - 1 do
        begin
          if Eof then break;
          //创建Panel
          pnl := TPanel.Create(self);
          pnl.Parent := sclbVat;
          pnl.Left := W;
          pnl.Top := H;
          pnl.Width := gWidth;
          pnl.Height := gHeight;
          pnl.BorderStyle := bsSingle;
          pnl.BevelInner := bvRaised;

          FontColor := clWindowText;
          //根据架位负载情况，设置不同颜色
          case FieldByName('Status').AsInteger of
            0: begin    //未开始
                 pnl.Color := clBtnFace;
                 FontColor := clWindowText;
                 Status_CN := '未开始';
               end;
            1: begin    //开始配料
                 pnl.Color := clRed;
                 FontColor := clYellow;
                 Status_CN := '开始配料';
               end;
            2: begin    //配料完成
                 pnl.Color := clGreen;
                 FontColor := clFuchsia;
                 Status_CN := '配料完成';
               end;
           end;

          //向架位上放入Label显示架位信息
          lbl := TLabel.Create(self);
          lbl.Parent := pnl;
          lbl.Align := alTop;
          lbl.Alignment := taLeftJustify;
          lbl.Font.Size := 15;
          lbl.Font.Style := [fsBold];
          lbl.Font.Color := FontColor;
          lbl.Caption := '' + #10#13 +
                         ' 料缸: ' + FieldByName('Vat_NO').AsString + #10#13 +
                         ' 配方: ' + FieldByName('Recipe_NO').AsString + #10#13 +
                         ' 状态: ' + Status_CN;
           W := W + gWidth;
           if Eof then break else Next;
        end;
        H := H + gHeight;
        W := W - Floor(C) * gWidth;
      end
    end;
  finally
    Dictionary.cds_VatList.EnableControls;
  end;
  sclbVat.Visible := True;
end;

function TMachineTerminalForm.CheckIfNeedSample():Boolean;
var
  Sample_Code: WideString;
begin
  Result := False;
  if cdsMachineTaskInfo.FieldByName('Sample')<> nil then
    Sample_Code :=  cdsMachineTaskInfo.FieldByName('Sample').AsString;
  if Trim(Sample_Code)<>'' then
    Result := MessageBox(0, '是否现在取样？', '系统确认', MB_YESNO+MB_ICONQUESTION) = IDYES ;
end;

procedure TMachineTerminalForm.GetMachineTaskInfo(Machine_ID: string);
var
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取数据稍等！', crHourGlass);
    cdsMachineTaskInfo.AfterScroll := nil;
    Delay := 0;
    tmr1.Enabled := chkAutoRefresh.Checked;

    sCondition := QuotedStr(Machine_ID)+','+ QUotedStr(sCurrent_Department);
    FNMServerObj.GetQueryData(vData,'GetMachineTask',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
   //填充机器列表信息
    cdsMachineTaskInfo.Data := vData;
    if cdsMachineTaskInfo.IsEmpty then
    begin
      SetFacadeState(cdsMachineTaskInfo);
      btnScrap.Enabled := False;
      Exit;
    end;
    GridDecorator.BindCxViewWithDataSource(cxgridtvMachineTaskInfo, dsMachineTaskInfo, True);
    GridDecorator.HideFields(cxgridtvMachineTaskInfo,['Operation_Code','GF_ID','Fact_Art_ID','Roll_NO']);
    GridDecorator.AddFooter(cxgridtvMachineTaskInfo, ['Quantity'], [skSum]);

    //on 2014-10-28 add by vinson for 预缩机需求
    cxgridtvMachineTaskInfo.GetColumnByFieldName('Car_NO').Caption := '车/卷号';

    DataSetAfterScroll(cdsMachineTaskInfo);
    btnScrap.Enabled := True;

    //on 2014-10-24 add by vinsong for 预缩机需求
    doGetMachineDownCache;
  finally
    cdsMachineTaskInfo.AfterScroll := DataSetAfterScroll;
    TStatusBarMessage.ShowMessageOnMainStatsusBar('', crDefault);
  end;
end;

procedure TMachineTerminalForm.RefreshData;
begin
  if (cbbMachine_ID.Style = csDropDownList) and
     ((cbbMachine_ID.ItemIndex = -1) or (cbbMachine_ID.Text = '')) then Exit;


  Cur_Machine_ID := LeftStr(cbbMachine_ID.Text, Pos('->', cbbMachine_ID.Text)-1);
  GetMachineTaskInfo(Cur_Machine_ID);
  //Label3.Visible := (pos('CP',Cur_Machine_ID)>0);
  //edtXJ.Visible := Label3.Visible;

  Dictionary.cds_WorkerStationList.Close;   //适时刷新
  Dictionary.cds_WorkerStationList.Filtered := False;
  Dictionary.cds_WorkerStationList.Filter := Format('Machine_ID= ''%s'' AND Current_Department = ''%s''', [Cur_Machine_ID, sCurrent_Department]);
  Dictionary.cds_WorkerStationList.Filtered := True;
  TGlobal.FillItemsFromDataSet(Dictionary.cds_WorkerStationList, 'Worker_ID', 'Operate_Type', '->', lstOperator.Items);
end;
{
procedure TMachineTerminalForm.RefreshRecipeInfo;
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  if (cbbMachine_ID.Style = csDropDownList) and
     ((cbbMachine_ID.ItemIndex = -1) or (cbbMachine_ID.Text = '')) then  Exit;
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取数据稍等！', crHourGlass);

    FNMServerArtObj.GetMachineRecipeBatch(sCurrent_Department, Cur_Machine_ID, vData, sErrorMsg);

    if sErrorMsg <> '' then
      raise ExceptionEx.CreateResFmt(@ERR_GetNoFinishBatch, [sErrorMsg]);
    cdsRecipeInfo.Data := vData;
    GridDecorator.BindCxViewWithDataSource(cxgridtvRecipeInfo, dsRecipeInfo, True);
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('', crDefault);
  end;
end;
}
procedure TMachineTerminalForm.CanOperationCard(Car_NO: String; Index: Integer; var dSpeed, dWidth: Double);
begin
  if Index = 0 then
  begin
    //上机操作
    dSpeed := StrToFloat(edtSpeed.Text);
    //if (dSpeed = 0.0) and (LeftStr(cbbMachine_ID.Text, 2)<> 'CP') then //2014-01-28 APJ zhaogang 注销
    if (dSpeed = 0.0) and (LeftStr(cbbMachine_ID.Text, 2)<> 'CP')
      and (LeftStr(cdsMachineTaskInfo.FieldByName('FN_Card').AsString, 1) <> 'Q') then //2014-01-28 APJ zhaogang
    begin
      //edtSpeed.SetFocus;
      raise Exception.Create('WAR_车速数据不合理，请联系工艺人员设定车速');
    end;
  end;

  if Index = 2 then
  begin


    //坯布小样下机操作  2014-01-08 APJ zhaogang
    if Pos('Q', cdsMachineTaskInfo.FieldByName('FN_Card').AsString) = 1 then
      Exit;

    //下机操作
    if not CheckCanBeDown(cdsMachineTaskInfo) then
      raise Exception.Create('WAR_卡的加工时间必须大于计划加工时间的一半才能下机, 请检查');

    //2011-4-26
    //2011-4-30放开

    //on 2014-11-4 add by vinson for 预缩机需求
    if (Car_NO = '') and
       (LeftStr(Cur_Machine_ID, 2)<> 'CP') and
       (LeftStr(Cur_Machine_ID, 2)<> 'SG') and
       (LeftStr(Cur_Machine_ID, 2)<> 'DS') then
    begin
      edtCar_NO.SetFocus;
      raise Exception.Create('WAR_请输入新的车牌号');
    end;

    dWidth := StrToFloat(edtWidth.Text);
    //on 2014-11-4 add by vinson for 预缩机需求
    if (dWidth = 0.0) and
       (LeftStr(Cur_Machine_ID, 2)<> 'CP') and
       (LeftStr(Cur_Machine_ID, 2)<> 'SG') and
       (LeftStr(Cur_Machine_ID, 2)<> 'DS') then
    begin
      edtWidth.SetFocus;
      raise Exception.Create('WAR_落幅数据不合理，请重新输入');
    end;
  end;
end;

procedure TMachineTerminalForm.SetMachineOperation(Index: Integer);
var
  sFN_Card, sCar_NO, sRoll_NO,UserMachineID, sValues: string;
  dSpeed, dWidth: Double;
  iStep_NO, iFields:Integer;
  sCondition,sErrorMsg: WideString;
  sOperationCode, sOperateType, sFactArtID,sGFNO:String;
  vData:OleVariant;
  location: string;
begin
  inherited;
  try
    cdsMachineTaskInfo.DisableControls;
    tmr1.Enabled := False;
    sFN_Card := Trim(edtFN_Card.Text);
    if sFN_Card = '' then Exit;

    dSpeed := 0;
    dWidth := 0;
    // on 2014-10-31 add by vinson for 预缩机反馈问题
    dWidth := StrToFloatDef(Trim(edtWidth.Text),0.0);
    
    sCar_NO := Trim(edtCar_NO.Text);
    sRoll_NO := Trim(edtRoll.Text);
    iStep_NO:= cdsMachineTaskInfo.FieldValues['Step_NO'];

    //on 2014-10-24 amend by vinson for 将下机流程改为先保存再输入车卷号等
    //1,对于上下机的所有弹出的质量提示,只针对预缩机/烧毛机/退浆机全部取消.
    if LeftStr(sFN_Card, 1) <> 'N' then CanOperationCard(sCar_NO, Index, dSpeed, dWidth);
//    if (LeftStr(sFN_Card, 1) <> 'N') and
//       (LeftStr(Cur_Machine_ID, 2)<> 'CP') and
//       (LeftStr(Cur_Machine_ID, 2)<> 'SG') and
//       (LeftStr(Cur_Machine_ID, 2)<> 'DS') then CanOperationCard(sCar_NO, Index, dSpeed, dWidth);

    //预缩和烧毛需要选择具体的加工机台
    UserMachineID:=Cur_Machine_ID;
    if Index = 2 then
    begin
      //cuijf 2010-3-2 Yan, Miao Qing /GET/Weaving/Finishing1修改规则
      //磨毛机	所有金刚砂磨毛  FA  排1#机，选择机台下机，所有磨毛工序排2#机
      //预缩机	所有待预缩品种	FG	数据统一传送到1# 预缩机,选择机台下机
      //起毛机	所有待起毛品种	FG	数据统一传送到1# 起毛机,选择机台下机

      //lwl modify 2012-1-16  FG要求下机后 预缩不再选机台

      //FA 预缩和烧毛
      //if (sCurrent_Department = 'FA') and (Pos(LeftStr(UserMachineID, 2), 'SG,CP,SD') <> 0) then
      if (sCurrent_Department = 'FA') and (Pos(LeftStr(UserMachineID, 2), 'SG,SD') <> 0) then
        UserMachineID:=GetSelectMachine(UserMachineID, sCurrent_Department);

      //FG 起毛
      //if (sCurrent_Department = 'FG') and (Pos(LeftStr(UserMachineID, 2), 'RS,CP') <> 0) and (UserMachineID <> 'CP03') then
      if (sCurrent_Department = 'FG') and (Pos(LeftStr(UserMachineID, 2), 'RS') <> 0) and (UserMachineID <> 'CP03') then
        UserMachineID:=GetSelectMachine(UserMachineID, sCurrent_Department);
    end;

    if UserMachineID = '' then Exit;
    // 2010-11-15
    //on 2014-10-30 amend by Vinson for FangYu:是对所有的机台上下机的提示全部取消.TKS.
    if ((Index= 0) or (Index= 1)) and
       (LeftStr(UserMachineID, 2)<> 'CP') and
       (LeftStr(UserMachineID, 2)<> 'SG') and
       (LeftStr(UserMachineID, 2)<> 'DS') then
      GetAffirmCardMsg;

    //2011-11-4预缩只针对008
    sOperationCode:= cdsMachineTaskInfo.FieldValues['Operation_Code'];
    sFactArtID:= cdsMachineTaskInfo.FieldByName('Fact_Art_ID').AsString;
    sGFNO := cdsMachineTaskInfo.FieldByName('GF_NO').AsString;
    //2011-9-16
    // 定型、预缩机台下机确认工艺参数，下机自动生成工艺回顾
    if (((Pos(LeftStr(UserMachineID, 2), 'CP') <> 0) and (sOperationCode= '008'))
        or ((Pos(LeftStr(UserMachineID, 2), 'ST') <> 0) and (sOperationCode= '025'))) //ST,CP
      and (Index= 2) then
    begin
      if LeftStr(UserMachineID, 2)= 'CP' then
        sOperateType := '007'
      else if LeftStr(UserMachineID, 2)= 'ST' then
        sOperateType := '022';

      //sOperateCode:= cdsMachineTaskInfo.FieldByName('Operation_Code').AsString;

      //on 2014-10-24 amend by Vinson for 取消预缩终端下机时工艺对话框弹出,直接上下机
      if (LeftStr(UserMachineID, 2)<> 'CP') and (Index <> 2)  then
      begin
        //弹出确认界面
        if not Assigned(CheckArtForm) then
          CheckArtForm:= TCheckArtForm.Create(Self);
        CheckArtForm.SetInitializeParam(sOperateType, '0', sFN_Card, sFactArtID,sGFNO);

        //不OK退出
        if CheckArtForm.ShowModal<> mrOK then
          Exit;
      end
    end;

    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在保存数据稍等!', crHourGlass);

    //BEGIN 2011-10-14
    if LeftStr(UserMachineID, 2)= 'CB' then
    begin
      sCondition := IntToStr(Index)+','
                  + QuotedStr(sFN_Card)+','
                  + IntToStr(iStep_NO)+','
                  + QuotedStr(UserMachineID)+','
                  + QuotedStr(sCurrent_Department);
      FNMServerObj.GetQueryData(vData,'fnGetExportToDSData',sCondition,sErrorMsg);
      if sErrorMsg <> '' then
        Raise Exception.Create(sErrorMsg);
      cdsExportToDS.Data := vData;
      if not cdsExportToDS.IsEmpty then
      begin
        sValues := '';
        for iFields:=0 to cdsExportToDS.FieldCount-1 do
          sValues := sValues+ QuotedStr(cdsExportToDS.Fields[iFields].AsString)+',';
        sValues := LeftStr(sValues, Length(sValues)-1);
        sCondition := sCondition +','
                   +  QuotedStr(sValues);
        with dsExportToDS do
        begin
          Close;
          CommandText := 'exec usp_rcpExportRecipeToDS '+ sCondition;
          Open;
        end;
      end;
    end;
    //END 2011-10-14

    location := cbbArea.Text;
    if Pos('(已占用)',location)>0 then
    begin
      location := Copy(location,1,Pos('(已占用)',location)-1);
    end;

    sCondition := QuotedStr(sFN_Card)+','
                + IntToStr(iStep_NO)+','
                + QuotedStr(UserMachineID)+','
                + QuotedStr(sCar_NO)+','
                + FloatToStr(dSpeed)+','
                + FloatToStr(dWidth)+','
                + QuotedStr('1900-01-01')+','
                + QuotedStr('FNM_Terminal')+','
                + QuotedStr(sCurrent_Department)+','
                + IntToStr(Index)+ ','
                + QuotedStr(sRoll_NO)+ ','
                + QuotedStr(edtXJ.Text)+ ','
                + QuotedStr(location);
    FNMServerObj.SaveDataBySQL('SetMachineOperation',sCondition,sErrorMsg);
//    FNMServerObj.SetMachineOperation(sFN_Card, iStep_NO, UserMachineID, sCar_NO, dSpeed, dWidth, '1900-01-01', '', sCurrent_Department, Index, sErrorMsg);
    if sErrorMsg <> '' then
      Raise Exception.Create(sErrorMsg);

    case Index of
      0: begin
          if cdsMachineTaskInfo.Locate('FN_Card', sFN_Card, []) then
          begin
            cdsMachineTaskInfo.Edit;
            cdsMachineTaskInfo.FieldValues['Fact_Begin_Time'] := TGlobal.GetServerTime; //Now;
          end;
          btnUp.Enabled := False;
          //edtSpeed.Enabled := btnUp.Enabled;
//          edtWidth.Enabled := not btnUp.Enabled;
//          edtCar_NO.Enabled :=not btnUp.Enabled;
//          edtRoll.Enabled := edtCar_NO.Enabled;
          //on 2014-11-4 amend by vinson for 预缩机需求
          doSetCarNOEnable;
          edtXJ.Enabled := edtCar_NO.Enabled;
          edtCar_NO.Text := '';
          edtRoll.Text := '';
          btnCancel.Enabled := True;
          btnDown.Enabled := True;
         end;
      1: begin
          if cdsMachineTaskInfo.Locate('FN_Card', sFN_Card, []) then
          begin
            cdsMachineTaskInfo.Edit;
            cdsMachineTaskInfo.FieldValues['Fact_Begin_Time'] := null;
          end;
          btnUp.Enabled := True;
          //edtSpeed.Enabled := btnUp.Enabled;
//          edtWidth.Enabled := not btnUp.Enabled;
//          edtCar_NO.Enabled :=not btnUp.Enabled;
//          edtRoll.Enabled := edtCar_NO.Enabled;
          //on 2014-11-4 amend by vinson for 预缩机需求
          doSetCarNOEnable;

          edtXJ.Enabled := edtCar_NO.Enabled;
          btnCancel.Enabled := False;
          btnDown.Enabled := False;
        end;
      2: begin
          //on 2014-10-24 add by vinson for 预缩机需求

          doInsertCache(Index,iStep_NO,sFN_Card,UserMachineID,sCurrent_Department,sFactArtID,sGFNO);

          //Del Saved Card
          if cdsMachineTaskInfo.Locate('FN_Card', sFN_Card, []) then
            cdsMachineTaskInfo.Delete;
          btnCancel.Enabled := False;
          btnDown.Enabled := False;
          edtWidth.Clear;
        end;
    end;
    edtSpeed.Color := IfThen(edtSpeed.Enabled, clWindow, clMenu);
    edtWidth.Color := IfThen(edtWidth.Enabled, clWindow, clMenu);
    edtCar_NO.Color := IfThen(edtCar_NO.Enabled, clWindow, clMenu);
    edtRoll.Color := edtCar_NO.Color;
    edtXJ.Color := edtCar_NO.Color;
    cdsMachineTaskInfo.Edit;
    cdsMachineTaskInfo.FieldByName('Speed').AsFloat := dSpeed;
    cdsMachineTaskInfo.Post;
    TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
    //add luoty 保存后刷新一下 //轧光机 起毛机
    if (LeftStr(Cur_Machine_ID,2) ='CL') or (LeftStr(Cur_Machine_ID,2) ='RS') then
       GetMachineTaskInfo(Cur_Machine_ID);
  finally
    cdsMachineTaskInfo.MergeChangeLog;
    cdsMachineTaskInfo.EnableControls;
    cdsMachineTaskInfo.CheckBrowseMode;
    cxgridtvMachineTaskInfo.ViewData.RefreshRecords;
    TStatusBarMessage.ShowMessageOnMainStatsusBar('', crDefault);
  end;
end;

procedure TMachineTerminalForm.Initialize();
begin
  cxsplBottom.CloseSplitter;
  cxsplRight.CloseSplitter;
  cxsplTop.CloseSplitter;
  
  //on 2014-11-4 add by vinson for预缩机需求
  cxsp1.CloseSplitter;
{$IFDEF TERMINAL}
  FormStyle := fsNormal;
  cbbMachine_ID.Enabled:=false;
  cbbMachine_ID.Color:=clBtnFace;
  cbbMachine_ID.Style:=csSimple;
  cxgridtvMachineTaskInfo.OptionsCustomize.ColumnFiltering := False;
  cxgridtvMachineTaskInfo.OptionsCustomize.ColumnSorting := False;
{$ELSE}
  FormStyle := fsMDIChild;
  BorderStyle := bsSizeable;
  cxgridtvMachineTaskInfo.OptionsCustomize.ColumnFiltering := True;
  cxgridtvMachineTaskInfo.OptionsCustomize.ColumnSorting := True;
{$ENDIF}
  btnCancel.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  btnDown.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnUp.Glyph.LoadFromResourceName(HInstance, RES_UP);

  //SetWindowLong(edtSpeed.Handle, GWL_STYLE, GetWindowLong(edtSpeed.Handle, GWL_STYLE) or ES_NUMBER);
  SetWindowLong(edtWidth.Handle, GWL_STYLE, GetWindowLong(edtWidth.Handle, GWL_STYLE) or ES_NUMBER);
  edtClass.Text := TGlobal.GetClass;

  btnScrap.Enabled := False;
end;

procedure TMachineTerminalForm.FormCreate(Sender: TObject);
begin
  Initialize;
  initCarLocationInfo;
end;

procedure TMachineTerminalForm.FormDestroy(Sender: TObject);
begin
  MachineTerminalForm := nil;
end;

procedure TMachineTerminalForm.CustomerKeyPress(var Key: Char);
begin
  if (ActiveControl <> edtSpeed) and
    (ActiveControl <> edtWidth) and
    (ActiveControl <> edtCar_No) and
    //2011-9-7
    (ActiveControl <> edtRoll) and
    (ActiveControl <> edtXJ) then
  begin
    case Key of
      '0': chkShowMsg.SetFocus;
      '1': SetMachineOperation(0);
      '2': SetMachineOperation(1);
      '3': SetMachineOperation(2);
      '4': btnSample.Click;
      //'5': edtSpeed.SetFocus;
      '6': edtWidth.SetFocus;
      '7': edtCar_No.SetFocus;
      '8': cxgridMachineTaskInfo.SetFocus;
      '9': cxgridRecipeInfo.SetFocus;
      '+': cbbMachine_ID.SetFocus;
      '`': Close;
      '*': cbbType.SetFocus;
     end;
    Key := #0;
  end;
end;

procedure TMachineTerminalForm.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  CustomerKeyPress(Key);
end;

procedure TMachineTerminalForm.FormResize(Sender: TObject);
begin
  Resizing(wsMaximized);
end;

procedure TMachineTerminalForm.tmr1Timer(Sender: TObject);
begin
  Inc(Delay);
  if Delay >= 25 then
  begin
    GetMachineTaskInfo(Cur_Machine_ID);
    DrawVatState;
    Delay := 0;
  end;
end;

procedure TMachineTerminalForm.cxgridMachineTaskInfoDblClick(Sender: TObject);
begin
  SetMachineOperation(0);
end;

procedure TMachineTerminalForm.chkAutoRefreshClick(Sender: TObject);
begin
  Delay := 0;
  tmr1.Enabled := chkAutoRefresh.Checked;
end;

procedure TMachineTerminalForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TMachineTerminalForm.btnUpClick(Sender: TObject);
var
  field,field1: TField;
  strInfo,Cur_Machine_ID:string;
  messages:PChar;
  sSQL,sErrorMsg:WideString;
  vData:OleVariant;
  cdsCompactingCanBeStart:TClientDataSet;
begin
//on 2014-10-30 amend by Vinson for FangYu:是对所有的机台上下机的提示全部取消.TKS.
  Cur_Machine_ID := LeftStr(cbbMachine_ID.Text, Pos('->', cbbMachine_ID.Text)-1);
//chengg 2016-01-14增加判断，如果结果是Ｎ则表示不能上机
  cdsCompactingCanBeStart:=TClientDataSet.Create(nil);
  sSQL:='exec fnmdb.dbo.usp_fnCompactingCanBeStart '+QuotedStr(sCurrent_Department)+','+QuotedStr(Copy(Cur_Machine_ID,1,4))+','+QuotedStr(Trim(edtFN_Card.Text)) ;
  FNMServerObj.GetQueryBySQL(vData, sSQL, sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
    Exit;
  end;
  cdsCompactingCanBeStart.Data:=vData;

  if Trim(cdsCompactingCanBeStart.FieldByName('Can_Start').AsString) = 'N' then
  begin
    TMsgDialog.ShowMsgDialog('正常大货不同车牌不可以与其它布同时上机', mtError);
    Exit;
  end;
  //chengg 2016-1-14 end


  if (LeftStr(Cur_Machine_ID, 2)<> 'CP') and
      (LeftStr(Cur_Machine_ID, 2)<> 'SG') and
      (LeftStr(Cur_Machine_ID, 2)<> 'DS') then
  begin



     if Cur_Machine_ID = '063' then
     begin
       field:= cdsMachineTaskInfo.FindField('BeamAlert');
       if not (field = nil) then
       begin
        if Trim(cdsMachineTaskInfo.FieldByName('BeamAlert').AsString) <> '' then
          ShowMessage(cdsMachineTaskInfo.FieldByName('BeamAlert').AsString);
       end;
     end;
    //检查是否需要跟踪
    if Not CheckIsTrace then
      Exit;
    field:= cdsMachineTaskInfo.FindField('IsOrganic');
    if not (field = nil) then
    begin
      if Trim(cdsMachineTaskInfo.FieldByName('IsOrganic').AsString) = '1' then
        if MessageBox(Handle, '有机棉品种加工,请务必先停机清洁!!!'+#13#10#13#10+'已经清洁请选择 是(Y)'+#13#10+'还没清洁请选择 否(N)', Pchar(Application.Title), MB_YESNO + MB_ICONQUESTION) <> IDYES then
            Exit;
    end;

    field1:= cdsMachineTaskInfo.FindField('Is_Trace');
    if not (field1 = nil) then
    begin
      if Trim(cdsMachineTaskInfo.FieldByName('Is_Trace').AsString) <> '' then
      begin
        //strInfo := cdsMachineTaskInfo.FieldByName('Is_Trace').AsString;
        //messages := PChar('该卡需要跟踪，请通知 ' + strInfo + ''#13#10#13#10+'已经通知请选择 是(Y)'+#13#10+'还没通知请选择 否(N)');
        //if MessageBox(Handle, messages, Pchar(Application.Title), MB_YESNO + MB_ICONQUESTION) <> IDYES then
           // Exit;
      end;
    end;

    if Trim(cdsMachineTaskInfo.FieldByName('White_Type').AsString) = '加白' then
      if Dictionary.GetItemList('加白提示',Cur_Machine_ID,sCurrent_Department) <> '加白' then
        if MessageBox(Handle, '加白布品种加工,请务必先停机清洁!!!'+#13#10#13#10+'已经清洁请选择 是(Y)'+#13#10+'还没清洁请选择 否(N)', Pchar(Application.Title), MB_YESNO + MB_ICONQUESTION) <> IDYES then
          Exit;
  end;
//  if sCurrent_Department <> 'FA' then
//    SaveSampleInfo(0);

  SetMachineOperation(0);

  edtAutoUpDown.SetFocus;
  edtAutoUpDown.AutoSelect := True;
end;

function TMachineTerminalForm.CheckIsTrace(): Boolean;
var
  vData: OleVariant;
  fnCard:string;
  sType, sSQL, sErrMsg: WideString;
  sInfo:PChar;
begin
  with cxgridtvMachineTaskInfo do
  begin
    fnCard := Controller.SelectedRows[0].Values[GetColumnByFieldName('Fn_Card').index];
  end;
  Result := True;
  sSQL := QuotedStr('fnGetAccidentInfo')+','+ QuotedStr(login.CurrentDepartment)+','+ QuotedStr('2')+','+ QuotedStr(fnCard);
  FNMServerObj.GetQueryData(vData, 'CommonSQL', sSQL, sErrMsg);
  if sErrMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  cdsTrace.Data := vData;
  if cdsTrace.RecordCount > 0 then
  begin
    sInfo := PChar('该卡需要跟踪! 请通知 ' + cdsTrace.FieldByName('处理人').AsString + ' 进行跟踪！' +#13#10#13#10+'已经通知请选择 是(Y)'+#13#10+'还没通知请选择 否(N)');
    if MessageBox(Handle, sInfo , Pchar(Application.Title), MB_YESNO + MB_ICONQUESTION) <> IDYES then
      Result := False;
  end;

end;

procedure TMachineTerminalForm.btnCancelClick(Sender: TObject);
begin
  SetMachineOperation(1);
  edtAutoUpDown.SetFocus;
  edtAutoUpDown.AutoSelect := True;
end;

procedure TMachineTerminalForm.btnDownClick(Sender: TObject);
var
  sSQL,sSQL1,sSQL2,sErrMsg: WideString;
  remark:string;
  vData,vData1,vData2:OleVariant;
  n:word;
begin
//  if sCurrent_Department <> 'FA' then
//    SaveSampleInfo(2);
  sSQL:=' exec usp_Samplingdo '+QuotedStr(edtFN_Card.Text)+','+QUotedStr(sCurrent_Department)+','+'1';
  FNMServerObj.GetQueryBySQL(vData, sSQL,sErrMsg);
  if sErrMsg <> '' then
  Raise Exception.Create(sErrMsg);
  cdssamping.Data:= vData  ;
  if   cdssamping.RecordCount<>0 then
  begin
    //ShowMessage(cdssamping.FieldByName('item_value').AsString);
    remark:= cdssamping.FieldByName('item_value').AsString;
    if  remark='STD33'  then
        remark:='取样0.3码';
    if  remark='STD21'  then
        remark:='取样0.7码';
    n:=messagedlg(remark,mtconfirmation,[mbyes,mbno],1);
    if n=mryes
    then
    begin
    sSQL1:=' exec usp_Samplingdo '+QuotedStr(edtFN_Card.Text)+','+QUotedStr(sCurrent_Department)+','+'2';
    FNMServerObj.GetQueryBySQL(vData1, sSQL1,sErrMsg);
    if sErrMsg <> '' then
    Raise Exception.Create(sErrMsg);
    end

    else
    begin
    sSQL2:=' exec usp_Samplingdo '+QuotedStr(edtFN_Card.Text)+','+QUotedStr(sCurrent_Department)+','+'3';
    FNMServerObj.GetQueryBySQL(vData2, sSQL2,sErrMsg);
    if sErrMsg <> '' then
    Raise Exception.Create(sErrMsg);
    end;
  end;


  if (LeftStr(Cur_Machine_ID,2) ='MC') or (LeftStr(Cur_Machine_ID,2) ='ST') then
  begin
    sDownLF := edtWidth.Text;
    with cxgridtvMachineTaskInfo do
    begin
      sQuantity := Controller.SelectedRows[0].Values[GetColumnByFieldName('Quantity').Index];
      sOperation_Code := Controller.SelectedRows[0].Values[GetColumnByFieldName('Operation_Code').Index];
      saLF := Controller.SelectedRows[0].Values[GetColumnByFieldName('落幅').Index];
    end;
    sFnCard := edtFN_Card.Text;
  end;

  SetMachineOperation(2);
  CheckLF();
  edtAutoUpDown.SetFocus;
  edtAutoUpDown.AutoSelect := True;
end;
//丝光定型机 检查落幅
procedure TMachineTerminalForm.CheckLF();
var
  i:Integer;
begin
  //丝光定型机 检查落幅
  if (LeftStr(Cur_Machine_ID,2) ='MC') then
  begin

    if saLF = '' then
      Exit;
      //saLF:= '0';
    if sDownLF = '' then
      sDownLF :='0'
    else
      sDownLF :=sDownLF;

    if (StrToFloat(saLF) > StrToFloat(sDownLF) + 2) or (StrToFloat(saLF) < StrToFloat(sDownLF) - 2) then
    begin
      WriteAccidentBill();
    end;
  end;

//  if  (LeftStr(Cur_Machine_ID,2) ='ST') then
//  begin
//
//    if saLF = '' then
//      Exit;
//      //saLF:= '0';
//    if sDownLF = '' then
//      sDownLF :='0'
//    else
//      sDownLF :=sDownLF;
//
//    if (StrToFloat(saLF) > StrToFloat(sDownLF) + 1) or (StrToFloat(saLF) < StrToFloat(sDownLF) - 1) then
//    begin
//      WriteAccidentBill();
//    end;
//  end;
end;

procedure TMachineTerminalForm.WriteAccidentBill();
var
  sCondition,sErrorMsg:WideString;

begin
  sCondition := QuotedStr(sFnCard) + ',' +
                QuotedStr(sOperation_Code) + ',' + QuotedStr(Cur_Machine_ID) +
                ',' + QuotedStr('产生原因,码长,实际落幅,工艺落幅,卡号') + ',' + QuotedStr(''+ ',' + sQuantity+','+ sDownLF + ',' +saLF + ',' +sFnCard);
  FNMServerObj.SaveDataBySQL('AutoCreateAccident',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
    Exit;
  end;
end;

procedure TMachineTerminalForm.btnRefreshClick(Sender: TObject);
begin
  if Sender = btnRefresh then
    RefreshData;
  if Sender = btnVat then
  begin
     if cxsplBottom.State = ssOpened then
       DrawVatStateN;
  end;
  edtAutoUpDown.SetFocus;
  edtAutoUpDown.AutoSelect := True;
end;

procedure TMachineTerminalForm.chkShowMsgClick(Sender: TObject);
begin
  if chkShowMsg.Checked then
    cxsplRIght.OpenSplitter
  else
    cxsplRight.CloseSplitter;
  DataSetAfterScroll(cdsMachineTaskInfo)
end;

procedure TMachineTerminalForm.SetFacadeState(DataSet: TDataSet);
var
  vData: OleVariant;
  job_no,gf_no:WideString;
  sCondition,sErrorMsg: WideString;
begin
  if DataSet.IsEmpty then
  begin
    edtCar_NO.Text := '';
    edtRoll.Text := '';
    edtFN_Card.Text := '';
    edtSpeed.Text := '0.0';
    edtWidth.Text := '0.0';
    edtRoll.Text := '';
    edtXJ.Text := '';

    edtSpeed.Enabled := False;
    edtWidth.Enabled := False;
    edtCar_NO.Enabled := False;
    edtRoll.Enabled := False;
    btnUp.Enabled := False;
    btnDown.Enabled := False;
    btnCancel.Enabled := False;
  end else
  begin
    btnUp.Enabled := DataSet.FieldbyName('Fact_Begin_Time').IsNull
      and (DataSet.FieldbyName('Is_Hold').AsInteger = 0);
    //edtSpeed.Enabled :=  btnUp.Enabled;
//    edtWidth.Enabled := not btnUp.Enabled;
//    edtCar_NO.Enabled := not btnUp.Enabled;
//    edtRoll.Enabled := edtCar_NO.Enabled;
    //on 2014-11-4 amend by vinson for 预缩机需求
    doSetCarNOEnable;

    edtXJ.Enabled := edtCar_NO.Enabled;
    btnDown.Enabled := (not DataSet.FieldbyName('Fact_Begin_Time').IsNull);
    btnCancel.Enabled := not DataSet.FieldbyName('Fact_Begin_Time').IsNull;
  end;
  edtSpeed.Color := IfThen(edtSpeed.Enabled, clWindow, clMenu);
  if DataSet.FindField('Speed')<>nil then
    edtSpeed.Text := DataSet.FieldByName('Speed').AsString;
  if Trim(edtSpeed.Text)='' then edtSpeed.Text := '0.0';
  if DataSet.FindField('Width')<>nil then
    edtWidth.Text := DataSet.FieldByName('Width').AsString;
  if Trim(edtWidth.Text)='' then edtWidth.Text := '0.0';

  edtWidth.Color := IfThen(edtWidth.Enabled, clWindow, clMenu);
  edtCar_NO.Color := IfThen(edtCar_NO.Enabled, clWindow, clMenu);
  edtRoll.Color := edtCar_NO.Color;
  edtXJ.Color := edtCar_NO.Color;
  //liangzhh
  gf_no:=DataSet.FieldByName('gf_no').AsString;
  job_no:=DataSet.FieldByName('job_no').AsString;
  sCondition := QuotedStr(job_no)+','+ QUotedStr(gf_no);
  FNMServerObj.GetQueryData(vData,'Getfnquantiyinfo',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
    CDSquantityinfo.Data:=vData;
    if DataSet.FieldByName('Operation_CHN').AsString='定型'  then
    begin
    if CDSquantityinfo.FieldByName('result').AsString='Y' then
    ShowMessage('通知带班/组长或质量员跟进');
    end;

    if  DataSet.FieldByName('Operation_CHN').AsString<>'定型'  then
    begin
     if CDSquantityinfo.FieldByName('result').AsString='Y' then
    ShowMessage('卖布小单,严防损耗/疵品');
    end;
  if DataSet.FieldByName('Fact_Begin_Time').IsNull then
  begin
     edtCar_NO.Text := DataSet.FieldByName('Car_NO').AsString;
     edtRoll.Text := DataSet.FieldByName('Roll_NO').AsString;
  end
  else
  begin
     edtCar_NO.Text := '';
     edtRoll.Text := '';
  end;
  mmoRemark.Lines.Clear;
  vleArtParam.Strings.Clear;
end;

procedure TMachineTerminalForm.ShowArtInfo(iGF_ID, iStep_NO, iFact_Art_ID: Integer);
begin
  if (iGF_ID < 1) then Exit;
  if FactArtInfo = nil then
  FactArtInfo := TFactArtDtlInfo.Create(Self);
  FactArtInfo.FACT_Art_ID := iFact_Art_ID;
  FactArtInfo.OpenFNArt;
  mmoRemark.Lines.Add(FactArtInfo.Remark);
  FactArtInfo.FillAStepToAListControls(iStep_NO, vleArtParam);
  CADInfo.OrgGFKeyValue := IntToStr(Cur_GF_ID);
  gfcadPattern.Info := CADInfo.Info;


end;

function TMachineTerminalForm.CheckCanBeDown(DataSet: TDataSet):Boolean;
begin
  Result := True;
  //2011-11-29  2,取消对加工卡号码长<300yds的上下机时间限制,可上机后马上进行下机操作
  if (DataSet.FieldByName('Quantity').AsFloat<300) and (LeftStr(cbbMachine_ID.Text, 2)= 'CP') then
     Exit;
      
  if pos(LeftStr(Cur_Machine_ID, 1), '0123456789') = 0 then
    Result := MinutesBetween(now, DataSet.FieldByName('Fact_Begin_Time').AsDateTime)*2 >
              DataSet.FieldByName('Seconds').AsInteger;
end;

procedure TMachineTerminalForm.DataSetAfterScroll(DataSet: TDataSet);
var
  sOperationCode, sFN_Card, sOperateType, sFactArtID, UserMachineID,sGFNO:String;
begin
  if DataSet.ControlsDisabled then exit;

  if (not DataSet.Active) or DataSet.IsEmpty then Exit;
  SetFacadeState(DataSet);
  edtFN_Card.Text := DataSet.FieldByName('FN_Card').AsString;

  edtAutoUpDown.SetFocus;
  edtAutoUpDown.AutoSelect := True;

  if chkShowMsg.Checked or (cxsplRight.State = ssOpened) then
  begin
    if Cur_GF_ID <> DataSet.FieldByName('GF_ID').AsInteger then
    begin
      Cur_GF_ID := DataSet.FieldByName('GF_ID').AsInteger;
      Cur_Step_NO:= DataSet.FieldByName('Step_NO').AsInteger;
    end;
    if Cur_Fact_Art_ID <> DataSet.FieldByName('Fact_Art_ID').AsInteger then
    begin
      Cur_Fact_Art_ID := DataSet.FieldByName('Fact_Art_ID').AsInteger;
    end;
    //on 2014-10-28 add by Vinson for 预缩需求
    doOpenStdArtData(IntToStr(Cur_GF_ID),cdsMachineTaskInfo.FieldValues['Operation_Code'],Login.CurrentDepartment);

    ShowArtInfo(Cur_GF_ID, Cur_Step_NO, Cur_Fact_Art_ID);
  end;

  if cxsplTop.State = ssOpened then
    GetAffirmCardMsg;
     
  //if (not cdsRecipeInfo.Active) and cdsRecipeInfo.IsEmpty then Exit;

    //2011-9-28
    // 定型、预缩机台上机前查看工艺参数
    sFN_Card := trim(edtFN_Card.Text);
    UserMachineID := cbbMachine_ID.Text;
    sFactArtID := DataSet.FieldByName('Fact_Art_ID').AsString;

    //2011-11-4预缩只针对008
    sOperationCode:= cdsMachineTaskInfo.FieldValues['Operation_Code'];
    sGFNO:= DataSet.FieldByName('GF_NO').AsString;
    if ((Pos(LeftStr(UserMachineID, 2), 'CP') <> 0) and (sOperationCode= '008'))
       or ((Pos(LeftStr(UserMachineID, 2), 'ST') <> 0) and (sOperationCode= '025')) then //ST,CP
    begin
      if LeftStr(UserMachineID, 2)= 'CP' then
        sOperateType := '007'
      else if LeftStr(UserMachineID, 2)= 'ST' then
        sOperateType := '022';
      //弹出确认界面
      if not Assigned(CheckArtForm) then
        CheckArtForm:= TCheckArtForm.Create(Self);
      CheckArtForm.SetInitializeParam(sOperateType, '0', sFN_Card, sFactArtID,sGFNO,True);

      CheckArtForm.ShowModal;
    end;

  if (not cdsRecipeInfo.Active) and cdsRecipeInfo.IsEmpty then
    Exit
  else if DataSet.FindField('Recipe_NO') <> nil then
    cdsRecipeInfo.Locate('Recipe_NO', DataSet['Recipe_NO'], []);
    
end;

procedure TMachineTerminalForm.cdsMachineTaskInfoAfterScroll(DataSet: TDataSet);
begin
  DataSetAfterScroll(DataSet);
end;

procedure TMachineTerminalForm.cxgridtvMachineTaskInfoCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.Focused then Exit;
  cdsMachineTaskInfo.AfterScroll := nil;
  GridDecorator.CustomerDraw(Sender, ACanvas, AViewInfo);
  cdsMachineTaskInfo.AfterScroll := DataSetAfterScroll;
end;

procedure TMachineTerminalForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TMachineTerminalForm.edtWidthKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edtCar_NO.SetFocus;
end;

procedure TMachineTerminalForm.btn_NewAccidentClick(Sender: TObject);
  var
  sSQL,sErrorMsg:WideString;
  vData:OleVariant;
begin
  //chengg 2016-1-12增加重新取数，
  sSQL:='exec fnmdb.dbo.usp_GetMachineTaskInfo '+QuotedStr(Copy(Cur_Machine_ID,1,4))+','+QuotedStr(Login.CurrentDepartment)+','+QuotedStr('Y') ;
  FNMServerObj.GetQueryBySQL(vData, sSQL, sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
    Exit;
  end;
  cdsNewAccident.Data:=vData;
  if cdsNewAccident.Active and (not cdsNewAccident.IsEmpty) then
  begin
    cdsMachineTaskInfo.AfterScroll := nil;
    CreateNewAccident(cdsNewAccident, cbbMachine_ID.Text, lstOperator.Items.Text);
    cdsMachineTaskInfo.AfterScroll := cdsMachineTaskInfoAfterScroll;

    edtAutoUpDown.SetFocus;
    edtAutoUpDown.AutoSelect := True;
  end;

 {  //chengg改前是用的后整机台列表中的卡号开单
  if cdsMachineTaskInfo.Active and (not cdsMachineTaskInfo.IsEmpty) then
  begin
    cdsMachineTaskInfo.AfterScroll := nil;
    CreateNewAccident(cdsMachineTaskInfo, cbbMachine_ID.Text, lstOperator.Items.Text);
    cdsMachineTaskInfo.AfterScroll := cdsMachineTaskInfoAfterScroll;

    edtAutoUpDown.SetFocus;
    edtAutoUpDown.AutoSelect := True;
  end;
  }
end;

procedure TMachineTerminalForm.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
  sCurrent_Department := Login.CurrentDepartment;
{$IFDEF TERMINAL}
  cbbMachine_ID.Text:=MachineName;
  Caption:=MachineName + ' ' + '机台终端';
  Application.Title:=Caption;
  Cur_Machine_ID:= LeftStr(cbbMachine_ID.Text, Pos('->', cbbMachine_ID.Text)-1);
  btnRefresh.Click;
  btnVat.Click;
{$ELSE}
  FillAllOperationToItems(sCurrent_Department, cbbMachine_ID.Items);
  if cbbMachine_ID.Items.Count<=30 then
    cbbMachine_ID.DropDownCount := cbbMachine_ID.Items.Count
  else
    cbbMachine_ID.DropDownCount := 30;
{$ENDIF}
  OnActivate:=nil;
end;

procedure TMachineTerminalForm.btnSuspendClick(Sender: TObject);
var
  sCondition,sErrorMsg: WideString;
begin
  SuspendForm := TSuspendForm.Create(nil);
  try
    TGlobal.FilterData(Dictionary.cds_SuspendReasonList,'Machine_Model='+QuotedStr(LeftStr(Cur_Machine_ID,2)));
    TGlobal.FillComboBoxFromDataSet(Dictionary.cds_SuspendReasonList, 'Suspend_Code',
      'Suspend_Info', '->', SuspendForm.cbbSuspend);
    if SuspendForm.ShowModal = mrOK then
    begin
      if Cur_Machine_ID='' then
      begin
        TMsgDialog.ShowMsgDialog('请先选择机台',mtWarning);
        Exit;
      end;

      sCondition := QuotedStr(Cur_Machine_ID)+','+QuotedStr(LeftStr(SuspendForm.cbbSuspend.Text, 4))+','+
                     QuotedStr(SuspendForm.sBegin_Time)+','+ QuotedStr(SuspendForm.sEnd_Time)+','+
                     QuotedStr(sCurrent_Department)+','+QuotedStr(SuspendForm.sRemark);
      FNMServerObj.SaveDataBySQL('SaveSuspendInfo',sCondition,sErrorMsg);
      if sErrorMsg <> '' then
      begin
        TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
        Exit;
      end;
      TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
    end;
  finally
    SuspendForm.Free;

    edtAutoUpDown.SetFocus;
    edtAutoUpDown.AutoSelect := True;
  end;
end;

procedure TMachineTerminalForm.btnSampleClick(Sender: TObject);
begin
  SaveSampleInfo(2);
  edtAutoUpDown.SetFocus;
  edtAutoUpDown.AutoSelect := True;
end;

procedure TMachineTerminalForm.SaveSampleInfo(Index: Integer);
var
  vData,vParam : OleVariant;
  Test_NO,FNCard, StepNO,OperationCode, SampleCode, GFID,JobNO,sCondition,sErrorMsg: WideString;
  showinfo:  string;
begin
  FNCard:=edtFN_Card.Text;
  if FNCard[1] = 'N' then Exit;//raise Exception.Create('WAR_手织板不能取样!');
  sCondition := QuotedStr(FNCard)+','+QuotedStr(sCurrent_Department)+',0';
  FNMServerObj.GetQueryData(vData,'GetSampleInfo',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
    Exit;
  end;
  TempClientDataSet.Data := vData;
  if TempClientDataSet.IsEmpty then Exit;
  //上机提示
  if Index = 0 then
  begin
    showinfo:= TempClientDataSet.FieldByName('Sample_Code').AsString + #13#10+
               TempClientDataSet.FieldByName('Sample_Name').AsString;
    Application.MessageBox(Pchar(showinfo),'取样提示', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;
  
  MachineSampleForm := TMachineSampleForm.Create(nil);
  try
    with MachineSampleForm, TempClientDataSet do
    begin
      edtOperation.Text := FieldByName('Operation_CHN').AsString;
      edtSampleName.Text := FieldByName('Sample_Name').AsString;
      edtPlanQuantity.Text := FieldByName('Plan_QTY').AsString;
      cbbFabricNOList.Items.Text := FieldByName('FabricNOList').AsString;
      cbbWorkerList.Items := lstOperator.Items;
      StepNO := FieldByName('Step_NO').AsString;
      OperationCode := FieldByName('Operation_Code').AsString;
      SampleCode := FieldByName('Sample_Code').AsString;
      GFID := FieldByName('GF_ID').AsString;
      JobNO := FieldByName('Job_NO').AsString;
      edtFactQuantity.Text := edtPlanQuantity.Text;
      if cbbFabricNOList.Items.Count > 0 then
        cbbFabricNOList.ItemIndex := 0 ;
      if cbbWorkerList.Items.Count > 0 then
        TGlobal.SetComboBoxValue(cbbWorkerList,'落布');
      //记录取样
      vParam := VarArrayCreate([0,0], VarVariant);
      vParam[0] := VarArrayOf([GFID,JobNO,cbbFabricNOList.Text,StepNO,OperationCode, Cur_Machine_ID,
                            SampleCode, edtFactQuantity.Text, LeftStr(cbbWorkerList.Text, 7),sCurrent_Department]);
      FNMServerObj.SaveSampleInfo(vParam,sErrorMsg);
      if sErrorMsg <> '' then
      begin
        TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
        Exit;
      end;
         //排卡
      if MachineSampleForm.ShowModal = mrOK then
      begin
        sCondition := QuotedStr(LeftStr(cbbFabricNOList.Text,12))+','+QuotedStr('FNM');
        FNMServerObj.SaveDataBySQLEx('SaveSampleToPTMEx',sCondition,Test_NO,sErrorMsg);
        if sErrorMsg <> '' then
        begin
          TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
          Exit;
        end;
        if Test_NO <> '' then
        begin
          showinfo:= '测试号:'+Test_NO;
          Application.MessageBox(Pchar(showinfo),'取样排卡成功', MB_OK + MB_ICONINFORMATION);
        end;
        // TMsgDialog.ShowMsgDialog('取样成功', mtInformation);
      end;
    end;
  finally
    MachineSampleForm.Free;
  end;
end;

procedure TMachineTerminalForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F5: btnRefresh.Click;
    VK_F4: btnVat.Click;
    VK_F11: ShowCADPicture(Cur_GF_ID);
  end;
end;

procedure TMachineTerminalForm.cbbMachine_IDCloseUp(Sender: TObject);
begin
  if cbbMachine_ID.ItemIndex = -1 then Exit;
  if Cur_Machine_ID <> LeftStr(cbbMachine_ID.Text, Pos('->', cbbMachine_ID.Text)-1) then
  begin
    btnRefresh.Click;
    btnVat.Click;
  end;
end;

procedure TMachineTerminalForm.edtCar_NOKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edtRoll.SetFocus;
end;

procedure TMachineTerminalForm.edtSpeedKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnUp.SetFocus;
end;

procedure TMachineTerminalForm.cbbMachine_IDExit(Sender: TObject);
begin
  if cbbMachine_ID.ItemIndex = -1 then Exit;
  if Cur_Machine_ID <> LeftStr(cbbMachine_ID.Text, Pos('->', cbbMachine_ID.Text)-1) then
  begin
    btnRefresh.Click;
    btnVat.Click;
  end;
end;

procedure TMachineTerminalForm.btn_ModifyCarNOClick(Sender: TObject);
begin
  ModifyCarNO(lstOperator.Items.Text);
end;

procedure TMachineTerminalForm.btnQueryClick(Sender: TObject);
begin
  case cbbType.ItemIndex of
    0 : ViewWorkerYield(0);
    1 : ViewSuspendInfo(Cur_Machine_ID,1);
    2 : ViewWorkerYield(2);
    3 : ViewAccidentInfo(edtFN_Card.Text);
    4 : ViewWorkerShift;
    5 : ViewOTDAnalysis;
    6 : ViewSOPDefect;
    7,8 : if cbbMachine_ID.ItemIndex = -1 then Exit
          else
            ViewAffirmCard(LeftStr(cbbMachine_ID.Text, Pos('->', cbbMachine_ID.Text)-1),cbbType.ItemIndex);
    9 : ViewAlertInfo;
    10: ViewPrice;
    11: ViewPerformanceSop;
  end;
  edtAutoUpDown.SetFocus;
  edtAutoUpDown.AutoSelect := True;
end;

procedure TMachineTerminalForm.ViewAlertInfo();
begin
  if AlertInfoForm = nil then
    AlertInfoForm:=TAlertInfoForm.Create(Application);
  AlertInfoForm.ShowModal;
end;

procedure TMachineTerminalForm.ViewPrice();
begin
  if PriceQueryForm = nil then
    PriceQueryForm:=TPriceQueryForm.Create(Application);
  PriceQueryForm.ShowModal;
end;

procedure TMachineTerminalForm.ViewPerformanceSop();
begin
   if PerformanceSopForm = nil then
   begin
       PerformanceSopForm:=TPerformanceSopForm.Create(Application);
       PerformanceSopForm.ShowModal;
   end;


end;

procedure TMachineTerminalForm.cxgridtvRecipeInfoCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  col: Integer;
begin
  if AViewInfo.Focused then Exit;

  col := TcxGridDBTableView(Sender).GetColumnByFieldName('Status').Index;
  if AViewInfo.GridRecord.Values[col] = 1 then
  begin
    ACanvas.Brush.Color:=clWhite;
    ACanvas.Font.Color:=clRed; //已经开始化料
  end;

  if AViewInfo.GridRecord.Values[col] = 2 then
  begin
    ACanvas.Brush.Color:=clWhite;
    ACanvas.Font.Color:=clBlue;  //已经完成化料
  end;
end;

procedure TMachineTerminalForm.ViewSOPDefect;
begin
  if Assigned(SOPDefectForm) then
    SOPDefectForm.Close;
  SOPDefectForm:= TSOPDefectForm.Create(Application);
  with SOPDefectForm do
  begin
    sModel := 'Q';
    FormStyle := fsNormal;
    WindowState := wsMaximized;
    Position := poScreenCenter;
    Visible := False;
    ShowModal;
  end;
end;

procedure TMachineTerminalForm.GetAffirmCardMsg;
var
  sMsg, FN_Card, Operation_Code: string;
  sSQL, sErrMsg: WideString;
  vData:OleVariant;
begin
  if not cdsMachineTaskInfo.Active then Exit;

  FN_Card := Trim(edtFN_Card.Text);
  Operation_Code :=  cdsMachineTaskInfo.FieldValues['Operation_Code'];
  if Operation_Code= '' then Exit;

  sSQL := 'select sMsg= FNMDB.dbo.udf_fnGetAffirmCardByFNCard('
        + QuotedStr(FN_Card)+','
        + QuotedStr(Operation_Code)+')';
  FNMServerObj.GetQueryBySQL(vData, sSQL,sErrMsg);
  if sErrMsg <> '' then
    Raise Exception.Create(sErrMsg);

  cdsAffirmCardMsg.Data := vData;

  cxmMsg.Text:= '';
  if not cdsAffirmCardMsg.IsEmpty then
  begin
    sMsg := cdsAffirmCardMsg.FieldByName('sMsg').AsString;
    if sMsg<>'' then
    begin
      cxmMsg.Text := '疵点防范:'+sMsg+ char(13);
      Application.MessageBox(pchar(sMsg), '疵点防范', MB_OK + MB_ICONINFORMATION);
      //TMsgDialog.ShowMsgDialog(sMsg, mtWarning);
    end;
  end;
  cdsAffirmCardMsg.EmptyDataSet;

  //2011-3-28 增加备注显示
  sSQL := 'select sMsg= FNMDB.dbo.udf_fnGetLongRemark('
        + QuotedStr(FN_Card)+')';
  FNMServerObj.GetQueryBySQL(vData, sSQL,sErrMsg);
  if sErrMsg <> '' then
    Raise Exception.Create(sErrMsg);
  cdsAffirmCardMsg.Data := vData;
  sMsg := '';
  if not cdsAffirmCardMsg.IsEmpty then
  begin
    sMsg := cdsAffirmCardMsg.FieldByName('sMsg').AsString;
    if sMsg<>'' then
    begin
      cxmMsg.Text := cxmMsg.Text+ sMsg;
    end;
  end;
  cdsAffirmCardMsg.EmptyDataSet;

  if cxmMsg.Text<>'' then
    cxsplTop.OpenSplitter
  else
    cxsplTop.CloseSplitter;
end;

procedure TMachineTerminalForm.pnlBottomDblClick(Sender: TObject);
begin
  //测试用
  GetAffirmCardMsg;
end;

procedure TMachineTerminalForm.edtRollKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edtXJ.SetFocus;
end;

procedure TMachineTerminalForm.btnLocationClick(Sender: TObject);
begin
  if Assigned(LocateCarForm) then
    LocateCarForm.Close;
  LocateCarForm:= TLocateCarForm.Create(Application);
  with LocateCarForm do
  begin
    sDept := sCurrent_Department;
    FormStyle := fsNormal;
    Position := poScreenCenter;
    Visible := False;
    ShowModal;
  end;
  edtAutoUpDown.SetFocus;
  edtAutoUpDown.AutoSelect := True;
end;

procedure TMachineTerminalForm.edtXJKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnDown.SetFocus;
end;

procedure TMachineTerminalForm.timerMCTimer(Sender: TObject);
var
  sErrMsg:WideString;
  sSQL:string;
  vData:OleVariant;
begin

  //存储工序自动下机
  //sSQL := QuotedStr('存储') + ',2';
  //FNMServerObj.GetQueryData(vData, 'GetAlertInfo', sSQL, sErrMsg);
  //if sErrMsg <> '' then
  // begin
  //  TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    //Exit;
  //end;

  if (LeftStr(cbbMachine_ID.Text,2) = 'MC') and (sCurrent_Department = 'FA') then
  begin
    sSQL := QuotedStr(LeftStr(cbbMachine_ID.Text,4));
    FNMServerObj.GetQueryData(vData, 'GetAlertInfo', sSQL, sErrMsg);
    if sErrMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;
    cdsAlertInfo.Data := vData[0];
    cdsOneAlertInfo.Data := vData[1];

    if cdsAlertInfo.fieldbyname('Alert_Message').AsString <> '' then
    begin
      ShowMessage(cdsAlertInfo.fieldbyname('Alert_Message').AsString);
    end;
    if cdsOneAlertInfo.fieldbyname('Alert_Message').AsString <> '' then
    begin
      lblAlertInfo.Caption := '最近报警信息：' + cdsOneAlertInfo.fieldbyname('Alert_Message').AsString;
    end;
  end;
end;

procedure TMachineTerminalForm.btnMCClick(Sender: TObject);
begin
  ShellExecute(Handle,'open','IExplore.exe','http://192.168.22.125/KingViewWeb/Default.htm',nil,SW_SHOWNORMAL)
end;

procedure TMachineTerminalForm.btnScrapClick(Sender: TObject);
var
   GF_NO:string;
   FN_Card:string;
   Fabric_NO:string;
   Job_NO:string;
   Operation_Code:string;
   Machine_ID:string;
   Current_Department:string;
   Operator:string;
begin

  if (HiWord(GetKeyState(VK_CONTROL)) <> 0)then
  begin
    if not Assigned(ScrapInfoForm) then
      ScrapInfoForm:= TScrapInfoForm.Create(Self);
    ScrapInfoForm.Show;
    Exit;
  end;

  with cxgridtvMachineTaskInfo do
  begin
    GF_NO   := Controller.SelectedRows[0].Values[GetColumnByFieldName('GF_NO').index];
    FN_Card := Controller.SelectedRows[0].Values[GetColumnByFieldName('FN_Card').index];
    Job_NO  := Controller.SelectedRows[0].Values[GetColumnByFieldName('Job_NO').index];
    Operation_Code := Controller.SelectedRows[0].Values[GetColumnByFieldName('Operation_CHN').index];
    Machine_ID := cbbMachine_ID.Text;
    Current_Department := sCurrent_Department;
    Operator := Login.LoginID;
  end;
  if FN_Card = '' then
  begin
    Application.MessageBox(Pchar('请选择记录需要报废的卡号！'),'信息', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;
  CreateNewScrapInfo(GF_NO,FN_Card,Job_NO,Operation_Code,Machine_ID,Current_Department,Operator);

  edtAutoUpDown.SetFocus;
  edtAutoUpDown.AutoSelect := True;
end;

procedure TMachineTerminalForm.edtAutoUpDownChange(Sender: TObject);
var
  i:Integer;
  j:Integer;
  sCard:string;
begin
  j :=- 1;

  if Length(edtAutoUpDown.Text) <> 9 then Exit;
  sCard := edtAutoUpDown.Text;
  if (edtAutoUpDown.Text = '') then
    Exit;

  with cxgridtvMachineTaskInfo do
  begin
    for i :=0 to DataController.RowCount - 1 do
    begin
      if DataController.GetDisplayText(i,GetColumnByFieldName('FN_Card').index) = UpperCase(edtAutoUpDown.Text) then
      begin
        j := i;
      end;
    end;
    if j = -1 then
    begin
      edtAutoUpDown.Text := '';
      Application.MessageBox(Pchar('没有找到卡号，请检查卡号是否正确！'),'信息', MB_OK + MB_ICONINFORMATION);
      Exit;
    end;

    if j <> -1 then
    begin
      Controller.FocusedRowIndex:=j;
    end;
    if (DataController.GetDisplayText(j,GetColumnByFieldName('Fact_Begin_Time').index) = '') then
    begin
      btnUp.Click;   //上机
    end
    else
    begin
      //on 2014-10-23 amend by Vinson for 预缩机需求 4.
//      DownInfoForm := TDownInfoForm.Create(nil);
//      if (DownInfoForm.ShowModal = mrOK) or (DownInfoForm.ShowModal = mrCancel) then
//      begin
//        edtWidth.Text := DownInfoForm.sWith;
//        edtCar_NO.Text := DownInfoForm.sCarNo;
//        edtRoll.Text := DownInfoForm.sRoll;
//        DownInfoForm.Free;
//      end;

      btnDown.Click;
    end;

  end;
  edtAutoUpDown.Text := '';

end;

procedure TMachineTerminalForm.btnPWClick(Sender: TObject);
begin
   if not Assigned(AddPriceForm) then
    AddPriceForm:= TAddPriceForm.Create(Self);
  AddPriceForm.Show;
end;

procedure TMachineTerminalForm.doInsertCache(AType,AStep_NO: Integer;AFN_Card,AUserMachineID,ACurrent_Department,AFactArtID,AGFNO: string);
var
   sSQL: String;
begin
  if not cdsMachineDownCache.Active then
    Exit;
  with cdsMachineDownCache do

  if cdsMachineDownCache.Locate('FN_Card', VarArrayOf([AFN_Card]), []) = false then
  begin
    Append;
    FieldByName('Type').AsInteger := AType;
    FieldByName('Step_NO').AsInteger := AStep_NO;
    FieldByName('FN_Card').AsString := AFN_Card;
    FieldByName('Machine_ID').AsString := AUserMachineID;
    FieldByName('Current_Department').AsString := ACurrent_Department;
    FieldByName('Fact_Art_ID').AsString := AFactArtID;
    FieldByName('GF_NO').AsString := AGFNO;
    FieldByName('Status').AsInteger := 0;
    FieldByName('Operate_Time').AsDateTime := Now;
    FieldByName('Operator').AsString := Login.LoginID;
    Post;
  end;
  sSQL := 'INSERT FNMDB.dbo.fnMachineDownCache(Type,Step_NO,FN_Card,Machine_ID,Current_Department,Fact_Art_ID,GF_NO,Status,Operate_Time,Operator) '+
            Format('VALUES(%d,%d,%s,%s,%s,%s,%s,0,GETDATE(),%s)',[
              AType,
              AStep_NO,
              QuotedStr(AFN_Card),
              QuotedStr(AUserMachineID),
              QuotedStr(ACurrent_Department),
              QuotedStr(AFactArtID),
              QuotedStr(AGFNO),
              QuotedStr(Login.LoginID)
            ]);
  doSaveCache(sSQL, False);
end;

procedure TMachineTerminalForm.doGetMachineDownCache;
var
  Machine_ID: String;
  sSQL, sErrMsg: WideString;
  vData:OleVariant;
begin

  Machine_ID := LeftStr(cbbMachine_ID.Text, Pos('->', cbbMachine_ID.Text)-1);
  sSQL := ' exec usp_fnGetMachineDownCache '+QuotedStr(Machine_ID)+','+QUotedStr(sCurrent_Department);

  FNMServerObj.GetQueryBySQL(vData, sSQL,sErrMsg);
  if sErrMsg <> '' then
    Raise Exception.Create(sErrMsg);
  cdsMachineDownCache.Data := vData;

  //2,预缩终端内的以下红框不允许操作工再输入
  if LeftStr(Machine_ID, 2) = 'CP' then
  begin

    doSetCarNOEnable;

    //on 2014-11-4 add by Vinson for 除预缩终端外隐藏“下机缓存”
    cxsp1.OpenSplitter;
  end else
  begin
    cxsp1.CloseSplitter;
  end;

end;


function TMachineTerminalForm.doSaveCache(ASQL: WideString; APrompt: Boolean = false): Boolean;
var
  vData:OleVariant;
  sErrorMsg, sSQL : WideString;
begin
  Result := false;
  if not cdsMachineDownCache.Active then
    Exit;
  if TGlobal.DeltaIsNull(cdsMachineDownCache) then
    Exit;
  if Trim(ASQL)  = '' then
    exit;

  sSQL :=  ASQL + ' SELECT 0 as F1';
  try
    uShowMessage.ShowStatusMessage('正在保存数据稍等！', crHourGlass);

    if (APrompt = True) then
    begin
      if MessageBox(0, '您是否确定保存数据？', '系统确认', MB_OKCANCEL + MB_ICONQUESTION + MB_DEFBUTTON2) = IDCANCEL then Exit;
    end;
//    vData := cdsMachineDownCache.Delta;
//    FNMServerObj.SaveBaseTableInfo(vData, 'fnMachineDownCache', 'Current_Department,Machine_ID,FN_Card', sErrorMsg);
    FNMServerObj.GetQueryBySQL(vData,sSQL,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
    cdsMachineDownCache.MergeChangeLog;

    Result := True;
    if (APrompt = True) then
    begin
      TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
    end;

  finally
    uShowMessage.ShowStatusMessage('', crDefault);
  end;

end;

procedure TMachineTerminalForm.btnSaveClick(Sender: TObject);
begin
//  doSaveCache(True);
end;

procedure TMachineTerminalForm.doSetArt;
var
  sOperateType,sFactArtID,sGFNO,fnCard: String;
  sSQL: WideString;
begin


  if (cdsMachineDownCache.Active = false) or (cdsMachineDownCache.RecordCount = 0) then exit;
  if cxgvCache.Controller.SelectedRowCount <> 1 then
  begin
    TMsgDialog.ShowMsgDialog('请选择一个卡号', mtInformation);
    exit;
  end;
  fnCard :=  cxgvCache.Controller.SelectedRows[0].Values[cxgvCache.GetColumnByFieldName('FN_Card').index];
  if cdsMachineDownCache.Locate('FN_Card', VarArrayOf([fnCard]), []) = false then
    Exit;
  with cdsMachineDownCache do
  begin
    //只有预缩机才可以设置
    if LeftStr(FieldByName('Machine_ID').AsString, 2) <> 'CP' then
    begin
      TMsgDialog.ShowMsgDialog('只有预缩机才可以操作！', mtInformation);
      exit;
    end;
    sOperateType := '007';

    sFactArtID:= FieldByName('Fact_Art_ID').AsString;
    sGFNO := FieldByName('GF_NO').AsString;
  end;

  if not Assigned(CheckArtForm) then
    CheckArtForm:= TCheckArtForm.Create(Self);

  CheckArtForm.SetInitializeParam(sOperateType, '0', fnCard, sFactArtID,sGFNO);
  CheckArtForm.SetIsCache(1);
  if CheckArtForm.ShowModal = mrOK then
    with cdsMachineDownCache do
    begin
      Edit;
      FieldByName('Status').AsInteger := 1;
      Post;

      sSQL := Format(' UPDATE fnMachineDownCache SET Status = 1 WHERE  FN_Card = %s AND Machine_ID = %s AND Current_Department = %s ',
                                      [
                                      QuotedStr(fnCard),
                                      QuotedStr(FieldByName('Machine_ID').AsString),
                                      QuotedStr(FieldByName('Current_Department').AsString)
                                      ]);
      doSaveCache(sSQL, false);
    end;
end;

procedure TMachineTerminalForm.edtCarNOKeyPress(Sender: TObject;
  var Key: Char);
begin
  if(Key=#13) then
  begin
    doSetCarNO;
  end;
end;

procedure TMachineTerminalForm.edtRoll2KeyPress(Sender: TObject;
  var Key: Char);
begin
  if(Key=#13) then
  begin
    doSetRollNO;
  end;
end;

procedure TMachineTerminalForm.doSetCarNO;
begin
  doSetValue('Car_NO',Trim(edtCarNO.Text));
end;

procedure TMachineTerminalForm.doSetRollNO;
begin
  doSetValue('Roll_NO',Trim(edtRoll2.Text));
end;


procedure TMachineTerminalForm.doSetValue(AFieldName, AValue: String);
var
  i: Integer;
  fnCard: String;
  fnCardList, StepNOList: String;
  sType,sSQL,sErrMsg: WideString;
begin
  if (cdsMachineDownCache.Active = false) or (cdsMachineDownCache.RecordCount = 0) then exit;
  if cxgvCache.Controller.SelectedRowCount = 0 then
  begin
    TMsgDialog.ShowMsgDialog('请选择卡号', mtInformation);
    exit;
  end;
  sSQL := '';
  
  for i := 0 to cxgvCache.Controller.SelectedRowCount -1 do
  begin
    fnCard :=  cxgvCache.Controller.SelectedRows[i].Values[cxgvCache.GetColumnByFieldName('FN_Card').index];

    with cdsMachineDownCache do
      if cdsMachineDownCache.Locate('FN_Card', VarArrayOf([fnCard]), []) = true then
      begin
        Edit;
        FieldByName(AFieldName).AsString := Trim(AValue);
        Post;
        fnCardList := fnCardList + fnCard + '+';
        StepNOList := StepNOList + FieldByName('Step_NO').AsString + '+';
        sSQL := sSQL + Format('  UPDATE fnMachineDownCache SET %s = %s WHERE  FN_Card = %s AND Machine_ID = %s AND Current_Department = %s ',
                                      [AFieldName,
                                      QuotedStr(AValue),
                                      QuotedStr(fnCard),
                                      QuotedStr(FieldByName('Machine_ID').AsString),
                                      QuotedStr(FieldByName('Current_Department').AsString)
                                      ]);
      end;
  end;

  if doSaveCache(sSQL, false) = False then
  begin
    exit;
  end;


  //更新卡号进度跟踪主表
  if AFieldName = 'Car_NO' then
    sType := '0'
  else if AFieldName = 'Roll_NO' then
    sType := '1';


  sSQL := sType+','
          +QuotedStr(fnCardList) +','
          +QuotedStr(StepNOList) + ','
          +QuotedStr(AValue) + ','
          +QuotedStr(AValue);
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在保存数据稍等...', crHourGlass);
    FNMServerObj.SaveDataBySQL('SetCarNOAndRollNO',sSQL,sErrMsg);
    if sErrMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg,mtError);

      Exit;
    end;

    TMsgDialog.ShowMsgDialog('保存数据成功',mtInformation);
    
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;

end;

procedure TMachineTerminalForm.btnSetArtClick(Sender: TObject);
begin
  doSetArt;
end;

procedure TMachineTerminalForm.vleArtParamDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  i,n:Integer;
  Item_Name,Item_Value:String;
begin
  inherited;
  if (cdsStdArt.Active = False) or (cdsStdArt.RecordCount = 0) then  Exit;

  with Sender as TCustomDrawGrid do
  begin
    if vleArtParam.RowCount>2 then
    begin
      for i := 1 to vleArtParam.RowCount-1 do
      begin
        Item_Name := vleArtParam.Cells[0, i];
        Item_Value := vleArtParam.Cells[1, i];
        n := Pos(' ',Item_Name);
        if  n> 0 then
        begin
          Item_Name := LeftStr(Item_Name,n-1);
        end;
        if cdsStdArt.Locate('Item_Name',Item_Name,[loPartialKey]) = True then
        begin
          if Item_Value <> cdsStdArt.FieldByName('Item_Value').AsString then
          begin
            Rect:= CellRect(1,i);
            Canvas.Font.Color := clRed;
            Canvas.Font.Style := [fsbold];
            Canvas.TextRect(Rect, Rect.Left+2, Rect.Top+2, Item_Value);
          end;
        end;

      end;
    end;
  end;
end;

procedure TMachineTerminalForm.doOpenStdArtData(AGF_ID,Operation_Code,Current_Department: String);
var
  sSQL, sErrMsg: WideString;
  vData:OleVariant;
begin

  sSQL := ' SELECT a.[Item_Name],a.[Item_Value] '+
          ' FROM dbo.fnStdArtDtl a WITH(NOLOCK) '+
          ' INNER JOIN dbo.uvw_fnStdArtHdr b WITH(NOLOCK) ON a.STD_Art_ID = b.Art_ID '+
          ' WHERE b.GF_ID = '+ AGF_ID + ' and b.Current_Department = '+QuotedStr(Current_Department) +
          ' AND a.Operation_Code = '+QuotedStr(Operation_Code);
  FNMServerObj.GetQueryBySQL(vData, sSQL,sErrMsg);
  if sErrMsg <> '' then
    Raise Exception.Create(sErrMsg);
  cdsStdArt.Data := vData;
  
end;

procedure TMachineTerminalForm.doSetCarNOEnable;
var
  b: Boolean;
begin
  b := (not btnUp.Enabled) and (LeftStr(Cur_Machine_ID, 2) <> 'CP');
  edtWidth.Enabled := b;
  edtCar_NO.Enabled := b;
  edtWidth.Color := IfThen(edtWidth.Enabled, clWindow, clMenu);
  edtCar_NO.Color := IfThen(edtCar_NO.Enabled, clWindow, clMenu);
end;

procedure TMachineTerminalForm.BtnEditCarNoClick(Sender: TObject);
begin
  if not Assigned(frmEditCarNoByFNCard.EditCarNoByFNCardForm) then
    frmEditCarNoByFNCard.EditCarNoByFNCardForm:= TEditCarNoByFNCardForm.Create(Self);
  try
    if EditCarNoByFNCardForm.FormStyle = fsMDIChild then
    begin
      EditCarNoByFNCardForm.FormStyle := fsNormal;
      EditCarNoByFNCardForm.Visible := False;
      EditCarNoByFNCardForm.WindowState := wsMaximized;
    end;//if

    EditCarNoByFNCardForm.ShowModal;

    btnRefresh.Click;
    btnVat.Click;
  finally
    if Assigned(EditCarNoByFNCardForm) then
      FreeAndNil(EditCarNoByFNCardForm);
  end;//finally
end;

procedure TMachineTerminalForm.initCarLocationInfo;
var
  sErrorMsg:WideString;
  vdata: OleVariant;
  condition:string;
begin
  condition := 'A';
  FNMServerObj.GetQueryData(vData, 'GetCarLocationUsedInfo', condition, sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  dsArea.Data := vdata;
  if dsArea.IsEmpty then Exit;
  while not dsArea.eof do
  begin
    cbbArea.Properties.Items.Add(dsArea.fieldByName('标准车位').AsString);
    dsArea.Next;
  end;
end;

//下面增加自动导入预缩终端的数据

procedure TMachineTerminalForm.tmrCompactingSkewingTimer(Sender: TObject);
begin
  if (DirectoryExists('D:\Mahlo\')) then
    UploadCompactingSkewing('D:\Mahlo\')
  else  if (DirectoryExists('E:\Mahlo\')) then
    UploadCompactingSkewing('E:\Mahlo\');
end;

function TMachineTerminalForm.IsFileInUse(fName: string): boolean;
var
  HFileRes: HFILE;
begin
  Result := false;
  if not FileExists(fName) then
  //如果文件不存在 判断文件是否存在
    exit;
  HFileRes := CreateFile(pchar(fName), GENERIC_READ or GENERIC_WRITE,0 {this is the trick!}, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  Result := (HFileRes = INVALID_HANDLE_VALUE);
  if not Result then
     CloseHandle(HFileRes);
end;

procedure TMachineTerminalForm.UploadCompactingSkewing(Patch:string);
var
  sr: TSearchRec;     //定义 TSearchRec 结构变量
  Attr: Integer;      //文件属性
  s: string;          //要搜索的内容
  FileName:string;
begin

  s:=patch+'*.csv';
  Attr := faAnyFile;
  //查找文件名
  if FindFirst(s,Attr,sr)=0 then  //开始搜索,并给 sr 赋予信息, 返回0表示找到第一个
  begin
    repeat                        //如果有第一个就继续找
      FileName:=Patch+sr.Name;          //用List记下结果
      if IsFileInUse(FileName)=false THEN
      begin
        getcsv(FileName);
        DeleteFile(pchar(FileName));
        //MoveFile(pchar(FileName),pchar(Patch+'back\'+sr.Name));
      end
      else
      begin
        //ShowMessage(filename+'被占用');
        EXIT;
      end;
    until(FindNext(sr)<>0) ;       //因为sr已经有了搜索信息, FindNext只要这一个参数, 返回0表示找到
  end;
  FindClose(sr);                  //需要结束搜索, 搜索是内含句柄的

end;

procedure TMachineTerminalForm.getcsv(FileName:string);

var
   CsvData: TStringList;
   RowStrs:TStrings;
   RowCount,ColCount,BlankLine,iCount,i: Integer;
   RowValue,HeadLine,Head,ErrorFile,s:string;
   Date_Value,Time_Value,Machine_ID,Machine_ID1,Machine_ID2,Machine_ID3,Machine_ID4,Machine_ID5:string;
   //RowCount行数;ColCount 列数;RowValue 每行值,
   sSQL, sErrorMsg: WideString;
   vData:OleVariant;
   Date_Value_List,Time_Value_List,Machine_ID_List,Speed_List,Quantity_List,Skewing_Setting_List,Bowing_Setting_List,Skewing_List,
   Bowing_List,In_Weft_Density_List,Skewing_Warn_List,Bowing_Warn_List,Out_Density_List,Out_Shrinkage_List: string;

begin
   CsvData:= TStringList.Create;
   BlankLine:=0;//空白行
   Machine_ID:='';
   Machine_ID1:='';
   Machine_ID2:='';
   Machine_ID3:='';
   Machine_ID4:='';
   Machine_ID5:='';
   i:=1 ;
   s:=copy(FileName,18,9);
   Date_Value_List:='';
   Time_Value_List:='';
   Machine_ID_List:='';
   Speed_List:='';
   Quantity_List:='';
   Skewing_Setting_List:='';
   Bowing_Setting_List:='';
   Skewing_List:='';
   Bowing_List:='';
   In_Weft_Density_List:='';
   Skewing_Warn_List:='';
   Bowing_Warn_List:='';
   Out_Density_List:='';
   Out_Shrinkage_List:='';
   try
     TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取中控纬斜数据！', crHourGlass);
     CsvData.LoadFromFile(FileName);
     for RowCount := 0 to CsvData.Count -1 do
     begin
       RowStrs:=TStringList.Create;
       RowValue:=CsvData[RowCount];
      // if Trim(RowValue)='' then
      //   BlankLine:=BlankLine+1;
       //替换掉数据中的空格和NA值     因为有些部份是ＮＡ因此要改为-９９表示无效
       RowValue:=StringReplace(RowValue,'< n/a >','-99',[rfReplaceAll, rfIgnoreCase]);
       RowValue:=StringReplace(RowValue,' ','',[rfReplaceAll, rfIgnoreCase]);
       RowStrs.Delimiter:=';' ;
       RowStrs.DelimitedText:=RowValue;
       if (Trim(RowValue)<>'') and (Machine_ID1='') then  //找机台,核对标题是否正确
       begin
         if Machine_ID1='' then
            Machine_ID1:=StringReplace(RowStrs[2],'车速','',[rfReplaceAll, rfIgnoreCase]);
         if RowStrs.Count>14 then
            Machine_ID2:=StringReplace(RowStrs[13],'车速','',[rfReplaceAll, rfIgnoreCase]);
         if RowStrs.Count>25 then
            Machine_ID3:=StringReplace(RowStrs[24],'车速','',[rfReplaceAll, rfIgnoreCase]);
         if RowStrs.Count>36 then
            Machine_ID4:=StringReplace(RowStrs[35],'车速','',[rfReplaceAll, rfIgnoreCase]);
         if RowStrs.Count>47 then
            Machine_ID5:=StringReplace(RowStrs[46],'车速','',[rfReplaceAll, rfIgnoreCase]);
          //根据机型数将机标题串起来,检查第一行有字符的标题是否正确.
          Head:='车速'+Machine_ID1+';长度'+Machine_ID1+';纬斜预设'+Machine_ID1+';纬弧预设'+Machine_ID1+';残余纬斜'+Machine_ID1
                     +';残余纬弧'+Machine_ID1+';进布纬密'+Machine_ID1+';纬斜报警'+Machine_ID1+';纬弧报警'+Machine_ID1+';出布纬密'+Machine_ID1+';缩率'+Machine_ID1+';';
          HeadLine:='CurrentDate;CurrentTime;'+Head;
          if Machine_ID2<>'' then
            HeadLine:=HeadLine+StringReplace(Head,Machine_ID1,Machine_ID2,[rfReplaceAll, rfIgnoreCase]);
          if Machine_ID3<>'' then
            HeadLine:=HeadLine+StringReplace(Head,Machine_ID1,Machine_ID3,[rfReplaceAll, rfIgnoreCase]);
          if Machine_ID4<>'' then
            HeadLine:=HeadLine+StringReplace(Head,Machine_ID1,Machine_ID4,[rfReplaceAll, rfIgnoreCase]);
          if Machine_ID5<>'' then
            HeadLine:=HeadLine+StringReplace(Head,Machine_ID1,Machine_ID5,[rfReplaceAll, rfIgnoreCase]);
          if RowValue<>HeadLine then
          begin
            ShowMessage('格式不对');
            Exit;
          end;
       end
       else  if (Trim(RowValue)<>'') then  //写入值勤
       begin
         Date_Value:=RowStrs[0] ;
         Time_Value:=RowStrs[1] ;
         iCount:=0 ;
         while iCount*11+3<RowStrs.Count do
         begin
          if iCount*11+2<13 then
            Machine_ID:=Machine_ID1
          else if iCount*11+2<24 then
            Machine_ID:=Machine_ID2
          else if iCount*11+2<35 then
            Machine_ID:=Machine_ID3
          else if iCount*11+2<46 then
            Machine_ID:=Machine_ID4
          else
            Machine_ID:=Machine_ID5;

           if (Trim(RowStrs[iCount*11+2])<>'-99') AND (Trim(RowStrs[iCount*11+2])<>'') and (Trim(RowStrs[iCount*11+2])<>null)  Then
           begin
             Date_Value_List            :=Date_Value_List+Date_Value+',';
             Time_Value_List            :=Time_Value_List+Time_Value+',';
             Machine_ID_List            :=Machine_ID_List+Machine_ID+',';
             Speed_List                 :=Speed_List+RowStrs[iCount*11+2]+',';
             Quantity_List              :=Quantity_List+RowStrs[iCount*11+3]+',';
             Skewing_Setting_List       :=Skewing_Setting_List+RowStrs[iCount*11+4]+',';
             Bowing_Setting_List        :=Bowing_Setting_List+RowStrs[iCount*11+5]+',';
             Skewing_List               :=Skewing_List+RowStrs[iCount*11+6]+',';
             Bowing_List                :=Bowing_List+RowStrs[iCount*11+7]+',';
             In_Weft_Density_List       :=In_Weft_Density_List+RowStrs[iCount*11+8]+',';
             Skewing_Warn_List          :=Skewing_Warn_List+RowStrs[iCount*11+9]+',';
             Bowing_Warn_List           :=Bowing_Warn_List+RowStrs[iCount*11+10]+',';
             Out_Density_List           :=Out_Density_List+RowStrs[iCount*11+11]+',';
             Out_Shrinkage_List         :=Out_Shrinkage_List+RowStrs[iCount*11+12]+',';
           end;
           iCount:=iCount+1;
         end;

       end;

     end;
     sSQL:= 'EXEC Usp_FNCompactingSkewingInfo ' +QuotedStr(sCurrent_Department)+','+QuotedStr(Date_Value_List)+','+QuotedStr(Time_Value_List)
               +','+QuotedStr(Machine_ID_List)+','+QuotedStr(Speed_List)+','+QuotedStr(Quantity_List)+','+QuotedStr(Skewing_Setting_List)
               +','+QuotedStr(Bowing_Setting_List)+','+QuotedStr(Skewing_List)+','+QuotedStr(Bowing_List)+','+QuotedStr(In_Weft_Density_List)
               +','+QuotedStr(Skewing_Warn_List)+','+QuotedStr(Bowing_Warn_List)+','+QuotedStr(Out_Density_List)+','+QuotedStr(Out_Shrinkage_List) ;
    FNMServerObj.GetQueryBySQL(vData, sSQL, sErrorMsg);
    if sErrorMsg<>'' then
    begin
       ErrorFile:=StringReplace(FileName,'Mahlo\','Mahlo\Error\',[rfReplaceAll, rfIgnoreCase])   ;
       MoveFile(pchar(FileName),pchar(ErrorFile));
       TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    end;

   finally
     CsvData.Free;
     TStatusBarMessage.ShowMessageOnMainStatsusBar('', crDefault);
   end;

end;

end.


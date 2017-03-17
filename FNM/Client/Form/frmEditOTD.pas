unit frmEditOTD;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmEditOTD.pas                                                }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 zhangjy                                                       }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  OTD编辑                                                      }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Buttons,  StdCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridCustomPopupMenu, cxGridPopupMenu,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxSplitter, ComCtrls, DBClient, Provider, Menus, ExtCtrls, frmBase,
  cxSpinEdit, cxDropDownEdit, StrUtils, ADODB;

type
  TEditOTDForm = class(TBaseForm)
    dsOTD: TDataSource;
    cxgpmOTD: TcxGridPopupMenu;
    cdsOTD: TClientDataSet;
    cxspl2: TcxSplitter;
    pnlValue: TPanel;
    btnAdd: TBitBtn;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    pmOTD: TPopupMenu;
    N1: TMenuItem;
    b1: TMenuItem;
    N3: TMenuItem;
    dsDelayOTD: TDataSource;
    cdsDelayOTD: TClientDataSet;
    btnUpdateOTD: TBitBtn;
    cdsUrgentPpoInfo: TClientDataSet;
    dsUrgentPpoInfo: TDataSource;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    pgcOTD: TPageControl;
    tbsOTD: TTabSheet;
    cxgridOTD: TcxGrid;
    cxgridtvOTD: TcxGridDBTableView;
    cxgdbcOTDJob_NO1: TcxGridDBColumn;
    cxgdbcOTDGF_NO1: TcxGridDBColumn;
    cxgdbcOTDOTD_Days1: TcxGridDBColumn;
    cxgdbcOTDLast_Received_Date1: TcxGridDBColumn;
    cxgdbcOTDQuality_Type1: TcxGridDBColumn;
    cxgdbcOTDRemark1: TcxGridDBColumn;
    cxgdbcOTDUpdater1: TcxGridDBColumn;
    cxgdbcOTDUpdate_Time1: TcxGridDBColumn;
    cxgridtvOTDIs_Active1: TcxGridDBColumn;
    cxgdbcOTDGF_ID1: TcxGridDBColumn;
    cxGridlOTD: TcxGridLevel;
    pnlTop: TPanel;
    lbl1: TLabel;
    btnQuery: TBitBtn;
    dtpQueryDate: TDateTimePicker;
    dtpQueryEndDate: TDateTimePicker;
    chkCPBEndTime: TCheckBox;
    tbsDelayOTD: TTabSheet;
    Panel1: TPanel;
    lbl3: TLabel;
    lbl4: TLabel;
    BitQueryDelayOTD: TBitBtn;
    dtpBegin_Date: TDateTimePicker;
    dtpEnd_Date: TDateTimePicker;
    chkStatus: TCheckBox;
    chkCPB: TCheckBox;
    cxGridDelayOTD: TcxGrid;
    cxGridDBtvDelayOTD: TcxGridDBTableView;
    cxGridDBtvDelayOTDJob_NO: TcxGridDBColumn;
    cxGridDBtvDelayOTDGF_NO: TcxGridDBColumn;
    cxGridDBtvDelayOTDPpo_Type: TcxGridDBColumn;
    cxGridDBtvDelayOTDWhite_Type: TcxGridDBColumn;
    cxGridDBtvDelayOTDUrgent_Type1: TcxGridDBColumn;
    cxGridDBtvDelayOTDBU_Delivery_Date: TcxGridDBColumn;
    cxGridDBtvDelayOTDLast_Received_Date: TcxGridDBColumn;
    cxGridDBtvDelayOTDPlan_Finished_Date: TcxGridDBColumn;
    cxGridDBtvDelayOTDFact_Finished_Date: TcxGridDBColumn;
    cxGridDBtvDelayOTDQuality_Type: TcxGridDBColumn;
    cxGridDBtvDelayOTDSecond_Reason: TcxGridDBColumn;
    cxGridDBtvDelayOTDThird_Reason: TcxGridDBColumn;
    cxGridDBtvDelayOTDFour_Reason: TcxGridDBColumn;
    cxGridDBtvDelayOTDRemark: TcxGridDBColumn;
    cxGridDBtvDelayOTDIs_Active1: TcxGridDBColumn;
    cxGridDBtvDelayOTDGF_ID: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    tbsUrgentPpoInfo1: TTabSheet;
    Panel2: TPanel;
    Label1: TLabel;
    edtGFNO: TEdit;
    btnQueryUrgent: TBitBtn;
    cxGrid1: TcxGrid;
    cxGridTVUrgentPpoInfo: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    tbsOTDInfo: TTabSheet;
    cxGrid2: TcxGrid;
    cxGridtvOTDInfo: TcxGridDBTableView;
    cxGridLevel3: TcxGridLevel;
    Panel3: TPanel;
    Button1: TButton;
    btnOpenOTD: TBitBtn;
    procedure FormDestroy(Sender: TObject);
    procedure cdsOTDOTD_DaysChange(Sender: TField);
    procedure btnAddClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure cxgdbcOTDOTD_Days1PropertiesChange(Sender: TObject);
    procedure cxgridtvOTDCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridDBtvDelayOTDCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure pgcOTDChange(Sender: TObject);
    procedure btnUpdateOTDClick(Sender: TObject);
    procedure cxGridTVUrgentPpoInfoCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure chkCPBEndTimeClick(Sender: TObject);
    procedure chkCPBClick(Sender: TObject);
    procedure btnOpenOTDClick(Sender: TObject);
  private
    { Private declarations }
    sFNSpecialStatus: string;
    DumbList: TStringList;
    procedure SetOtherReason(Sender: TField; const Text: String);
    procedure Initialize();
    procedure GetOTDInfo();
    procedure GetUrgentPpoInfo();
    procedure GetData(Index: Integer);
    procedure SaveOTDInfo();
    procedure SaveUrgentPpoInfo();
    procedure SaveData(Index: Integer);
  public
    { Public declarations }
  end;

var
  EditOTDForm: TEditOTDForm;

implementation

uses ServerDllPub, UShowMessage, uAppOption,uLogin,uGlobal,uDictionary, uGridDecorator,
  frmSdOtdInfo;

{$R *.dfm}
procedure TEditOTDForm.Initialize();
begin
  sFNSpecialStatus := '';
  Screen.Cursor := crHourGlass;
  dtpQueryDate.Date := Date();
  dtpQueryEndDate.Date := Date();
  dtpBegin_Date.Date := Date()-1;
  dtpEnd_Date.Date := Date();
  DumbList := TStringList.Create;
  with Dictionary.cds_OTDReasonList do
  begin
    Filtered := False;
    First;
    while not Eof do
    begin
      if DumbList.IndexOf(FieldByName('First_Reason').AsString) = -1 then
         DumbList.Add(FieldByName('First_Reason').AsString);
       Next
     end;
  end;
  TcxComboBoxProperties(cxgdbcOTDQuality_Type1.Properties).Items.Text := DumbList.Text;
  TcxComboBoxProperties(cxGridDBtvDelayOTDQuality_Type.Properties).Items.Text := TcxComboBoxProperties(cxgdbcOTDQuality_Type1.Properties).Items.Text;
  pgcOTD.ActivePageIndex := 1;
  Screen.Cursor := crDefault;
  Self.WindowState := wsMaximized;
end;

procedure TEditOTDForm.GetOTDInfo();
var vData: OleVariant;
    sBegin_Date,sEnd_Date,sQuery_Type: string;
    sCondition,sErrorMsg: WideString;
begin
  try
    ShowMsg('正在获取数据稍等！',crHourGlass);
    if pgcOTD.ActivePageIndex = 0  then
    begin
      sBegin_Date := DateToStr(dtpQueryDate.Date);
      if not chkCPBEndTime.Checked then
        sCondition := 'Last_Received_Date = '+ QuotedStr(sBegin_Date)
      else
        sCondition := 'GF_NO like ''PD%'' and Last_Received_Date between '
          + QuotedStr(sBegin_Date)+ ' and '+ QuotedStr(DateToStr(dtpQueryEndDate.Date));
      sCondition := sCondition+' AND Current_Department = '+ QuotedStr(Login.CurrentDepartment);
      FNMServerObj.GetQueryData(vData,'GetEditOTD',sCondition,sErrorMsg);
      if sErrorMsg<>'' then
      begin
        TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
        Exit;
      end;
      cdsOTD.Data := vData;
      if cdsOTD.RecordCount = 0 then
      begin
        TMsgDialog.ShowMsgDialog('没有相应的数据,请重新查询',1);
        Exit;
      end;
      cdsOTD.FieldByName('OTD_Days').OnChange:=cdsOTDOTD_DaysChange;
      cxgridtvOTD.ApplyBestFit(nil);
    end else
    begin
      sBegin_Date := DateToStr(dtpBegin_Date.Date);
      sEnd_Date := DateToStr(dtpEnd_Date.Date);
      sQuery_Type := Ifthen(chkStatus.Checked,'1','0');
      sCondition := QuotedStr(sBegin_Date)+','+ QuotedStr(sEnd_Date)+','+QuotedStr(Login.CurrentDepartment)+','+ QuotedStr(sQuery_Type)+',1';
      FNMServerObj.GetQueryData(vData,'GetDelayOTD',sCondition,sErrorMsg);
      if sErrorMsg<>'' then
      begin
        TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
        Exit;
      end;
      cdsDelayOTD.Data := vData;
      if cdsDelayOTD.RecordCount = 0 then
      begin
        TMsgDialog.ShowMsgDialog('没有相应的数据,请重新查询',1);
        Exit;
      end;
      if chkCPB.Checked then
      begin
        cdsDelayOTD.Filtered := False;
        cdsDelayOTD.Filter := 'GF_NO like ''PD%''';
        cdsDelayOTD.Filtered := True;
      end;

      cdsDelayOTD.FieldByName('Quality_Type').OnSetText := SetOtherReason;
      cxGridDBtvDelayOTD.ApplyBestFit(nil);
    end;
  finally
    ShowMsg('',crDefault);
  end;
end;

procedure TEditOTDForm.GetData(Index: Integer);
begin
  if (Index = 0) or (Index = 1) then
    GetOTDInfo()
  else
    GetUrgentPpoInfo();
end;

procedure TEditOTDForm.SaveOTDInfo();
var
  vData: OleVariant;
  sErrorMsg: WideString;
  i,iType,iIs_Active :Integer;
begin
  try
    ShowMsg('正在保存数据稍等！', crHourGlass);
    iType := pgcOTD.ActivePageIndex ;
    if iType =0  then
    begin
      if  cdsOTD.State in [dsInsert,dsEdit] then cdsOTD.Post;
      if TGlobal.DeltaIsNull(cdsOTD) then Exit;
      vData := cdsOTD.Delta;
    end else
    begin
      if TGlobal.DeltaIsNull(cdsDelayOTD) then Exit;
      TempClientDataSet.Data := cdsDelayOTD.Delta;
      vData := VarArrayCreate([0, cdsDelayOTD.ChangeCount - 1], VarVariant);
      i := 0;
      while not TempClientDataSet.Eof do
      begin
        if cdsDelayOTD.Locate('GF_ID;Job_NO',VarArrayOf([TempClientDataSet.Fieldbyname('GF_ID').AsInteger,                                                         TempClientDataSet.Fieldbyname('Job_NO').AsString]),[]) then
        begin
          if cdsDelayOTD.FieldByName('Is_Active').AsBoolean then
             iIs_Active := 1
          else
             iIs_Active := 0;
          vData[i] := varArrayOf([cdsDelayOTD.FieldByName('Quality_Type').AsString,
                                  cdsDelayOTD.FieldByName('Second_Reason').AsString,
                                  cdsDelayOTD.FieldByName('Third_Reason').AsString,
                                  cdsDelayOTD.FieldByName('Four_Reason').AsString,
                                  cdsDelayOTD.FieldByName('Remark').AsString,
                                  Login.LoginName,
                                  iIs_Active,
                                  cdsDelayOTD.FieldByName('GF_ID').AsInteger,
                                  cdsDelayOTD.FieldByName('Job_NO').AsString,
                                  Login.CurrentDepartment]);
        end;
        TempClientDataSet.Next;
        TempClientDataSet.Next;
        Inc(i);
      end;
    end;
    FNMServerObj.SaveOTDInfo(vData,iType, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
      btnSave.Enabled := cdsDelayOTD.ChangeCount<>0;
    if iType = 0 then
      cdsOTD.MergeChangeLog
    else
      cdsDelayOTD.MergeChangeLog;
    btnSave.Enabled := False;
    TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TEditOTDForm.SaveData(Index: Integer);
begin
  if (Index = 0) or (Index = 1) then
    SaveOTDInfo()
  else
    SaveUrgentPpoInfo();
end;

procedure TEditOTDForm.FormDestroy(Sender: TObject);
begin
  inherited;
  DumbList.Free;
  EditOTDForm := nil;
end;

procedure TEditOTDForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TEditOTDForm.btnAddClick(Sender: TObject);
begin
  with cdsOTD do
  begin
    if (not Active) or IsEmpty then Exit;
    Append;
    cdsOTD.FieldValues['Current_Department'] := Login.CurrentDepartment;
    cdsOTD.FieldValues['Is_Active'] := True;
  end;
end;

procedure TEditOTDForm.cdsOTDOTD_DaysChange(Sender: TField);
begin
  with cdsOTD do
  begin
    Edit;
    FieldValues['Updater'] := Login.LoginName;
    FieldValues['Update_Time'] := Now();
    Post;
  end;  
end;

procedure TEditOTDForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;
procedure TEditOTDForm.btnSaveClick(Sender: TObject);
begin
  SaveData(pgcOTD.ActivePageIndex);
end;

procedure TEditOTDForm.btnQueryClick(Sender: TObject);
begin
  if sFNSpecialStatus = '' then
    sFNSpecialStatus :=  Dictionary.GetItemList('后整状态','','');
  GetData(pgcOTD.ActivePageIndex);
end;

procedure TEditOTDForm.cxgdbcOTDOTD_Days1PropertiesChange(Sender: TObject);
begin
  inherited;
  btnSave.Enabled := True;
end;

procedure TEditOTDForm.cxgridtvOTDCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  btnSave.Enabled := cdsOTD.ChangeCount<>0;
end;

procedure TEditOTDForm.cxGridDBtvDelayOTDCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  btnSave.Enabled := cdsDelayOTD.ChangeCount<>0;
end;

procedure TEditOTDForm.pgcOTDChange(Sender: TObject);
begin
  inherited;
  btnAdd.Visible := pgcOTD.ActivePageIndex = 0;
end;

procedure TEditOTDForm.btnUpdateOTDClick(Sender: TObject);
var
  sErrorMsg: WideString;
begin
  inherited;
  try
    ShowMsg('正在更新OTD数据稍等！', crHourGlass);
    FNMServerObj.CreateOTDInfo(0,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TEditOTDForm.GetUrgentPpoInfo;
var vData: OleVariant;
    sGF_NO: string;
    sCondition,sErrorMsg: WideString;
begin
  try
    ShowMsg('正在获取数据稍等！',crHourGlass);
    sGF_NO := Trim(edtGFNO.Text);
    if sGF_NO = '' then Exit;
    sCondition := QuotedStr(sGF_NO);
    FNMServerObj.GetQueryData(vData,'GetUrgentPpoInfo',sCondition,sErrorMsg);
//    FNMServerObj.GetUrgentPpoInfo(vData,sGF_NO,sErrorMsg);
    cdsUrgentPpoInfo.Data := vData;
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    GridDecorator.BindCxViewWithDataSource(cxGridTVUrgentPpoInfo,dsUrgentPpoInfo);
    cxGridTVUrgentPpoInfo.GetColumnByFieldName('FN_Special_Status').PropertiesClass := TcxComboBoxProperties;
    TcxComboBoxProperties(cxGridTVUrgentPpoInfo.GetColumnByFieldName('FN_Special_Status').Properties).Items.Text:=sFNSpecialStatus;
    cxGridTVUrgentPpoInfo.GetColumnByFieldName('FN_Special_Status').Styles.Content := cxStyle1;;
  finally
    ShowMsg('',crDefault);
  end;
end;

procedure TEditOTDForm.SaveUrgentPpoInfo;
var
  vData: OleVariant;
  sErrorMsg: WideString;
  i :Integer;
begin
  try
    ShowMsg('正在保存数据稍等！', crHourGlass);
    begin
      if TGlobal.DeltaIsNull(cdsUrgentPpoInfo) then Exit;
      TempClientDataSet.Data := cdsUrgentPpoInfo.Delta;
      vData := VarArrayCreate([0, cdsUrgentPpoInfo.ChangeCount - 1], VarVariant);
      i := 0;
      while not TempClientDataSet.Eof do
      begin
        if cdsUrgentPpoInfo.Locate('GF_ID;Job_NO',VarArrayOf([TempClientDataSet.Fieldbyname('GF_ID').AsInteger, TempClientDataSet.Fieldbyname('Job_NO').AsString]),[]) then
        begin
          vData[i] := varArrayOf([cdsUrgentPpoInfo.FieldByName('FN_Special_Status').AsString,
                                  cdsUrgentPpoInfo.FieldByName('Job_NO').AsString,
                                  cdsUrgentPpoInfo.FieldByName('GF_ID').AsInteger]);
        end;
        TempClientDataSet.Next;
        TempClientDataSet.Next;
        Inc(i);
      end;
    end;
    FNMServerObj.SaveUrgentPpoInfo(vData,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsUrgentPpoInfo.MergeChangeLog;
    btnSave.Enabled := False;
    TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TEditOTDForm.cxGridTVUrgentPpoInfoCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  btnSave.Enabled := True;
end;

procedure TEditOTDForm.FormActivate(Sender: TObject);
begin
  inherited;
  OnActivate:=nil;
  Application.ProcessMessages;
  Initialize;
end;

procedure TEditOTDForm.SetOtherReason(Sender: TField; const Text: String);
begin
  with Sender.DataSet do
  if Text <> '' then
  begin
    if Sender.Value = Text then Exit;
    Sender.Value := Text;
    with Dictionary.cds_OTDReasonList do
    begin
      Filter := 'First_Reason = ' + QuotedStr(Text);
      Filtered := True;
      First;
      DumbList.Clear;
      DumbList.Add('');
      while not Eof do
      begin
        if DumbList.IndexOf(FieldByName('Second_Reason').AsString) = -1 then
           DumbList.Add(FieldByName('Second_Reason').AsString);
         Next;
      end;
      TcxComboBoxProperties(cxGridDBtvDelayOTDSecond_Reason.Properties).Items.Text := DumbList.Text;
      First;
      DumbList.Clear;
      DumbList.Add('');
      while not Eof do
      begin
        if DumbList.IndexOf(FieldByName('Third_Reason').AsString) = -1 then
           DumbList.Add(FieldByName('Third_Reason').AsString);
         Next;
      end;
      TcxComboBoxProperties(cxGridDBtvDelayOTDThird_Reason.Properties).Items.Text := DumbList.Text;;
      First;
      DumbList.Clear;
      DumbList.Add('');
      while not Eof do
      begin
        if DumbList.IndexOf(FieldByName('Four_Reason').AsString) = -1 then
           DumbList.Add(FieldByName('Four_Reason').AsString);
         Next;
      end;
      TcxComboBoxProperties(cxGridDBtvDelayOTDFour_Reason.Properties).Items.Text := DumbList.Text;
    end;
  end else
  begin
    Sender.Value := '';
    cdsDelayOTD.FieldByName('Second_Reason').Asstring := '';
    cdsDelayOTD.FieldByName('Third_Reason').Asstring := '';
    cdsDelayOTD.FieldByName('Four_Reason').Asstring := '';
   end;
end;



procedure TEditOTDForm.chkCPBEndTimeClick(Sender: TObject);
begin
  inherited;
  dtpQueryEndDate.Visible := chkCPBEndTime.Checked;
end;

procedure TEditOTDForm.chkCPBClick(Sender: TObject);
begin
  inherited;
  cdsDelayOTD.Filtered := chkCPB.Checked;
end;

procedure TEditOTDForm.btnOpenOTDClick(Sender: TObject);
begin
  inherited;
  if not Assigned(SdOtdInfo) then
    SdOtdInfo:= TSdOtdInfo.Create(Self);
  SdOtdInfo.Show;

end;

end.


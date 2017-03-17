unit frmSdOtdInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  DBClient, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  uShowMessage, cxDropDownEdit, cxCalendar, MakeSQL, uGlobal,cxTimeEdit,
  cxGridBandedTableView, cxGridDBBandedTableView, Mask, DBCtrls ;
  // QuickRpt, QRCtrls,  uGlobal, uShowMessage, Menus, uTestThread, MakeSQL;

 
type
  TSdOtdInfo = class(TForm)
    pgcSdOtdInfo: TPageControl;
    SdOtdInput: TTabSheet;
    SdOtdEdit: TTabSheet;
    pnl1: TPanel;
    cbbCurrentDepartment: TComboBox;
    btnInput: TSpeedButton;
    btnDelete: TSpeedButton;
    btnSave: TSpeedButton;
    dtpOperateTimBegin: TDateTimePicker;
    dtpOperateTimEnd: TDateTimePicker;
    grp1: TGroupBox;
    Machineid1: TLabel;
    Machineid2: TLabel;
    Machineid3: TLabel;
    cdsSdOtdInput: TClientDataSet;
    dsSdOtdInput: TDataSource;
    btnQuery: TSpeedButton;
    mksql1: TMakeSQL;
    cdsSdOtdInputTemp: TClientDataSet;
    pnl2: TPanel;
    edtInputCause: TEdit;
    btnEdit: TSpeedButton;
    Machineid4: TLabel;
    btnClose: TSpeedButton;
    cxgridGrid1DBTableView1: TcxGridDBTableView;
    cxgrdlvlGrid1Level1: TcxGridLevel;
    cxgrd1: TcxGrid;
    cxgridSdOtdInput: TcxGridDBBandedTableView;
    dbedtOldInputCause: TDBEdit;
    cxgrdbndclmnSdOtdInputDBBandedColumn1: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputDBBandedColumn2: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputDBBandedColumn3: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputDBBandedColumn4: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputDBBandedColumn5: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputDBBandedColumn6: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputDBBandedColumn7: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputDBBandedColumn8: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputDBBandedColumn9: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputDBBandedColumn10: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputDBBandedColumn11: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputDBBandedColumn12: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputDBBandedColumn13: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputDBBandedColumn14: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputDBBandedColumn15: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputDBBandedColumn16: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputDBBandedColumn17: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputDBBandedColumn18: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputDBBandedColumn19: TcxGridDBBandedColumn;
    pnl3: TPanel;
    Machineid5: TLabel;
    dtpOperateTimBeginEdit: TDateTimePicker;
    Machineid6: TLabel;
    dtpOperateTimEndEdit: TDateTimePicker;
    Machineid7: TLabel;
    cbbCurrentDepartmentEdit: TComboBox;
    grp2: TGroupBox;
    pnl4: TPanel;
    Machineid8: TLabel;
    edtInputCauseEdit: TEdit;
    btnQueryEdit: TSpeedButton;
    btnEditEdit: TSpeedButton;
    cxgridGrid1DBTableView2: TcxGridDBTableView;
    cxgrdlvlGrid1Level2: TcxGridLevel;
    cxgrd2: TcxGrid;
    cxgridSdOtdInputEdit: TcxGridDBBandedTableView;
    cdsSdOtdInputEdit: TClientDataSet;
    dsSdOtdInputEdit: TDataSource;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn1: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn2: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn3: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn4: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn5: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn6: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn7: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn8: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn9: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn10: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn11: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn12: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn13: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn14: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn15: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn16: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn17: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn18: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn19: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn20: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn21: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn22: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn23: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn24: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn25: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn26: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn27: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn28: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn29: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn30: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn31: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn32: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn33: TcxGridDBBandedColumn;
    cxgrdbndclmnSdOtdInputEditDBBandedColumn34: TcxGridDBBandedColumn;
    btnExit: TSpeedButton;
    procedure btnInputClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure cxgridSdOtdInputCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnCloseClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnQueryEditClick(Sender: TObject);
    procedure btnEditEditClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SdOtdInfo: TSdOtdInfo;

implementation

uses ServerDllPub,uGridDecorator,uLogin,strUtils;


{$R *.dfm}



//新增
procedure TSdOtdInfo.btnInputClick(Sender: TObject);
var
    vData, vData1 : olevariant;
    sErrMsg, sqlText,sErrorMsg,strConnection : WideString;
    ABeginTime, AEndTime: OleVariant;
    ADepartment : string;

begin
   inherited;
    ABeginTime:=FormatDateTime('yyyy-mm-dd',dtpOperateTimBegin.Date)+' 07:00:00'; //DateTimeToStr(dtpOperateTimBegin.Date);
    AEndTime:= FormatDateTime('yyyy-mm-dd',dtpOperateTimEnd.Date)+' 07:00:00';    //DateTimeToStr(dtpOperateTimEnd.Date);
    //ADepartment:= cbbCurrentDepartment.Text;
    //  +','+ QuotedStr(ADepartment)

    sqlText := 'EXEC FNMDB.dbo.usp_GetfnSdOtdInfoNEW ' + QuotedStr(ABeginTime) +','+  QuotedStr(AEndTime) ;
    FNMServerObj.GetQueryBySQL(vData, sqlText, sErrorMsg);
    if sErrorMsg <> '' then
       raise exception.Create('查询数据失败！' + sErrorMsg);
       cdsSdOtdInputTemp.Data := vData;
       cdsSdOtdInputTemp.Open ;

   if cdsSdOtdInputTemp.RecordCount<1 then
   begin
     ShowMessage('此查询时间段没有数据！') ;
     Exit;
   end;

    //初始化dataset(cdsSdOtdInput)
     sqlText := 'SELECT * FROM FNMdb.dbo.fnSdOtdInfoNEW  a (NOLOCK) where 1=2' ;
     FNMServerObj.GetQueryBySQL(vData1, sqlText, sErrorMsg);
     cdsSdOtdInput.Data := vData1;

     //把数据，插入到 cdsSdOtdInput中；
     with  cdsSdOtdInputTemp do
     begin
       cdsSdOtdInputTemp.First;
       While Not cdsSdOtdInputTemp.Eof do
         begin
          cdsSdOtdInput.Insert;
          cdsSdOtdInput.FieldByName('Job_No').AsString:=FieldByName('Job_No').AsString;
          cdsSdOtdInput.FieldByName('Gf_No').AsString:=FieldByName('Gf_No').AsString;
          cdsSdOtdInput.FieldByName('Gf_Id').AsString:=FieldByName('Gf_Id').AsString;
          cdsSdOtdInput.FieldByName('Wv_Factory').AsString:=FieldByName('Wv_Factory').AsString;
          cdsSdOtdInput.FieldByName('Current_Department').AsString:=FieldByName('Current_Department').AsString;
          cdsSdOtdInput.FieldByName('White_Type').AsString:=FieldByName('White_Type').AsString;
          cdsSdOtdInput.FieldByName('Delivery_Date').AsString:=FieldByName('Delivery_Date').AsString;
          cdsSdOtdInput.FieldByName('WV_Actual_Finish_Date').AsString:=FieldByName('WV_Actual_Finish_Date').AsString;
          cdsSdOtdInput.FieldByName('CanBeOutToFn_Time').AsString:=FieldByName('CanBeOutToFn_Time').AsString;
          cdsSdOtdInput.FieldByName('CT').AsString:=FieldByName('CT').AsString;
          cdsSdOtdInput.FieldByName('Add_Hour').AsString:=FieldByName('Add_Hour').AsString;
          cdsSdOtdInput.FieldByName('Operation_CHN').AsString:=FieldByName('Operation_CHN').AsString;
          cdsSdOtdInput.FieldByName('Send_Sample_Condition').AsString:=FieldByName('Send_Sample_Condition').AsString;
          cdsSdOtdInput.FieldByName('Require_Send_Sample_Name').AsString:=FieldByName('Require_Send_Sample_Name').AsString;
          cdsSdOtdInput.FieldByName('One_Duty').AsString:=FieldByName('One_Duty').AsString;
          cdsSdOtdInput.FieldByName('Two_Duty').AsString:=FieldByName('Two_Duty').AsString;
          cdsSdOtdInput.FieldByName('Three_Duty').AsString:=FieldByName('Three_Duty').AsString;
          cdsSdOtdInput.FieldByName('Input_Cause').AsString:=FieldByName('Input_Cause').AsString;
          cdsSdOtdInput.FieldByName('Insert_Time').AsString:=FieldByName('Insert_Time').AsString;
          cdsSdOtdInput.Post;
          Next;
         end;
     end ;

end;

//删除
procedure TSdOtdInfo.btnDeleteClick(Sender: TObject);
var
   sErrMsg: WideString;
begin
    if cdsSdOtdInput.IsEmpty then
      begin
        TMsgDialog.ShowMsgDialog('无记录删除！',mtWarning);
        Exit;
      end
    else
     cdsSdOtdInput.Delete;

end;

//保存
procedure TSdOtdInfo.btnSaveClick(Sender: TObject);
var
   sErrorMsg, sErrMsg : WideString;
   vData : olevariant;
 begin
   inherited;
    sErrorMsg := '';
       cdsSdOtdInput.Open ;


    if cdsSdOtdInput.IsEmpty then
      begin
        TMsgDialog.ShowMsgDialog('无记录可保存！',mtWarning);
        Exit;
      end
    else
       if MessageBox(0,'确定要保存吗？？','提示！',MB_YESNO+MB_ICONQUESTION)=IDyes then
        vData := cdsSdOtdInput.Delta;
        FNMServerObj.SaveBaseTableInfo(vData, 'fnSdOtdInfoNEW', 'Job_No,Gf_No,Gf_Id,Wv_Factory,Current_Department,White_Type,Delivery_Date,WV_Actual_Finish_Date,CanBeOutToFn_Time,CT,Add_Hour,Operation_CHN,Send_Sample_Condition,Require_Send_Sample_Name,One_Duty,Two_Duty,Three_Duty,Input_Cause,Insert_Time', sErrMsg);

          if sErrorMsg <> '' then
             raise exception.Create('数据保存失败！' + sErrorMsg)
          else
       showmessage('数据已保存成功!');
       cdsSdOtdInput.EmptyDataSet;
 end;


procedure TSdOtdInfo.btnCloseClick(Sender: TObject);
begin
inherited;
  if MessageBox(0,'确定要退出吗？？','提示！',MB_YESNO+MB_ICONQUESTION)=IDyes then
    BEGIN
      Close;
    END;
end;

procedure TSdOtdInfo.FormDestroy(Sender: TObject);
begin
  cdsSdOtdInput.Destroy;
  cdsSdOtdInputTemp.Destroy;
  SdOtdInfo:=nil;
end;

procedure TSdOtdInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;


procedure TSdOtdInfo.FormShow(Sender: TObject);
begin
   inherited;
   dtpOperateTimBegin.Date:=StrToDateTime(FormatDateTime('yyyy-mm-dd 7:00:00',now-7));
   dtpOperateTimEnd.Date:=StrToDateTime(FormatDateTime('yyyy-mm-dd 7:00:00',now));

   dtpOperateTimBeginEdit.Date:=StrToDateTime(FormatDateTime('yyyy-mm-dd',now-1));
   dtpOperateTimEndEdit.Date:=StrToDateTime(FormatDateTime('yyyy-mm-dd',now));

end;


//点击TcxGrid后给输入框符值
procedure TSdOtdInfo.cxgridSdOtdInputCellClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);

begin
  inherited;
  {
  begin
    with cxgridSdOtdInput do
    begin
      if Controller.SelectedRowCount <=0 then Exit;

      //if VarIsNull(Controller.SelectedRows[0].Values[getcolumnbyfieldname('Input_Cause').index]) then
      //  begin
        edtInputCause.Text := '';
        edtOldInputCause.Text:= '';
       //end
      //else
        edtOldInputCause.Text := Controller.SelectedRows[0].Values[getcolumnbyfieldname('Input_Cause').index];
    end;
  end;
  }
end;




procedure TSdOtdInfo.btnQueryEditClick(Sender: TObject);
var
    vData: olevariant;
    sqlText,sErrorMsg,strConnection : WideString;
    i:Integer;
    ABeginTime, AEndTime: OleVariant;
    ADepartment : string;
begin
    inherited;
    ABeginTime:=FormatDateTime('yyyy-mm-dd',dtpOperateTimBeginEdit.Date)+' 07:00:00'; //DateTimeToStr(dtpOperateTimBegin.Date);
    AEndTime:= FormatDateTime('yyyy-mm-dd',dtpOperateTimEndEdit.Date)+' 07:00:00';    //DateTimeToStr(dtpOperateTimEnd.Date);
    ADepartment:= cbbCurrentDepartmentEdit.Text;
    sqlText := 'EXEC FNMDB.dbo.usp_GetfnSdOtdInfoNEWQUERY ' + QuotedStr(ABeginTime) +','+  QuotedStr(AEndTime)+','+ QuotedStr(ADepartment) ;
    FNMServerObj.GetQueryBySQL(vData, sqlText, sErrorMsg);
    if sErrorMsg <> '' then
       raise exception.Create('查询数据失败！' + sErrorMsg);
       cdsSdOtdInputEdit.Data := vData;
       cdsSdOtdInputEdit.Open;

   if cdsSdOtdInputEdit.RecordCount<1 then
   begin
     ShowMessage('此查询时间段没有数据！') ;
     Exit;
   end;

 cxgridSdOtdInputEdit.ApplyBestFit();
  i:=0;
  while i < cxgridSdOtdInputEdit.ColumnCount do
  begin
    //cxgridSdOtdInput.Columns[i].Options.Editing := False;
    cxgridSdOtdInputEdit.Bands.Add();
    cxgridSdOtdInputEdit.Columns[i].Position.BandIndex := i;
    //cxgridSdOtdInput.Bands.Items[0].FixedKind:=fkLeft;
   // if (i=8) or (i=9) or (i=10)  or (i=11) then
   //    cxgridSdOtdInput.Columns[i].Width := 200;
    i:= i + 1;
  end;

  //cxgridSdOtdInput.Bands.Items[0].Visible := False;
  cxgridSdOtdInputEdit.Bands.Items[0].FixedKind:=fkLeft;
  cxgridSdOtdInputEdit.Bands.Items[1].FixedKind:=fkLeft;
  cxgridSdOtdInputEdit.Bands.Items[2].FixedKind:=fkLeft;
  cxgridSdOtdInputEdit.Bands.Items[3].FixedKind:=fkLeft;
  cxgridSdOtdInputEdit.Bands.Items[4].FixedKind:=fkLeft;
  cxgridSdOtdInputEdit.Bands.Items[5].FixedKind:=fkLeft;
  cxgridSdOtdInputEdit.Bands.Items[6].FixedKind:=fkLeft;
  cxgridSdOtdInputEdit.Bands.Items[7].FixedKind:=fkLeft;
  cxgridSdOtdInputEdit.Bands.Items[8].FixedKind:=fkLeft;
  cxgridSdOtdInputEdit.Bands.Items[9].FixedKind:=fkLeft;
  cxgridSdOtdInputEdit.Bands.Items[10].FixedKind:=fkLeft;
  cxgridSdOtdInputEdit.Bands.Items[11].FixedKind:=fkLeft;
  cxgridSdOtdInputEdit.Bands.Items[12].FixedKind:=fkLeft;
  cxgridSdOtdInputEdit.Bands.Items[13].FixedKind:=fkLeft;

end;


procedure TSdOtdInfo.btnEditEditClick(Sender: TObject);
var
   sErrorMsg: WideString;
   ATime: OleVariant;
   vData: OleVariant;
begin
    //Try
       inherited;
        sErrorMsg := '';
        ATime := Now;
        //cdsSdOtdInputEdit.DisableControls;

        with cdsSdOtdInputEdit do
        begin
           if edtInputCauseEdit.Text = '' then
              begin
               if cdsSdOtdInputEdit.State in[dsinsert,dsedit] then
                 begin
                  if MessageBox(0,'确定要保存吗？？','提示！',MB_YESNO+MB_ICONQUESTION)=IDyes then
                  vData := cdsSdOtdInputEdit.Delta;
                  FNMServerObj.SaveBaseTableInfo(vData, 'fnSdOtdInfoNEW', 'Job_No,Gf_No,Gf_Id,Wv_Factory,Current_Department,White_Type,Delivery_Date,WV_Actual_Finish_Date,CanBeOutToFn_Time,CT,Add_Hour,Operation_CHN,Send_Sample_Condition,Require_Send_Sample_Name,One_Duty,Two_Duty,Three_Duty,Input_Cause,Insert_Time', sErrorMsg);

                    if sErrorMsg <> '' then
                       raise exception.Create('数据保存失败！' + sErrorMsg)
                    else
                   showmessage('数据已保存成功!');
                   //cdsSdOtdInputEdit.EmptyDataSet;
                 btnQueryEdit.Click;
                 end
               ELSE
               ShowMessage('输入原因为空值,修改无效！');
               Exit;
              END;

          If MessageBox(0,'确定要修改吗？？','提示！',MB_YESNO+MB_ICONQUESTION)=IDyes then
            cdsSdOtdInputEdit.Edit;
            FieldByName('Input_Cause').AsString:=Trim(edtInputCauseEdit.Text)+'('+QuotedStr(Login.LoginName)+ QuotedStr(ATime)+')'+';'+FieldByName('Input_Cause').AsString ;
            cdsSdOtdInputEdit.Post;

            vData := cdsSdOtdInputEdit.Delta;
            FNMServerObj.SaveBaseTableInfo(vData, 'fnSdOtdInfoNEW', 'Job_No,Gf_No,Gf_Id,Wv_Factory,Current_Department,White_Type,Delivery_Date,WV_Actual_Finish_Date,CanBeOutToFn_Time,CT,Add_Hour,Operation_CHN,Send_Sample_Condition,Require_Send_Sample_Name,One_Duty,Two_Duty,Three_Duty,Input_Cause,Insert_Time', sErrorMsg);
              If sErrorMsg <> '' then
                 raise exception.Create('数据修改失败！' + sErrorMsg)
              else
             showmessage('数据已修改成功!');
        btnQueryEdit.Click;
        END;
    //finally
    //cdsSdOtdInputEdit.EnableControls;
    //end;

   edtInputCauseEdit.Text := '';
   //cdsSdOtdInputEdit.Open;
   //FormShow(Sender);


end;

procedure TSdOtdInfo.btnExitClick(Sender: TObject);
begin
  if MessageBox(0,'确定要退出吗？？','提示！',MB_YESNO+MB_ICONQUESTION)=IDyes then
    BEGIN
      Close;
    END;
end;

end.



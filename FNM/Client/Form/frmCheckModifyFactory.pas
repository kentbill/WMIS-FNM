unit frmCheckModifyFactory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, StdCtrls, Buttons, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, ExtCtrls, DBClient, MakeSQL,
  ComCtrls,uFNMArtInfo;

type
  TCheckModifyFactoryForm = class(TForm)
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    grp1: TGroupBox;
    btnQuery: TBitBtn;
    pnl4: TPanel;
    pnl5: TPanel;
    pnl6: TPanel;
    btnChoseAll: TBitBtn;
    btnCheck: TBitBtn;
    btnArt: TBitBtn;
    cxgrdCheck: TcxGrid;
    cxgrdCheckTV: TcxGridDBTableView;
    cxgrdCheckLV: TcxGridLevel;
    cxgrdStdStep: TcxGrid;
    cxgrdStdStepTV: TcxGridDBTableView;
    cxgrdStdStepLV: TcxGridLevel;
    cdsCheck: TClientDataSet;
    dsCheck: TDataSource;
    dsStdStep: TDataSource;
    cdsStdStep: TClientDataSet;
    MakeSQL: TMakeSQL;
    cdsQuery: TClientDataSet;
    dsQuery: TDataSource;
    lv_query: TListView;
    btnclose: TBitBtn;
    procedure btnQueryClick(Sender: TObject);
    procedure lv_QueryCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lv_QueryColumnClick(Sender: TObject; Column: TListColumn);
    procedure lv_QueryDblClick(Sender: TObject);
    procedure btnStepNo(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxgrdCheckDblClick(Sender: TObject);
    procedure cxgrdCheckTVKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgrdCheckEnter(Sender: TObject);
    procedure cxgrdCheckTVCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnChoseAllClick(Sender: TObject);
    procedure btnCheckClick(Sender: TObject);
    procedure btncloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure SaveData(job_id_list,note_no,checker:string);
    procedure BtnControl(id:Integer);
    { Private declarations }
  public
    procedure GetCheckInfo(check_no:string);
    procedure GetArtInfo(types:Integer);
    { Public declarations }
  end;

var
  CheckModifyFactoryForm: TCheckModifyFactoryForm;

implementation
 uses  StrUtils, uDictionary, uFNMResource, ULogin, UGlobal, uShowMessage, UGridDecorator,
       ServerDllPub;
{$R *.dfm}

procedure TCheckModifyFactoryForm.btnQueryClick(Sender: TObject);
var
  sCondition:string;
  sql_text,sErrorMsg: WideString;
  vData:OleVariant;
  i:Integer;
begin
  // sCondition:=makesql.GetSql;
  // if sCondition = '' then exit;

   sql_text:='select check_no,submit_date,check_status,submit_operator from fnFactoryCheckByArtHdr where check_status=0 ';//and  '+ sCondition ;
   FNMServerObj.GetQueryBySQL(vData,sql_text,sErrorMsg);
   if sErrorMsg <> '' then
   begin
      raise ExceptionEx.CreateResFmt(@SaveCheckArtDataError, [sErrorMsg]);
   end;
   cdsQuery.Data:=vData;


   FillListItemsFromDataSet(cdsQuery, 'check_no', '', [ 'submit_date','check_status','submit_operator'], lv_Query.Items);

   // FillListItemsFromDataSet(cdsQuery, 'check_no', '', [ 'submit_date','check_status','submit_operator'], lv_CurNOCheckArt.Items);


end;

procedure TCheckModifyFactoryForm.lv_QueryCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
    {*if Item.Index mod 2 =0 then
    Sender.Canvas.Brush.Color :=clSkyBlue
    else
    Sender.Canvas.Brush.Color :=clWhite;  *}
end;

procedure TCheckModifyFactoryForm.lv_QueryColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  TGlobal.SortListView(lv_Query,Column);
end;

procedure TCheckModifyFactoryForm.lv_QueryDblClick(Sender: TObject);
var
   index_no:Integer;
begin
     //双击获取审批单号，查询审批单号明细
     index_no:=lv_query.ItemIndex;
     //ShowMessage(IntToStr(index_no));
     if  index_no<0 then
     begin
       ShowMessage('请点击正确的行');
       exit;
     end ;
          //(lv_query.Items[index_no].Caption);
     GetCheckInfo(lv_query.Items[index_no].Caption);

     //设置按钮可用
      BtnControl(1);

     //ShowMessage(lv_query.Items[0].Caption);
     //ShowMessage(lv_query.Items[0].SubItems.strings[0]);
     //ShowMessage(lv_query.Items[1].Caption);

end;

procedure TCheckModifyFactoryForm.GetCheckInfo(check_no:string);
var
  sCondition:string;
  sql_text,sErrorMsg: WideString;
  vData:OleVariant;
  i:Integer;
begin
   sql_text:='exec USP_fnQueryForModifyFactory 1, '+   QuotedStr(check_no);//and  '+ sCondition ;
   //(sql_text);
   FNMServerObj.GetQueryBySQL(vData,sql_text,sErrorMsg);
   if sErrorMsg <> '' then
   begin
      raise ExceptionEx.CreateResFmt(@SaveCheckArtDataError, [sErrorMsg]);
   end;
   cdsCheck.Data:=vData;
   GridDecorator.BindCxViewWithDataSource(cxgrdCheckTV, dsCheck);

   //列属性设置
   for i:=0 to cxgrdCheckTV.ColumnCount - 1 do
    begin
      cxgrdCheckTV.Columns[i].DataBinding.Field.ReadOnly:=true;
    end;
   cxgrdCheckTV.GetColumnByFieldName('is_chosed').DataBinding.Field.ReadOnly:=False;

end;

procedure TCheckModifyFactoryForm.btnStepNo(Sender: TObject);
var
  factory:string;
  sql_text,sErrorMsg: WideString;
  vData:OleVariant;
  i,gf_id:Integer;
begin

  GetArtInfo(1);
    {*
   ShowMessage(IntToStr(cdsCheck.FieldByName('gf_id').AsInteger));
   ShowMessage(cdsCheck.FieldByName('factory').AsString);
   gf_id:=cdsCheck.FieldByName('gf_id').AsInteger;
   factory :=cdsCheck.FieldByName('factory').AsString;

   sql_text:='exec USP_fnQueryForModifyFactory 2, '+   QuotedStr(IntToStr(gf_id))+','+QuotedStr(factory);//and  '+ sCondition ;
   ShowMessage(sql_text);
   FNMServerObj.GetQueryBySQL(vData,sql_text,sErrorMsg);
   if sErrorMsg <> '' then
   begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
   end;
   cdsStdStep.Data:=vData;
   GridDecorator.BindCxViewWithDataSource(cxgrdStdStepTV, dsStdStep); *}
end;

procedure TCheckModifyFactoryForm.FormDestroy(Sender: TObject);
begin
        CheckModifyFactoryForm:=nil;
end;

procedure TCheckModifyFactoryForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     Action:=caFree;
end;

procedure TCheckModifyFactoryForm.cxgrdCheckDblClick(Sender: TObject);
begin
//     ShowMessage('已双击');
end;

procedure TCheckModifyFactoryForm.cxgrdCheckTVKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    if Key=13 then
    begin
       //ShowMessage('按回车lel');
       btnArt.OnClick(Self);
    end;
end;

procedure TCheckModifyFactoryForm.cxgrdCheckEnter(Sender: TObject);
begin
     //cdsCheck.Edit;
    // cdsCheck.FieldByName('is_chosed').AsBoolean:=True;
end;

procedure TCheckModifyFactoryForm.cxgrdCheckTVCellClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
   cdsCheck.Edit;
   if   cdsCheck.FieldByName('is_chosed').AsBoolean=True then
        cdsCheck.FieldByName('is_chosed').AsBoolean:=False
   else  cdsCheck.FieldByName('is_chosed').AsBoolean:=True;
end;

procedure TCheckModifyFactoryForm.btnChoseAllClick(Sender: TObject);
begin
    if cdsCheck.RecordCount<1 then
    begin
        showmessage('没有可选择的数据');
        Exit;
    end;

    cdsCheck.First;
    while not cdsCheck.Eof do
    begin
        cdsCheck.Edit;
        cdsCheck.FieldByName('is_chosed').AsBoolean:=True;
        cdsCheck.Next;
    end;
end;

procedure TCheckModifyFactoryForm.btnCheckClick(Sender: TObject);
var
  job_id_list:WideString;
  checker,note_no:string;
begin
    job_id_list:='';
    cdsCheck.First;
    while not cdsCheck.Eof do
    begin
        if cdsCheck.FieldByName('is_chosed').AsBoolean=True then
           job_id_list:=job_id_list+ cdsCheck.FieldByName('job_id').AsString+',';
        cdsCheck.Next;
    end;

    if   job_id_list='' then
    begin
        ShowMessage('没有可保存的数据');
        exit;
    end;
    job_id_list:=copy(job_id_list,1,Length(job_id_list)-1);
    note_no:=cdsCheck.FieldByName('check_no').AsString ;
    checker:=login.LoginName;
    //保存数据
    SaveData(job_id_list,note_no,checker);
    //过滤已经审批的本次数据
    cdsCheck.Filtered:=False;
    cdsCheck.Filter:='  check_no <> '+ QuotedStr(note_no);
    cdsCheck.Filtered:=True;

    //待审批单号刷新
       // lv_query.Items.Item[i].Delete
       btnQuery.OnClick(Self);

    //  工艺信息清空
        cdsStdStep.Close;
       //GetArtInfo(0);
    //设置按钮
       BtnControl(0);

end;

procedure TCheckModifyFactoryForm.SaveData(job_id_list,note_no,checker:string);
var
  sErrorMsg,JOB_ID,remark_reson,sCondition:WideString;
  VData: OleVariant;
  confirm_operator:string;
begin
    //保存数据，传入审批单号和job_id_list
    try
    ShowStatusMessage('正在保存数据...', crHourGlass);
    sCondition:=quotedstr(job_id_list)+','+ quotedstr(note_no)+','+quotedstr(checker);
    //ShowMessage(sCondition);
    FNMServerObj.SaveDataBySQL('CheckApproveFactory',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end
    else   TMsgDialog.ShowMsgDialog('审批成功!',mtInformation);
  finally
    ShowStatusMessage('', crDefault);
  end;

end;


procedure TCheckModifyFactoryForm.GetArtInfo(types:Integer);
var
  factory:string;
  sql_text,sErrorMsg: WideString;
  vData:OleVariant;
  i,gf_id:Integer;
begin
   if   types=1 then
   begin
     //ShowMessage(IntToStr(cdsCheck.FieldByName('gf_id').AsInteger));
     //ShowMessage(cdsCheck.FieldByName('factory').AsString);
     gf_id:=cdsCheck.FieldByName('gf_id').AsInteger;
     factory :=cdsCheck.FieldByName('factory').AsString;

     sql_text:='exec USP_fnQueryForModifyFactory 2, '+   QuotedStr(IntToStr(gf_id))+','+QuotedStr(factory);//and  '+ sCondition ;
   end
   else
     sql_text:='exec USP_fnQueryForModifyFactory 3, '+   QuotedStr(IntToStr(gf_id));

   //ShowMessage(sql_text);
   FNMServerObj.GetQueryBySQL(vData,sql_text,sErrorMsg);
   if sErrorMsg <> '' then
   begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
   end;
   cdsStdStep.Data:=vData;
   GridDecorator.BindCxViewWithDataSource(cxgrdStdStepTV, dsStdStep);
end;

procedure TCheckModifyFactoryForm.btncloseClick(Sender: TObject);
begin
        close;
end;

procedure TCheckModifyFactoryForm.BtnControl(id:Integer);
begin
    if id=0 then
    begin
       //不可用
       btnChoseAll.Enabled:=False;
       btnCheck.Enabled:=False;
    end
    else
    begin
       //可用
       btnChoseAll.Enabled:=True;
       btnCheck.Enabled:=True;
    end;


end;

procedure TCheckModifyFactoryForm.FormShow(Sender: TObject);
begin
   BtnControl(0);
end;

end.

unit frmSetCapacity;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, DBClient, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, StdCtrls, Buttons, ExtCtrls, MakeSQL, Mask,
  DBCtrls;

type
  TSetCapacityForm = class(TForm)
    pnl1: TPanel;
    pnl2: TPanel;
    rgFactory: TRadioGroup;
    rgOperation: TRadioGroup;
    lbl8: TLabel;
    lbl9: TLabel;
    cbbMachine_id: TComboBox;
    edt_DayCapacity: TEdit;
    btnNew: TBitBtn;
    btnSave: TBitBtn;
    grp1: TGroupBox;
    pnl3: TPanel;
    cxGridInCapacityTV: TcxGridDBTableView;
    cxGridInCapacityLV: TcxGridLevel;
    cxGridInCapacity: TcxGrid;
    dsInCapacity: TDataSource;
    cdsInCapacity: TClientDataSet;
    grp2: TGroupBox;
    pnl4: TPanel;
    cxGridQueryapacityTV: TcxGridDBTableView;
    cxGridQueryapacityLV: TcxGridLevel;
    cxGridQueryapacity: TcxGrid;
    btnModifyQuery: TBitBtn;
    btnModifyDelete: TBitBtn;
    btnModifySave: TBitBtn;
    cdsQueryapacity: TClientDataSet;
    dsQueryapacity: TDataSource;
    lbl1: TLabel;
    edtRemark: TEdit;
    btnDelete: TBitBtn;
    MakeSQL1: TMakeSQL;
    grp3: TGroupBox;
    chk_Twhite: TCheckBox;
    chk_Pwhite: TCheckBox;
    chk_Bwhite: TCheckBox;
    chk_SYwhite: TCheckBox;
    grp4: TGroupBox;
    chk_Twhite_Q: TCheckBox;
    chk_Pwhite_Q: TCheckBox;
    chk_Bwhite_Q: TCheckBox;
    chk_Swhite_Q: TCheckBox;
    btn2: TBitBtn;
    dbedtmachine_capacity: TDBEdit;
    lbl2: TLabel;
    dbedtwhite_type: TDBEdit;
    lbl3: TLabel;
    btn1: TBitBtn;
    lbl4: TLabel;
    edt_Speed: TEdit;
    lbl5: TLabel;
    dbedtstandard_speed: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnModifyQueryClick(Sender: TObject);
    procedure btnModifyDeleteClick(Sender: TObject);
    procedure btnModifySaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private

     function getFactory(Chose_index:Integer):string;
     function getOperation(Chose_index:Integer):string;
    // function getWhiteType(Chose_index:Integer):string;
     function getWhiteTypeList(types:Integer):string;
    { Private declarations }
  public
     procedure getcolumn;
    { Public declarations }
  end;

var
  SetCapacityForm: TSetCapacityForm;

implementation

uses StrUtils, Math, uAppOption, uGlobal, uShowMessage,
     ServerDllPub, uCADInfo, uDictionary, uLogin, uGridDecorator, frmAccident;

{$R *.dfm}

procedure TSetCapacityForm.FormShow(Sender: TObject);
var
  Allitems:TStrings;
  Sconditions:string;
  sql_text,sErrorMsg: WideString;
  vData:OleVariant;
  i:Integer;
begin
   //初始化机台列表
   Allitems:=cbbMachine_id.Items;
   with Dictionary do
  try
    with cds_FinishMachineList do
    begin
      Filter := ' (Machine_Model_CHN like ''%烧毛%'') or  (Machine_Model_CHN like ''%退浆%'') or (Machine_Model_CHN like ''丝光%'')  or  (Machine_Model_CHN like ''练漂%'')' ;
      Filtered := True;
      TGlobal.FillItemsFromDataSet(cds_FinishMachineList, 'Machine_ID', 'Machine_Model_CHN', '->', Allitems);
    end;
   finally
     cds_FinishMachineList.Filtered:=false;
    end;

    Getcolumn;

end;

procedure TSetCapacityForm.btnNewClick(Sender: TObject);
var
  a:Double;
  machine_id:string;
 // lengths:Integer;
begin
  //数据校验
    if cbbMachine_id.Text='' then
       begin
           ShowMessage('请选择机台ID');
           exit;
       end;

   if not TryStrToFloat(edt_DayCapacity.text,a) then
       begin
           ShowMessage('日产能输入格式有误，请重新输入');
           exit;
       end;
    if not TryStrToFloat(edt_speed.Text,a) then
       begin
           ShowMessage('车速输入格式有误，请重新输入');
           exit;
       end;

 // lengths:=Pos(cbbMachine_id.Text,'->')
  machine_id:=LeftStr(cbbMachine_id.Text,Pos('->',cbbMachine_id.Text)-1);
   with  cdsInCapacity do
   begin
       Append;
       FieldByName('factory').AsString:=getFactory(rgFactory.ItemIndex);
       FieldByName('Operation_Type').AsString:=getOperation(rgOperation.ItemIndex);
       FieldByName('white_type').AsString:=getWhiteTypelist(1);
       FieldByName('machine_id').AsString:=machine_id;
       FieldByName('remark').AsString:=edtRemark.Text;
       FieldByName('machine_capacity').AsFloat:=StrToFloat(edt_DayCapacity.text) ;
       FieldByName('standard_speed').AsFloat:=StrToFloat(edt_Speed.text) ;
       Post;
       end;

end;

function  TSetCapacityForm.getFactory(Chose_index:Integer):string;
begin
   case Chose_index of
    0:
        begin
           result:='FA';
        end;
    1:
       begin
           result:='FG';
        end;
    end;

end;
function  TSetCapacityForm.getOperation(Chose_index:Integer):string;
begin
   case Chose_index of
    0:
        begin
           result:='烧毛';
        end;
    1:
       begin
           result:='退浆';
        end;
    2:
       begin
           result:='丝光';
        end;
    end;

end;

function TSetCapacityForm.getWhiteTypeList(types:Integer):string;
var
  WhiteList:string;
begin
   WhiteList:='/';
   if types=1  then
   begin
     if chk_Twhite.Checked=True then WhiteList:=WhiteList+'特白/';
     if chk_Pwhite.Checked=True then WhiteList:=WhiteList+'漂白/';
     if chk_SYwhite.Checked=True then WhiteList:=WhiteList+'少荧/';
     if chk_Bwhite.Checked=True then WhiteList:=WhiteList+'本白/';
  end;
   if types=2  then
   begin
     if chk_Twhite_Q.Checked=True then WhiteList:=WhiteList+'特白/';
     if chk_Pwhite_Q.Checked=True then WhiteList:=WhiteList+'漂白/';
     if chk_Swhite_Q.Checked=True then WhiteList:=WhiteList+'少荧/';
     if chk_Bwhite_Q.Checked=True then WhiteList:=WhiteList+'本白/';
   end ;

   if  WhiteList='/' then   WhiteList:='/特白/漂白/少荧/本白/';

   Result:= WhiteList;
end;

procedure TSetCapacityForm.btnDeleteClick(Sender: TObject);
begin
    cdsInCapacity.Delete;
end;

procedure TSetCapacityForm.btnSaveClick(Sender: TObject);
var
  vData:OleVariant;
  sSQL,sErrMsg:WideString;
begin
   if TGlobal.DeltaIsNull(cdsInCapacity) then Exit;
  vData := cdsInCapacity.Delta;
  FNMServerObj.SaveBaseTableInfo(vData, 'fnProductCapicity', 'factory,machine_id,Operation_Type',sErrMsg);
  if sErrMsg<>'' then
  begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
  end
  else TMsgDialog.ShowMsgDialog('保存成功!',mtInformation);

  //重新初始化表头
   getcolumn;

end;


procedure TSetCapacityForm.btnModifyQueryClick(Sender: TObject);
var
  Sconditions:string;
  sql_text,sErrorMsg: WideString;
  vData:OleVariant;
  i:Integer;
begin
      //查询工艺已经审批完的JOB_ID明细
   Sconditions:=MakeSQL1.GetSql;
   if  Sconditions='' then Exit;

   sql_text:='exec USP_fnQueryForModifyFactory 6, '+quotedstr(Sconditions) ;

   FNMServerObj.GetQueryBySQL(vData,sql_text,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
   cdsQueryapacity.Data:=vData;
   GridDecorator.BindCxViewWithDataSource(cxGridQueryapacityTV, dsQueryapacity);


end;

procedure TSetCapacityForm.btnModifyDeleteClick(Sender: TObject);
begin
     cdsQueryapacity.Delete;
end;

procedure TSetCapacityForm.btnModifySaveClick(Sender: TObject);
var
  vData:OleVariant;
  sSQL,sErrMsg:WideString;
begin
   if TGlobal.DeltaIsNull(cdsQueryapacity) then Exit;
  vData := cdsQueryapacity.Delta;
  FNMServerObj.SaveBaseTableInfo(vData, 'fnProductCapicity', 'factory,machine_id,Operation_Type',sErrMsg);
  if sErrMsg<>'' then
  begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
  end
  else TMsgDialog.ShowMsgDialog('数据更新成功!',mtInformation);

  //清空数据集
  cdsQueryapacity.Close;

end;


 procedure TSetCapacityForm.getcolumn;
 var
  sql_text,sErrorMsg: WideString;
  vData:OleVariant;
 begin
  //初始化 表头
   sql_text:='exec USP_fnQueryForModifyFactory 5,'''' ' ;

   FNMServerObj.GetQueryBySQL(vData,sql_text,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
   cdsInCapacity.Data:=vData;
   GridDecorator.BindCxViewWithDataSource(cxGridInCapacityTV, dsInCapacity);

 end;

procedure TSetCapacityForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
        Action:=caFree;
end;

procedure TSetCapacityForm.FormDestroy(Sender: TObject);
begin
      SetCapacityForm:=nil;
end;

procedure TSetCapacityForm.btn1Click(Sender: TObject);
begin
  close;
end;

procedure TSetCapacityForm.btn2Click(Sender: TObject);
begin
      CdsQueryapacity.Edit;
      CdsQueryapacity.FieldByName('white_type').AsString:= getWhiteTypeList(2);
     // dbedtwhite_type.Text:=getWhiteTypeList(2);
end;

end.

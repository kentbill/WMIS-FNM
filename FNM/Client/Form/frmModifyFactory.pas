unit frmModifyFactory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, ComCtrls, MakeSQL, DBClient,
  Mask, DBCtrls,frmBase, ADODB, cxSplitter;

type
  TModifyFactoryForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnQuery: TBitBtn;
    grp1: TGroupBox;
    grp2: TGroupBox;
    lbl3: TLabel;
    edtday: TEdit;
    Panel3: TPanel;
    cxgrdConfirmTV: TcxGridDBTableView;
    cxgrdConfirmLV: TcxGridLevel;
    cxgrdConfirm: TcxGrid;
    grp3: TGroupBox;
    btnModifyFactory: TBitBtn;
    pgc1: TPageControl;
    ts1: TTabSheet;
    grp4: TGroupBox;
    lbl7: TLabel;
    rgFactory: TRadioGroup;
    rgType_bill: TRadioGroup;
    rgModify_Times: TRadioGroup;
    btnFilter: TBitBtn;
    btn7: TBitBtn;
    makesql2: TMakeSQL;
    lbl4: TLabel;
    edtCapacity: TEdit;
    lbl5: TLabel;
    dsConfirm: TDataSource;
    cdsConfirm: TClientDataSet;
    ts2: TTabSheet;
    pnl1: TPanel;
    pnl2: TPanel;
    cxGridArt_CheckTV: TcxGridDBTableView;
    cxGridArt_CheckLV: TcxGridLevel;
    cxGridArt_Check: TcxGrid;
    grp8: TGroupBox;
    btn2: TBitBtn;
    dsArt_Check: TDataSource;
    cdsArt_Check: TClientDataSet;
    SQL_Art_check: TMakeSQL;
    btn5: TBitBtn;
    dbedtconfirm_reason: TDBEdit;
    cdsCapacity: TClientDataSet;
    dsCapacity: TDataSource;
    cxGrid1: TcxGrid;
    cxGridCapacityTV: TcxGridDBTableView;
    cxgrdbclmnGrid1DBTableView1DBColumn1: TcxGridDBColumn;
    cxgrdbclmnGrid1DBTableView1DBColumn2: TcxGridDBColumn;
    cxgrdbclmnGrid1DBTableView1DBColumn3: TcxGridDBColumn;
    cxgrdbclmnGrid1DBTableView1DBColumn4: TcxGridDBColumn;
    cxgrdbclmnGrid1DBTableView1DBColumn5: TcxGridDBColumn;
    cxgrdbclmnGrid1DBTableView1DBColumn6: TcxGridDBColumn;
    cxgrdbclmnGrid1DBTableView1DBColumn7: TcxGridDBColumn;
    cxGridCapacityLV: TcxGridLevel;
    ts3: TTabSheet;
    ts4: TTabSheet;
    pnl3: TPanel;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    pnl4: TPanel;
    cxGrid3: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cdsTest_all: TClientDataSet;
    dsTest_all: TDataSource;
    dsTest_White: TDataSource;
    cdsTest_White: TClientDataSet;
    cxspl_Only: TcxSplitter;
    cxSplitter1: TcxSplitter;
    cxgrdbclmnGridCapacityTVDBColumn1: TcxGridDBColumn;
    cxgrdbclmnGridCapacityTVDBColumn2: TcxGridDBColumn;
    btn8: TBitBtn;
    grp5: TGroupBox;
    grp6: TGroupBox;
    edtReason: TEdit;
    cxgrdbclmnGridCapacityTVDBColumn3: TcxGridDBColumn;
    procedure btn9Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn13Click(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnModifyFactoryClick(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure ts1Show(Sender: TObject);
    procedure cxgrdConfirmTVCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btn8Click(Sender: TObject);
  private
    Getconditions:WideString;
    have_chosed:Boolean;
    function  Factory_Filter(Chose_index:Integer):string;
    function  BillType_Filter(Chose_index: Integer):string;
    function  ModifyTimes_Filter(Chose_index: Integer):string;
    procedure Setbutton_control;
    procedure clear_chosed;

    { Private declarations }
  public
    procedure SaveData;
    { Public declarations }
  end;

var
  ModifyFactoryForm: TModifyFactoryForm;

implementation

 uses
    StrUtils, frmCreateSample, uDictionary, uFNMResource, uFNMArtInfo,ULogin, UGlobal, uShowMessage, UGridDecorator,
    ServerDllPub;
{$R *.dfm}

procedure TModifyFactoryForm.btn9Click(Sender: TObject);
var
  Sconditions:string;
  sql_text,sErrorMsg: WideString;
  vData:OleVariant;
  i:Integer;
begin
      //��ѯ�����Ѿ��������JOB_ID��ϸ
   Sconditions:=SQL_Art_check.GetSql;

   sql_text:='exec USP_fnQueryForModifyFactory 4, '+quotedstr(Sconditions) ;

   FNMServerObj.GetQueryBySQL(vData,sql_text,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
   cdsArt_Check.Data:=vData;
   GridDecorator.BindCxViewWithDataSource(cxGridArt_CheckTV, dsArt_Check);

end;

procedure TModifyFactoryForm.btn5Click(Sender: TObject);
var
  sql_text:string;
begin
     close;
end;

procedure TModifyFactoryForm.btn13Click(Sender: TObject);
var
  sql_text:string;
begin
     sql_text:=makesql2.GetSql;
end;


procedure TModifyFactoryForm.btnQueryClick(Sender: TObject);
var
  sql_text,sErrorMsg,sconditions: WideString;
  vData:OleVariant;
  i:Integer;
  j:Double;
begin
    Getconditions:='' ;
    if (edtday.Text='') or ( not TryStrToInt(edtday.Text,i))  then
    begin
        showmessage('����������ʽ������������������');
        Exit;
    end;

    sconditions:=quotedstr(edtCapacity.Text)+','+quotedstr(edtday.Text);
    try
      ShowStatusMessage('���ڻ�ȡ�����Ե�!', crHourGlass);
      FNMServerObj.GetQueryData(vData,'QueryMODIFYFACTORY',sconditions,sErrorMsg);
      if sErrorMsg<>'' then
      begin
        TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
        Exit;
      end;
      cdsCapacity.Data := vData[0];
      cdsConfirm.Data := vData[1];

      //Ϊ���Է��㣬��ʾ��������
      cdsTest_White.Data:=vData[2];
      cdsTest_all.Data:=vData[3];

      GridDecorator.BindCxViewWithDataSource(cxgrdConfirmTV, dsConfirm,True);

      GridDecorator.BindCxViewWithDataSource(cxGrid2DBTableView1, dstest_all,True);
      GridDecorator.BindCxViewWithDataSource(cxGridDBTableView1, dsTest_White,True);


      //����������
      for i:=0 to cxgrdConfirmTV.ColumnCount - 1 do
      begin
        cxgrdConfirmTV.Columns[i].DataBinding.Field.ReadOnly:=true;
      end;
      cxgrdConfirmTV.GetColumnByFieldName('IS_chosed').DataBinding.Field.ReadOnly:=false;
      cxgrdConfirmTV.GetColumnByFieldName('confirm_reason').DataBinding.Field.ReadOnly:=false;
    finally
       ShowStatusMessage('', crDefault);
    end;
   Setbutton_control;
end;

procedure TModifyFactoryForm.btnFilterClick(Sender: TObject);
var
  a:Integer;
  filter_condition,S:string;
begin
   grp5.Enabled:=True;

  //�����˱�Ǳ����Ѿ������� ����������������
   // ����ȡ15�����������ĵ���
   S:=FormatDateTime('yyyy-MM-dd hh:mm:ss',Now-15);
   if Getconditions='' then
      filter_condition:=' submit_status<>1  and (confirm_date is null or confirm_date>='+ QuotedStr(s)+')'
   else  filter_condition:=  Getconditions + ' and (confirm_date is null or confirm_date>='+ QuotedStr(s)+')'  ;

  //�ٰ��յ�ǰ�Ĺ�����������
  filter_condition:=filter_condition
             +' and '+Factory_Filter(rgFactory.ItemIndex)
             +' and '+BillType_Filter(rgType_bill.ItemIndex)
             +' and '+ModifyTimes_Filter(rgModify_Times.ItemIndex);

  //ShowMessage(filter_condition);

  cdsConfirm.Filtered:=False;
  cdsConfirm.Filter := filter_condition;
  cdsConfirm.Filtered := True;

end;

function  TModifyFactoryForm.Factory_Filter(Chose_index:Integer):string;
begin
   case Chose_index of
    0:
        begin
           result:=' factory = ''FA''  ';
        end;
    1:
       begin
           result:=' factory = ''FG''  ';
        end;
    2:
       begin
           result:=' factory  in (''FA'',''FG'') ';
        end;
    end;

end;

function  TModifyFactoryForm.BillType_Filter(Chose_index: Integer):string;
begin
   //�����������ģ�����ֱ���ŵ���
    //����ʱ�������˲��ɸĹ��������ݣ�ȫ����ʾ
   case Chose_index of
    0:
        begin
           result:= ' is_redo_bill =''�µ�''    ' ;      // and Data_status<2
        end;
    1:
       begin
           result:= ' is_redo_bill =''����''    ';          //and Data_status<2
        end;
    2:
       begin
           result:=' data_status =''�������ſɸ�'' and submit_status=0  ';
        end;
    3:
       begin
           result:='  data_status =''�������ɸ�''   '; //submit_status=2  ';
        end;
    4:
       begin
           result:=' data_status <>'''' ';

       end;
    end;
end;

function  TModifyFactoryForm.ModifyTimes_Filter(Chose_index: Integer):string;
begin
   case Chose_index of
   0:
        begin
           result:='  modify_times = 0  ';
        end;
    1:
       begin
           result:='  modify_times = 1  ';
        end;
    2:
       begin
           result:='  modify_times>1  ';
        end;
    3:
       begin
           result:=' modify_times>=0   ';
       end;
    end;

end;

procedure TModifyFactoryForm.FormShow(Sender: TObject);
begin
  grp5.Enabled:=False;

end;

procedure TModifyFactoryForm.FormDestroy(Sender: TObject);
begin
    ModifyFactoryForm:=nil;
end;

procedure TModifyFactoryForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    Action:=caFree;
end;

procedure TModifyFactoryForm.Setbutton_control;
begin
     grp3.Enabled:=True;
     grp4.Enabled:=True;

end;


procedure TModifyFactoryForm.btnModifyFactoryClick(Sender: TObject);
var
  sErrorMsg,JOB_ID,remark_reson,sCondition,filters:WideString;
  VData: OleVariant;
  confirm_operator,confirm_reasons:string;
  have_modify:Boolean;
begin
    have_modify:=False;
    confirm_reasons:=edtReason.Text;
    cdsConfirm.Filtered:=false;
    //��grid��ѡ�е����ݣ��������ƶԵ���
    JOB_ID:='';
    remark_reson:='';
    filters:='';
    cdsConfirm.First;
    cxgrdConfirmTV.GetColumnByFieldName('for_confirm').DataBinding.Field.ReadOnly:=False;
    while not  cdsConfirm.Eof do
    begin
       if cdsConfirm.fieldbyname('is_chosed').AsBoolean=True   then
        begin
          //�����޸Ĵ���Ϊ1Ϊ���ϣ���ע��û���޸ģ�ȫ�����أ������棻
           if (cdsConfirm.fieldbyname('modify_times').AsInteger>=1)
           then   have_modify:=True;

           //ֻ������״̬Ϊ1���ɸģ�����ȷ���ŵ����޸Ĺ������������Ͳ���ȷ���ŵ���
           if    (cdsConfirm.fieldbyname('data_status').AsString='���ɸ�')
              or (cdsConfirm.fieldbyname('data_status').AsString='�������ſɸ�') then
           begin
                ShowMessage('��������״̬Ϊ�ǿɸĵ��������ͣ�����ȷ���ŵ���');
                clear_chosed;
                exit;
           end;

          //��������޸Ĵ���>=1�ģ���ʶ
           if  (cdsConfirm.fieldbyname('modify_times').AsInteger>=1) and (confirm_reasons='')  then
           begin
                showmessage('�����޸Ĵ������ڵ���1��û��¼�뱸ע��Ϣ������¼��') ;
                clear_chosed;
                exit;
           end;

           //���JOB_ID
           if pos(cdsConfirm.fieldbyname('job_id').AsString,job_id)=0 then
           begin
               JOB_ID:=JOB_ID+cdsConfirm.fieldbyname('job_id').AsString+',';

               //��ȡ����job_id
               filters:= filters+'job_id <> '+cdsConfirm.fieldbyname('job_id').AsString +' and ';
           end;
          //ȥ��ѡ�б�ʶ��
          cdsConfirm.Edit;
          cdsConfirm.fieldbyname('is_chosed').AsBoolean:=false;
          cdsConfirm.FieldByName('for_confirm').AsBoolean:=True;   //���´�ȷ�ϱ�ʶ
        end;
        cdsConfirm.Next;
      end;

    cxgrdConfirmTV.GetColumnByFieldName('for_confirm').DataBinding.Field.ReadOnly:=True;

    if JOB_ID='' then
     begin
        showmessage('û��ѡ������ݣ����ȹ�ѡ����');
        exit;
     end;
      // JOB_ID:=copy(JOB_ID,1,Length(JOB_ID)-1);
     //�жϣ��޸Ĵ������ڵ���1  ��ֻ��һ������¼�޸�
     if  have_modify  and  ( Pos(',',JOB_ID)>0)  then
     begin
        ShowMessage('�޸Ĵ�������1�ļ�¼��ÿ��ֻ���޸�һ��');
        exit;
     end;
       remark_reson:=confirm_reasons;
       confirm_operator:=login.LoginName;

       filters:= copy(filters,1,Length(filters)-4);

      //��������,�����JOB_ID ���к�̨���£�
   try
    ShowStatusMessage('���ڱ�������...', crHourGlass);
    if have_modify   then
           sCondition:=quotedstr(confirm_operator)+',1,'+quotedstr(JOB_ID)+','+quotedstr(remark_reson)
    else   sCondition:=quotedstr(confirm_operator)+',1,'+quotedstr(JOB_ID);
    FNMServerObj.SaveDataBySQL('SaveModifyFactory',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end
    else
    begin
         TMsgDialog.ShowMsgDialog('�޸ĳɹ�!',mtInformation);
         edtReason.Text:='';
    end ;
  finally
    ShowStatusMessage('', crDefault);
  end;
  //�����������������ӱ����ѹ�ѡ��ͬһjob_id
   if   Getconditions='' then
        Getconditions:=Filters
   else
         Getconditions:=Getconditions + ' and ' +Filters;

   //Getconditions:= copy(Getconditions,1,Length(Getconditions)-4);
  //cdsConfirm.Filter:='(' +cdsConfirm.Filter+') or ('+  +')';
  //showmessage(Getconditions);

   cdsConfirm.Filter:=cdsConfirm.Filter +' and '+ Getconditions;
   // showmessage(cdsConfirm.Filter);
  cdsConfirm.Filtered:=true;

end ;

procedure TModifyFactoryForm.btn7Click(Sender: TObject);
var
  sErrorMsg,JOB_ID_list,sCondition,filters:WideString;
  VData: OleVariant;
  submit_operator:string;
begin
    //��grid��ѡ�е����ݣ��������ƶԵ���
    cdsConfirm.Filtered:=false;
    JOB_ID_list:='';
    cdsConfirm.First;
    cxgrdConfirmTV.GetColumnByFieldName('submit_status').DataBinding.Field.ReadOnly:=false;
    while not  cdsConfirm.Eof do
    begin
       if cdsConfirm.fieldbyname('is_chosed').AsBoolean=True   then
        begin
          //ֻ������״̬Ϊ1���ɸģ�����ȷ���ŵ����޸Ĺ������������Ͳ���ȷ���ŵ���
           if  (cdsConfirm.fieldbyname('data_status').AsString<>'�������ſɸ�') then
           begin
                ShowMessage('��������״̬Ϊ���������ſɸ����ͣ������ύ�ŵ���');
                clear_chosed;
                exit;
           end;
          //cdsConfirm.fieldbyname('submit_status').AsInteger:=1;

           //���JOB_ID
           if pos(cdsConfirm.fieldbyname('job_id').AsString,JOB_ID_list)=0 then
           begin
               JOB_ID_list:=JOB_ID_list+cdsConfirm.fieldbyname('job_id').AsString+',';
                //��ȡ����job_id
                filters:= filters+'job_id <> '+cdsConfirm.fieldbyname('job_id').AsString +' and ';
          end;

         // JOB_ID_list:=JOB_ID_list+cdsConfirm.fieldbyname('job_id').AsString+',';
           //ȥ��ѡ�б�ʶ��
          cdsConfirm.Edit;
          cdsConfirm.fieldbyname('is_chosed').AsBoolean:=false;
        end;

        cdsConfirm.Next;
      end;
     // cxgrdConfirmTV.GetColumnByFieldName('submit_status').DataBinding.Field.ReadOnly:=True;

     if JOB_ID_list='' then
     begin
        showmessage('û��ѡ������ݣ����ȹ�ѡ����');
        exit;
     end;

      JOB_ID_list:=copy(JOB_ID_list,1,Length(JOB_ID_list)-1);
      submit_operator:=login.LoginName;

      //��ȡ�ַ�
      filters:= copy(filters,1,Length(filters)-4);

     //�ύ��������,�����JOB_ID ����̨����������
   try
    ShowStatusMessage('���ڱ�������...', crHourGlass);
    sCondition:=quotedstr(JOB_ID_list)+','+quotedstr(submit_operator);
    //ShowMessage(sCondition);
    FNMServerObj.SaveDataBySQL('SubmitApproveFactory',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end
    else   TMsgDialog.ShowMsgDialog('�ύ�����ɹ�!',mtInformation);
  finally
    ShowStatusMessage('', crDefault);
  end;
    //  showmessage(cdsConfirm.Filter);
  if   Getconditions='' then
        Getconditions:=Filters
   else
         Getconditions:=Getconditions + ' and ' +Filters;

   //Getconditions:= copy(Getconditions,1,Length(Getconditions)-4);
  //cdsConfirm.Filter:='(' +cdsConfirm.Filter+') or ('+  +')';
  //showmessage(Getconditions);

   cdsConfirm.Filter:=cdsConfirm.Filter +' and '+ Getconditions;
   // showmessage(cdsConfirm.Filter);
  cdsConfirm.Filtered:=true;

end;

procedure TModifyFactoryForm.SaveData;
begin



end;

procedure TModifyFactoryForm.ts1Show(Sender: TObject);
begin
    have_chosed:=False;
end;


procedure TModifyFactoryForm.cxgrdConfirmTVCellClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
     {*cdsConfirm.Edit;
     if cdsConfirm.fieldbyname('is_chosed').AsBoolean=False then
        cdsConfirm.fieldbyname('is_chosed').AsBoolean:=True
     else     cdsConfirm.fieldbyname('is_chosed').AsBoolean:=False; *}


end;

procedure TModifyFactoryForm.btn8Click(Sender: TObject);
var
  sErrorMsg,JOB_ID,remark_reson,sCondition,filters:WideString;
  VData: OleVariant;
  confirm_operator:string;
begin

    cdsConfirm.Filtered:=false;
    //��grid������������ȷ��
    JOB_ID:='';
    cdsConfirm.First;
    while not  cdsConfirm.Eof do
    begin
       if (cdsConfirm.fieldbyname('data_status').AsString<>'���ɸ�')
         and ( pos(cdsConfirm.fieldbyname('job_id').AsString,job_id)=0)
         and (cdsConfirm.fieldbyname('for_confirm').AsBoolean=True)    //����
       then
        begin
          JOB_ID:=JOB_ID+cdsConfirm.fieldbyname('job_id').AsString+',';
        end;
        cdsConfirm.Next;
      end;
      // JOB_ID:=copy(JOB_ID,1,Length(JOB_ID)-1);
       confirm_operator:=login.LoginName;

    //MSTD���� �� ���ȿ��ƣ��������ȡ500��Ψһ��JOB_ID
   // if  Length(JOB_ID)>3500  then
   //   JOB_ID:=copy(JOB_ID,1,3500);                       

      //��������,�����JOB_ID ���к�̨���£�
   try
    ShowStatusMessage('���ڱ�������...', crHourGlass);
    sCondition:=QuotedStr(confirm_operator)+',0,'+QuotedStr(JOB_ID);
    //ShowMessage(sCondition);
    FNMServerObj.SaveDataBySQL('SaveModifyFactory',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end
    else   TMsgDialog.ShowMsgDialog('����ȷ�ϳɹ�!',mtInformation);
  finally
    ShowStatusMessage('', crDefault);
  end;

  //�����ѯ���������ݣ�
  cdsConfirm.Close;

end;

 procedure TModifyFactoryForm.clear_chosed;
begin
   with cdsConfirm do
   begin
       First;
      // while not Eof do    //ѭ��̫���� 
     //  begin
         Edit;
         cdsConfirm.fieldbyname('is_chosed').AsBoolean:=false;
         Next;
      // end
   end;
end;

end.

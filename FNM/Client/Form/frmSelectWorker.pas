unit frmSelectWorker;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, Grids, ValEdit, ExtCtrls, DB, DBClient;

type
  TSelectWorkerForm = class(TForm)
    lstWorker: TListBox;
    lbl1: TLabel;
    lbl2: TLabel;
    btnRight: TBitBtn;
    btnClear: TButton;
    edtFilter: TEdit;
    btn1: TSpeedButton;
    pnl1: TPanel;
    btnSave: TSpeedButton;
    cdsWorker: TClientDataSet;
    btn2: TSpeedButton;
    lstWorkers: TListBox;
    edtWorkers: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btnRightClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
     sSQL:WideString;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  SelectWorkerForm: TSelectWorkerForm;

implementation
uses uShowMessage,ServerDllPub, uLogin, UAppOption, uGlobal, uGridDecorator,uDictionary,StrUtils,frmOutRework;

{$R *.dfm}

procedure TSelectWorkerForm.FormCreate(Sender: TObject);
var
  sErrMsg:WideString;
  vData:Olevariant;
begin
   edtWorkers.Text:='';
   sSQL:= 'SELECT * FROM PUBDB.dbo.pbWorkerList where worker_group=''²ð¾í¹¤'' and is_active=1 and department= '+QuotedStr(login.CurrentDepartment);
    FNMServerObj.GetQueryBySQL(vData, sSQL, sErrMsg);
  if sErrMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg,mtError);
    Exit;
  end;
   cdsWorker.Data:=vData;
   TGlobal.FillItemsFromDataSet(cdsWorker, 'Worker_ID', 'Worker_Name', '->', lstWorker.Items);

end;

procedure TSelectWorkerForm.btn1Click(Sender: TObject);
var
  ssql1:WideString;
  FilterStr:string;
  sErrMsg:WideString;
  vData:Olevariant;
begin

   ssql1:=ssql+' and Worker_Name like ''%'+edtFilter.Text+'%''';
   FNMServerObj.GetQueryBySQL(vData, sSQL1, sErrMsg);
  if sErrMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg,mtError);
    Exit;
  end;
   cdsWorker.Data:=vData;
   TGlobal.FillItemsFromDataSet(cdsWorker, 'Worker_ID', 'Worker_Name', '->', lstWorker.Items);

   //cdsWorker.Filtered:=False;
   //cdsWorker.Filter:='worker_name like ''*2*'' ' ;  //'worker_name =' +QuotedStr(edtFilter.Text);
  // cdsWorker.Filtered:=True;
  // FilterStr := 'worker_name like ''%' +edtFilter.Text+'%''';
  // cdsWorker.Filtered:=True;
  // TGlobal.FilterData( cdsWorker,FilterStr);

end;

procedure TSelectWorkerForm.btnRightClick(Sender: TObject);
var
  worker:string;
begin
   Worker := LeftStr(lstWorker.Items[lstWorker.ItemIndex],7)+'('+MidStr(lstWorker.Items[lstWorker.ItemIndex],10,Length(lstWorker.Items[lstWorker.ItemIndex])-9)+')';
   if   lstWorkers.Items.IndexOf(worker)=-1 then
   begin
      edtWorkers.Text:=edtWorkers.Text+worker+',';
      //lstWorkers.AddItem(edt1.Text,);
      lstWorkers.Items.Add(worker);
   end;


end;

procedure TSelectWorkerForm.btnClearClick(Sender: TObject);
begin
   lstWorkers.Clear;
   edtWorkers.Text:='';
end;

procedure TSelectWorkerForm.btnSaveClick(Sender: TObject);
begin
    OutReworkFrom.workers:=edtWorkers.text;
    lstWorker.Clear;
    close;
end;

procedure TSelectWorkerForm.btn2Click(Sender: TObject);
var
   serrmsg:WideString;
   vdata:OleVariant;
begin
 FNMServerObj.GetQueryBySQL(vData, sSQL, sErrMsg);
  if sErrMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg,mtError);
    Exit;
  end;
   cdsWorker.Data:=vData;
   TGlobal.FillItemsFromDataSet(cdsWorker, 'Worker_ID', 'Worker_Name', '->', lstWorker.Items);
end;

procedure TSelectWorkerForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
          action:=caFree;
end;

procedure TSelectWorkerForm.FormDestroy(Sender: TObject);
begin
      SelectWorkerForm:=nil;
end;

end.

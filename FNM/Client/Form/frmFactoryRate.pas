unit frmFactoryRate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, DBCtrls, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  DBClient;

type
  TFactoryRateForm = class(TForm)
    pnl1: TPanel;
    pnl2: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    dbedtfactory: TDBEdit;
    dbedtrate: TDBEdit;
    btn1: TBitBtn;
    btn2: TBitBtn;
    cxGridFactoryRate: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cdsFactoryRate: TClientDataSet;
    dsFactoryRate: TDataSource;
    cxgrdbclmnID: TcxGridDBColumn;
    cxgrdbclmnGridFactoryRateDBColumn2: TcxGridDBColumn;
    cxgrdbclmnGridFactoryRateDBColumn3: TcxGridDBColumn;
    btnAdd: TBitBtn;
    btnDelete: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    procedure GetData;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FactoryRateForm: TFactoryRateForm;

implementation
uses StrUtils, Math, uAppOption, uGlobal, uShowMessage,
     ServerDllPub, uCADInfo, uDictionary, uLogin, uGridDecorator, frmAccident;
{$R *.dfm}

procedure TFactoryRateForm.FormShow(Sender: TObject);
begin
    GetData;
end;

procedure TFactoryRateForm.btn1Click(Sender: TObject);
var
  vData:OleVariant;
  sSQL,sErrMsg:WideString;
  a,b:string;
begin
   if TGlobal.DeltaIsNull(cdsFactoryRate) then Exit;
   //判断是否有空值
   with cdsFactoryRate do
   begin
        First;
        while not Eof do
        begin
          a:=FieldByName('factory').AsString;
          b:=FieldByName('rate').AsString;

          if  (FieldByName('factory').AsString='')  or
               (FieldByName('rate').AsString='')
          then
          begin
                ShowMessage('有空值，请先填入数据');
                exit;

          end;

           Next;
        end;

   end;

  vData := cdsFactoryRate.Delta;
  FNMServerObj.SaveBaseTableInfo(vData, 'fnFactoryRate', 'id',sErrMsg);
  if sErrMsg<>'' then
  begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
  end
  else
  begin
      GetData;
      TMsgDialog.ShowMsgDialog('数据更新成功!',mtInformation);
  end;


end;

procedure TFactoryRateForm.GetData;
var
  Sconditions:string;
  sql_text,sErrorMsg: WideString;
  vData:OleVariant;
  i:Integer;
begin
   sql_text:='exec USP_fnQueryForModifyFactory 7 ';   //加载数据

   FNMServerObj.GetQueryBySQL(vData,sql_text,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
   cdsFactoryRate.Data:=vData;
   GridDecorator.BindCxViewWithDataSource(cxGridFactoryRate, dsFactoryRate);
end;

procedure TFactoryRateForm.btn2Click(Sender: TObject);
begin
  close;
end;

procedure TFactoryRateForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action:=caFree;
end;

procedure TFactoryRateForm.FormDestroy(Sender: TObject);
begin
   FactoryRateForm:=nil;
end;

procedure TFactoryRateForm.btnAddClick(Sender: TObject);
begin
   cdsFactoryRate.Append;
   cdsFactoryRate.FieldByName('factory').AsString:='N/A ';
   cdsFactoryRate.FieldByName('rate').AsFloat:=1;
   cdsFactoryRate.Post;

end;

procedure TFactoryRateForm.btnDeleteClick(Sender: TObject);
begin
    cdsFactoryRate.Delete;
end;

end.

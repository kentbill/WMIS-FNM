unit frmScanInventory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, DBClient, ComCtrls,filectrl;

type
  TScanInventoryForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    edtFnCard: TEdit;
    Label1: TLabel;
    Button1: TButton;
    cdsCardInfo: TClientDataSet;
    dsCardInfo: TDataSource;
    cxGridJobTrace: TcxGrid;
    cxtvJobTrace: TcxGridDBTableView;
    cxGridJobTraceLevel1: TcxGridLevel;
    Button2: TButton;
    btnImport: TButton;
    btnSave: TButton;
    dlgOpen1: TOpenDialog;
    procedure edtFnCardChange(Sender: TObject);
    procedure LoadInfo();
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ScanInventoryForm: TScanInventoryForm;

implementation

uses ServerDllPub, uGlobal, uShowMessage, uLogin, uGridDecorator,uDictionary,StrUtils;

{$R *.dfm}

procedure TScanInventoryForm.edtFnCardChange(Sender: TObject);
begin
  if edtFnCard.Text = '' then
    Exit;
  LoadInfo;
  edtFnCard.Text := '';
end;

procedure TScanInventoryForm.LoadInfo();
var
  i:Integer;
  vData: OleVariant;
  sFNCard: string;
  sCondition,sErrorMsg: WideString;
begin
  cdsCardInfo.Filtered := False;
  sFNCard := edtFnCard.Text;
  sCondition := QuotedStr(sFNCard)+','+ QuotedStr(Login.CurrentDepartment)+',22';
  FNMServerObj.GetQueryData(vData,'GetJobTrace',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    Application.ShowException(Exception.Create(sErrorMsg));
    Exit;
  end;
  //cdsCardInfo.Data := vData;
  cdsCardInfo.AppendData(vData,True);
  GridDecorator.BindCxViewWithDataSource(cxtvJobTrace, dsCardInfo);
end;

procedure TScanInventoryForm.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TScanInventoryForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TScanInventoryForm.FormActivate(Sender: TObject);
begin
  edtFnCard.SetFocus;
  edtFnCard.AutoSelect := True;
end;

procedure TScanInventoryForm.Button2Click(Sender: TObject);
begin
  //cdsCardInfo.Filter := '1=2';
  //cdsCardInfo.Filtered := True;
  cdsCardInfo.Close;
  //GridDecorator.BindCxViewWithDataSource(cxtvJobTrace, dsCardInfo);
end;

procedure TScanInventoryForm.btnImportClick(Sender: TObject);
var
  path:string;
  strCont:TStringList;
  i:Integer;
  SearchRec:TSearchRec;
  found:integer;
  dict:string;
begin
  if selectdirectory('请指定文件夹','',dict) then
  begin
    dict := dict;
  end;

  found:=FindFirst(dict+'\*.txt',faAnyFile,SearchRec);
  while found=0 do
  begin
    if (SearchRec.Name<>'.') and (SearchRec.Name<>'..')
         and    (SearchRec.Attr<>faDirectory)    then
       //Memo1.Lines.Add(SearchRec.Name);

      strCont := TStringList.Create;
      try
        strCont.LoadFromFile(dict + '\' + SearchRec.Name);
        for i := 0 to strCont.Count - 1 do
        begin
          edtFnCard.Text := strCont[i];
        end;
      finally

      end;
      found:=FindNext(SearchRec);
  end;
  FindClose(SearchRec);


//  if dlgOpen1.Execute then
//  begin
//    path := dlgOpen1.FileName;
//    //TMsgdialog.ShowMsgDialog(path, mtInformation);
//    strCont := TStringList.Create;
//    try
//      strCont.LoadFromFile(path);
//      for i := 0 to strCont.Count - 1 do
//      begin
//        edtFnCard.Text := strCont[i];
//      end;
//    finally
//
//    end;
//
//  end;
end;

procedure TScanInventoryForm.btnSaveClick(Sender: TObject);
var
  sCondition,sErrorMsg: WideString;
  vData: OleVariant;
  sCard:string;
  i:Integer;
begin
  with cxtvJobTrace do
  begin
    DataController.SelectAll;

    for i:=0 to Controller.SelectedRowCount - 1 do
    begin
      sCard := Controller.SelectedRows[i].Values[GetColumnByFieldName('Fn_Card').index];
      sCondition := QuotedStr(sCard)+','+ QuotedStr(Login.CurrentDepartment)+',23';
      FNMServerObj.SaveDataBySQL('GetJobTrace',sCondition,sErrorMsg);
      if sErrorMsg <> '' then
      begin
        Application.ShowException(Exception.Create(sErrorMsg));
        Exit;
      end;
    end;

    TMsgDialog.ShowMsgDialog('保存数据成功!', mtInformation);
  end;
end;

end.

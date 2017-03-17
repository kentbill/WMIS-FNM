unit frmMutexChemical;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ValEdit, ComCtrls;

type
  TMutexChemicalkForm = class(TForm)
    btnRefresh: TButton;
    btnSave: TButton;
    btnClose: TButton;
    lvMutex: TListView;
    cbCHemical: TComboBox;
    cbMutex: TComboBox;
    btnDelete: TButton;
    btnAdd: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MutexChemicalkForm: TMutexChemicalkForm;

implementation

uses ServerDllPub, uGlobal, frmMain, uShowMessage, uLogin, uDictionary;

{$R *.dfm}

procedure TMutexChemicalkForm.FormCreate(Sender: TObject);
begin
  btnRefresh.Click;
end;

procedure TMutexChemicalkForm.FormDestroy(Sender: TObject);
begin
  MutexChemicalkForm := nil;
end;

procedure TMutexChemicalkForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TMutexChemicalkForm.btnRefreshClick(Sender: TObject);
begin
  Dictionary.cds_ChemicalList.Close;
  TGlobal.FillItemsFromDataSet(Dictionary.cds_ChemicalList, 'Chemical_ID', 'Chemical_Name', '->',cbCHemical.Items);
  cbMutex.Items := cbCHemical.Items;
  Dictionary.cds_ChemicalList.Close;
  with Dictionary.cds_MutexChemicalList do
  begin
    First;
    while not Eof do
    begin
      with lvMutex.Items.Add do
      begin
        Caption := FieldByName('Chemical_ID').AsString;
        SubItems.Add(FieldByName('Chemical_Name').AsString);
        SubItems.Add(FieldByName('Mutex_ID').AsString);
        SubItems.Add(FieldByName('Mutex_Name').AsString);
      end;
      Next;
    end;
    Close;
  end;
end;

procedure TMutexChemicalkForm.btnSaveClick(Sender: TObject);
var
  vData: OleVariant;
  iCount,i: Integer;
  sErrorMsg: WideString;
begin
  iCount := lvMutex.Items.Count;
  vData := VarArrayCreate([0, iCount-1], VarVariant);
  for i := 0 to iCount - 1 do
    vData[i] := varArrayOf([lvMutex.Items[i].Caption,lvMutex.Items[i].SubItems[1], Login.LoginName]);
  FNMServerObj.SaveMutexChemical(vData,iCount,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
end;

procedure TMutexChemicalkForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TMutexChemicalkForm.btnAddClick(Sender: TObject);
var
  i: Integer;
begin
  if (cbCHemical.Text = '') or (cbMutex.Text = '') then Exit;
  with lvMutex.Items.Add do
  begin
    i := Pos('->',cbCHemical.Text);
    Caption := Copy(cbCHemical.Text,1,i-1);
    SubItems.Add(Copy(cbCHemical.Text,i+2,Length(cbCHemical.Text)-i-2));
    i := Pos('->',cbMutex.Text);
    SubItems.Add(Copy(cbMutex.Text,1,i-1));
    SubItems.Add(Copy(cbMutex.Text,i+2,Length(cbMutex.Text)-i-2));
  end;
end;

procedure TMutexChemicalkForm.btnDeleteClick(Sender: TObject);
begin
  if lvMutex.Selected <> nil then
    lvMutex.DeleteSelected;
end;

end.

unit frmReceiveBenchMark;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ValEdit;

type
  TReceiveBenchMarkForm = class(TForm)
    GFTypeEditor: TValueListEditor;
    btnRefresh: TButton;
    btnSave: TButton;
    btnClose: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure GFTypeEditorValidate(Sender: TObject; ACol, ARow: Integer;
      const KeyName, KeyValue: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReceiveBenchMarkForm: TReceiveBenchMarkForm;

implementation

uses ServerDllPub, uGlobal, frmMain, uShowMessage, uLogin, uDictionary;

{$R *.dfm}

procedure TReceiveBenchMarkForm.FormCreate(Sender: TObject);
begin
  Dictionary.cds_ReceiveBenchMarkList.Close;
  TGlobal.FillItemsFromDataSet(Dictionary.cds_ReceiveBenchMarkList, 'GF_Type', 'Quantity', '=', GFtYPEEditor.Strings);
end;

procedure TReceiveBenchMarkForm.FormDestroy(Sender: TObject);
begin
  ReceiveBenchMarkForm := nil;
end;

procedure TReceiveBenchMarkForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TReceiveBenchMarkForm.btnRefreshClick(Sender: TObject);
begin
  Dictionary.cds_ReceiveBenchMarkList.Close;
  TGlobal.FillItemsFromDataSet(Dictionary.cds_ReceiveBenchMarkList, 'GF_Type', 'Quantity', '=', GFTypeEditor.Strings);
end;

procedure TReceiveBenchMarkForm.btnSaveClick(Sender: TObject);
var
  vData: OleVariant;
  iCount,i: Integer;
  sErrorMsg: WideString;
begin
  iCount := GFTypeEditor.RowCount - 1;
  vData := VarArrayCreate([0, iCount-1], VarVariant);
  for i := 0 to iCount - 1 do
    vData[i] := varArrayOf([GFTypeEditor.Strings[i],Login.LoginName]);
  FNMServerObj.SaveReceiveBenchMark(vData,iCount,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
end;

procedure TReceiveBenchMarkForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TReceiveBenchMarkForm.GFTypeEditorValidate(Sender: TObject; ACol,
  ARow: Integer; const KeyName, KeyValue: String);
begin
  TGlobal.CheckValueIsNumeric(KeyValue,'请输入数字');
end;

end.

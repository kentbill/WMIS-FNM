unit frmCreateAffirmHand;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,StrUtils;

type
  TCreateAffirmHandForm = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edtGFNO: TEdit;
    Label2: TLabel;
    edtStepNO: TEdit;
    Label3: TLabel;
    cboOperationCode: TComboBox;
    Label4: TLabel;
    memoPrevent: TMemo;
    GroupBox2: TGroupBox;
    btnSave: TButton;
    btnClose: TButton;
    procedure FormCreate(Sender: TObject);
    procedure INIControl();
    procedure btnSaveClick(Sender: TObject);
    procedure SaveAffrimByHand();
    procedure btnCloseClick(Sender: TObject);
    procedure edtStepNOChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CreateAffirmHandForm: TCreateAffirmHandForm;

implementation

uses  cxGridDBDataDefinitions, uFNMArtInfo,uDictionary, UAppOption,
    uFNMResource, ServerDllPub, uShowMessage, uLogin, uGlobal,
    UGridDecorator, uCADInfo, frmInput, frmCheckArt;

{$R *.dfm}

procedure TCreateAffirmHandForm.FormCreate(Sender: TObject);
begin
  INIControl();
end;

procedure TCreateAffirmHandForm.INIControl();
begin
  with Dictionary.cds_OperationHdrList do
  try
//    Filter:='Operation_Type = ''Art_Dip''';
//    Filtered:=true;
    FillItemsFromDataSet(Dictionary.cds_OperationHdrList, 'Operation_Code', 'Operation_CHN', '','-', cboOperationCode.Items);
  finally
    Filtered:=false;
  end;
end;

procedure TCreateAffirmHandForm.btnSaveClick(Sender: TObject);
begin
  SaveAffrimByHand();
end;

procedure TCreateAffirmHandForm.SaveAffrimByHand();
var
  vData: OleVariant;
  sSQL, sErrMsg: WideString;
begin
  sSQL := QuotedStr(edtGFNO.Text) + ',' +
          edtStepNO.Text + ',' +
          QuotedStr(LeftStr(cboOperationCode.Text,3)) + ',' +
          QuotedStr(memoPrevent.Lines.Text) + ',' +
          QuotedStr(login.CurrentDepartment) + ',1' ;

  FNMServerObj.SaveDataBySQL('SaveAffrimbyHand',sSQL,sErrMsg);
  if sErrMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg,mtWarning);
    Exit;
  end;
  TMsgDialog.ShowMsgDialog('添加成功！',mtInformation);
end;

procedure TCreateAffirmHandForm.btnCloseClick(Sender: TObject);
begin
  CreateAffirmHandForm.Close;
  CreateAffirmHandForm := nil;
end;

procedure TCreateAffirmHandForm.edtStepNOChange(Sender: TObject);
var
  i:Integer;
begin
  if not TryStrToInt(edtStepNO.Text,i) then
  begin
     ShowMessage('步骤必须是数字！');
     btnSave.Enabled := False;
  end
  else
  begin
     btnSave.Enabled := True;
  end;
end;

end.

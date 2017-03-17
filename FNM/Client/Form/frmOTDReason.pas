unit frmOTDReason;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Buttons, ExtCtrls, StdCtrls;

type
  TOTDReasonForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    sbAdd: TSpeedButton;
    sbEdit: TSpeedButton;
    sbDelete: TSpeedButton;
    sbSave: TSpeedButton;
    edtFirstReason: TEdit;
    edtSecondReason: TEdit;
    edtThirdReason: TEdit;
    edtFourReason: TEdit;
    edtRemark: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lvDetail: TListView;
    procedure lvDetailChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure sbAddClick(Sender: TObject);
    procedure sbEditClick(Sender: TObject);
    procedure sbDeleteClick(Sender: TObject);
    procedure sbSaveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    IsNew : Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OTDReasonForm: TOTDReasonForm;

implementation

uses cxDropDownEdit, uDictionary, ServerDllPub, uGlobal, uLogin, UGridDecorator, uShowMessage, uFNMArtInfo, StrUtils;

{$R *.dfm}

procedure TOTDReasonForm.lvDetailChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  if lvDetail.ItemIndex = -1 then Exit;
  IsNew := False;
  edtFirstReason.Enabled := False;
  edtSecondReason.Enabled := False;
  edtThirdReason.Enabled := False;
  edtFourReason.Enabled := False;
  edtRemark.Enabled := False;

  sbAdd.Enabled := True;
  sbEdit.Enabled := True;
  sbDelete.Enabled := True;
  sbSave.Enabled := False;


  edtFirstReason.Text := lvDetail.Selected.SubItems[0];
  edtSecondReason.Text := lvDetail.Selected.SubItems[1];
  edtThirdReason.Text := lvDetail.Selected.SubItems[2];
  edtFourReason.Text := lvDetail.Selected.SubItems[3];
  edtRemark.Text := lvDetail.Selected.SubItems[4];
end;

procedure TOTDReasonForm.sbAddClick(Sender: TObject);
begin
  IsNew := True;
  edtFirstReason.Enabled := sbAdd.Caption = '新增';
  edtSecondReason.Enabled := sbAdd.Caption = '新增';
  edtThirdReason.Enabled := sbAdd.Caption = '新增';
  edtFourReason.Enabled := sbAdd.Caption = '新增';
  edtRemark.Enabled := sbAdd.Caption = '新增';
  edtFirstReason.Clear;
  edtSecondReason.Clear;
  edtThirdReason.Clear;
  edtFourReason.Clear;
  edtRemark.Clear;

  lvDetail.Enabled := sbAdd.Caption = '放弃';
  sbEdit.Enabled := sbAdd.Caption = '放弃';
  sbDelete.Enabled := sbAdd.Caption = '放弃';
  sbSave.Enabled :=  sbAdd.Caption = '新增';
  if sbAdd.Caption = '放弃' then
    sbAdd.Caption := '新增'
  else
    sbAdd.Caption := '放弃';
end;

procedure TOTDReasonForm.sbEditClick(Sender: TObject);
begin
  IsNew := False;
  edtFirstReason.Enabled := sbEdit.Caption = '编辑';
  edtSecondReason.Enabled := sbEdit.Caption = '编辑';
  edtThirdReason.Enabled := sbEdit.Caption = '编辑';
  edtFourReason.Enabled := sbEdit.Caption = '编辑';
  edtRemark.Enabled := sbEdit.Caption = '编辑';

  lvDetail.Enabled := sbEdit.Caption = '放弃';
  sbAdd.Enabled := sbEdit.Caption = '放弃';
  sbDelete.Enabled := sbEdit.Caption = '放弃';
  sbSave.Enabled := sbEdit.Caption = '编辑';
  if sbEdit.Caption = '放弃' then
    sbEdit.Caption := '编辑'
  else
    sbEdit.Caption := '放弃';
end;

procedure TOTDReasonForm.sbDeleteClick(Sender: TObject);
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  if lvDetail.SelCount = 0  then Exit;
  if MessageDlg('你确认要删除此条回修原因明细记录吗?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在删除数据稍等！', crHourGlass);
    vData := VarArrayCreate([0, 1], VarVariant);
    vData[0] := varArrayOf([lvDetail.Selected.Caption]);
    FNMServerObj.SaveOTDReason(vData,2,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    lvDetail.DeleteSelected;
    TMsgDialog.ShowMsgDialog('删除数据成功',mtInformation);
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('', crDefault);
  end;
end;

procedure TOTDReasonForm.sbSaveClick(Sender: TObject);
var
  vData: OleVariant;
  sErrorMsg: WideString;
  iType : Integer;
begin
  vData := VarArrayCreate([0, 1], VarVariant);
  if IsNew then
  begin
    iType := 0;
    vData[0] := varArrayOf(['0',
                            edtFirstReason.Text,
                            edtSecondReason.Text,
                            edtThirdReason.Text,
                            edtFourReason.Text,
                            edtRemark.Text,
                            Login.LoginName]);
  end else
  begin
    iType := 1;
    vData[0] := varArrayOf([lvDetail.Selected.Caption,
                            edtFirstReason.Text,
                            edtSecondReason.Text,
                            edtThirdReason.Text,
                            edtFourReason.Text,
                            edtRemark.Text,
                            Login.LoginName]);
  end;
  FNMServerObj.SaveOTDReason(vData,iType,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;

  if IsNew then
  begin
    with lvDetail.Items.Add do
    begin
      Caption := '0';
      SubItems.Add(edtFirstReason.Text);
      SubItems.Add(edtSecondReason.Text);
      SubItems.Add(edtThirdReason.Text);
      SubItems.Add(edtFourReason.Text);
      SubItems.Add(edtRemark.Text);
    end;
  end else
  begin
    with lvDetail.Selected do
    begin
      SubItems[0] := edtFirstReason.Text;
      SubItems[1] := edtSecondReason.Text;
      SubItems[2] := edtThirdReason.Text;
      SubItems[3] := edtFourReason.Text;
      SubItems[4] := edtRemark.Text;
    end;
  end;
  edtFirstReason.Enabled := False;
  edtSecondReason.Enabled := False;
  edtThirdReason.Enabled := False;
  edtFourReason.Enabled := False;
  edtRemark.Enabled := False;
  sbAdd.Caption := '新增';
  sbAdd.Enabled := True;
  sbEdit.Caption := '编辑';
  sbEdit.Enabled := True;
  sbDelete.Enabled := True;
  lvDetail.Enabled := True;
  sbSave.Enabled := False;
  TMsgDialog.ShowMsgDialog('保存数据成功', mtInformation);
end;

procedure TOTDReasonForm.FormActivate(Sender: TObject);
begin
 with Dictionary.cds_OTDReasonList do
  begin
    Filtered := False;
    First;
    while not Eof do
    begin
      with lvDetail.Items.Add do
      begin
        Caption := FieldByName('Iden').AsString;
        SubItems.Add(FieldByName('First_Reason').AsString);
        SubItems.Add(FieldByName('Second_Reason').AsString);
        SubItems.Add(FieldByName('Third_Reason').AsString);
        SubItems.Add(FieldByName('Four_Reason').AsString);
        SubItems.Add(FieldByName('Remark').AsString);
      end;
      Next;
    end;
  end;
  edtFirstReason.Enabled := False;
  edtSecondReason.Enabled := False;
  edtThirdReason.Enabled := False;
  edtFourReason.Enabled := False;
  edtRemark.Enabled := False;
  sbSave.Enabled := False;
end;

procedure TOTDReasonForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TOTDReasonForm.FormDestroy(Sender: TObject);
begin
  OTDReasonForm := nil;
end;

end.

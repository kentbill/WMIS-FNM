unit frmAutoPlanShift;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxCheckComboBox, cxListBox, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, DB, DBClient, StdCtrls, ExtCtrls,
  Buttons;

type
  TAutoPlanShiftForm = class(TForm)
    cdsMachines: TClientDataSet;
    cdsItems: TClientDataSet;
    cdsType: TClientDataSet;
    cdsSave: TClientDataSet;
    pnlBtton: TPanel;
    btnSave: TBitBtn;
    btnCancel: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure DataQuery;
    procedure DataSave;
    procedure cbbChange(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sMachineType:String;
    procedure GetAutoPlanShift(sType:String);
  end;

var
  AutoPlanShiftForm: TAutoPlanShiftForm;

implementation

uses ServerDllPub, uLogin, uShowMessage, uGlobal, uGridDecorator, uFNMArtInfo;

{$R *.dfm}

procedure TAutoPlanShiftForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin 
  if ModalResult = mrOk then
    DataSave;
    
  Action := caFree;
end;

procedure TAutoPlanShiftForm.FormDestroy(Sender: TObject);
begin
  AutoPlanShiftForm := nil;
end;

procedure TAutoPlanShiftForm.DataQuery;
var     
  pnl: TPanel;
  lbl: TLabel;
  cbb: TComboBox;
  iWidth, iHeight, iRecordCount, iP, iC, pT: Integer;
  sName:String;

  vData:OleVariant;
  sDept, sType, sSQL,sErrMsg:WideString;
begin
  sDept := Login.CurrentDepartment;
  sSQL := QuotedStr('fnAutoPlanMachineShift')+',' + QuotedStr(sDept)+ ','+ QuotedStr(sMachineType);

  sType := sSQL+','+ QuotedStr('保存');
  FNMServerObj.GetQueryData(vData,'CommonSQL',sType, sErrMsg);
  if sErrMsg<>'' then
  begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
  end;
  cdsSave.Data := vData;
  if cdsSave.IsEmpty then
  begin
    close;
    Exit;
  end;

  sType := sSQL+','+ QuotedStr('机台');
  FNMServerObj.GetQueryData(vData,'CommonSQL',sType, sErrMsg);
  if sErrMsg<>'' then
  begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
  end;
  cdsMachines.Data := vData;
  if cdsMachines.IsEmpty then
  begin
    close;
    Exit;
  end;

  //设Form高
  iWidth := 480;
  iHeight := 240;

  iRecordCount := cdsMachines.RecordCount;
  if iHeight< iRecordCount*80 then
    AutoPlanShiftForm.Height := iRecordCount*80;

  iRecordCount := 0;
  cdsMachines.First;
  pT := 0;   //Panel的Top
  iP := 0;   //Panel的个数
  while not cdsMachines.Eof do
  begin
    sName := 'pnl'+ FloatToStr(iP);

    pnl := TPanel.Create(Self);
    pnl.Parent := AutoPlanShiftForm;
    pnl.Height := 33;
    pnl.Top := pT;
    pnl.BevelInner := bvLowered;
    pnl.BevelOuter := bvRaised;
    pnl.Align := alTop;
    pnl.Name := sName;
    pnl.Caption := '';
    
    lbl := TLabel.Create(Self);
    lbl.Parent := pnl;
    lbl.Name := 'pnl'+FloatToStr(iP)+'lbl0';
    lbl.Font.Style :=  [fsBold];
    lbl.Font.Size := 10;
    lbl.Left := 8;
    lbl.Top := 9;
    lbl.Caption := cdsMachines.FieldByName('Machine_ID').AsString;

    iC := 1; //Panel中下拉框的个数
    sType := sSQL+','+ QuotedStr('类型')+ ','+ QuotedStr(cdsMachines.FieldByName('Machine_ID').AsString);
    FNMServerObj.GetQueryData(vData,'CommonSQL',sType, sErrMsg);
    if sErrMsg<>'' then
    begin
        TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
        Exit;
    end;
    cdsType.Data := vData;
    if cdsType.IsEmpty then Exit;

    //设Form宽
    if iRecordCount < cdsType.RecordCount then
    begin
      iRecordCount := cdsType.RecordCount;
      if iWidth< iRecordCount*200 then
        AutoPlanShiftForm.Width := iRecordCount*200;
    end;

    cdsType.First;
    while not cdsType.Eof do
    begin
      sName := 'pnl'+FloatToStr(iP)+'lbl'+FloatToStr(iC);

      //类型
      lbl := TLabel.Create(Self);
      lbl.Parent := pnl;
      lbl.Name := sName;
      lbl.Left := 60+(iC-1)*180;
      lbl.Top := 11;
      lbl.Caption := cdsType.FieldByName('sType').AsString;

      //类型列表
      sName := 'pnl'+FloatToStr(iP)+'cbb'+FloatToStr(iC);
      cbb := TComboBox.Create(Self);
      cbb.Parent := pnl;
      cbb.Name := sName;
      cbb.Style := csDropDownList;
      cbb.Left := 100+(iC-1)*180;
      cbb.Top := 7;
      cbb.Width := 105;

      sType := sSQL+','+QuotedStr(cdsType.FieldByName('sType').AsString)+ ','+ QuotedStr(cdsMachines.FieldByName('Machine_ID').AsString);
      FNMServerObj.GetQueryData(vData,'CommonSQL',sType, sErrMsg);
      if sErrMsg<>'' then
      begin
          TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
          Exit;
      end;
      cdsItems.Data := vData;
      if cdsItems.IsEmpty then Exit;

      //填充下拉列表
      FillItemsFromDataSet(cdsItems,'sValue','','','',cbb.Items);
      cbb.Items.Add('');

      //选择原来的值
{
      cdsItems.First;
      while not cdsItems.Eof do
      begin
        if cdsItems.FieldByName('Is_Active').AsBoolean= True then
        begin
          cbb.ItemIndex := cbb.Items.IndexOf(cdsItems.FieldByName('sValue').AsString);
          Break;
        end;
        cdsItems.Next;
      end;
}

      if cdsItems.Locate('Is_Active','1',[]) then
        cbb.ItemIndex := cbb.Items.IndexOf(cdsItems.FieldByName('sValue').AsString);

      cbb.OnChange := cbbChange;

      iC := iC+ 1;
      cdsType.Next;
    end;

    iP := iP+ 1;
    pT := pT+ iP*33;
    cdsMachines.Next;
  end;
  ShowModal;
end;

procedure TAutoPlanShiftForm.DataSave;   
var
  vData:OleVariant;
  sSQL,sErrMsg:WideString;
begin
  if TGlobal.DeltaIsNull(cdsSave) then Exit;
  vData := cdsSave.Delta;
  FNMServerObj.SaveBaseTableInfo(vData, 'fnAutoPlanMachineShift', 'Dept,Machine_ID,sType,sValue',sErrMsg);
  if sErrMsg<>'' then
  begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
  end;
  cdsSave.MergeChangeLog;
end;

procedure TAutoPlanShiftForm.cbbChange(Sender: TObject);
var
  sSQL, sDept, sMachineID, sName, sType, sValue:String;
begin
  sDept := login.CurrentDepartment;
  sName := TComboBox(Sender).Parent.Name+ 'lbl0';
  sMachineID := TLabel(FindComponent(sName)).Caption;
  sName := TComboBox(Sender).Name;
  sName := StringReplace(sName, 'cbb','lbl',[rfReplaceAll]);
  sType := TLabel(FindComponent(sName)).Caption;
  sValue := TComboBox(Sender).Text;
  if pos('->',sValue)>0 then
    sValue := copy(sValue,0, pos('->',sValue)-1);

  cdsSave.DisableControls;
  try
    with cdsSave do
    begin
      // 配方单独处理
      if sType = '配方' then
      begin
        sType := '工序';
        if Locate('Dept;Machine_ID;sType;Is_Active',VarArrayOf([sDept,sMachineID,sType,'1']),[]) then
        begin
          Edit;
          FieldByName('Recipe').AsString := sValue;
          Post;
        end;
      end
      else
      begin
        //与原来的值一样，不用改
        if Locate('Dept;Machine_ID;sType;sValue;Is_Active',VarArrayOf([sDept,sMachineID,sType,sValue,'1']),[]) then
          Exit
        else
        begin
          if Locate('Dept;Machine_ID;sType;Is_Active',VarArrayOf([sDept,sMachineID,sType,'1']),[]) then
          begin
            Edit;
            FieldByName('Is_Active').AsString := '0';
            Post;
          end;

          if Locate('Dept;Machine_ID;sType;sValue',VarArrayOf([sDept,sMachineID,sType,sValue]),[]) then
          begin
            Edit;
            FieldByName('Is_Active').AsString := '1';
            Post;
          end
        end;
      end;
    end
  finally
    cdsSave.EnableControls;
  end;
end;

procedure TAutoPlanShiftForm.btnSaveClick(Sender: TObject);
begin
  DataSave;
end;

procedure TAutoPlanShiftForm.GetAutoPlanShift(sType: String);
begin
  sMachineType := sType;     
  DataQuery;
end;

end.

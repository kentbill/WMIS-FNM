unit frmWeigh;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, ExtCtrls, StdCtrls, ComCtrls, Buttons, OleCtrls,
  MSCommLib_TLB, Gauges, DB, DBClient,StrUtils, QuickRpt, QRCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid;

type
  TWeighForm = class(TBaseForm)
    nbWeigh: TNotebook;
    lvOption: TListView;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edtName: TEdit;
    Label4: TLabel;
    cbbPort: TComboBox;
    Label5: TLabel;
    cbbTransSpeed: TComboBox;
    Label2: TLabel;
    cbbDataBit: TComboBox;
    Label3: TLabel;
    cbbParity: TComboBox;
    Label6: TLabel;
    cbbStopBit: TComboBox;
    Label7: TLabel;
    edtMinValue: TEdit;
    edtmaxValue: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    edtPrecent: TEdit;               
    btnAdd: TBitBtn;
    btnSave: TBitBtn;
    btnBack: TBitBtn;
    pnlChemical: TPanel;
    btnTest: TBitBtn;
    Gauge1: TGauge;
    lvChemical: TListView;
    Panel1: TPanel;
    Label12: TLabel;
    edtBillNO: TEdit;
    btnQuery: TBitBtn;
    GroupBox2: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    edtBatchNO: TEdit;
    edtMachineID: TEdit;
    edtWeight: TEdit;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    btnExit: TBitBtn;
    btnWeigh: TBitBtn;
    btnOption: TBitBtn;
    Label18: TLabel;
    edtFactWeight: TEdit;
    cdsWeigh: TClientDataSet;
    TimerWeigh: TTimer;
    btnDel: TBitBtn;
    edtUnit: TEdit;
    rptWeigh: TQuickRep;
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    qrdbt8: TQRDBText;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRSysData1: TQRSysData;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    btnPrint: TBitBtn;
    pnlCaption: TPanel;
    Panel5: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    lbUnit: TLabel;
    lbFactUnit: TLabel;
    pnlWeight: TPanel;
    pnlFactWeight: TPanel;
    DateTimePicker1: TDateTimePicker;
    QRShape1: TQRShape;
    QRDBText7: TQRDBText;
    QRShape2: TQRShape;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    lbbarChemicalID: TLabel;
    lbbarChemicalName: TLabel;
    edtbarcode: TEdit;
    Panel2: TPanel;
    btnOK: TBitBtn;
    btnHandle: TBitBtn;
    btnCancel: TBitBtn;
    sbCancel: TSpeedButton;
    msComm: TMSComm;
    edtChemicalID: TEdit;
    edtChemicalName: TEdit;
    cbCanBarcode: TCheckBox;
    Label22: TLabel;
    Edit1: TEdit;
    cboINI: TComboBox;
    cxgridOnline: TcxGrid;
    cxGridVOnline: TcxGridDBTableView;
    cxGridlOnline: TcxGridLevel;
    cdsOnline: TClientDataSet;
    dsOnline: TDataSource;
    BitBtn1: TBitBtn;
    dsWeigh: TDataSource;
    lbBarcode: TLabel;
    procedure btnAddClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure btnWeighClick(Sender: TObject);
    procedure lvChemicalKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvChemicalDblClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure lvChemicalChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOptionClick(Sender: TObject);
    procedure lvOptionChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure TimerWeighTimer(Sender: TObject);
    procedure cbbChemicalIDChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbbChemicalNameChange(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure edtbarcodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnHandleClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sbCancelClick(Sender: TObject);
    procedure edtbarcodeKeyPress(Sender: TObject; var Key: Char);
    procedure cboINIChange(Sender: TObject);
    procedure lvChemicalClick(Sender: TObject);
    procedure LoadIni();
    procedure QueryOnlineCard();
    procedure BitBtn1Click(Sender: TObject);
    procedure cxGridVOnlineDblClick(Sender: TObject);
    procedure cxGridVOnlineCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    Path: string;
    strList: TStringList;
    sRecipe_no: string;
    sOperator:string;
    function GetWeight: string;
    function GetWeightByLittle:string;
    procedure Weight;
    function GetPortAndSetting(Weight:Extended;var Port:Integer; var Settting:string;var Precent:string):Boolean;
    procedure GetDetail(Recipe_NO:string;Batch_NO:string);
  protected
    procedure UpdateActions; override;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WeighForm: TWeighForm;

implementation

uses ServerDllPub, frmWeighSelect,uShowMessage,uLogin,UGridDecorator;

{$R *.dfm}

function CheckValueIsNumeric(sValue: string): Boolean;
begin
  try
    strtofloat(sValue);
    result := true;
  except
    result := false;
  end;
end;

function TWeighForm.GetWeight: string;
var
  i ,iBegin,iEnd,times: Integer;
  RecMsg,strB,strE: string;
  isBegin :Boolean ;
begin
  Result := '0.0';
  if not msComm.PortOpen then Exit;
  isBegin := False;
  RecMsg := Trim(msComm.Input);
  //showmessage(RecMsg + msComm.Settings);

  //Result := RecMsg;
  strList.Clear;
  strList.Text := RecMsg;
  times := 1;

//  //取第一组 数字
//  for i := 0  to Length(RecMsg)-1  do
//  begin
//    if (MidStr(RecMsg,i,1)>='0') and (MidStr(RecMsg,i,1)<='9') then
//    begin
//      if not isBegin then
//      begin
//        iBegin := i;
//        strB := MidStr(RecMsg,i,1);
//        isBegin := True;
//      end;
//    end
//    else
//    begin
//      if isBegin then
//      begin
//        iEnd := i;
//        strE := MidStr(RecMsg,i,1);
//        Break;
//      end;
//    end;
//  end;

  //取第二组 数字
  for i := 0  to Length(RecMsg)-1  do
  begin
    if (MidStr(RecMsg,i,1)>='0') and (MidStr(RecMsg,i,1)<='9') then
    begin
      if isBegin then
      begin
        iBegin := i;
        strB := MidStr(RecMsg,i,1);
        isBegin := False;
        times := 2;
      end;
    end
    else
    begin
      isBegin := True;
      if isBegin and (times = 2) then
      begin
        iEnd := i;
        strE := MidStr(RecMsg,i,1);
        Break;
      end;
    end;
  end;
  //showmessage(IntToStr(iBegin) + ';' + IntToStr(iEnd));
  Result := MidStr(RecMsg,iBegin,iEnd-iBegin);
  //Label11.Caption := Result;
  if Result = '' then Result := '-1';
  if (Pos(chr(3),Result) > 0) or (Pos(chr(4),Result) > 0) then
    Result := '-1'
  else
  begin
    Result := LeftStr(Result,6);
    if not CheckValueIsNumeric(Result) then
      Result := '-1'
  end;

//  else
    //Result := '' + chr(3) ;

//  for i := 0  to Length(Result) - 1  do
//  begin
//    Result := Result + ';' + IntToStr(Ord(result[i + 1]));
//  end;

//  for i := 0  to Length(Result)-1  do
//  begin
//    Result := Result + ';' + IntToStr(Ord(Result[i])) ;
//  end;
//  if strList.Count = 0 then
//  begin
//    Result :='0.0';
//    Exit;
//  end;
//  Result := strList.Strings[0];
//  for i := 0  to Length(Result)-1  do
//  begin
//    if (Result[i]>='0') and (Result[i]<='9') or (Result[i]='-') then
//    begin
//       Result := Trim(Copy(Result,i,Length(Result)));
//       break;
//    end;
//  end;
//  Result :=  StringReplace(Result,'-','',[rfReplaceAll, rfIgnoreCase]);
//  Result :=  StringReplace(Result,'g','',[rfReplaceAll, rfIgnoreCase]);
//  Result :=  StringReplace(Result,'s','',[rfReplaceAll, rfIgnoreCase]);
//  Result :=  StringReplace(Result,'k','',[rfReplaceAll, rfIgnoreCase]);
//  Result := Trim(Result);
//  if Result = '' then
//    Result := '0.0';
//  if not CheckValueIsNumeric(Result) then
//    Result := '0.0'
end;


function TWeighForm.GetWeightByLittle: string;
var
  i ,iEnd,times: Integer;
  RecMsg,strB,strE: string;
begin
  Result := '0.0';
  if not msComm.PortOpen then Exit;
  RecMsg := Trim(msComm.Input);
  //Result := RecMsg;
  strList.Clear;
  strList.Text := RecMsg;

  if strList.Count = 0 then
  begin
    Result :='0.0';
    Exit;
  end;
  Result := strList.Strings[0];
  for i := 0  to Length(Result)-1  do
  begin
    if (Result[i]>='0') and (Result[i]<='9') or (Result[i]='-') then
    begin
       Result := Trim(Copy(Result,i,Length(Result)));
       break;
    end;
  end;
  Result :=  StringReplace(Result,'-','',[rfReplaceAll, rfIgnoreCase]);
  Result :=  StringReplace(Result,'g','',[rfReplaceAll, rfIgnoreCase]);
  Result :=  StringReplace(Result,'s','',[rfReplaceAll, rfIgnoreCase]);
  Result :=  StringReplace(Result,'k','',[rfReplaceAll, rfIgnoreCase]);
  Result := Trim(Result);
  if Result = '' then
    Result := '0.0';
  if not CheckValueIsNumeric(Result) then
    Result := '0.0';

end;

procedure TWeighForm.FormCreate(Sender: TObject);
var i:Integer;
begin
  inherited;
  DateTimePicker1.DateTime := Now;
  nbWeigh.ActivePage := 'Main';
  strList := TStringList.Create;
  Path := ExtractFileDir(Application.ExeName);
  if FileExists(Path+'\Com.ini') then
  begin
    strList.LoadFromFile(Path+'\Com.ini');
    cbCanBarcode.Checked := False;
    lvOption.Items.Clear;
    for i := 0 to strList.Count-1 do
    begin
      cboINI.Items.Add(Copy(strList.Strings[i],1,pos(char(9),strList.Strings[i])-1));
      if Pos('CanBarcode', strList.Strings[i])>0 then
        cbCanBarcode.Checked := True
      else
      begin
        with lvOption.Items.Add do
        begin
          Caption := Copy(strList.Strings[i],1,pos(char(9),strList.Strings[i])-1);
          SubItems.Delimiter := char(9);
          SubItems.DelimitedText := Copy(strList.Strings[i],pos(char(9),strList.Strings[i])+1,200);
        end;
      end;  
    end;
  end;
  cboINI.ItemIndex := 0;
  if cboINI.Text <> '' then
    LoadIni;
  TimerWeigh.Enabled := False;

  QueryOnlineCard;

  //GetChemicalName(cbbChemicalID, cbbChemicalName, 'D');
  //cbbChemicalID.ItemIndex := -1;
  //cbbChemicalName.ItemIndex := -1;
end;

procedure TWeighForm.QueryOnlineCard();
var
  vData: olevariant;
  sErrorMsg, sCondition: widestring;
begin
    sCondition := QuotedStr('') + ',1,2';
    FNMServerObj.GetQueryData(vData,'GetWeighData',sCondition,sErrorMsg);
    cdsOnline.Data := vData;
    GridDecorator.BindCxViewWithDataSource(cxgridVOnline, dsOnline,True);
end;


procedure TWeighForm.FormDestroy(Sender: TObject);
begin
  inherited;
  WeighForm := nil;
  if msComm.PortOpen then
    msComm.PortOpen := False;
  FreeAndNil(strList);
end;

procedure TWeighForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

//*************Option Begin*******************
procedure TWeighForm.btnAddClick(Sender: TObject);
begin
  inherited;
  btnSave.Tag := 0;
  edtName.Text := '';
  cbbPort.ItemIndex :=0;
  cbbTransSpeed.ItemIndex :=0;
  cbbDataBit.ItemIndex :=0;
  cbbParity.ItemIndex :=0;
  cbbStopBit.ItemIndex :=0;
  edtMinValue.Text := '0';
  edtMaxValue.Text := '1000';
  edtPrecent.Text := '0.3';
  edtName.SetFocus;
end;

procedure TWeighForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  if btnSave.Tag = 0 then
  begin
    with lvOption.Items.Add do
    begin
      Caption := edtName.Text;
      SubItems.Add(cbbPort.Text);
      SubItems.Add(cbbTransSpeed.Text);
      SubItems.Add(cbbDataBit.Text);
      SubItems.Add(cbbParity.Text);
      SubItems.Add(cbbStopBit.Text);
      SubItems.Add(edtMinValue.Text);
      SubItems.Add(edtMaxValue.Text);
      SubItems.Add(edtPrecent.Text);
    end;
  end else
  begin
     with lvOption.Selected do
     begin
      Caption := edtName.Text;
      SubItems[0] := cbbPort.Text;
      SubItems[1] := cbbTransSpeed.Text;
      SubItems[2] := cbbDataBit.Text;
      SubItems[3] := cbbParity.Text;
      SubItems[4] := cbbStopBit.Text;
      SubItems[5] := edtMinValue.Text;
      SubItems[6] := edtMaxValue.Text;
      SubItems[7] := edtPrecent.Text;
    end;
  end;
end;

procedure TWeighForm.btnTestClick(Sender: TObject);
begin
  inherited;
  try
    with msComm do
    begin
      if PortOpen then
        PortOpen := False;

//      msComm.CommPort := 1;
//      msComm.Settings := '1200,n,6,1';
//      msComm.PortOpen := True;

      LoadIni;
     
      //ShowMessage(IntToStr(cbbPort.ItemIndex+2) + ';' + cbbTransSpeed.Text+ ';'+',n,'+cbbDataBit.Text+ ';'+','+cbbStopBit.Text+ ';' + GetWeight);
    end;
    MessageBox(Handle, PChar(cbbPort.Text+' 端口打开成功!'), '端口测试', MB_OK + MB_ICONINFORMATION);
  except
    on e:Exception do
      MessageBox(Handle,PChar(cbbPort.Text+' 端口打开失败!'+#13#10+e.Message), '端口测试', MB_OK + MB_ICONSTOP);
  end;
end;

procedure TWeighForm.btnDelClick(Sender: TObject);
begin
  inherited;
  lvOption.DeleteSelected;
end;

procedure TWeighForm.btnBackClick(Sender: TObject);
var
  i: Integer;
  Line: string;
begin
  inherited;
  nbWeigh.ActivePage := 'Main';
  if lvOption.Items.Count = 0 then Exit;
  strList.Clear;
  for i:= 0 to lvOption.Items.Count -1 do
  begin
     with lvOption.Items[i] do
     begin
       SubItems.Delimiter := char(9);
       Line := Caption+char(9)+SubItems.DelimitedText;
     end;
     if strList.IndexOf(Line) = -1 then
      strList.Add(Line);
  end;
  if cbCanBarcode.Checked then
    strList.Add('CanBarcode');
  SetFileAttributes(PChar(Path+'\Com.ini'),0);
  strList.SaveToFile(Path+'\Com.ini');
  SetFileAttributes(PChar(Path+'\Com.ini'),2);
end;


procedure TWeighForm.lvChemicalClick(Sender: TObject);
begin
  inherited;
  if lvChemical.Selected <> nil then
  begin
    lbFactUnit.Caption := UpperCase(LeftStr(lvChemical.Selected.SubItems[3],2));
    lbUnit.Caption := UpperCase(LeftStr(lvChemical.Selected.SubItems[3],2));
    pnlWeight.Caption := lvChemical.Selected.SubItems[1];
  end;
end;


procedure TWeighForm.lvOptionChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  inherited;
  if lvOption.Selected = nil then Exit;
  with lvOption.Selected do
  begin
    edtName.Text := Caption;
    cbbPort.ItemIndex := StrToInt(RightStr(SubItems[0],1))-2;
    cbbTransSpeed.Text := SubItems[1];
    cbbDataBit.Text := SubItems[2];
    cbbParity.Text := SubItems[3];
    cbbStopBit.Text := SubItems[4];
    edtMinValue.Text := SubItems[5];
    edtMaxValue.Text := SubItems[6];
    edtPrecent.Text := SubItems[7];
  end;
  btnSave.Tag := 1;
end;
//*************Option End*******************
//*************Weigh Begin*******************
procedure TWeighForm.btnOKClick(Sender: TObject);
begin
  inherited;
  TimerWeigh.Enabled := False;
  if msComm.PortOpen then
    //msComm.PortOpen := False;

  edtFactWeight.Text := FloatToStr(StrToFloat(edtFactWeight.Text)+StrToFloat(pnlFactWeight.Caption));
  if lvChemical.Selected <> nil then
    lvChemical.Selected.SubItems[2] := edtFactWeight.Text;

  if cdsWeigh.Locate('Chemical_ID',edtChemicalID.Text,[]) then
  begin
    cdsWeigh.Edit;
    cdsWeigh.FieldByName('Fact_Weight').AsString := edtFactWeight.Text;
    cdsWeigh.Post;
  end;
  pnlFactWeight.Caption := '';
  pnlFactWeight.Font.Color := clRed;
  Gauge1.Progress := 0;
  nbWeigh.ActivePage := 'Main';
  lvChemical.SetFocus;
end;

procedure TWeighForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  TimerWeigh.Enabled := False;
//  if msComm.PortOpen then
//    msComm.PortOpen := False;
//  edtFactWeight.Text := '';;
//  pnlFactWeight.Caption := '';
//  pnlFactWeight.Font.Color := clRed;
//  Gauge1.Progress := 0;
  nbWeigh.ActivePage := 'Main';
  //lvChemical.SetFocus;
end;

procedure TWeighForm.btnHandleClick(Sender: TObject);
var
  HandleWeight: real;
begin
  inherited;
  TimerWeigh.Enabled := False;
  if msComm.PortOpen then
    msComm.PortOpen := False;
  HandleWeight := GetSel;//StrToFloat(InputBox('手工称重','请输入称重重','0.0'))
  edtFactWeight.Text :=  FloatToStr(StrToFloat(edtFactWeight.Text)+HandleWeight);
  if lvChemical.Selected <> nil then
    lvChemical.Selected.SubItems[2] := edtFactWeight.Text;

  if cdsWeigh.Locate('Chemical_ID',edtChemicalID.Text,[]) then
  begin
    cdsWeigh.Edit;
    cdsWeigh.FieldByName('Fact_Weight').AsString := edtFactWeight.Text;
    cdsWeigh.Post;
  end;
  pnlFactWeight.Caption := '';
  pnlFactWeight.Font.Color := clRed;
  Gauge1.Progress := 0;
  nbWeigh.ActivePage := 'Main';
  lvChemical.SetFocus;
end;


procedure TWeighForm.TimerWeighTimer(Sender: TObject);
var
  FactWeight: string;
  bEsqual : Boolean;
  Ratio : Extended;
  DiffRatio: Extended;
begin
  inherited;
  if not msComm.PortOpen then Exit;
  //edit1.Text :=  GetWeight;
  //Label22.Caption :=  '&&' +  GetWeight+ '&&';
 // Edit1.Text := GetWeight;
  if cboINI.Text = '大秤' then
    FactWeight := GetWeight
  else
    FactWeight := GetWeightByLittle;

  Ratio := 1;
  //if (pnlFactWeight.Hint = '小称') and (UPPERCASE(lbFactUnit.Caption) = 'KG') then
  if cboINI.Text = '大秤' then
  begin
    if (UPPERCASE(lbFactUnit.Caption) = 'KG') then
       Ratio := 0.01
    else
       Ratio := 10;
  end;
  if cboINI.Text = '小秤' then
  begin
    if (UPPERCASE(lbFactUnit.Caption) = 'g') then
       Ratio := 1;
  end;

//  DiffRatio := 1;
//  if (UPPERCASE(lbFactUnit.Caption) = 'KG') then
//     DiffRatio := 0.01
//  else
//     Ratio := 10;

  if  FactWeight <> '-1' then
    pnlFactWeight.Caption := FloatToStr(StrToFloat(FactWeight)*Ratio);

//  bEsqual := (StrToFloat(pnlWeight.Caption)*(1+StrToFloat(msComm.Hint)/100.0)>= StrToFloat(pnlFactWeight.Caption))
//            and (StrToFloat(pnlWeight.Caption)*(1-StrToFloat(msComm.Hint)/100.0)<=StrToFloat(pnlFactWeight.Caption));
//  bEsqual := (StrToFloat(pnlWeight.Caption)+StrToFloat(msComm.Hint)*DiffRatio >= StrToFloat(pnlFactWeight.Caption))
//            and (StrToFloat(pnlWeight.Caption)-StrToFloat(msComm.Hint)*DiffRatio <= StrToFloat(pnlFactWeight.Caption));
//  if bEsqual then
//    pnlFactWeight.Font.Color := clLime
//  else
//    pnlFactWeight.Font.Color := clRed;
//  Gauge1.Progress := Round(StrToFloat(pnlFactWeight.Caption)/StrToFloat(pnlWeight.Caption)*100);
//  Gauge1.Refresh;
//  btnOK.Enabled := bEsqual;
//  if btnOk.CanFocus then
//    btnOK.SetFocus;
end;

function TWeighForm.GetPortAndSetting(Weight: Extended; var Port: Integer; var Settting: string; var Precent:string): Boolean;
var
  i:Integer;
begin
  Result := False;
  for i := 0 to lvOption.Items.Count -1 do
  begin
    if ((Weight>=StrToFloat(lvOption.Items[i].SubItems[5]))) and
       (Weight<=(StrToFloat(lvOption.Items[i].SubItems[6]))) then
    begin
       Port := StrToInt(RightStr(lvOption.Items[i].SubItems[0],1));
       Settting := lvOption.Items[i].SubItems[1]+',n,'+lvOption.Items[i].SubItems[2]+','+lvOption.Items[i].SubItems[4];
       Precent := lvOption.Items[i].SubItems[7];
       pnlFactWeight.Hint := lvOption.Items[i].Caption;
       Result := True;
       Break;
    end;
  end;
  if Result then
    TimerWeigh.Enabled := True;
end;
//*************Weigh End*******************

procedure TWeighForm.btnQueryClick(Sender: TObject);
var
  vData: olevariant;
  sErrorMsg, BillNo, sCondition: widestring;
begin
  try
    Screen.Cursor := crHourGlass;
    edtBatchNO.Text := '';
    edtMachineID.Text := '';
    lvChemical.OnChange := nil;
    BillNo := Trim(edtBillNO.Text);
    sRecipe_no := BillNo;
    if BillNo = '' then
    begin
      ShowMessage('请先输入化料单号');
      Exit;
    end;
    sCondition := QuotedStr(BillNo) + ',1,2';
    FNMServerObj.GetQueryData(vData,'GetWeighData',sCondition,sErrorMsg);
    cdsOnline.Data := vData;
    GridDecorator.BindCxViewWithDataSource(cxgridVOnline, dsOnline,True);
//    lvChemical.Items.Clear;
//    with cdsWeigh do
//    begin
//      if not Active or IsEmpty then Exit;
//      FieldByName('Fact_Weight').ReadOnly := False;
//      First;
//      edtBatchNO.Text := FieldByName('Batch_NO').AsString;
//      edtMachineID.Text := FieldByName('Machine_ID').AsString;
//      lvChemical.Items.Clear;
//      while not Eof do
//      begin
//        with lvChemical.Items.Add do
//        begin
//          Caption := FieldByName('Chemical_ID').AsString;
//          SubItems.Add(FieldByName('Chemical_Name').AsString);
//          SubItems.Add(FieldByName('Weight').AsString);
//          SubItems.Add(FieldByName('Fact_Weight').AsString);
//          SubItems.Add(FieldByName('Unit').AsString);
//        end;
//        Next;
//      end;
//    end;
  finally
    Screen.Cursor := crDefault;
  end;
  lvChemical.OnChange := lvChemicalChange;
  lvChemical.SetFocus;
  if lvChemical.Items.Count >0 then
    lvChemical.Items[0].Selected := True;
end;

procedure TWeighForm.btnWeighClick(Sender: TObject);
begin
  nbWeigh.ActivePage := 'Barcode';
  //Weight;
  lbbarChemicalID.Caption := edtChemicalID.Text;
  lbbarChemicalName.Caption := edtChemicalName.Text;
  edtbarcode.Text := '';
end;

procedure TWeighForm.edtbarcodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = 13 then
  begin
    //if StrToInt(Trim(edtbarcode.Text)) <> StrToInt(lbbarChemicalID.Caption) then
    if StrToInt(Trim(edtbarcode.Text)) <> StrToInt(lbBarcode.Caption) then
    begin
      edtbarcode.Text := '';
      Application.MessageBox('扫描条码不匹配,请重新扫描', '条码扫描', MB_OK + MB_ICONSTOP);
    end else
      //Weight;
      nbWeigh.ActivePage := 'Weigh';
      TimerWeigh.Enabled := True;
  end;
end;

procedure TWeighForm.edtbarcodeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
//  if not cbCanBarcode.Checked and (Key in ['0'..'9']) then
//    Key :=#0;
end;

procedure TWeighForm.Weight;
var
  APort:Integer;
  ASetting:string;
  APrecent: string;
  Weight : Extended;
  FactWeight:String;
begin
  inherited;
  pnlCaption.Caption := '缸号:'+edtBatchNO.Text+'   机台:'+edtmachineID.Text;
  pnlChemical.Caption := edtChemicalID.Text+'  '+edtChemicalName.Text;
  FactWeight := lvChemical.Selected.SubItems[2];
  if FactWeight = '' then FactWeight := '0.0';
  Weight := StrToFloat(lvChemical.Selected.SubItems[1])-StrToFloat(FactWeight);
  pnlWeight.Caption:= FloatToStr(Weight);
  lbUnit.Caption := edtUnit.Text;
  lbFactUnit.Caption := lbUnit.Caption;
  pnlFactWeight.Caption := '';
  pnlFactWeight.Color := clBtnFace;
  Gauge1.Progress := 0;
  with msComm do
  begin
    if PortOpen then
       PortOpen := False;
    if UpperCase(lbUnit.Caption) = 'KG' then
      Weight := Weight*1000;
 
    if GetPortAndSetting(Weight,APort,ASetting,APrecent) then
    begin
      CommPort := APort;
      Settings := ASetting;
      Hint := APrecent;
      PortOpen := True;
      if PortOpen then
        nbWeigh.ActivePage := 'Weigh';
    end;
  end;   
end;

procedure TWeighForm.lvChemicalChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  inherited;
  if Item.SubItems.Count = 5 then
  begin
    edtChemicalID.Text := Item.Caption;
    edtChemicalName.Text := Item.SubItems[0];
    edtWeight.Text := Item.SubItems[1];
    edtFactWeight.Text := Trim(Item.SubItems[2]);
    if edtFactWeight.Text = '' then
       edtFactWeight.Text := '0.0';
    edtUnit.Text := Item.SubItems[3];
    lbBarcode.Caption := Item.SubItems[4];
  end
end;

procedure TWeighForm.lvChemicalKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if lvChemical.Selected = nil then Exit;
  //if (lvChemical.Selected.SubItems[2]<>'')  and (lvChemical.Selected.SubItems[2]<>'0') then Exit;
  if (key = VK_F5) or (key = VK_RETURN) then
    btnWeigh.Click;
end;

procedure TWeighForm.lvChemicalDblClick(Sender: TObject);
var
  sUnit:string;
begin
  inherited;
  sUnit := lvChemical.Selected.SubItems[3];
  if lvChemical.Selected.SubItems[3] = 'g/l' then
     cboINI.Text := '小秤'
  else
     cboINI.Text := '大秤';

  LoadIni();
  SendMessage(lvChemical.Handle, WM_KEYDOWN, VK_RETURN, 0);
end;

procedure TWeighForm.btnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TWeighForm.btnOptionClick(Sender: TObject);
begin
  inherited;
   nbWeigh.ActivePage := 'Option';
end;

procedure TWeighForm.cbbChemicalIDChange(Sender: TObject);
begin
  inherited;
  //cbbChemicalName.ItemIndex := edtChemicalID.;
end;

procedure TWeighForm.cbbChemicalNameChange(Sender: TObject);
begin
  inherited;
  //cbbChemicalID.ItemIndex := cbbChemicalName.ItemIndex;
end;

procedure TWeighForm.FormShow(Sender: TObject);
var iMonth:integer;
    sMonthNo:string;
begin
  inherited;
  edtBillNO.SetFocus;
  iMonth := StrToInt(FormatDateTime('mm', now()));
  case iMonth of
     10: sMonthNo:='A';
     11: sMonthNo:='B';
     12: sMonthNo:='C';
    else sMonthNo:=inttostr(iMonth);
  end;
  //edtBillNO.Text :=FormatDateTime('Ayy', Now())+sMonthNo+FormatDateTime('dd', Now());
  edtBillNO.SelStart := 6;
  edtBillNO.SelLength := 0;
  btnOption.Visible := HiWord(GetKeyState(VK_CONTROL)) <> 0;
end;

procedure TWeighForm.UpdateActions;
begin
  inherited;
  if nbWeigh.ActivePage = 'Main' then
  begin
    btnQuery.Default := ActiveControl = edtBillNO;
    btnWeigh.Default := ActiveControl = lvChemical;
  end;
end;

procedure TWeighForm.btnPrintClick(Sender: TObject);
var
  sIden,sFactWeight,sCondition,sErrorMsg: widestring;
  i :Integer;
  sWeight,sNeed:string;
  fWeight,fNeed,fDiff:Double;
begin
  inherited;
  if not cdsWeigh.Active or cdsWeigh.IsEmpty then Exit;

  if sRecipe_no = '' then
  begin
    Application.MessageBox('请先查询单号并称重！', '称重', MB_OK + MB_ICONSTOP);
    Exit;
  end;

  if lvChemical.Items.Count >0 then
  begin
    for i :=0 to lvChemical.Items.Count -1 do
    begin
      if lvChemical.Items[i].Caption <> '' then
      begin
        sIden := sIden + lvChemical.Items[i].Caption + '+';
        sWeight := lvChemical.Items[i].SubItems[2];
        sNeed := lvChemical.Items[i].SubItems[1];
        fWeight := StrToFloat(sWeight);
        fNeed := StrToFloat(sNeed);
        fDiff :=  fNeed * 0.002;

        if (sWeight = '') or (sWeight = '0') then
        begin
          TMsgDialog.ShowMsgDialog('实际称重不能为0！', mtError);
          Exit;
        end;
        if (fWeight> fNeed + fDiff) or (fWeight < fNeed - fDiff) then
        begin
          TMsgDialog.ShowMsgDialog('实际称重误差超过0.2% ' + FloatToStr(fweight) + ':' + FloatToStr(fNeed) , mtError);
          Exit;
        end;

        if lvChemical.Items[i].SubItems[2] = '' then
        begin
          sFactWeight := sFactWeight + '0' + '+';
        end
        else
        begin
          sFactWeight := sFactWeight + lvChemical.Items[i].SubItems[2] + '+';
        end;
      end;
    end;
  end;

  sCondition := QuotedStr(sRecipe_no) + ','
              + QuotedStr(sIden) + ','
              + QuotedStr(sFactWeight) ;
  FNMServerObj.SaveDataBySQL('fnSaveFactWeight',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
    Exit;
  end;
  TMsgDialog.ShowMsgDialog('保存成功！', mtInformation);
//  if (HiWord(GetKeyState(VK_CONTROL)) <> 0)then
//    rptWeigh.Preview
//  else
//    rptWeigh.Print;
end;

procedure TWeighForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F1: if nbWeigh.ActivePage = 'Main' then btnPrint.Click;
    VK_F5,13: if (nbWeigh.ActivePage = 'Weigh') and btnOK.Enabled then btnOK.Click;
    VK_F4: begin
             if nbWeigh.ActivePage = 'Weigh' then btnHandle.Click;
             if nbWeigh.ActivePage = 'Main' then btnWeigh.Click;
           end;
    VK_F2: begin
             if nbWeigh.ActivePage = 'Weigh' then btnCancel.Click;
             if nbWeigh.ActivePage = 'Barcode' then sbCancel.Click
           end;
  end;
end;

procedure TWeighForm.sbCancelClick(Sender: TObject);
begin
  inherited;
  nbWeigh.ActivePage := 'Main';;
end;

procedure TWeighForm.cboINIChange(Sender: TObject);
var
  i:Integer;
  str:string;
begin
  inherited;
  LoadIni;
end;

procedure TWeighForm.LoadIni();
var
  i:Integer;
  str:string;
begin
  try
     with msComm do
     begin

       if PortOpen then
         PortOpen := False;
//        msComm.CommPort := 1;
//        msComm.Settings := '1200,n,6,1';
//        msComm.PortOpen := True;

       for i:=0 to lvOption.Items.Count - 1 do
       begin
         if lvOption.Items[i].Caption = cboINI.Text then
         begin
           msComm.CommPort :=StrToInt(MidStr(lvOption.Items[i].SubItems[0],4,1));
           str := lvOption.Items[i].SubItems[1] + ',' + 'n' + ',' + lvOption.Items[i].SubItems[2] + ',1';
           msComm.Settings :=str;
           msComm.PortOpen := True;
         end;
       end;

     end;
   except
    on e:Exception do
      MessageBox(Handle,PChar(cbbPort.Text+' 端口打开失败!'+#13#10+e.Message), '端口测试', MB_OK + MB_ICONSTOP);
   end;
end;

procedure TWeighForm.BitBtn1Click(Sender: TObject);
begin
  inherited;
  QueryOnlineCard;
end;

procedure TWeighForm.cxGridVOnlineDblClick(Sender: TObject);
var
  recipe_no,batch_no,strTemp:string;
begin
  inherited;
  with cxGridVOnline do
  begin
    if Controller.SelectedRowCount >= 1 then
      recipe_no := Controller.SelectedRows[0].Values[GetColumnByFieldName('Recipe_NO').Index];
      batch_no := Controller.SelectedRows[0].Values[GetColumnByFieldName('Batch_NO').Index];
      sOperator := Controller.SelectedRows[0].Values[GetColumnByFieldName('WORKER').Index];
  end;
  edtBillNO.Text := recipe_no;
  sRecipe_no := recipe_no;

  //btnQuery.Click;
  GetDetail(recipe_no,batch_no);
end;
procedure TWeighForm.GetDetail(Recipe_NO:string;Batch_NO:string);
var
  vData: olevariant;
  sErrorMsg, BillNo, sCondition: widestring;
begin
    sCondition := QuotedStr(Recipe_NO) + ',' + Batch_NO + ',3';
    FNMServerObj.GetQueryData(vData,'GetWeighData',sCondition,sErrorMsg);
    cdsWeigh.Data := vData;

    lvChemical.Items.Clear;
    with cdsWeigh do
    begin
      if not Active or IsEmpty then Exit;
      FieldByName('Fact_Weight').ReadOnly := False;
      First;
      edtBatchNO.Text := FieldByName('Batch_NO').AsString;
      //edtMachineID.Text := FieldByName('Machine_ID').AsString;
      lvChemical.Items.Clear;
      while not Eof do
      begin
        with lvChemical.Items.Add do
        begin
          Caption := FieldByName('Chemical_ID').AsString;
          SubItems.Add(FieldByName('Chemical_Name').AsString);
          SubItems.Add(FieldByName('QTY').AsString);
          SubItems.Add(FieldByName('Fact_Weight').AsString);
          SubItems.Add(FieldByName('Unit').AsString);
          SubItems.Add(FieldByName('Barcode').AsString);
        end;
        Next;
      end;
    end;
end;

procedure TWeighForm.cxGridVOnlineCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  var col :Integer;
begin
  inherited;
   col := TcxGridDBTableView(Sender).GetColumnByFieldName('RGB').Index;
  if AViewInfo.Item.Caption = 'RGB' then
     if AViewInfo.GridRecord.Values[col] <> NULL then
     begin
       ACanvas.Brush.Color := AViewInfo.GridRecord.Values[col];
       ACanvas.Font.Color := AViewInfo.GridRecord.Values[col];
     end;
end;

end.

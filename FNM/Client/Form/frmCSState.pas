{******************************************************************************
                                                                              
       ������� FNM                                                            
       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                              
       ��Ԫ���� frmCSState.pas                                                 
       �������� 2007-11-30 10:54:40                                            
       ������Ա cuijf                                                          
       �޸���Ա                                                                
       �޸�����                                                                
       �޸�ԭ��                                                                
       ��Ӧ����                                                                
       �ֶ�����                                                                
       ������ݿ��                                                            
       ������Ҫ����/SQL����˵��                                                
       ��������                                                                
                                                                              
******************************************************************************}
unit frmCSState;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxSplitter, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxContainer, cxListBox, cxDBEdit, ExtCtrls,
  Buttons, StdCtrls, DBClient, cxCheckBox;

type
  TCSStateForm = class(TBaseForm)
    pnl1: TPanel;
    cxgridtvBatch: TcxGridDBTableView;
    cxGridlBatch: TcxGridLevel;
    cxgridBatch: TcxGrid;
    pnl2: TPanel;
    cxspl1: TcxSplitter;
    pnl3: TPanel;
    cxgridTank: TcxGrid;
    cxgridtvTank: TcxGridDBTableView;
    cxGridlTank: TcxGridLevel;
    pnl4: TPanel;
    cxsplTank: TcxSplitter;
    cxgridGF: TcxGrid;
    cxgridtvGF: TcxGridDBTableView;
    cxGridlGF: TcxGridLevel;
    cxgridCS: TcxGrid;
    cxgridtvCS: TcxGridDBTableView;
    cxGridlCS: TcxGridLevel;
    cxspl3: TcxSplitter;
    pnlVat: TPanel;
    cdsTank: TClientDataSet;
    dsTank: TDataSource;
    dsGF: TDataSource;
    cdsGF: TClientDataSet;
    dsCS: TDataSource;
    cdsCS: TClientDataSet;
    dsBatch: TDataSource;
    cdsBatch: TClientDataSet;
    cdsVat: TClientDataSet;
    sclbVat: TScrollBox;
    btnDelete: TSpeedButton;
    btnAdd: TSpeedButton;
    btnExit: TSpeedButton;
    cxcbFilter: TcxCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure InitForm;
    procedure DataQuery(sQueryType, sTank:String);
    procedure DataAdd;
    procedure DataDelete;
    procedure DataSave;
    procedure SetBtnState;
    procedure AutoCreateBTN;
    procedure BtnClick(Sender:Tobject);
    procedure BtnDblClick(Sender:Tobject);
    function CloseQuery:Boolean;
    procedure cdsTankAfterScroll(DataSet: TDataSet);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure DataFilter;
    procedure cxcbFilterPropertiesChange(Sender: TObject);
  private
    { Private declarations }
    sBatch: String;
  public
    { Public declarations }
  end;

var
  CSStateForm: TCSStateForm;

implementation

uses  uGlobal, uDictionary, uLogin, Math, ServerDllPub, uShowMessage,
  UGridDecorator, StrUtils;
{$R *.dfm}

{ TCSStateForm }

procedure TCSStateForm.AutoCreateBTN;
var
  sb: TSpeedButton;
  FontColor: TColor;
  C, R: Double;
  gWidth, gHeight, iRecordCount, i, j, W, H: Integer;
  vData: Olevariant;
  sSQL, sErrorMsg: WideString;
begin      
  try
    ShowMsg('���ڸ���״̬...', crHourGlass);

    sSQL := QuotedStr(Login.CurrentDepartment);
    FNMServerObj.GetQueryData(vData, 'RCPGetCSVatStatus', sSQL, sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsVat.Data := vData;
    if cdsVat.IsEmpty then Exit;

    //����Panel��С
    gWidth := 115;
    gHeight := 65;
    W := 1; //Panel��Left
    H := 5; //Panel��Top
    iRecordCount := cdsVat.RecordCount;

    //��һ�λ�
    if sclbVat.ControlCount<2 then
    begin
      // һ����ʾ�ĸ���,����
      C := Int((sclbVat.Width - 20) / gWidth);
      if C = 0 then C := 1;

      //��������
      if Frac(iRecordCount / C) > 0 then
        R := Int(iRecordCount / C) + 1
      else
        R := Int(iRecordCount / C);

      with cdsVat do
      begin
        First;
        for i := 0 to Floor(R) - 1 do
        begin
          for j := 0 to Floor(C) - 1 do
          begin
            if Eof then break;
            //����SpeedBtn
            sb := TSpeedButton.Create(self);
            sb.Parent := sclbVat;
            sb.Left := W;
            sb.Top := H;
            sb.Width := gWidth;
            sb.Height := gHeight;
            sb.GroupIndex := 1;
            sb.Align := alTop;

            W := W + gWidth;
            if Eof then break else Next;
          end;
          H := H + gHeight;
          W := W - Floor(C) * gWidth;
        end
      end;
    end;

    //��ֵ
    cdsVat.First;
    for i := sclbVat.ControlCount - 1 downto 0 do
    begin

      if TSpeedButton(sclbVat.Controls[i]).ClassName= 'TSpeedButton' then
      begin
        with TSpeedButton(sclbVat.Controls[i]) do
        begin
          Caption := cdsVat.FieldByName('Caption').AsString;
          Font.Color := StringToColor(cdsVat.FieldByName('Font_Color').AsString);
          Color := StringToColor(cdsVat.FieldByName('Color').AsString);
          Hint := cdsVat.FieldByName('Remark').AsString;
          Name := cdsVat.FieldByName('Vat_Code').AsString;
          OnClick := BtnClick;
          OnDblClick := BtnDblClick;
        end;                                                

        if not cdsVat.Eof then
          cdsVat.Next;
      end;
    end;
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCSStateForm.BtnClick(Sender: Tobject);
begin
  if Sender.ClassName = 'TSpeedButton' then
    sBatch := TSpeedButton(Sender).Name;
    
  AutoCreateBTN; //ˢ�°�ť�ϵĸ�״̬��Ϣ
  DataQuery('Tank', sBatch);
end;

function TCSStateForm.CloseQuery: Boolean;
begin
  if not TGlobal.DeltaIsNull(cdsTank) then
  begin
    if TMsgDialog.ShowMsgDialog('����δ���棬�Ƿ񱣴棡', mtConfirmation, [mebYes, mebNo], mebYes)= mrNo then
      Result := false;
  end
  else
    Result := False;
end;

procedure TCSStateForm.DataAdd;
var
  sCondition, sMachine, sErrorMsg: WideString;
begin
  try
    ShowMsg('���ڱ��������Ե�...', crHourGlass);

    if cdsBatch.IsEmpty then Exit;
    sMachine := '';
    if sBatch<> cdsBatch.FieldByName('Vat_Code').AsString then
      sMachine := sBatch;

    if cdsBatch.FieldByName('Status').AsString<>'0' then
    begin
      TMsgDialog.ShowMsgDialog('�Ѿ���ʼ���ϣ������޸��ϸף�', mtWarning);
      Exit;
    end;

    if cdsBatch.FieldByName('Is_ExportTOCS').AsString='1' then
    begin
      if TMsgDialog.ShowMsgDialog('�ѵ��Զ�����ϵͳ���Ƿ������', mtConfirmation, [mebYes, mebNo], mebYes)= mrNo then
        Exit;
    end;

    sCondition := QuotedStr('A')+ ','+ QuotedStr(cdsBatch.FieldByName('Batch_NO').AsString)+ ','+ QuotedStr(sMachine);
    FNMServerObj.SaveDataBySQL('RCPSaveCSVatInfo', sCondition, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
  finally
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TCSStateForm.DataDelete;
var
  sCondition, sMachine, sErrorMsg: WideString;
begin
  try
    ShowMsg('���ڱ��������Ե�...', crHourGlass);

    if cdsTank.IsEmpty then Exit;

    sCondition := QuotedStr('D')+ ','+ QuotedStr(cdsTank.FieldByName('Batch_Code').AsString);
    FNMServerObj.SaveDataBySQL('RCPSaveCSVatInfo', sCondition, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
  finally
    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TCSStateForm.DataQuery(sQueryType, sTank: String);
var
  vData: Olevariant;
  sErrorMsg: WideString;
  sCondition: string;
begin
  try
    //��������
    if CloseQuery then
      DataSave;

    ShowMsg('���ڻ�ȡ�����Ե�...', crHourGlass);

    sCondition := QuotedStr(Login.CurrentDepartment)+','+ QuotedStr(sQueryType)+ ','
                  + QuotedStr(sTank);

    FNMServerObj.GetQueryData(vData, 'RCPGetCSVatInfo', sCondition, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;

    if sQueryType= 'Tank' then   //�����������ݼ������ϸ׵Ĵ������񣬻��ϸ׻�̨����������
    begin
      cdsTank.DisableControls;
      cdsBatch.DisableControls;
      cdsTank.AfterScroll := nil;
      cdsTank.Data := vData[0];
      cdsBatch.Data:=vData[1];

      GridDecorator.BindCxViewWithDataSource(cxgridtvTank,dsTank);
      GridDecorator.BindCxViewWithDataSource(cxgridtvBatch,dsBatch);
    end
    else if sQueryType= 'GF' then  //�����������ݼ������ϸ�Ʒ���������������ϸ׻�������Ϣ
    begin
      cdsGF.DisableControls;
      cdscs.DisableControls;

      cdsGF.Data := vData[0];
      cdsCS.Data:=vData[1];

      GridDecorator.BindCxViewWithDataSource(cxgridtvGF,dsGF);
      GridDecorator.BindCxViewWithDataSource(cxgridtvCS,dsCS);
    end;
  finally
    if sQueryType= 'Tank' then
    begin
      cdsTank.EnableControls;
      cdsBatch.EnableControls;
      cdsTank.AfterScroll := cdsTankAfterScroll;
      cdsTank.First;
    end
    else
    begin
      cdsGF.EnableControls;
      cdscs.EnableControls;
    end;

    SetBtnState;
    ShowMsg('', crDefault);
  end;
end;

procedure TCSStateForm.DataSave;
begin
{}
end;

procedure TCSStateForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TCSStateForm.FormCreate(Sender: TObject);
begin
  InitForm;
end;

procedure TCSStateForm.FormDestroy(Sender: TObject);
begin
  CSStateForm := nil;
end;

procedure TCSStateForm.InitForm;
begin
  AutoCreateBTN;
  cxsplTank.CloseSplitter;
  SetBtnState;
end;

procedure TCSStateForm.SetBtnState;
begin
  btnDelete.Enabled := not cdsTank.IsEmpty;
  btnAdd.Enabled := not cdsBatch.IsEmpty;
  cxcbFilter.Enabled := btnAdd.Enabled;
end;

procedure TCSStateForm.cdsTankAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if cxsplTank.State = ssOpened then
    DataQuery('GF', DataSet.FieldByName('Batch_Code').AsString);
end;

procedure TCSStateForm.btnAddClick(Sender: TObject);
begin
  inherited;
  DataAdd;
  DataQuery('Tank', sBatch);
end;

procedure TCSStateForm.btnDeleteClick(Sender: TObject);
begin
  inherited;
  DataDelete;
  DataQuery('Tank', sBatch);
end;

procedure TCSStateForm.btnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TCSStateForm.DataFilter;
var
  sStr:String;
begin  
  sStr := '';
  if cxcbFilter.Checked then
    sStr := 'Is_ExportTOCS=0';
  cdsBatch.Filtered := False;
  cdsBatch.Filter := sStr;
  cdsBatch.Filtered := True;
end;

procedure TCSStateForm.cxcbFilterPropertiesChange(Sender: TObject);
begin
  inherited;
  DataFilter;
end;

procedure TCSStateForm.BtnDblClick(Sender: Tobject);
begin
  if TSpeedButton(Sender).Hint<>'' then
    TMsgDialog.ShowMsgDialog(TSpeedButton(Sender).Caption+ TSpeedButton(Sender).Hint, 10);
end;

end.




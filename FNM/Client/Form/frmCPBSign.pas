unit frmCPBSign;
{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmCPBManage.pas                                          }
{       �������� 2004-8-26 16:20:05                                            }
{       ������Ա zhangjy                                                       }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{       ������Ҫ����/SQL����˵��                                               }
{       �������� �Ͳ�ǰ����CHECK                                               }
{                                                                              }
{******************************************************************************}


interface

uses
  uFNMResource, Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,Dialogs, frmBase, StdCtrls, ExtCtrls, OleCtrls, Buttons,
  DB, DBClient, ComCtrls, StrUtils, GFCADLib_TLB, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxSplitter, CheckLst, Math;

type
  TCPBSignForm = class(TBaseForm)
    pnlLeft: TPanel;
    pnlCard: TPanel;
    pnl2: TPanel;
    btnAdd: TSpeedButton;
    btnUp: TSpeedButton;
    btnCancel: TSpeedButton;
    btnDown: TSpeedButton;
    cxSplitter1: TcxSplitter;
    cxdbgUnSelect: TcxGrid;
    cxdbgtvUnSelect: TcxGridDBTableView;
    cxGridlUnSelect: TcxGridLevel;
    cdsUnSelect: TClientDataSet;
    dsUnSelect: TDataSource;
    cdsSelect: TClientDataSet;
    dsSelect: TDataSource;
    cxdbgSelect: TcxGrid;
    cxdbgtvSelect: TcxGridDBTableView;
    cxGridlSelect: TcxGridLevel;
    pnlTop: TPanel;
    btnRefresh: TSpeedButton;
    btnSave: TSpeedButton;
    btnClose: TSpeedButton;
    Label13: TLabel;
    edtRCP: TEdit;
    btnExport: TSpeedButton;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cdsUnSelectFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure btnAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure cxdbgtvUnSelectKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxdbgtvSelectKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsSelectFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure cxdbgtvUnSelectCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxdbgtvSelectCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnExportClick(Sender: TObject);
  private
    { Private declarations }
    sKeyName: string;
    sQueryType: string;
    sQueryCon: string;
    sSaveType: string;
    sSaveCon: string;
    ItemList: TStringList;
    procedure Initialize;
    procedure Add;
    procedure Cancel;
    procedure GetData;
    procedure SaveData;
  protected
    procedure UpdateActions; override;
  public
    { Public declarations }
    procedure PublicQuery; override;
    procedure PublicExport; override;
    procedure PublicSave; override;
  end;
var
  CPBSignForm: TCPBSignForm;

implementation

uses ServerDllPub, uGlobal, uShowMessage, uLogin, uGridDecorator,
  uAppOption,uDictionary,uCADInfo;

{$R *.dfm}

procedure TCPBSignForm.UpdateActions;
var sItemStr: string;
begin
  inherited;
  sKeyName := 'Recipe_NO';
  sQueryType := 'CPBGetTask';
  //���ǩ��   sQueryCon := QuotedStr(login.CurrentDepartment)+','+ IntTostr(7);
  //���������ϻ�
  sQueryCon := QuotedStr(login.CurrentDepartment)+','+ IntTostr(12);
  sSaveType := 'CPBCheckRecipe';
  sItemStr := StringReplace(ItemList.Text,#13#10,',',[rfReplaceAll]);
  //���ǩ��   sSaveCon:= QuotedStr(sItemStr)+',0,'''','''','''','''','''''+',2,'+ QuotedStr(Login.CurrentDepartment) + ',' + QuotedStr(Login.LoginID)+',0';
  //���������ϻ�
  sSaveCon:= QuotedStr(sItemStr)+',0,'''','''','''','''','''''+',2,' +
             QuotedStr(Login.CurrentDepartment) + ',' + QuotedStr(Login.LoginID)+',4';
  btnSave.Enabled := ItemList.Count > 0;
  btnAdd.Enabled := cxdbgtvUnSelect.Controller.SelectedRowCount > 0;
  btnDown.Enabled := btnAdd.Enabled;
  btnCancel.Enabled := cxdbgtvSelect.Controller.SelectedRowCount > 0;
  btnUp.Enabled := btnCancel.Enabled;
end;

procedure TCPBSignForm.PublicQuery;
begin
  GetData;
end;

procedure TCPBSignForm.PublicExport;
begin
end;

procedure TCPBSignForm.PublicSave;
begin
  SaveData;
end;

procedure TCPBSignForm.Initialize;
begin
  btnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnAdd.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btnDown.Glyph.LoadFromResourceName(HInstance, RES_DOWNALL);
  btnCancel.Glyph.LoadFromResourceName(HInstance, RES_UP);
  btnUp.Glyph.LoadFromResourceName(HInstance, RES_UPALL);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_EXOPRTFILE);
  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
  ItemList := TStringList.Create;
  ItemList.Clear;
  cxdbgtvSelect.OnDblClick := TGlobal.DblClickAWinControl;
  cxdbgtvUnSelect.OnDblClick := TGlobal.DblClickAWinControl;
end;    

procedure TCPBSignForm.GetData;
var vData: OleVariant;
    sErrorMsg: WideString;
begin
  try
    ShowMsg('���ڻ�ȡ�����Եȣ�', crHourGlass);
    FNMServerObj.GetQueryData(vData,sQueryType,sQueryCon,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsUnSelect.Data := vData;
    if cdsUnSelect.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('û�д�ǩ�յ�ɫ����Ϣ!',mtInformation);
      Exit;
    end;
    ItemList.Clear;
    cdsSelect.Data := vData;
    cdsUnSelect.Filtered := True;
    cdsSelect.Filtered := True;
    GridDecorator.BindCxViewWithDataSource(cxdbgtvSelect, dsSelect,True);
    GridDecorator.BindCxViewWithDataSource(cxdbgtvUnSelect, dsUnSelect);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCPBSignForm.SaveData;
var
  sErrorMsg: WideString;
  i: integer;
begin
  if FileExists('\\GEW195399\Transfer\CPB.rcp') then
  begin
    ShowMessage('����ϵͳ����ת��,�롾10�롿���ٲ���,лл��');
    Exit;
  end;

  try
    ShowMsg('���ڱ��������Եȣ�', crHourGlass);
    if ItemList.Count = 0 then Exit;
    FNMServerObj.SaveDataBySQL(sSaveType,sSaveCon,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;
    for i := 0 to ItemList.Count -1 do
    begin
      cxdbgtvSelect.DataController.BeginUpdate;
      cdsUnSelect.Filtered := False;
      while cdsUnSelect.Locate(sKeyName,ItemList.Strings[i],[]) do
        cdsUnSelect.Delete;
      cdsUnSelect.Filtered := True;
      cdsSelect.Filtered := False;
      while cdsSelect.Locate(sKeyName,ItemList.Strings[i],[]) do
        cdsSelect.Delete;
      cdsSelect.Filtered := True;
      cxdbgtvSelect.DataController.EndUpdate;
    end;
    //
    TGlobal.GenerateRCPFile(StringReplace(ItemList.Text,#13#10,',',[rfReplaceAll]));
    //
    ItemList.Clear;
    TMsgDialog.ShowMsgDialog('����/�������ݳɹ�', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCPBSignForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TCPBSignForm.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(ItemList);
  CPBSignForm := nil;
end;

procedure TCPBSignForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  GetData;
end;

procedure TCPBSignForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveData;
end;

procedure TCPBSignForm.FormCreate(Sender: TObject);
begin
  inherited;
  Initialize;
end;

procedure TCPBSignForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TCPBSignForm.Add;
var i: Integer;
    sItemNO: string;
begin
  if (not cdsUnSelect.Active) or (cdsUnSelect.IsEmpty) then Exit;
  for i :=cxdbgtvUnSelect.Controller.SelectedRowCount - 1 downto 0 do
  begin
    with cxdbgtvUnSelect do
      sItemNO := Controller.SelectedRows[i].Values[GetColumnByFieldName(sKeyName).Index];
    ItemList.Add(sItemNO);
  end;
  cdsUnSelect.Filtered := False;
  cdsUnSelect.Filtered := True;
  cdsSelect.Filtered := False;
  cdsSelect.Filtered := True;
end;

procedure TCPBSignForm.Cancel;
var i,Index: Integer;
    sItemNO: string;
begin
  if (not cdsSelect.Active) or (cdsSelect.IsEmpty) then Exit;
  for i :=cxdbgtvSelect.Controller.SelectedRowCount - 1 downto 0 do
  begin
    with cxdbgtvSelect do
      sItemNO := Controller.SelectedRows[i].Values[GetColumnByFieldName(sKeyName).Index];
    Index := ItemList.IndexOf(sItemNO);
    if Index <> -1 then
      ItemList.Delete(Index);
  end;
  cdsUnSelect.Filtered := False;
  cdsUnSelect.Filtered := True;
  cdsSelect.Filtered := False;
  cdsSelect.Filtered := True;
end;

procedure TCPBSignForm.cdsUnSelectFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept := Pos(DataSet.FieldByName(sKeyName).AsString,ItemList.Text) = 0;
end;

procedure TCPBSignForm.cdsSelectFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept := Pos(DataSet.FieldByName(sKeyName).AsString,ItemList.Text) > 0;
end;

procedure TCPBSignForm.btnAddClick(Sender: TObject);
begin
  inherited;
  Add;
end;

procedure TCPBSignForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  Cancel;
end;

procedure TCPBSignForm.btnDownClick(Sender: TObject);
begin
  inherited;
  cxdbgtvUnSelect.DataController.SelectAll;
  Add;
end;

procedure TCPBSignForm.btnUpClick(Sender: TObject);
begin
  inherited;
  cxdbgtvSelect.DataController.SelectAll;
  Cancel;
end;

procedure TCPBSignForm.cxdbgtvUnSelectKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
   if key = vk_Return then
    Add;
end;

procedure TCPBSignForm.cxdbgtvSelectKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = vk_Return then
    Cancel;
end;

procedure TCPBSignForm.cxdbgtvUnSelectCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var col :Integer;
begin
  inherited;
  col := TcxGridDBTableView(Sender).GetColumnByFieldName('RGB').Index;
  if AViewInfo.Item.Caption = 'RGB' then
  begin
    ACanvas.Brush.Color := AViewInfo.GridRecord.Values[col];
    ACanvas.Font.Color := AViewInfo.GridRecord.Values[col];
  end;
end;

procedure TCPBSignForm.cxdbgtvSelectCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var col: Integer;
begin
  inherited;
  col := TcxGridDBTableView(Sender).GetColumnByFieldName('RGB').Index;
  if AViewInfo.Item.Caption = 'RGB' then
  begin
    ACanvas.Brush.Color := AViewInfo.GridRecord.Values[col];
    ACanvas.Font.Color := AViewInfo.GridRecord.Values[col];
  end;
end;

procedure TCPBSignForm.btnExportClick(Sender: TObject);
begin
  inherited;
  if Trim(edtRCP.Text) <> '' then
  begin
    TGlobal.GenerateRCPFile(edtRCP.Text);
    edtRCP.Clear;
    TMsgDialog.ShowMsgDialog('�������ϻ��ɹ�',mtInformation);
  end;  
end;

end.

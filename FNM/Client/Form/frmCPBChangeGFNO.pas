unit frmCPBChangeGFNO;
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
  TCPBChangeGFNOForm = class(TBaseForm)
    cdsUnSelect: TClientDataSet;
    dsUnSelect: TDataSource;
    cdsSelect: TClientDataSet;
    dsSelect: TDataSource;
    pnlTop: TPanel;
    btnRefresh: TSpeedButton;
    btnSave: TSpeedButton;
    btnClose: TSpeedButton;
    GroupBox1: TGroupBox;
    cxdbgUnSelect: TcxGrid;
    cxdbgtvUnSelect: TcxGridDBTableView;
    cxGridlUnSelect: TcxGridLevel;
    cxSplitter1: TcxSplitter;
    pnlCard: TPanel;
    pnl2: TPanel;
    btnAdd: TSpeedButton;
    btnUp: TSpeedButton;
    btnCancel: TSpeedButton;
    btnDown: TSpeedButton;
    cxdbgSelect: TcxGrid;
    cxdbgtvSelect: TcxGridDBTableView;
    cxGridlSelect: TcxGridLevel;
    GroupBox2: TGroupBox;
    cxSplitter2: TcxSplitter;
    cxGrid1: TcxGrid;
    cxdbgtvReserved: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cdsReserved: TClientDataSet;
    dsReserved: TDataSource;
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
    procedure cxdbgtvReservedKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    ReservedIden: Integer;
    sKeyName: string;
    ItemList: TStringList;
    procedure Initialize;
    procedure Add;
    procedure Cancel;
    procedure GetData(Iden:Integer);
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
  CPBChangeGFNOForm: TCPBChangeGFNOForm;

implementation

uses ServerDllPub, uGlobal, uShowMessage, uLogin, uGridDecorator,
  uAppOption,uDictionary,uCADInfo;

{$R *.dfm}

procedure TCPBChangeGFNOForm.UpdateActions;
begin
  inherited;
  sKeyName := 'Fabric_NO';
  btnSave.Enabled := ItemList.Count > 0;
  btnAdd.Enabled := cxdbgtvUnSelect.Controller.SelectedRowCount > 0;
  btnDown.Enabled := btnAdd.Enabled;
  btnCancel.Enabled := cxdbgtvSelect.Controller.SelectedRowCount > 0;
  btnUp.Enabled := btnCancel.Enabled;
end;

procedure TCPBChangeGFNOForm.PublicQuery;
begin
  GetData(0);
end;

procedure TCPBChangeGFNOForm.PublicExport;
begin
end;

procedure TCPBChangeGFNOForm.PublicSave;
begin
  SaveData;
end;

procedure TCPBChangeGFNOForm.Initialize;
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
  cxdbgtvReserved.OnDblClick := TGlobal.DblClickAWinControl;
  cxdbgtvSelect.OnDblClick := TGlobal.DblClickAWinControl;
  cxdbgtvUnSelect.OnDblClick := TGlobal.DblClickAWinControl;
end;    

procedure TCPBChangeGFNOForm.GetData(Iden:Integer);
var vData: OleVariant;
    sErrorMsg: WideString;
    sQueryType, sQueryCon: string;
begin
  try
    ShowMsg('���ڻ�ȡ�����Եȣ�', crHourGlass);
    sQueryType := 'CPBGetReservedInfo';
    sQueryCon := IntTostr(Iden)+','+QuotedStr(Login.CurrentDepartment);
    FNMServerObj.GetQueryData(vData,sQueryType,sQueryCon,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    if Iden = 0 then
    begin
      cdsReserved.Data := vData;
      if cdsReserved.IsEmpty then
      begin
        TMsgDialog.ShowMsgDialog('û����λ��Ʒ����Ϣ!',mtInformation);
        Exit;
      end;
      GridDecorator.BindCxViewWithDataSource(cxdbgtvReserved, dsReserved);
      GridDecorator.HideFields(cxdbgtvReserved,['Iden']);
    end else
    begin
      cdsUnSelect.Data := vData;
      if cdsUnSelect.IsEmpty then
      begin
        TMsgDialog.ShowMsgDialog('û�и�Ʒ���Ŀ����Ϣ!',mtInformation);
        Exit;
      end;
      ItemList.Clear;
      cdsSelect.Data := vData;
      cdsUnSelect.Filtered := True;
      cdsSelect.Filtered := True;
      GridDecorator.BindCxViewWithDataSource(cxdbgtvSelect, dsSelect);
      GridDecorator.BindCxViewWithDataSource(cxdbgtvUnSelect, dsUnSelect);
      GridDecorator.AddFooter(cxdbgtvSelect,['Quantity','Fabric_No'],[skSum,skCount]);
      GridDecorator.AddFooter(cxdbgtvUnSelect,['Quantity','Fabric_No'],[skSum,skCount]);
    end;
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCPBChangeGFNOForm.SaveData;
var
  sErrorMsg: WideString;
  i: integer;
  sItemStr,sSaveType,sSaveCon: string;
begin
  try
    ShowMsg('���ڱ��������Եȣ�', crHourGlass);
    if ItemList.Count = 0 then Exit;
    sSaveType := 'CPBChangeGFNO';
    sItemStr := StringReplace(ItemList.Text,#13#10,',',[rfReplaceAll]);
    sSaveCon:= IntToStr(ReservedIden)+','+ QuotedStr(sItemStr) + ',' + QuotedStr(Login.LoginID);
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
    ItemList.Clear;
    TMsgDialog.ShowMsgDialog('������λƷ���ɹ�', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCPBChangeGFNOForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TCPBChangeGFNOForm.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(ItemList);
  CPBChangeGFNOForm := nil;
end;

procedure TCPBChangeGFNOForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  GetData(0);
end;

procedure TCPBChangeGFNOForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveData;
end;

procedure TCPBChangeGFNOForm.FormCreate(Sender: TObject);
begin
  inherited;
  Initialize;
end;

procedure TCPBChangeGFNOForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TCPBChangeGFNOForm.Add;
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

procedure TCPBChangeGFNOForm.Cancel;
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

procedure TCPBChangeGFNOForm.cdsUnSelectFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept := Pos(DataSet.FieldByName(sKeyName).AsString,ItemList.Text) = 0;
end;

procedure TCPBChangeGFNOForm.cdsSelectFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept := Pos(DataSet.FieldByName(sKeyName).AsString,ItemList.Text) > 0;
end;

procedure TCPBChangeGFNOForm.btnAddClick(Sender: TObject);
begin
  inherited;
  Add;
end;

procedure TCPBChangeGFNOForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  Cancel;
end;

procedure TCPBChangeGFNOForm.btnDownClick(Sender: TObject);
begin
  inherited;
  cxdbgtvUnSelect.DataController.SelectAll;
  Add;
end;

procedure TCPBChangeGFNOForm.btnUpClick(Sender: TObject);
begin
  inherited;
  cxdbgtvSelect.DataController.SelectAll;
  Cancel;
end;

procedure TCPBChangeGFNOForm.cxdbgtvUnSelectKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
   if key = vk_Return then
    Add;
end;

procedure TCPBChangeGFNOForm.cxdbgtvSelectKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = vk_Return then
    Cancel;
end;

procedure TCPBChangeGFNOForm.cxdbgtvReservedKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if not cdsReserved.Active or cdsReserved.IsEmpty then Exit;
  ReservedIden := cdsReserved.FieldByName('Iden').AsInteger;
  if key = vk_Return then
     GetData(ReservedIden);
end;

end.

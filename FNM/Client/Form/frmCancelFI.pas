unit frmCancelFI;
{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmCancelFI.pas                                               }
{       �������� 2004-8-26 16:22:52                                            }
{       ������Ա zhangjy                                                       }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{       ������Ҫ����/SQL����˵��                                               }
{       ��������  ȡ����Ʒ����                                                             }
{                                                                              }
{******************************************************************************}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, StdCtrls, CheckLst, DBClient,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  ExtCtrls;

type
  TCancelFIForm = class(TBaseForm)
    pnl1: TPanel;
    lblNote_NO: TLabel;
    btnSave: TButton;
    btnClose: TButton;
    btnQuery: TButton;
    cxgdReceiveInfo1: TcxGrid;
    cxgridtvReceiveInfo: TcxGridDBTableView;
    cxGridl2: TcxGridLevel;
    dsReceiveInfo: TDataSource;
    cdsReceiveInfo: TClientDataSet;
    grp1: TGroupBox;
    chklstFabricNOList: TCheckListBox;
    chkAll: TCheckBox;
    edtNoteNO: TEdit;
    procedure chkAllClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetReceiveInfo();
    procedure GetData;
    procedure CancelFIInfo();
    procedure SaveData;
  public
    { Public declarations }
  end;

var
  CancelFIForm: TCancelFIForm;

implementation

uses uGlobal, uGridDecorator, uShowMessage, ServerDllPub, uLogin;

{$R *.dfm}

procedure TCancelFIForm.GetReceiveInfo();
var vData: OleVariant;
    sCondition,sNote_NO, sErrorMsg: WideString;
begin
  try
    ShowMsg('���ڲ�ѯ�����Եȣ�', crHourGlass);
     if not TGlobal.CheckValueLength(edtNoteNO.Text, 12) then
    begin
      TMsgDialog.ShowMsgDialog('�������������' + lblNote_NO.Caption + '�ĳ����Ƿ�Ϊ12λ',mtWarning);
      Exit;
    end;
    sNote_NO := Trim(edtNoteNO.Text);
    sCondition :=QuotedStr(sNote_NO)+','+QuotedStr(Login.CurrentDepartment)+','+QuotedStr('3');
    FNMServerObj.GetQueryData(vData,'GetReciveInfo',sCondition,sErrorMsg);
//    FNMServerObj.GetReceiveInfo(vData, sNote_NO, Login.CurrentDepartment, '3', sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsReceiveInfo.Data := vData;
     //���cxGrid
    GridDecorator.BindCxViewWithDataSource(cxgridtvReceiveInfo, dsReceiveInfo,True);
    GridDecorator.AddFooter(cxgridtvReceiveInfo,['Quantity','Fabric_No'],[skSum,skCount]);
    with cdsReceiveInfo do
    begin
      if IsEmpty then
      begin
        TMsgDialog.ShowMsgDialog('�������������' + lblNote_NO.Caption,mtWarning);
        Exit;
      end;
      chklstFabricNOList.Items.Clear;
      First;
      while not Eof do
      begin
        chklstFabricNOList.Items.Add(FieldByName('Fabric_NO').AsString);
        Next;
      end;
    end;
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCancelFIForm.GetData;
begin
  GetReceiveInfo;
end;

procedure TCancelFIForm.CancelFIInfo();
var
  i: Integer;
  sCondition,sNote_NO,sFabricNOList,sErrorMsg: WideString;
begin
  sFabricNOList := '';
  for i := 0 to chklstFabricNOList.Count -1 do
    if chklstFabricNOList.Checked[i] then
      sFabricNOList := sFabricNOList+','+chklstFabricNOList.Items[i];
  if sFabricNOList = '' then
  begin
    TMsgDialog.ShowMsgDialog('��ѡ��Ҫȡ���Ĳ���',mtWarning);
    Exit;
  end;
  sNote_NO := edtNoteNO.Text;
  if Trim(sNote_NO) = '' then Exit;
  try
    ShowMsg('����ȡ�������Եȣ�', crHourGlass);
    sFabricNOList := StringReplace(sFabricNOList, '`', '#96#', [rfReplaceAll]);
    sCondition := QuotedStr(sNote_NO)+ ','+ QuotedStr(sFabricNOList)+','+QuotedStr(Login.LoginName);
    FNMServerObj.SaveDataBySQL('CancelFIInfo',sCondition,sErrorMsg);
//    FNMServerObj.CancelFIInfo(sNote_NO,sFabricNOList,Login.LoginName,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TMsgDialog.ShowMsgDialog('ȡ�����ݳɹ�', 2);
    cdsReceiveInfo.EmptyDataSet;
    chklstFabricNOList.Clear;
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCancelFIForm.SaveData;
begin
 CancelFIInfo;
end;

procedure TCancelFIForm.chkAllClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  for i := 0 to chklstFabricNOList.Items.Count -1 do
    chklstFabricNOList.Checked[i] := chkAll.Checked;
end;

procedure TCancelFIForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TCancelFIForm.FormDestroy(Sender: TObject);
begin
  inherited;
  CancelFIForm := nil;
end;

procedure TCancelFIForm.btnQueryClick(Sender: TObject);
begin
  inherited;
  GetData;
end;

procedure TCancelFIForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveData;
end;

procedure TCancelFIForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.

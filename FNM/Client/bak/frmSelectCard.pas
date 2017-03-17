unit frmSelectCard;
{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmSelectCard.pas                                             }
{       �������� 2004-8-26 13:50:57                                            }
{       ������Ա LVZD                                                          }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{       ������Ҫ����/SQL����˵��                                               }
{       �������� ���߿���ѡ��                                                  }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, DB, DBClient;

type
  TSelectCardForFactPrescripForm = class(TForm)
    lv_IncludeCard: TListView;
    pnl_Only: TPanel;
    btn_Help: TButton;
    btn_Next: TButton;
    btn_Exit: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadIncludeCard(OrgDataSet, CardDataSet: TDataSet);
  end;

procedure SelectCardForFactPrescrip(OperationCode, GFID: String; ADataSet: TDataSet);

implementation

uses uFNMPrescriptionInfo, ServerDllPub, UFNMResource, uDictionary, uLogin;

{$R *.dfm}

var
  SelectCardForFactPrescripForm: TSelectCardForFactPrescripForm;
  CardDataSet: TClientDataSet;
  
procedure SelectCardForFactPrescrip(OperationCode, GFID: String; ADataSet: TDataSet);
var
  i, j: Integer;
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  FNMServerArtObj.GetNoPrescripCard(GFID, Login.CurrentDepartment, OperationCode, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetNoPrescripCard, [sErrorMsg]);

  if CardDataSet = nil then
    CardDataSet:=TClientDataSet.Create(nil);
  CardDataSet.Data:=vData;
  if CardDataSet.IsEmpty then
    raise Exception.CreateRes(@EMP_NoPrescripCard);

  if SelectCardForFactPrescripForm = nil then
    SelectCardForFactPrescripForm:=TSelectCardForFactPrescripForm.Create(Application);
  SelectCardForFactPrescripForm.LoadIncludeCard(ADataSet, CardDataSet);
  SelectCardForFactPrescripForm.ShowModal;

  if SelectCardForFactPrescripForm.ModalResult = mrOk then
  begin
    CardDataSet.First;
    for i := 0 to CardDataSet.RecordCount - 1 do
    begin
      if not ADataSet.Locate('FN_Card', CardDataSet['FN_Card'], []) then
      begin
        ADataSet.Append;
        for j := 0 to ADataSet.FieldCount - 1 do
          ADataSet.Fields.Fields[j].Value:=CardDataSet.Fields.Fields[j].Value;
      end;
      CardDataSet.Next;
    end;
  end;
end;

procedure TSelectCardForFactPrescripForm.LoadIncludeCard(OrgDataSet, CardDataSet: TDataSet);
var
  i: Integer;
begin
  lv_IncludeCard.Items.Clear;
  for i := 0 to CardDataSet.RecordCount - 1 do
  begin
    with lv_IncludeCard.Items.Add do
    begin
      Caption:= CardDataSet['FN_Card'];
      SubItems.Add(CardDataSet['GF_NO']);
      SubItems.Add(CardDataSet['Quantity']);
      SubItems.Add(CardDataSet['Step_NO']);
      SubItems.Add(CardDataSet['Operation_CHN']);
      Checked:=OrgDataSet.Locate('FN_Card', Caption, []);
    end;
    CardDataSet.Next;
  end;
end;

procedure TSelectCardForFactPrescripForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  i: Integer;
begin
  if ModalResult = mrOK then
  with lv_IncludeCard.Items do
  begin
    for i := 0 to Count - 1 do
    begin
      if not Item[i].Checked then
        if CardDataSet.Locate('FN_Card', Item[i].Caption, []) then
          CardDataSet.Delete;
    end;
    CardDataSet.MergeChangeLog;
  end;
end;

initialization
  CardDataSet:=nil;

finalization
  FreeAndNil(CardDataSet);
end.

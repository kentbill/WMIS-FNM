unit frmChangeGFNO;
{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmChangeGFNO.pas                                             }
{       �������� 2004-8-26 13:50:57                                            }
{       ������Ա zhangjy                                                       }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{       ������Ҫ����/SQL����˵��                                               }
{       �������� ����Ʒ��                                                      }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, StdCtrls, ExtCtrls, Buttons, DBClient,
  cxContainer, cxTextEdit, cxMaskEdit, cxButtonEdit;

type
  TChangeGFNOForm = class(TBaseForm)
    pnlTop: TPanel;
    rgType: TRadioGroup;
    lbledtCode: TLabeledEdit;
    pnlClient: TPanel;
    cxGridtvFabric: TcxGridDBTableView;
    cxGridlFabric: TcxGridLevel;
    cxGridFabric: TcxGrid;
    pnlBottom: TPanel;
    lbledtOldGFID: TLabeledEdit;
    lbledtOldJobNO: TLabeledEdit;
    btnSave: TSpeedButton;
    btnClose: TSpeedButton;
    btnQuery: TSpeedButton;
    dsFabric: TDataSource;
    cdsFabric: TClientDataSet;
    mmoReason: TMemo;
    lbReason: TLabel;
    cxbeGFKey: TcxButtonEdit;
    Label1: TLabel;
    Label2: TLabel;
    cbbJobNO: TComboBox;
    Memo1: TMemo;
    lbledtLength: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure rgTypeClick(Sender: TObject);
    procedure cxbeGFKeyPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cbbJobNOEnter(Sender: TObject);
    procedure cxbeGFKeyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbledtCodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbbJobNOChange(Sender: TObject);
  private
    { Private declarations }
    procedure GetFabricInfo;
    procedure GetData();
    procedure SaveChangeGFNO();
    procedure SaveData();
  public
    { Public declarations }
    procedure PublicQuery; override;
    procedure PublicSave; override;
  end;

var
  ChangeGFNOForm: TChangeGFNOForm;

implementation

uses ServerDllPub, uGlobal, frmMain, uShowMessage, uLogin, uGridDecorator,
  uAppOption, uCADInfo, uFNMResource,uDictionary;

{$R *.dfm}

procedure TChangeGFNOForm.PublicQuery;
begin
  GetData();
end;

procedure TChangeGFNOForm.PublicSave;
begin
  SaveData();
end;

procedure TChangeGFNOForm.GetFabricInfo();
var
  sCode,sType : string;
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  try
    ShowMsg('���ڻ�ȡ�����Եȣ�', crHourGlass);
    sType := IntToStr(rgType.ItemIndex);
    sCode := lbledtCode.Text;
    if TGlobal.CheckValueIsNull(sCode,'�����벼��/����!') then Exit;
    sCondition :=QuotedStr(sCode)+','+QuotedStr(Login.CurrentDepartment)+','+QuotedStr(sType);
    FNMServerObj.GetQueryData(vData,'GetReciveInfo',sCondition,sErrorMsg);
//    FNMServerObj.GetReceiveInfo(vData,sCode,Login.CurrentDepartment,sType,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      lbledtOldGFID.Clear;
      lbledtOldJobNO.Clear;
      Exit;
    end;
    cdsFabric.Data := vData;
  finally
    ShowMsg('', crDefault);
  end;
  GridDecorator.BindCxViewWithDataSource(cxGridtvFabric, dsFabric);
  lbledtOldGFID.Text :=  cdsFabric.FieldByName('GF_NO').AsString;
  lbledtOldJobNO.Text := cdsFabric.FieldByName('Job_NO').AsString;
  cxbeGFKey.Clear;
  cbbJobNO.Items.Clear;
  Memo1.Visible := False;
end;

procedure TChangeGFNOForm.GetData();
begin
  GetFabricInfo();
end;

procedure TChangeGFNOForm.SaveChangeGFNO();
var
  iType : Integer;
  sCode,sGFKey,sJobNO,sReason: String;
  sCondition,sErrorMsg: WideString;
begin
  try
    ShowMsg('���ڱ��������Եȣ�', crHourGlass);
    //��⳵������
    rgType.Enabled := False;
    iType := rgType.ItemIndex;
    sCode := lbledtCode.Text;
    sGFKey := cxbeGFKey.Text;
    sJobNO := cbbJobNO.Text;
    sReason := mmoReason.Lines.Text;
    if TGlobal.CheckValueIsNull(sGFKey,'������Ʒ��/ID!') then Exit;
    if TGlobal.CheckValueIsNull(sJobNO,'�������ŵ���!')  then Exit;
    sCondition := QuotedStr(sCode)+','+QuotedStr(sGFKey)+','+
                  QuotedStr(sJobNO)+','+QuotedStr(sReason)+','+QuotedStr(Login.LoginName)+','+
                  QuotedStr(Login.CurrentDepartment)+','+IntToStr(iType);
    FNMServerObj.SaveDataBySQL('ChangeGFNO',sCondition,sErrorMsg);
    //FNMServerObj.ChangeGFNO(sCode,sGFKey,sJobNO,sReason,Login.LoginName,Login.CurrentDepartment,iType, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TMsgDialog.ShowMsgDialog('�������ݳɹ�', mtInformation);
    Memo1.Visible := rgType.ItemIndex = 1;
  finally
    rgType.Enabled := True;
    ShowMsg('', crDefault);
  end;
end;

procedure TChangeGFNOForm.SaveData();
begin
  SaveChangeGFNO();
end;

procedure TChangeGFNOForm.FormCreate(Sender: TObject);
begin
  inherited;
  cxbeGFKey.Properties.Buttons.Items[0].Glyph.LoadFromResourceName(HInstance, RES_QUERYSMALL);
  btnQuery.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
end;

procedure TChangeGFNOForm.FormDestroy(Sender: TObject);
begin
  inherited;
  ChangeGFNOForm := nil;
end;

procedure TChangeGFNOForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TChangeGFNOForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TChangeGFNOForm.btnQueryClick(Sender: TObject);
begin
  inherited;
  GetData();
end;

procedure TChangeGFNOForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveData();
end;

procedure TChangeGFNOForm.rgTypeClick(Sender: TObject);
begin
  inherited;
  if rgType.ItemIndex = 0 then
    lbledtCode.EditLabel.Caption := '����:'
  else
    lbledtCode.EditLabel.Caption := '����:' ;
  lbledtCode.Clear;
  if cdsFabric.Active then
    cdsFabric.EmptyDataSet;
  lbledtOldGFID.Clear;
  lbledtOldJobNO.Clear;
end;

procedure TChangeGFNOForm.cxbeGFKeyPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  cbbJobNO.Items.Text := Dictionary.GetItemList('Ʒ��KEY',cxbeGFKey.Text,'');
  if cbbJobNO.Items.Count > 0 then
   cbbJobNO.ItemIndex := 0
end;

procedure TChangeGFNOForm.cbbJobNOEnter(Sender: TObject);
begin
  inherited;
  if cbbJobNO.Items.Count =  0 then
    cxbeGFKey.Properties.OnButtonClick(cxbeGFKey,0);
end;

procedure TChangeGFNOForm.cxbeGFKeyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = 13 then
    cxbeGFKey.Properties.OnButtonClick(cxbeGFKey,0);
end;

procedure TChangeGFNOForm.lbledtCodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = 13 then
    GetData();
end;

//����ID : 281756    ���ں����޸�Ʒ������,�����ŵ�������λ���볤,лл! tracy tan 2016-12-23	

procedure TChangeGFNOForm.cbbJobNOChange(Sender: TObject);
begin
  inherited;
    lbledtLength.Text := Dictionary.GetItemList('�ŵ�KEY',cxbeGFKey.Text,cbbJobNO.Text);

end;

end.

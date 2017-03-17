unit frmLocateCar;

{******************************************************************************

       ������� FNM
       ��Ȩ���� (C) 2004-2012 ESQUEL GROUP GET/IT
       �������� 2011-5-11 10:54:40
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

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, StdCtrls, Buttons, ExtCtrls;

type
  TLocateCarForm = class(TForm)
    cdsLocateCar: TClientDataSet;
    pnl1: TPanel;
    grp1: TGroupBox;
    cbbCarNO: TComboBox;
    GroupBox1: TGroupBox;
    cbbLocation: TComboBox;
    pnl2: TPanel;
    btnSave: TSpeedButton;
    btnRefresh: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure btnRefreshClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure cbbCarNOEnter(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
    procedure DataSave;
    procedure DataCancel;
    procedure DataQuery;
    function CloseQuery:Boolean;    
    procedure SetBtnState;
    procedure UpdateActions; override;
  public
    { Public declarations }  
    sDept:String;
  end;

var
  LocateCarForm: TLocateCarForm;

implementation

uses ServerDllPub, uFNMArtInfo, uGlobal, uDictionary, uShowMessage, uLogin, uGridDecorator;

{$R *.dfm}

{ TLocateCarForm }

function TLocateCarForm.CloseQuery: Boolean;
begin
  if not TGlobal.DeltaIsNull(cdsLocateCar) then
  begin
    if TMsgDialog.ShowMsgDialog('����δ���棬�Ƿ񱣴棡', mtConfirmation, [mebYes, mebNo], mebYes)= mrYes then
      Result := false;
  end
  else
    Result := True;
end;

procedure TLocateCarForm.DataCancel;
begin
  if cdsLocateCar.Active then
  begin
    cdsLocateCar.CancelUpdates;
    SetBtnState;
  end;
end;

procedure TLocateCarForm.DataQuery;
var
  vData: OleVariant;
  sSQL, sErrMsg: WideString;
begin
  try
    sSQL := QuotedStr(sDept)+ ','+ QuotedStr('Q');

    FNMServerObj.GetQueryData(vData, 'fnLocateCar', sSQL, sErrMsg);
    if sErrMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;

    cdsLocateCar.Data := vData[0];

    if not cdsLocateCar.IsEmpty then
      TGlobal.FillItemsFromDataSet(cdsLocateCar,'Location','','',cbbLocation.Items);
    cdsLocateCar.EmptyDataSet;
    cdsLocateCar.Data := vData[1];
    if not cdsLocateCar.IsEmpty then
      TGlobal.FillItemsFromDataSet(cdsLocateCar,'Car_NO','','',cbbCarNO.Items);

  finally
    SetBtnState;
  end;
end;

procedure TLocateCarForm.DataSave;
var
  sLocation, sCarNO:String;
  sSQL, sErrMsg: WideString;
begin
  try
    //ShowMsg('', crHourGlass);

    sLocation := cbbLocation.Text;
    sCarNO := cbbCarNO.Text;
    if (sCarNO='') or (sLocation= '') then Exit;

    sSQL := QuotedStr(sDept)+ ','
          + QuotedStr('S')+ ','
          + QuotedStr(sLocation)+ ','
          + QuotedStr(sCarNO);
    FNMServerObj.SaveDataBySQL('fnLocateCar', sSQL, sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
      Exit;
    end;

    cbbLocation.Items.Delete(cbbLocation.Items.IndexOf(sLocation));
    cbbCarNO.Items.Delete(cbbCarNO.Items.IndexOf(sCarNO));

    cbbLocation.Text := '';
    cbbCarNO.Text := '';

    Application.MessageBox('����ɹ�!','������ʾ', MB_OK + MB_ICONINFORMATION);
  finally
    SetBtnState;
    //ShowMsg('', crDefault);
  end;
end;

procedure TLocateCarForm.SetBtnState;
begin
  btnSave.Enabled := (cbbLocation.Text<>'') and (cbbCarNO.Text<>'');
end;

procedure TLocateCarForm.btnRefreshClick(Sender: TObject);
begin
  DataQuery;
end;

procedure TLocateCarForm.UpdateActions;
begin
  inherited;
  SetBtnState;
end;

procedure TLocateCarForm.btnSaveClick(Sender: TObject);
begin
  DataSave;
end;

procedure TLocateCarForm.cbbCarNOEnter(Sender: TObject);
begin
  cbbCarNO.SelectAll;
end;

procedure TLocateCarForm.SpeedButton2Click(Sender: TObject);
begin
  Close;
end;

end.

unit frmEditSpecialOTD;
{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmEditSpecialOTD.pas                                         }
{       �������� 2004-8-26 13:50:57                                            }
{       ������Ա zhangjy                                                       }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{       ������Ҫ����/SQL����˵��                                               }
{       ��������  OTD�༭                                                      }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Buttons,  StdCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridCustomPopupMenu, cxGridPopupMenu,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxSplitter, ComCtrls, DBClient, Provider, Menus, ExtCtrls, frmBase,
  cxSpinEdit, cxDropDownEdit, StrUtils, ADODB;

type
  TEditSpecialOTDForm = class(TBaseForm)
    cxgpmOTD: TcxGridPopupMenu;
    pnlValue: TPanel;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    dsDelayOTD: TDataSource;
    cdsDelayOTD: TClientDataSet;
    pnl1: TPanel;
    lbl3: TLabel;
    lbl4: TLabel;
    btnBitQueryDelayOTD1: TBitBtn;
    dtpBegin_Date: TDateTimePicker;
    dtpEnd_Date: TDateTimePicker;
    chkStatus: TCheckBox;
    cxgdDelayOTD1: TcxGrid;
    cxGridDBtvDelayOTD: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    btnUpdateOTD: TBitBtn;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure cxGridDBtvDelayOTDCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnUpdateOTDClick(Sender: TObject);
    procedure btnBitQueryDelayOTD1Click(Sender: TObject);
  private
    { Private declarations }
    procedure Initialize();
    procedure GetOTDInfo();
    procedure GetData();
    procedure SaveOTDInfo();
    procedure SaveData();
  public
    { Public declarations }
  end;

var
  EditSpecialOTDForm: TEditSpecialOTDForm;

implementation

uses ServerDllPub, UShowMessage, uAppOption,uLogin,uGlobal, uDictionary,
  uGridDecorator;

{$R *.dfm}
procedure TEditSpecialOTDForm.Initialize();
begin
  dtpBegin_Date.Date := Date()-1;
  dtpEnd_Date.Date := Date();
end;

procedure TEditSpecialOTDForm.GetOTDInfo();
var vData: OleVariant;
    sBegin_Date,sEnd_Date,sQuery_Type: string;
    sErrorMsg: WideString;
begin
  try
    ShowMsg('���ڻ�ȡ�����Եȣ�',crHourGlass);
    //��ȡOTD��ͳ����Ϣ
    sBegin_Date := DateToStr(dtpBegin_Date.Date);
    sEnd_Date := DateToStr(dtpEnd_Date.Date);
    sQuery_Type := Ifthen(chkStatus.Checked,'1','0');
    FNMServerObj.GetOTDInfo(vData,sBegin_Date,sEnd_Date,sQuery_Type,Login.CurrentDepartment,3,sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsDelayOTD.Data := vData;
    if cdsDelayOTD.RecordCount = 0 then
    begin
      TMsgDialog.ShowMsgDialog('û����Ӧ������,�����²�ѯ',1);
      Exit;
    end;
    GridDecorator.BindCxViewWithDataSource(cxGridDBtvDelayOTD,dsDelayOTD);
  finally
    ShowMsg('',crDefault);
  end;
end;

procedure TEditSpecialOTDForm.GetData();
begin
  GetOTDInfo();
end;

procedure TEditSpecialOTDForm.SaveOTDInfo();
var
  vData: OleVariant;
  sErrorMsg: WideString;
  i,iIs_Active :Integer;
begin
  try
    ShowMsg('���ڱ��������Եȣ�', crHourGlass);
    if TGlobal.DeltaIsNull(cdsDelayOTD) then Exit;
    TempClientDataSet.Data := cdsDelayOTD.Delta;
    vData := VarArrayCreate([0, cdsDelayOTD.ChangeCount - 1], VarVariant);
    i := 0;
    while not TempClientDataSet.Eof do
    begin
      if cdsDelayOTD.Locate('GF_ID;Job_NO',VarArrayOf([TempClientDataSet.Fieldbyname('GF_ID').AsInteger,
                                                       TempClientDataSet.Fieldbyname('Job_NO').AsString]),[]) then
      begin
        if cdsDelayOTD.FieldByName('Is_Active').AsBoolean then
           iIs_Active := 1
        else
           iIs_Active := 0;
        vData[i] := varArrayOf([cdsDelayOTD.FieldByName('Remark').AsString,
                                Login.LoginName,
                                iIs_Active,
                                cdsDelayOTD.FieldByName('GF_ID').AsInteger,
                                cdsDelayOTD.FieldByName('Job_NO').AsString,
                                cdsDelayOTD.FieldByName('Special_Type').AsString,
                                Login.CurrentDepartment]);
      end;
      TempClientDataSet.Next;
      TempClientDataSet.Next;
      Inc(i);
    end;
    FNMServerObj.SaveOTDInfo(vData,2, sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    btnSave.Enabled := cdsDelayOTD.ChangeCount<>0;
    cdsDelayOTD.MergeChangeLog;
    btnSave.Enabled := False;
    TMsgDialog.ShowMsgDialog('�������ݳɹ�', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TEditSpecialOTDForm.SaveData();
begin
  SaveOTDInfo();
end;

procedure TEditSpecialOTDForm.FormCreate(Sender: TObject);
begin
  inherited;
  Initialize();
end;

procedure TEditSpecialOTDForm.FormDestroy(Sender: TObject);
begin
  inherited;
  EditSpecialOTDForm := nil;
end;

procedure TEditSpecialOTDForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TEditSpecialOTDForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;
procedure TEditSpecialOTDForm.btnSaveClick(Sender: TObject);
begin
  SaveData();
end;

procedure TEditSpecialOTDForm.cxGridDBtvDelayOTDCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  btnSave.Enabled := cdsDelayOTD.ChangeCount<>0;
end;

procedure TEditSpecialOTDForm.btnUpdateOTDClick(Sender: TObject);
var
  sErrorMsg: WideString;
begin
  inherited;
  try
    ShowMsg('���ڸ���OTD�����Եȣ�', crHourGlass);
    FNMServerObj.CreateOTDInfo(1,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TMsgDialog.ShowMsgDialog('�������ݳɹ�', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TEditSpecialOTDForm.btnBitQueryDelayOTD1Click(Sender: TObject);
begin
  inherited;
  GetData();
end;

end.


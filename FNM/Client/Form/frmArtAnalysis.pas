unit frmArtAnalysis;
{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmEditOTD.pas                                                }
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
  TArtAnalysisForm = class(TBaseForm)
    dsArtAnalysis: TDataSource;
    cxgpmOTD: TcxGridPopupMenu;
    cdsArtAnalysis: TClientDataSet;
    pnlValue: TPanel;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    lbl1: TLabel;
    dtpQueryDate: TDateTimePicker;
    btnQuery: TBitBtn;
    cxgrid: TcxGrid;
    cxgriddbTV: TcxGridDBTableView;
    cxGridl: TcxGridLevel;
    cbbType: TComboBox;
    Label1: TLabel;
    cxgriddbTVCreate_Date: TcxGridDBColumn;
    cxgriddbTVFN_Card: TcxGridDBColumn;
    cxgriddbTVType: TcxGridDBColumn;
    cxgriddbTVJob_NO: TcxGridDBColumn;
    cxgriddbTVGF_NO: TcxGridDBColumn;
    cxgriddbTVQuantity: TcxGridDBColumn;
    cxgriddbTVReason_Info: TcxGridDBColumn;
    cxgriddbTVChecker: TcxGridDBColumn;
    cxgriddbTVWorker0: TcxGridDBColumn;
    cxgriddbTVQty0: TcxGridDBColumn;
    cxgriddbTVWorker1: TcxGridDBColumn;
    cxgriddbTVQty1: TcxGridDBColumn;
    cxgriddbTVRemark: TcxGridDBColumn;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
  private
    { Private declarations }
    procedure Initialize();
    procedure GetArtAnalysisInfo();
    procedure GetData();
    procedure SaveArtAnalysisInfo();
    procedure SaveData();
  public
    { Public declarations }
  end;

var
  ArtAnalysisForm: TArtAnalysisForm;

implementation

uses ServerDllPub, uShowMessage, uAppOption, uLogin, uGlobal, uDictionary, uGridDecorator;

{$R *.dfm}
procedure TArtAnalysisForm.Initialize();
begin
  dtpQueryDate.Date := Date();
  TcxComboBoxProperties(cxgriddbTVWorker0.Properties).Items.Text :=  Dictionary.GetItemList('����������','','');
  TcxComboBoxProperties(cxgriddbTVWorker1.Properties).Items.Text :=  TcxComboBoxProperties(cxgriddbTVWorker0.Properties).Items.Text;
end;

procedure TArtAnalysisForm.GetArtAnalysisInfo();
var
  vData: OleVariant;
  sErrorMsg: WideString;
  Query_Date: TDateTime;
  iType: Integer;
begin
  try
    ShowMsg('���ڻ�ȡ�����Եȣ�',crHourGlass);
    Query_Date := dtpQueryDate.Date;
    iType := cbbType.ItemIndex;
    FNMServerObj.GetArtAnalysisData(vData,Query_Date,Login.CurrentDepartment,iType,sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsArtAnalysis.Data := vData;
    if cdsArtAnalysis.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('û����Ӧ������,�����²�ѯ',1);
      Exit;
    end;
    GridDecorator.BindCxViewWithDataSource(cxgriddbTV,dsArtAnalysis);
    cxgriddbTV.ApplyBestFit(nil);
  finally
    ShowMsg('',crDefault);
  end;
end;

procedure TArtAnalysisForm.GetData();
begin
  GetArtAnalysisInfo();
end;

procedure TArtAnalysisForm.SaveArtAnalysisInfo;
var
  vData: OleVariant;
  sErrorMsg: WideString;
  i :Integer;
begin
  try
    ShowMsg('���ڱ��������Եȣ�', crHourGlass);
    if TGlobal.DeltaIsNull(cdsArtAnalysis) then Exit;
    TempClientDataSet.Data := cdsArtAnalysis.Delta;
    vData := VarArrayCreate([0, cdsArtAnalysis.ChangeCount - 1], VarVariant);
    i := 0;
    while not TempClientDataSet.Eof do
    begin
      if cdsArtAnalysis.Locate('FN_Card',TempClientDataSet.Fieldbyname('FN_Card').AsString, []) then
      begin
         vData[i] := varArrayOf([cdsArtAnalysis.FieldByName('Create_Date').AsString,
                                 cdsArtAnalysis.FieldByName('FN_Card').AsString,
                                 cdsArtAnalysis.FieldByName('Type').AsString,
                                 cdsArtAnalysis.FieldByName('Worker0').AsString,
                                 cdsArtAnalysis.FieldByName('Qty0').AsString,
                                 cdsArtAnalysis.FieldByName('Worker1').AsString,
                                 cdsArtAnalysis.FieldByName('Qty1').AsString,
                                 cdsArtAnalysis.FieldByName('Remark').AsString,
                                 Login.LoginName,
                                 Login.CurrentDepartment]);
        end;
        TempClientDataSet.Next;
        TempClientDataSet.Next;
        Inc(i);
    end;
    FNMServerObj.SaveArtAnalysisData(vData,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsArtAnalysis.MergeChangeLog;
    TMsgDialog.ShowMsgDialog('�������ݳɹ�', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TArtAnalysisForm.SaveData();
begin
  SaveArtAnalysisInfo();
end;

procedure TArtAnalysisForm.FormCreate(Sender: TObject);
begin
  inherited;
  Initialize();
end;

procedure TArtAnalysisForm.FormDestroy(Sender: TObject);
begin
  inherited;
  ArtAnalysisForm := nil;
end;

procedure TArtAnalysisForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TArtAnalysisForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TArtAnalysisForm.btnSaveClick(Sender: TObject);
begin
  SaveData();
end;

procedure TArtAnalysisForm.btnQueryClick(Sender: TObject);
begin
  GetData();
end;

end.


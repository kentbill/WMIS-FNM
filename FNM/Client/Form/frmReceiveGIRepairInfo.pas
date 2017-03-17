unit frmReceiveGIRepairInfo;
{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmSendInfoCheck.pas                                          }
{       �������� 2004-8-26 16:20:05                                            }
{       ������Ա zhangjy                                                       }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{            ��:                                                               }
{            д:                                                               }
{       ������Ҫ����/SQL����˵��                                               }
{       �������� �Ͳ�ǰ����CHECK                                               }
{                                                                              }
{******************************************************************************}


interface

uses
  uFNMResource, Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, frmBase, StdCtrls, ExtCtrls, OleCtrls, Buttons,
  DB, DBClient, ComCtrls, StrUtils, GFCADLib_TLB, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxSplitter;

type
  TReceiveGIRepairInfoForm = class(TBaseForm)
    cdsGIRepairInfo: TClientDataSet;
    grpSource: TGroupBox;
    lvSource: TListView;
    btnRefresh: TSpeedButton;
    btnSave: TSpeedButton;
    btnClose: TSpeedButton;
    pnl_Only: TPanel;
    btnRight: TSpeedButton;
    btnRightAll: TSpeedButton;
    btnLeft: TSpeedButton;
    btnLeftAll: TSpeedButton;
    grp4: TGroupBox;
    lvDestinate: TListView;
    spl1: TSplitter;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnRightClick(Sender: TObject);
    procedure btnRightAllClick(Sender: TObject);
    procedure btnLeftClick(Sender: TObject);
    procedure btnLeftAllClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure lvSourceClick(Sender: TObject);
    procedure lvSourceDblClick(Sender: TObject);
    procedure lvDestinateClick(Sender: TObject);
    procedure lvDestinateDblClick(Sender: TObject);
    procedure lvSourceColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvDestinateColumnClick(Sender: TObject; Column: TListColumn);
    procedure FormCreate(Sender: TObject);
    procedure lvSourceKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvDestinateKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvDestinateCustomDraw(Sender: TCustomListView;
      const ARect: TRect; var DefaultDraw: Boolean);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
{* -----------------------------------------------------------------------------
   �������� Initialize
   ������Ա zhangjy
   �������� 2004-8-26 14:24:10
   �����б� None
   ����ֵ   None
   �������� ��ʼ���������
   ��������
   �ο��ĵ�

   ����˵��
-------------------------------------------------------------------------------}
    procedure Initialize;
{* -----------------------------------------------------------------------------
   �������� GetData ,GetGIRepairInfo
   ������Ա zhangjy
   �������� 2004-8-26 14:24:39
   �����б� None
   ����ֵ   None
   �������� ��ȡ������Ĳ�����Ϣ
   ��������
   �ο��ĵ�

   ����˵��
-------------------------------------------------------------------------------}
    procedure GetGIRepairInfo;
    procedure GetData;
{* -----------------------------------------------------------------------------
   �������� SaveData,SaveGIRepairInfo
   ������Ա zhangjy
   �������� 2004-8-26 16:19:22
   �����б� None
   ����ֵ   None
   �������� �Ͳ�ǰ����CHECK
   ��������
   �ο��ĵ�

   ����˵��
-------------------------------------------------------------------------------}
    procedure SaveGIRepairInfo;
    procedure SaveData;
  public
    { Public declarations }
{* -----------------------------------------------------------------------------
   �������� PublicQuery ;PublicExport; PublicSave
   ������Ա zhangjy
   �������� 2004-8-31 15:41:59
   �����б� None
   ����ֵ   None
   �������� ��ӦTOOLBAR��Ӧ���¼�
   ��������
   �ο��ĵ�

   ����˵��
-------------------------------------------------------------------------------}
    procedure PublicQuery; override;
    procedure PublicExport; override;
    procedure PublicSave; override;
  end;
var
  ReceiveGIRepairInfoForm: TReceiveGIRepairInfoForm;

implementation

uses ServerDllPub, uGlobal, uShowMessage, uLogin,
  uAppOption;

{$R *.dfm}

procedure TReceiveGIRepairInfoForm.PublicQuery;
begin
  GetData;
end;

procedure TReceiveGIRepairInfoForm.PublicExport;
begin
  TGlobal.SaveDataToFile(cdsGIRepairInfo, sftXLS)
end;

procedure TReceiveGIRepairInfoForm.PublicSave;
begin
  SaveData;
end;

procedure TReceiveGIRepairInfoForm.Initialize;
begin
  //����BUTTONͼƬ
  btnRight.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  btnRightAll.Glyph.LoadFromResourceName(HInstance, RES_DOWNALL);
  btnLeft.Glyph.LoadFromResourceName(HInstance, RES_UP);
  btnLeftAll.Glyph.LoadFromResourceName(HInstance, RES_UPALL);
  btnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnClose.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
end;

procedure TReceiveGIRepairInfoForm.GetGIRepairInfo;
var vData: OleVariant;
    sCondition,sErrorMsg: WideString;
begin
  if lvDestinate.Items.Count > 0 then Exit;
  try
    ShowMsg('���ڻ�ȡ�����Եȣ�', crHourGlass);
    //��ȡ��ȷ�ϵĲ�����Ϣ
    sCondition := 'a.Current_Department ='+QuotedStr(Login.CurrentDepartment);
    FNMServerObj.GetQueryData(vData,'GetGIRepairInfo',sCondition,sErrorMsg);
     if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsGIRepairInfo.Data := vData;
    if cdsGIRepairInfo.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('û�д����յ���������Ĳ���',2);
      Exit;
    end;
    //����ȷ�ϵĿ���ListView
    TGlobal.FillItemsFromDataSet(cdsGIRepairInfo,'',['Fabric_NO','Quantity','GF_ID','GF_NO'],nil,nil,lvSource.Items);
    TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TReceiveGIRepairInfoForm.GetData;
begin
  GetGIRepairInfo;
end;

procedure TReceiveGIRepairInfoForm.SaveGIRepairInfo;
var i: Integer;
  sCondition,sFabric_NO_List, sErrorMsg: WideString;
begin
  inherited;
  try
    ShowMsg('���ڱ��������Եȣ�', crHourGlass);
    if lvDestinate.Items.Count = 0 then Exit;

    sFabric_NO_List := '';
    for i := 0 to lvDestinate.Items.Count - 1 do
      sFabric_NO_List := sFabric_NO_List + lvDestinate.Items[i].Caption + ',';
    sFabric_NO_List := LeftStr(sFabric_NO_List, Length(sFabric_NO_List) - 1);
    sCondition := QuotedStr(sFabric_NO_List)+','+ QuotedStr(Login.CurrentDepartment);
    FNMServerObj.SaveDataBySQL('SaveGIRepairInfo',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    lvDestinate.Items.Clear;
    TMsgDialog.ShowMsgDialog('�������ݳɹ�', mtInformation);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TReceiveGIRepairInfoForm.SaveData;
begin
  SaveGIRepairInfo;
end;

procedure TReceiveGIRepairInfoForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TReceiveGIRepairInfoForm.FormDestroy(Sender: TObject);
begin
  inherited;
  ReceiveGIRepairInfoForm := nil;
end;

procedure TReceiveGIRepairInfoForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  GetData;
end;

procedure TReceiveGIRepairInfoForm.btnRightClick(Sender: TObject);
begin
  TGlobal.MoveData(lvSource, lvDestinate);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TReceiveGIRepairInfoForm.btnRightAllClick(Sender: TObject);
begin
  TGlobal.MoveData(lvSource, lvDestinate, True);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TReceiveGIRepairInfoForm.btnLeftClick(Sender: TObject);
begin
  TGlobal.MoveData(lvDestinate, lvSource);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TReceiveGIRepairInfoForm.btnLeftAllClick(Sender: TObject);
begin
  TGlobal.MoveData(lvDestinate, lvSource, True);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TReceiveGIRepairInfoForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveData;
end;

procedure TReceiveGIRepairInfoForm.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TReceiveGIRepairInfoForm.lvSourceClick(Sender: TObject);
begin
  if lvSource.ItemIndex < 0 then Exit;
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TReceiveGIRepairInfoForm.lvSourceDblClick(Sender: TObject);
begin
  TGlobal.MoveData(lvSource, lvDestinate);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TReceiveGIRepairInfoForm.lvDestinateClick(Sender: TObject);
begin
  if lvDestinate.ItemIndex < 0 then Exit;
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;

procedure TReceiveGIRepairInfoForm.lvDestinateDblClick(Sender: TObject);
begin
  TGlobal.MoveData(lvDestinate, lvSource);
  TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
end;


procedure TReceiveGIRepairInfoForm.lvSourceColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  inherited;
  TGlobal.SortListView(lvSource, Column);
end;

procedure TReceiveGIRepairInfoForm.lvDestinateColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  inherited;
  TGlobal.SortListView(lvDestinate, Column);
end;

procedure TReceiveGIRepairInfoForm.FormCreate(Sender: TObject);
begin
  inherited;
  Initialize;
end;

procedure TReceiveGIRepairInfoForm.lvSourceKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    TGlobal.MoveData(lvSource, lvDestinate);
    TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
  end;
end;

procedure TReceiveGIRepairInfoForm.lvDestinateKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    TGlobal.MoveData(lvDestinate, lvSource);
    TGlobal.SetButtonState(btnRight, btnRightAll, btnLeft, btnLeftAll, lvSource, lvDestinate);
  end;
end;

procedure TReceiveGIRepairInfoForm.lvDestinateCustomDraw(
  Sender: TCustomListView; const ARect: TRect; var DefaultDraw: Boolean);
begin
  inherited;
  btnSave.Enabled := lvDestinate.Items.Count>0;
end;

procedure TReceiveGIRepairInfoForm.FormActivate(Sender: TObject);
begin
  inherited;
  Application.ProcessMessages;
  GetData;
  OnActivate:=nil;
end;

end.

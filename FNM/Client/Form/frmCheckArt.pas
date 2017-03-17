unit frmCheckArt;
            
{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmCheckArt.pas                                               }
{       �������� 2011-9-13 10:56:21                                            }
{       ������Ա                                                               }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{       ������Ҫ����/SQL����˵��                                               }
{       ��������                                                               }
{                                                                              }
{******************************************************************************}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ValEdit, ExtCtrls, DB, DBClient;

type
  TCheckArtForm = class(TForm)
    pnl1: TPanel;
    vlelist: TValueListEditor;
    pnl2: TPanel;
    btnSave: TButton;
    cdsList: TClientDataSet;
    cdsItemPickList: TClientDataSet;
    btnCancel: TButton;
    procedure vlelistKeyPress(Sender: TObject; var Key: Char);
    function CheckValue(sType:String):Boolean;
    procedure vlelistDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    function DataQuery(sType:String):Boolean;
    function DataSave(sType:String):Boolean;
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure vlelistGetPickList(Sender: TObject; const KeyName: String;
      Values: TStrings);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sFactArtID, sFNCard, sIsDip, sOperateType,sGFNO:String;
    //add by vinson for �»�����
    nIsCache: Integer;

    procedure SetInitializeParam(OperateType, IsDip, FNCard, FactArtID,GFNO:String;OnlyShow:Boolean=False);
    procedure SetIsCache(AIsCache: Integer);
  end;

var
  CheckArtForm: TCheckArtForm;

implementation


uses Math, StrUtils, ServerDllPub, uFNMArtInfo, uShowMessage, uLogin, uGlobal;

{$R *.dfm}

function TCheckArtForm.CheckValue(sType:String): Boolean;
var
  sItemName, sItemValue:String;
  i,iCount, iRow:Integer;
begin
  Result := False;

  iCount :=vlelist.Strings.Count-1;
  if iCount<0 then
  begin
    TMsgDialog.ShowMsgDialog('���ݴ���',mtInformation);
    Exit;
  end;

  for i := 1 to ifthen(iCount=0,1) do
  begin
    //sItemName := string(vlelist.Strings.Objects[i]);
    sItemName := vlelist.Keys[i];
    sItemValue := vlelist.Values[vlelist.Keys[i]];;
    if cdsList.Locate('Item_Name;Is_Null',VarArrayOf([sItemName,0]), []) then
    begin
      //���ֵ����Ϊ��
      if sType= 'CheckData' then
      begin
        if sItemValue = '' then
        begin
          TMsgDialog.ShowMsgDialog('ֵ����Ϊ��!',mtWarning);
          vlelist.Row := i;
          Exit;
        end;
      end
      //�����Ⱦ����������
      else if sType= 'ResetData' then
      begin
        vlelist.Values[vlelist.Keys[i]] := '';
      end;
    end;
   end;
   Result := True;
end;

procedure TCheckArtForm.vlelistKeyPress(Sender: TObject; var Key: Char);
var
  iRow:Integer;
begin
  inherited;
  if(Key=#13) then
  begin
    iRow := vlelist.Row;
    vlelist.Row := IfThen(iRow<vlelist.RowCount-1,iRow+1, vlelist.TopRow);
  end;
end;

procedure TCheckArtForm.vlelistDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  i,j:Integer;
  CellText,Chemical_ID:String;
begin
  inherited;
  with Sender as TCustomDrawGrid do
  begin
    if vlelist.RowCount>2 then
    begin
      for i := 1 to vlelist.RowCount-1 do
      begin
        for j:=0 to 0 do
        begin
          Rect:= CellRect(j,i);
          Canvas.Brush.Color := clBtnFace;
          Canvas.FillRect(Rect);
          //Canvas.Font.Color := clBlue;
          Canvas.Font.Style := [fsbold];
          CellText := vlelist.Cells[j, i];
          Canvas.TextRect(Rect, Rect.Left+2, Rect.Top+2, CellText);
        end;
      end;
    end;
  end;
end;

function TCheckArtForm.DataSave(sType:String):Boolean;
var
  sSQL, sErrMsg: WideString;
  i : Integer;
  ItemNameStr,ItemValueStr: string;
begin
  Result := true;
  if not CheckValue('CheckData') then Exit;

  ItemNameStr := '';
  ItemValueStr := '';
  if vlelist.Strings.Text <> '' then
  begin
    for i := 1 to vlelist.RowCount - 1 do
    begin
      ItemNameStr := ItemNameStr + vlelist.Keys[i] + '+';
      ItemValueStr := ItemValueStr + vlelist.Values[vlelist.Keys[i]] + '+';
    end;
  end;

  sSQL := QuotedStr(sIsDip)+','
          +QuotedStr(ItemNameStr)+','
          +QuotedStr(ItemValueStr)+','
          +QuotedStr(Login.CurrentDepartment)+','
          +QuotedStr(Login.LoginID)+','
          +QuotedStr(sFNCard)+','
          +QuotedStr(sFactArtID)+','
          +QuotedStr(cdsList.FieldByName('Operation_Code').AsString);
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('���ڱ��������Ե�...', crHourGlass);
    FNMServerObj.SaveDataBySQL('SaveCheckArtItem',sSQL,sErrMsg);
    if sErrMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg,mtError);
      Result := False;
      Exit;
    end;

    TMsgDialog.ShowMsgDialog('�������ݳɹ�',mtInformation);
    ModalResult := mrOK;
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

function TCheckArtForm.DataQuery(sType: String):Boolean;
var
  vData: OleVariant;
  sSQL, sErrMsg: WideString;
begin
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('���ڻ�ȡ�����Ե�...',crHourGlass);
    sSQL := QuotedStr(sIsDip)+','
            +QuotedStr(sOperateType)+','
            +QuotedStr(login.CurrentDepartment)+','
            +QuotedStr(sFNCard)+','
            +QuotedStr(sFactArtID)+','
            +QuotedStr(sGFNO) + ','
            +IntToStr(nIsCache);  //on 2014-10-28 add by vinson for �»�����
    FNMServerObj.GetQueryData(vData,'GetCheckArtItem',sSQL,sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg,mtError);
      Result := False;
      Exit;
    end;
    cdsList.Data := vData;
    FillItemsFromDataSet(cdsList, 'Item_Name', 'Item_Value', 'Iden', '=', vlelist.Strings, true);
    Result:= True;
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

procedure TCheckArtForm.btnSaveClick(Sender: TObject);
begin
  if not DataSave('') then
    Exit;
end;

procedure TCheckArtForm.FormShow(Sender: TObject);
var
  s:String;
begin
  //SetInitializeParam('007','A11702438','848232');
  if sOperateType= '007' then
    s := 'Ԥ�����ղ���ȷ��'
  else if sOperateType= '022' then
    s := '���͹��ղ���ȷ��'
  else if sOperateType= '999' then  
    s := '�Ͳ�ȷ��';

  s := s+ '��'+ sOperateType+
      ' '+ sFactArtID+
      ' '+ sFNCard+'��' ;

  Self.Caption := s;
  DataQuery('');
end;

procedure TCheckArtForm.vlelistGetPickList(Sender: TObject;
  const KeyName: String; Values: TStrings);
var
  vData: OleVariant;
  sSQL, sErrMsg: WideString;
begin
  if cdsItemPickList.IsEmpty then
  begin
    sSQL := QuotedStr(sOperateType)+','+QuotedStr(login.CurrentDepartment);
    FNMServerObj.GetQueryData(vData,'CheckArtItemPickList',sSQL,sErrMsg);
    if sErrMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrMsg,mtError);
      Exit;
    end;
    cdsItemPickList.Data := vData;
    if cdsItemPickList.IsEmpty then Exit;
  end;

  if Values.Text= '' then
    if cdsItemPickList.Locate('Item_Name',KeyName,[]) then
      Values.Text := cdsItemPickList.FieldByName('Item_Value').AsString;
end;

procedure TCheckArtForm.SetInitializeParam(OperateType, IsDip, FNCard, FactArtID,GFNO: String;OnlyShow:Boolean=False);
begin
  nIsCache := 0;
  
  sOperateType := OperateType;
  sIsDip := IsDip;
  sFNCard := FNCard;
  sFactArtID := FactArtID;
  sGFNO := GFNO;

  btnSave.Visible := not OnlyShow;
  vlelist.Enabled := btnSave.Visible;
  if OnlyShow then
    btnCancel.Caption := 'OK'
  else
    btnCancel.Caption := 'ȡ��';

end;

procedure TCheckArtForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TCheckArtForm.FormDestroy(Sender: TObject);
begin
  CheckArtForm := nil;
end;

procedure TCheckArtForm.SetIsCache(AIsCache: Integer);
begin
  nIsCache := AIsCache;
end;

end.

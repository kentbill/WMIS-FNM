unit uFNMPrescriptionInfo;
{*|<PRE>*****************************************************************************

       ������� FNM CLIENT MODEL
       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT
       ��Ԫ���� uFinishPrescriptionInfo.pas
       �������� 2004-8-24 ���� 05:57:41
       ������Ա lvzd, zhangjy
       �޸���Ա
       �޸�����
       �޸�ԭ��
       ��Ӧ����
       �ֶ�����
       ������ݿ��
       ������Ҫ����/SQL����˵��
       �������� �������׼������,ʵ�ʴ�����,���ϵ���,��ȡ���ϵ�����ֵ亯��.

******************************************************************************}

interface

uses
   DB, DBClient, Classes, SysUtils, StrUtils, Grids, Valedit, Windows,
   ServerDllPub, Forms, UFNMResource, uGlobal, uFNMArtInfo, ComCtrls,
   uShowMessage, Dialogs, uDictionary, Variants;

type
  {TRecipeBase}
  TRecipeBase=class
  {* ��׼������, ʵ�ʴ�����, ���ϵ��Ļ���}
  Private
    { Private declarations }
    FOrgIden_NO: String;
    {* ԭʼ���Ž����ڴ�}
    Fcds_PrescriptionHdr: TClientDataSet;
    {* ��������������ݼ�, һ��ֻ��һ����¼}
    Fcds_PrescriptionDtl: TClientDataSet;
    {* }
    Fcds_PrescriptionDtl2: TClientDataSet;
    {* }
    FModify: Boolean;
    {* �����Ƿ��޸�}

    FOnAfterEdit: TNotifyEvent;
    {* FAfterEdit}
    FOnBeforeSave: TNotifyEvent;
    {* FBeforeSave}
    FOnAfterSave: TNotifyEvent;
    {* FAfterSave}
    FOnAfterOpen: TNotifyEvent;
    {* FAfterOpen}
    FOnAfterClose: TNotifyEvent;
    {* FOnAfterClose}

    procedure SetModify(ModifyValue: Boolean);
    {* ��ʶ���޸�}
    procedure SetOrgIden_NO(OrgIden_NOValue: String);
    {* ����ԭʼ��������,����ʱ�Զ�ȥ�����ݼ���}
    function  GetActive: Boolean;
    {* �ж��䷽���Ƿ��Ѵ�}
    function GetIncludeCardList: String;
  protected
    function  GetFieldValue(Index: integer): Variant;
    {* ��ȡ����Index�ֶε�ֵ}
    procedure SetFieldValue(Index: integer; FieldValue: Variant);
    {* ��������ĳ���ֶε�ֵ}
  public
    { public declarations }
    constructor Create(AOwner: TComponent);
    {* Create}
    destructor Destroy; override;
    {* Destroy}
    procedure Open; virtual;
    {* ���䷽��}
    function Close: Boolean;
    {* �ر��䷽��, �ر�֮ǰ��ѯ���û��Ƿ񱣴��޸ĵ�����.}
    function  SaveRecipeToDataBase: Boolean; virtual;
    {* �����䷽��}
    function  SavePrescriptionToLocal: Boolean;
    {* �����䷽��������}
    function  IsEmpty: Boolean;
    {* �ж��䷽�������Ƿ�Ϊ��}
    procedure AddAChemical(Chemical_ID: Integer);
    {* ׷��һ��������}
    procedure ReMoveAChemical(Chemical_ID: Integer);
    {* ɾ��һ��������}
    procedure SetAChemicalUnit_QTY(Chemical_ID: Integer; Unit_QTY: String);
    {* ����ĳ�������ϵĵ�λ����}
    procedure FillChemicalToAListControl(AItem: TStrings); 
    {* ��仯���ϵ��б���}
    procedure FillCardListToAListView(AListItem: TListItems);
    {* ��俨�ŵ��б���}
    procedure DeleteACard(FN_Card: String);
    {* ɾ�������Ŀ���}
    procedure SetEditStyle(AValueListEditor: TValueListEditor);
    {* ���û����ϱ༭���ı༭��ʽ}
    procedure GetPickListString(Const KeyName: String; Values: TStrings);
    {* ��ȡ�����б���б�ѡ��}
    procedure GetEditMask(Chemical_ID: Integer; var EditMaskValue: String);
    {* ȡ�༭��ʽ}
    procedure DoAfterOpen(Sender: TObject);
    {* ִ��AfterOpen�¼�}
  published
    { published declarations }
    property OnAfterEdit: TNotifyEvent read FOnAfterEdit write FOnAfterEdit;
    {* property AfterEdit}
    property OnBeforeSave: TNotifyEvent read FOnBeforeSave write FOnBeforeSave;
    {* property BeforeSave}
    property OnAfterSave: TNotifyEvent read FOnAfterSave write FOnAfterSave;
    {* property AfterSave}
    property OnAfterOpen: TNotifyEvent read FOnAfterOpen write FOnAfterOpen;
    {* property AfterOpen}
    property OnAfterClose: TNotifyEvent read FOnAfterClose write FOnAfterClose;
    {* property OnAfterClose}

    property Modify: Boolean read FModify write SetModify;
    {* �䷽���Ƿ��޸�}
    property Active: Boolean read GetActive;
    {* �䷽���Ƿ��}
    property OrgIden_NO: String read FOrgIden_NO write SetOrgIden_NO;
    {* ԭʼ����,�����ڴ�}
  end;

  {TRecipeInfo}
  TRecipeInfo=class(TRecipeBase)
  private
  {* ��׼��������}
  public
    procedure Open; override;
    {* �򿪱�׼�䷽��}
    procedure CreateRecipe(Operation_Code, Current_Department, Creator: String);
    {* ������׼�䷽��}
    procedure AddCard(FNCard, GFNO: String; Quantity: Single);
    {* ���ӿ���}
    procedure RemoveCard(FNCard: String);
    {* �Ƴ�����}
    procedure FillStepToItems(AItems: TStrings);
    {* }
    procedure SetCurrentSteps(StepID: Integer);
    {* }
//    procedure SelectIncludeCard;
//    {* ���ø�ʵ�ʴ����������Ŀ���}
    procedure CheckRecipe(Checker: String);
    {* ȷ�ϱ�׼����}
    function  SaveRecipeToDataBase: Boolean; override;
    {* ���湤�յ����ݿ�}

    property Recipe_NO          :Variant index 1  read GetFieldValue write SetFieldValue;
    {* ���ϵ���}
    property Prescrip_NO        :Variant index 2  read GetFieldValue write SetFieldValue;
    {* �䷽��}
    property Operation_Code     :Variant index 3  read GetFieldValue write SetFieldValue;
    {* ����}
    property Operation_CHN      :Variant index 4  read GetFieldValue write SetFieldValue;
    {* ����}
    property Machine_ID         :Variant index 5  read GetFieldValue write SetFieldValue;
    {* ��̨}
    property Pre_DryTemperature :Variant index 6  read GetFieldValue write SetFieldValue;
    {* Ԥ���¶�}
    property Dry_Temperature    :Variant index 7  read GetFieldValue write SetFieldValue;
    {* ����¶�}
    property Flood_Class        :Variant index 8  read GetFieldValue write SetFieldValue;
    {* ��������}
    property Flood_Percent      :Variant index 9  read GetFieldValue write SetFieldValue;
    {* ������}
    property Sample_Type        :Variant index 10 read GetFieldValue write SetFieldValue;
    {* ��������}
    property Need_Trace         :Variant index 11 read GetFieldValue write SetFieldValue;
    {* �Ƿ���Ҫ����}
    property Fact_Volume        :Variant index 12 read GetFieldValue write SetFieldValue;
    {* ʵ�����}
    property Remark             :Variant index 13 read GetFieldValue write SetFieldValue;
    {* ��ע}
    property Current_Department :Variant index 14 read GetFieldValue write SetFieldValue;
    {* ��ǰ����}
    property Operator           :Variant index 15 read GetFieldValue write SetFieldValue;
    {* ������}
    property Operate_Time       :Variant index 16 read GetFieldValue write SetFieldValue;
    {* ����ʱ��}
    property Checker            :Variant index 17 read GetFieldValue write SetFieldValue;
    {* ȷ����}
    property Check_Time         :Variant index 18 read GetFieldValue write SetFieldValue;
    {* ȷ��ʱ��}
  end;

{TBatchRecipe}
  TBatchRecipe=class(TRecipeBase)
  {* ʵ�ʴ�������}
  public
    procedure Open; override;
    {* �򿪴�����}
    procedure FillStepToItems(AItems: TStrings);
    {* ��������䵽�б���}
    procedure SetCurrentSteps(StepID: Integer);
    {* }
    function  SaveRecipeToDataBase: Boolean; override;
    {* ���洦���������ݿ�}

    property Recipe_NO             :Variant index 1  read GetFieldValue;
    {* �䷽��}
    property Prescrip_NO           :Variant index 2  read GetFieldValue;
    {* }
    property Operation_CHN         :Variant index 3  read GetFieldValue;
    {* ����}
    property Batch_NO              :Variant index 4  read GetFieldValue;
    {* �׺�}
    property Machine_Name          :Variant index 5  read GetFieldValue;
    {* ��̨}
    property Pre_DryTemperature    :Variant index 6  read GetFieldValue;
    {* Ԥ���¶�}
    property Dry_Temperature       :Variant index 7  read GetFieldValue;
    {* ����¶�}
    property Flood_Class           :Variant index 8  read GetFieldValue;
    {* ��������}
    property Flood_Percent         :Variant index 9  read GetFieldValue;
    {* ������}
    property Vat_Code              :Variant index 10 read GetFieldValue;
    {* �׺�}
    property Volume                :Variant index 11  read GetFieldValue;
    {* ���}
    property Status                :Variant index 12  read GetFieldValue;
    {* ״̬}
    property Remark                :Variant index 13  read GetFieldValue;
    {* ��ע}
    property Operator              :Variant index 14  read GetFieldValue;
    {* ������}
    property Operate_Time          :Variant index 15  read GetFieldValue;
    {* ����ʱ��}
    property Checker               :Variant index 16  read GetFieldValue;
    {* ȷ����}
    property Check_time            :Variant index 17  read GetFieldValue;
    {* ȷ��ʱ��}
  end;
//
//{TRecipeDtlInfo}
//  TRecipeDtlInfo=class(TRecipeBase)
//  {* ���ϵ���}
//  Private
//    FFactPrescription: TBatchRecipe;
//    {* �ô�������ʹ�õ�ʵ���䷽��}
//
//    function  GetFactPrescription: TBatchRecipe;
//    {* }
//  public
//    constructor Create(AOwner: TComponent);
//    {* Create}
//    destructor Destroy; override;
//    {* Destroy}
//
//    procedure Open; override;
//    {* �򿪻��ϵ�}
//    procedure CalculateChemicalDosage;
//    {* ����ÿ�ֻ������ڸõ������� }
//    procedure FillPrescriptionDtlToAListControls(AItem: TListItems);
//    {* ����䷽�����б���}
//    function  SaveRecipeToDataBase: Boolean; override;
//    {* ���滯�ϵ���Ϣ�����ݿ���}
//    function  DeleteCurRecipe: Boolean;
//    {* ɾ��������}
//    procedure PrintPreView;
//
//    property Recipe_NO           :Variant index 1  read GetFieldValue;
//    {* ���ϵ���}
//    property Prescrip_NO         :Variant index 2  read GetFieldValue;
//    {* ��������
//    |<B><I>��׼�䷽��</I></B>��}
//    property Prescrip_Type       :Variant index 3  read GetFieldValue;
//    {* Prescrip_NO������,1Ϊʵ�ʴ�����,0Ϊ��׼������}
//    property Operation_Code     :Variant index 4  read GetFieldValue;
//    {* �������}
//    property Operation_CHN       :Variant index 5  read GetFieldValue;
//    {* �������}
//    property Quantity            :Variant index 6  read GetFieldValue;
//    {* �����������Ŀ��ŵ��볤���ܺ�}
//    property Base_Volume         :Variant index 7  read GetFieldValue  write SetFieldValue;
//    {* �����������,����ʵ���ϲ۵��ݻ�,һ�����û�����}
//    property Theory_Volume       :Variant index 8  read GetFieldValue;
//    {* �������=Sum_QTY*Chemical_Ratio}
//    property Sum_Volume          :Variant index 9 read GetFieldValue;
//    {* �ܻ������=Theory_Volume+Base_Volume}
//    property Recipe_Status       :Variant index 10 read GetFieldValue;
//    {* ���ϵ�״̬:0 �Ѿ����� 1 �ѻ��� 2 �����}
//    property Machine_ID          :Variant index 11 read GetFieldValue  write SetFieldValue;
//    {* �ӹ���̨}
//    property Current_Department  :Variant index 12 read GetFieldValue;
//    {* �û��ϵ���������}
//    property Fact_Volume         :Variant index 13 read GetFieldValue  write SetFieldValue;
//    {* ʵ�ʻ������:�ն˻��������,��Щ�ϵ�Ҫ�ּ��λ���}
//    property Scrap_Volume        :Variant index 14 read GetFieldValue;
//    {* �������:��Щ�ϻ��˵���ʧЧҪ�ŷŵ�}
//    property Reciper             :Variant index 15 read GetFieldValue;
//    {* ������}
//    property Begin_Time          :Variant index 16 read GetFieldValue;
//    {* ��ʼ����ʱ��}
//    property End_Time            :Variant index 17 read GetFieldValue;
//    {* ����ʱ��}
//    property Operator            :Variant index 18 read GetFieldValue;
//    {* ���ϵ�������}
//    property Operate_Time        :Variant index 19 read GetFieldValue;
//    {* ���ϵ�����ʱ��}
//  published
//    property FactPrescription: TBatchRecipe read GetFactPrescription;
//    {* �ô�������ʹ�õ�ʵ���䷽��}
//  end;
//
procedure GetNoFinishRecipe(cds: TClientDataSet; VatStudio: String);
{*|<PRE>------------------------------------------------------------------------------
   ������Ա: lvzd
   ��������: 2004-9-17 9:58:14
   �����б�: cds: TClientDataSet; VatStudio: ���Ϸ����Ż��Ŵ���
   ����ֵ  : ��
   ��������: ȡ��ǰ���Ż��Ϸ�û��û����ɵĻ��ϵ�
   ����˵��:
-------------------------------------------------------------------------------}

implementation

procedure GetNoFinishRecipe(cds: TClientDataSet; VatStudio: String);
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  FNMServerArtObj.GetNoFinishRecipe(VatStudio, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetNoFinishRecipe, [sErrorMsg]);

  cds.Data:=vData;
  if cds.IsEmpty then
    raise Exception.CreateRes(@EMP_NoFinishRecipe);
end;

{TRecipeBase}

constructor TRecipeBase.Create(AOwner: TComponent);
begin
  inherited Create;

  Fcds_PrescriptionHdr:=TClientDataSet.Create(AOwner);
  Fcds_PrescriptionDtl:=TClientDataSet.Create(AOwner);
  Fcds_PrescriptionDtl2:=TClientDataSet.Create(AOwner);
end;

destructor TRecipeBase.Destroy;
begin
  if not Close then exit;

  Fcds_PrescriptionHdr.Destroy;
  Fcds_PrescriptionDtl.Destroy;
  Fcds_PrescriptionDtl2.Destroy;
  inherited Destroy;
end;

procedure TRecipeBase.SetModify(ModifyValue: Boolean);
begin
  if FModify = ModifyValue then exit;
  if not Active then
  begin
    FModify:=false;
    exit;
  end;

  FModify := ModifyValue;
  if Assigned(FOnAfterEdit) then FOnAfterEdit(Self);
end;

procedure TRecipeBase.SetOrgIden_NO(OrgIden_NOValue: String);
begin
  if FOrgIden_NO = OrgIden_NOValue then exit;
    
  Close;
  FOrgIden_NO:=OrgIden_NOValue;
end;

function TRecipeBase.GetActive: Boolean;
begin
  result:=Fcds_PrescriptionHdr.Active and Fcds_PrescriptionDtl.Active;
end;

procedure TRecipeBase.Open;
begin
end;

function TRecipeBase.Close: Boolean;
var
  MessResult: Integer;
begin
  result := False;
  //�ж��û��Ƿ񱣴����޸����ݣ�û�б���ѯ���û���
  if Active and Modify then
  begin
    MessResult:=MessageBox(Application.Handle, Pchar(GetResourceString(@AskSaveDataStr)),Pchar(Application.Title), MB_YESNOCANCEL+MB_ICONQUESTION);
    if (MessResult = IDYES) and (not SaveRecipeToDataBase ) then
      raise Exception.Create(GetResourceString(@SaveDataFail));

    if MessResult = IDNO then
    begin
      Fcds_PrescriptionHdr.CancelUpdates;
      Fcds_PrescriptionDtl.CancelUpdates;
      Modify:=false;
    end;

    if MessResult = IDCANCEL then
      exit;
  end;

  Fcds_PrescriptionHdr.Close;
  Fcds_PrescriptionDtl.Close;
  Fcds_PrescriptionDtl2.Close;
  if Assigned(OnAfterClose) then OnAfterClose(self);
  result := True;
end;

function TRecipeBase.SaveRecipeToDataBase: Boolean;
begin
  result := False;
end;

function TRecipeBase.SavePrescriptionToLocal: Boolean;
var
  FileName: String;
begin
  result := False;
  Fcds_PrescriptionHdr.MergeChangeLog;//*.hdr
  Fcds_PrescriptionDtl.MergeChangeLog;//*.dtl
  {TODO -oPublic: ��ӱ��浽���صĴ���}
  PromptForFileName(FileName, '���������ļ�(*.Art)|*.Art', 'Art', '���Ϊ');
//  �ݳƲ�Ҫʹ��XML��ʽ,Ӧ��ʹ�ö����Ƹ�ʽ,ӦΪ�����¼�а����Ƿ����ַ�����LOADʱ�ᷢ�������Ĵ��� }
//  Fcds_ArtHdr.SaveToFile(FileName, dfXML);
end;

function TRecipeBase.IsEmpty: Boolean;
begin
  result:=Fcds_PrescriptionHdr.IsEmpty;
end;

procedure TRecipeBase.AddAChemical(Chemical_ID: Integer);
var
  Tmep_cds: TClientDataSet;
begin
  Tmep_cds:=Dictionary.cds_ChemicalList;
  if (Tmep_cds = nil) or (not Tmep_cds.Active) then
    exit;
    
  with Dictionary.cds_ChemicalList do
  try
    Fcds_PrescriptionHdr.DisableControls;

    if Locate('Chemical_ID', Chemical_ID,[]) then
    begin
      if not Fcds_PrescriptionDtl.Locate('Chemical_ID', Chemical_ID,[])then
      begin
        Fcds_PrescriptionDtl.Append;
        //Record([nil,
        //    Chemical_ID, FieldByName('Chemical_Name').AsString,
        //    nil,         FieldByName('Unit').AsString]);
        Fcds_PrescriptionDtl['Chemical_ID']:=Chemical_ID;
        Fcds_PrescriptionDtl['Chemical_Name']:=FieldByName('Chemical_Name').AsString;
        Fcds_PrescriptionDtl['Unit']:=FieldByName('Unit').AsString;
        //Fcds_PrescriptionDtl['Unit_QTY']:= StrToFloat('0.0000');
        Modify:=true;
      end
    end
    else
      TMsgDialog.ShowMsgDialog(GetResourceString(@InvalidChemical_ID),2500);
  finally
    Fcds_PrescriptionHdr.EnableControls;
  end;
end;

procedure TRecipeBase.ReMoveAChemical(Chemical_ID: Integer);
begin
  if Fcds_PrescriptionDtl.Locate('Chemical_ID', Chemical_ID,[]) then
  begin
    Fcds_PrescriptionDtl.Delete;
    Modify:=true;
  end;
end;

procedure TRecipeBase.SetAChemicalUnit_QTY(Chemical_ID: Integer; Unit_QTY: String);
var
  tempe: Extended;
begin
  if not TryStrToFloat(Unit_QTY, tempe)then
    raise Exception.CreateResFmt(@INV_NOItemValue, ['Numeric', 'Numeric']);

  if tempe <= 0 then
    raise Exception.CreateResFmt(@INV_ValueIsLessThenZero, ['']);

  if Fcds_PrescriptionDtl.Locate('Chemical_ID', Chemical_ID,[]) then
  begin
    Fcds_PrescriptionDtl.Edit;
    Fcds_PrescriptionDtl.FieldByName('Unit_QTY').AsString:= Unit_QTY;
    Modify:=true;
  end
  else
    raise Exception.CreateRes(@DataError);
end;

procedure TRecipeBase.FillChemicalToAListControl(AItem: TStrings);
begin
  FillItemsFromDataSet(Fcds_PrescriptionDtl, 'Chemical_Name', 'Unit_QTY', 'Chemical_ID' , '=', AItem)
end;

procedure TRecipeBase.SetEditStyle(AValueListEditor: TValueListEditor);
var
  i: Integer;
begin
  for i := 0 to AValueListEditor.RowCount - 1 do
  begin
    if Trim(AValueListEditor.Cells[0,i]) = '����' then
      AValueListEditor.ItemProps[i-1].EditStyle:=esPickList;
//    if Trim(AValueListEditor.Cells[0,i]) = '����' then
//      AValueListEditor.ItemProps[i-1].EditStyle:=esPickList;
  end;
end;

procedure TRecipeBase.GetPickListString(Const KeyName: String; Values: TStrings);
begin
//  if Trim(KeyName) = '����' then
//  begin
//    Values.Add('90');
//    Values.Add('80');
//    Values.Add('70');
//  end
end;

procedure TRecipeBase.GetEditMask(Chemical_ID: Integer; 
  var EditMaskValue: String);
//var
//  Chemical_Type: String;
begin
  EditMaskValue:='###.####';
//  with Dictionary.cds_ChemicalList do
//  begin
//    if not Locate('Chemical_ID', Chemical_ID, []) then exit;
//    Chemical_Type:=FieldByName('Chemical_Type').AsString;
//    if (Chemical_Type = '�����') or (Chemical_Type = '��͸��') or (Chemical_Type = '�˽�ø')then
//      EditMaskValue:='###'
//    else if Chemical_Type = 'Ⱦ��' then
//      EditMaskValue:='#.####'
//    else if (Chemical_Type = '��') or (Chemical_Type = 'ӫ�����׼�')  then
//      EditMaskValue:='##.##'
//    else
//      EditMaskValue:='###.#'
//  end
end;

procedure TRecipeBase.DoAfterOpen(Sender: TObject);
begin
  if Assigned(OnAfterOpen) then
    OnAfterOpen(Sender);
end;

function TRecipeBase.GetFieldValue(Index: integer): Variant;
begin
  result:='';
  if (not Active) or IsEmpty then exit;

  result:=Fcds_PrescriptionHdr.Fields.Fields[Index - 1].Value;
  if Fcds_PrescriptionHdr.Fields.Fields[Index - 1].IsNull then
  begin
    result:='';
//    case Fcds_ArtHdr.Fields.Fields[Index - 1].DataType of   
//      ftString: result:='';
//    end;
  end
end;

procedure TRecipeBase.SetFieldValue(Index: integer; FieldValue: Variant);
begin
  if (not Active) or IsEmpty then exit;

  if VarCompareValue(Fcds_PrescriptionHdr.Fields.Fields[Index - 1].Value, FieldValue) <> vrEqual then
  begin
    Fcds_PrescriptionHdr.Edit;
    Fcds_PrescriptionHdr.Fields.Fields[Index - 1].Value := FieldValue;
  end;
  Modify:=true;
end;

procedure TRecipeBase.FillCardListToAListView(
  AListItem: TListItems);
begin
  FillListItemsFromDataSet(Fcds_PrescriptionDtl2, 'FN_Card', '', ['GF_NO', 'Quantity'], AListItem);
end;

function TRecipeBase.GetIncludeCardList: String;
var
  i: Integer;
begin
  result:='';
  if (not Fcds_PrescriptionDtl2.Active) or Fcds_PrescriptionDtl2.IsEmpty then exit;

  Fcds_PrescriptionDtl2.First;
  for i := 0 to Fcds_PrescriptionDtl2.RecordCount - 1 do
  begin
    result := result + Fcds_PrescriptionDtl2['FN_Card'] + ',';
    Fcds_PrescriptionDtl2.Next;
  end;
end;

procedure TRecipeBase.DeleteACard(FN_Card: String);
begin
  if (not Fcds_PrescriptionDtl2.Active) or Fcds_PrescriptionDtl2.IsEmpty then exit;
  if Fcds_PrescriptionDtl2.Locate('FN_Card', FN_Card, []) then
    Fcds_PrescriptionDtl2.Delete;
end;

{TRecipeInfo}
procedure TRecipeInfo.Open;
var
  sErrorMsg: WideString;
  vDataHdr, vDataDtl, vDataCard: OleVariant;
begin
  Close;

  FNMServerArtObj.GetRecipeInfo(OrgIden_NO, vDataHdr, vDataDtl, vDataCard, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@GetAssiPrescriptionError, [sErrorMsg]);

  Fcds_PrescriptionHdr.Data:=vDataHdr;
  Fcds_PrescriptionDtl.Data:=vDataDtl;
  Fcds_PrescriptionDtl2.Data:=vDataCard;
  
  if IsEmpty then
  begin
    Close;
    raise Exception.CreateRes(@EMP_STDPrescription);
  end;

  DoAfterOpen(Self);
  Modify:=false;
end;

procedure TRecipeInfo.CheckRecipe(Checker: String);
var
  sErrorMsg: WideString;
begin
  if (not Active) or IsEmpty then
    raise Exception.CreateRes(@EMP_STDPrescription);

  //�ȱ���!
  if Modify then
    SaveRecipeToDataBase;

  //��������
  FNMServerArtObj.SaveCheckRecipe(Checker, Recipe_NO, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveCheckArtData, [sErrorMsg]);

  if Assigned(FOnAfterSave) then FOnAfterSave(Self);
  ShowMsgDialog(@MSG_SaveCheckPrescriptionSuccess, mtInformation);
end;

function  TRecipeInfo.SaveRecipeToDataBase: Boolean;
var
  sErrorMsg: WideString;
begin
  result := True;
  if (not Active) or (not Modify) or IsEmpty then exit;
  if Fcds_PrescriptionDtl2.IsEmpty then
    raise Exception.CreateRes(@INV_NOCardSelected);
    
  if Assigned(FOnBeforeSave) then FOnBeforeSave(Self);
  Fcds_PrescriptionHdr.MergeChangeLog;
  Fcds_PrescriptionDtl.MergeChangeLog;
  Fcds_PrescriptionDtl2.MergeChangeLog;

  //��������
  FNMServerArtObj.SaveHandRecipe(GetIncludeCardList, Fcds_PrescriptionHdr.Data, Fcds_PrescriptionDtl.Data, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveAssiPrescription, [sErrorMsg]);

  result:=true;
  Modify:=false;
  if Assigned(FOnAfterSave) then FOnAfterSave(Self);
  ShowMsgDialog(@MSG_SaveRecipeSuccess, mtInformation);
end;

procedure TRecipeInfo.CreateRecipe(Operation_Code, Current_Department, Creator: String);
begin
  Close;
  OrgIden_NO:='';
  with Fcds_PrescriptionHdr do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('Recipe_NO',          ftString, 12);
    FieldDefs.Add('Prescrip_NO',        ftString, 12);
    FieldDefs.Add('Operation_Code',     ftString, 3 );
    FieldDefs.Add('Operation_CHN',      ftString, 20 );
    FieldDefs.Add('Machine_ID',         ftString, 4 );
    FieldDefs.Add('Pre_DryTemperature', ftBCD,    2 );
    FieldDefs.Add('Dry_Temperature',    ftBCD,    2 );
    FieldDefs.Add('Flood_Class',        ftString, 8 );
    FieldDefs.Add('Flood_Percent',      ftString, 2 );
    FieldDefs.Add('Sample_Type',        ftSmallint  );
    FieldDefs.Add('Need_Trace',         ftSmallint  );
    FieldDefs.Add('Fact_Volume',        ftInteger   );
    FieldDefs.Add('Remark',             ftString, 150);
    FieldDefs.Add('Current_Department', ftString, 2 );
    FieldDefs.Add('Operator',           ftString, 20);
    FieldDefs.Add('Operate_Time',       ftDateTime  );
    FieldDefs.Add('Checker',            ftString, 20);
    FieldDefs.Add('Check_Time',         ftDateTime  );

    CreateDataSet;
    Append;
    FieldByName('Operation_Code').AsString:=Operation_Code;
    if Dictionary.cds_OperationHdrList.Locate('Operation_Code', Operation_Code, []) then
      FieldByName('Operation_CHN').AsString:=Dictionary.cds_OperationHdrList['Operation_CHN'];
    FieldByName('Current_Department').AsString:=Current_Department;
    FieldByName('Operator').AsString:=Creator;
    FieldByName('Operate_Time').AsDateTime:=now;
    FieldByName('Flood_Class').AsString:='ѭ������';
    FieldByName('Flood_Percent').AsString:='С';
    FieldByName('Flood_Class').Value:=0;
    FieldByName('Need_Trace').Value:=0;
    FieldByName('Sample_Type').Value:=0;
    //FieldByName('Is_Active').AsBoolean:=true;
  end;

  with Fcds_PrescriptionDtl do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('Iden', ftInteger);
    FieldDefs.Add('Chemical_ID', ftInteger);
    FieldDefs.Add('Chemical_Name', ftString, 100);
    FieldDefs.Add('Unit_QTY', ftBCD, 4);
    FieldDefs.Add('Unit', ftString, 5);
    CreateDataSet;
  end;

  with Self.Fcds_PrescriptionDtl2 do
  begin
    FieldDefs.Clear;

    FieldDefs.Add('FN_Card', ftString, 9);
    FieldDefs.Add('GF_NO', ftString, 20);
    FieldDefs.Add('Quantity', ftBCD, 2);

    CreateDataSet;
  end;
  DoAfterOpen(Self);
  Modify:=true;
end;

//procedure TRecipeInfo.SelectIncludeCard;
//begin
////{$IFNDEF TERMINAL}
////  SelectCardForFactPrescrip(Operation_Code, GF_ID, Fcds_PrescriptionDtl2);
////  if Fcds_PrescriptionDtl2.ChangeCount <> 0 then
////    Modify:=True;
////{$ENDIF};
//end;
//
procedure TRecipeInfo.FillStepToItems(AItems: TStrings);
var
  i: Integer;
begin
  i:=0;
  Fcds_PrescriptionDtl.First;
  while not Fcds_PrescriptionDtl.Eof do
  begin
    if i < Fcds_PrescriptionDtl['Step_ID'] then
    begin
      inc(i);
      AItems.Add(Format('��%d��', [i]));
    end;
    Fcds_PrescriptionDtl.Next;
  end;
end;

procedure TRecipeInfo.SetCurrentSteps(StepID: Integer);
begin
  Fcds_PrescriptionDtl.Filter:=Format('Step_ID = %d', [StepID]);
  Fcds_PrescriptionDtl.Filtered:=True;
end;

procedure TRecipeInfo.AddCard(FNCard, GFNO: String;
  Quantity: Single);
begin
  Fcds_PrescriptionDtl2.AppendRecord([FNCard, GFNO, Quantity]);
end;

procedure TRecipeInfo.RemoveCard(FNCard: String);
begin
  if Fcds_PrescriptionDtl2.Locate('FN_Card', FNCard, []) then
    Fcds_PrescriptionDtl2.Delete;
end;

{TBatchRecipe}
procedure TBatchRecipe.FillStepToItems(AItems: TStrings);
var
  i: Integer;
begin
  for i := 0 to Fcds_PrescriptionDtl2.RecordCount - 1 do
  begin
    AItems.Add(Format('��%s��', [Fcds_PrescriptionDtl2['Step_ID']]));
    Fcds_PrescriptionDtl2.Next;
  end;
end;

procedure TBatchRecipe.Open;
var
  sErrorMsg: WideString;
  vDataHdr, vDataStep, vDataStepDtl: OleVariant;
begin
  Close;

  //FNMServerArtObj.GetBatchInfo(OrgIden_NO, vDataHdr, vDataStep, vDataStepDtl, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetBatchInfo, [sErrorMsg]);
    
  Fcds_PrescriptionHdr.Data:=vDataHdr;
  Fcds_PrescriptionDtl.Data:=vDataStepDtl;
  Fcds_PrescriptionDtl2.Data:=vDataStep;

  DoAfterOpen(Self);
  Modify:=false;
end;

procedure TBatchRecipe.SetCurrentSteps(StepID: Integer);
begin
  Fcds_PrescriptionDtl.Filter:=Format('Step_ID = %d', [StepID]);
  Fcds_PrescriptionDtl.Filtered:=True;
end;

function  TBatchRecipe.SaveRecipeToDataBase: Boolean;
var
  vDataDtl: OleVariant;
  sErrorMsg: WideString;
  UpdateMode: TUpdateStatus;
begin
  result:=True;
  if (not Active) or (not Modify) or IsEmpty then exit;

   //��������
  if Assigned(FOnBeforeSave) then FOnBeforeSave(Self);
  if Fcds_PrescriptionHdr.FieldByName('Prescrip_NO').IsNull then UpdateMode:=usInserted else UpdateMode:=usModified;
  Fcds_PrescriptionHdr.MergeChangeLog;
  Fcds_PrescriptionDtl.MergeChangeLog;
  vDataDtl:=Fcds_PrescriptionDtl.Data;

  FNMServerArtObj.SaveFactAssiPrescription(Integer(UpdateMode), '', Fcds_PrescriptionHdr.Data, vDataDtl, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveFactPrescription, [sErrorMsg]);

  if Fcds_PrescriptionHdr.FieldByName('Prescrip_NO').IsNull then
  begin
    TempClientDataSet.Data:=vDataDtl;
    Fcds_PrescriptionHdr.Edit;
    Fcds_PrescriptionHdr['Prescrip_NO']:=TempClientDataSet.Fields.Fields[0].Value;
  end;

  if Assigned(FOnAfterSave) then FOnAfterSave(Self);
  result:=true;
  Modify:=false;
//  ShowMsgDialog(@MSG_FactPrescriptionDtlSuccess, mtInformation);
end;

//function TBatchRecipe.DeleteCurPrescription: Boolean;
//var
//  vData: OleVariant;
//  sErrorMsg: WideString;
//begin
//  if not Fcds_PrescriptionHdr.FieldByName('Prescrip_NO').IsNull then
//  begin
//    FNMServerArtObj.SaveFactAssiPrescription(Integer(usDeleted), Prescrip_NO, vData, vData, sErrorMsg);
//    if sErrorMsg <> '' then
//      raise ExceptionEx.CreateResFmt(@ERR_SaveFactPrescription, [sErrorMsg]);
//
//    //ShowMsgDialog(@MSG_FactPrescriptionDtlSuccess, mtInformation);
//  end;
//
//  result := True;
//  Modify:=false;
//  Close;
//end;

//procedure TBatchRecipe.FillCardListToAListView(AListItem: TListItems);
//var
//  sErrorMsg: WideString;
//  vDataCards: OleVariant;
//begin
//  if (not Fcds_PrescriptionDtl2.Active) and (FactPreType = 1) then
//  begin
//    if Prescrip_NO = '' then exit;
//    FNMServerArtObj.GetFNCardsByRecipeNO(Prescrip_NO, vDataCards, sErrorMsg);
//    if sErrorMsg <> '' then
//    begin
//      Fcds_PrescriptionHdr.Close;
//      Fcds_PrescriptionDtl.Close;
//      raise ExceptionEx.CreateResFmt(@ERR_GetFNCardsByRecipeNO, [sErrorMsg]);
//    end;
//    Fcds_PrescriptionDtl2.Data:=vDataCards;  
//  end;
//
//  FillListItemsFromDataSet(Fcds_PrescriptionDtl2, 'FN_Card', '' ,
//        ['GF_NO', 'Quantity', 'Step_NO', 'Operation_CHN'], AListItem);
//end;

{TRecipeDtlInfo}
//function  TRecipeDtlInfo.GetFactPrescription: TBatchRecipe;
//begin
//  if (Prescrip_Type = 0) and (Prescrip_NO <> '') and ((not FFactPrescription.Active) or (FFactPrescription.Prescrip_NO <> Prescrip_NO)) then
//  begin
//    FFactPrescription.OrgIden_NO:=Prescrip_NO;
//    FFactPrescription.Open;
//  end;
//
//  result:=FFactPrescription;
//end;
//
//constructor TRecipeDtlInfo.Create(AOwner: TComponent);
//begin
//  inherited Create(AOwner);
//  
//  FFactPrescription:=TBatchRecipe.Create(AOwner);
//end;
//
//destructor TRecipeDtlInfo.Destroy;
//begin
//  FFactPrescription.Destroy;
//
//  inherited Destroy;
//end;
//
//procedure TRecipeDtlInfo.Open;
//var
//  sErrorMsg: WideString;
//  vDataHdr, vDataDtl, vDataCard: OleVariant;
//begin
//  Close;
//  if OrgIden_NO = '' then exit;
//    
////  FNMServerArtObj.GetPrescriptionInfo(2, OrgIden_NO, vDataHdr, vDataDtl, vDataCard, sErrorMsg);
////  if sErrorMsg <> '' then
////    raise ExceptionEx.CreateResFmt(@ERR_GetRecipe, [sErrorMsg]);
////
////  Fcds_PrescriptionHdr.Data:=vDataHdr;
////  Fcds_PrescriptionDtl.Data:=vDataDtl;
////  Fcds_PrescriptionDtl2.Data:=vDataCard;
////  Fcds_PrescriptionHdr.CheckBrowseMode;
////  //ȡʵ���䷽������;������,û�����
////  FFactPrescription.OrgIden_NO:=Prescrip_NO;
////  FFactPrescription.Open;
////
////  DoAfterOpen(Self);
////  Modify:=false;
//end;
//
//procedure TRecipeDtlInfo.CalculateChemicalDosage;
//var
//  i: Integer;
//  SumVolume: Single;
//begin
//  SumVolume:=StrToFloat(Sum_Volume);
//  Fcds_PrescriptionDtl.First;
//  for i := 0 to Fcds_PrescriptionDtl.RecordCount - 1 do
//  with Fcds_PrescriptionDtl do
//  begin
//    Edit;
//    FieldByName('Dosage').AsFloat:=(SumVolume * FieldByName('Unit_QTY').AsFloat) / 1000;//�����Kg�ĵ�λ
//    Next
//  end;
//end;
//
//procedure TRecipeDtlInfo.FillPrescriptionDtlToAListControls(AItem: TListItems);
//begin
//  FillListItemsFromDataSet(Fcds_PrescriptionDtl, 'Chemical_Name', '', ['Unit_QTY', 'Dosage'], AItem);
//end;
//
//function  TRecipeDtlInfo.SaveRecipeToDataBase: Boolean;
//var
//  sErrorMsg: WideString;
//begin
//  result := True;
//  if (not Active) or (not Modify) or IsEmpty then exit;
//
//  if Assigned(FOnBeforeSave) then FOnBeforeSave(Self);
//
//  //��������
//  FNMServerArtObj.SaveRecipe(Integer(usModified), Recipe_NO, Base_Volume, Machine_ID, Operator, GetIncludeCardList, sErrorMsg);
//  if sErrorMsg <> '' then
//    raise ExceptionEx.CreateResFmt(@ERR_SaveRecipe, [sErrorMsg]);
//
//  Fcds_PrescriptionHdr.MergeChangeLog;
//  Fcds_PrescriptionDtl.MergeChangeLog;
//  Fcds_PrescriptionDtl2.MergeChangeLog;
//
//  result:=true;
//  Modify:=false;
//  if Assigned(FOnAfterSave) then FOnAfterSave(Self);
//  ShowMsgDialog(@MSG_SaveRecipeSuccess, mtInformation);
//end;
//
//function TRecipeDtlInfo.DeleteCurRecipe: Boolean;
//var
//  sErrorMsg: WideString;
//begin
//  FNMServerArtObj.SaveRecipe(Integer(usDeleted), Recipe_NO, 0, '', '', '', sErrorMsg);
//  if sErrorMsg <> '' then
//    raise ExceptionEx.CreateResFmt(@ERR_SaveRecipe, [sErrorMsg]);
//  result := True;
//end;
//
//procedure TRecipeDtlInfo.PrintPreView;
//begin
//{$IFNDEF TERMINAL}
//
//  PreViewRecipeReport(FFactPrescription.FactPreType, Fcds_PrescriptionHdr, Fcds_PrescriptionDtl, Fcds_PrescriptionDtl2);
//{$ENDIF};
//end;
//
end.


unit uFNMArtInfo;
{*|<PRE>*****************************************************************************

       ������� FNM CLIENT MODEL
       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT
       ��Ԫ���� uFNMArtInfo.pas
       �������� 2004-8-30 ���� 04:30:20
       ������Ա lvzd
       �޸���Ա
       �޸�����
       �޸�ԭ��
       ��Ӧ����
       �ֶ�����
       ������ݿ��
       ������Ҫ����/SQL����˵��
        1: �������ջ���
        2: ��׼������
        ��:    PDMDB.dbo.tdGFID; uvw_fnOperationList
        ��,д: fnStdArtHdr; fnStdArtDtl
        3: ʵ�ʹ�����
        ��:
        4: ���޹�����
        ��:
        5: ��֯�湤����

       ��������: CAD������,�������ջ���, ��׼����, ʵ�ʹ���, ����޹�����,
       ��ȡ��������ֵ亯��.

******************************************************************************}

interface

{$I Terminal.inc}

uses
     DB, DBClient, Classes, SysUtils, StrUtils, Valedit, Grids, Menus, Windows, Forms,
     ComCtrls, ServerDllPub, uFNMResource, uGlobal, uShowMessage, uDictionary, Dialogs,
     Variants, StdCtrls, Controls, uLogin, uCADInfo;

Type

{TOperateOffset}
  TOperateOffset=(ooMoveDown= -1, ooDelete = 0, ooMoveUP=1);
  {* ���������ƶ�:MoveDown:����; Delete: ɾ��; MoveUP: ����}
{TArtDtlInfo}
  TArtDtlInfo=Class
  {* ��׼����,ʵ�ʹ���,���޹��յĻ���}
  Private
    Fcds_ArtHdr: TClientDataSet;
    {* �����������ݼ���}
    Fcds_ArtDtl: TClientDataSet;
    {* ������ϸ�����ݼ���}

    Org_Fcds_ArtDtl: TClientDataSet;
    {* �޸�ǰ������ϸ�����ݼ���}

    FModify: Boolean;
    {* �����Ƿ��޸�}

    FOnAfterEdit: TNotifyEvent;
    {* ���ձ༭�¼�}
    FOnBeforeSave: TNotifyEvent;
    {* ���տ�ʼ�����¼�}
    FOnAfterSave: TNotifyEvent;
    {* ���ձ�������¼�}
    FOnAfterOpen: TNotifyEvent;
    {* ���մ��¼�}
    FOnAfterClose: TNotifyEvent;
    {* ���չر��¼�}

    procedure SetModify(ModifyValue: Boolean);
    {* ��ʶ���շ��޸�}
    function  GetActive: Boolean;
    {* �ж����ݼ����Ƿ��Ѵ�}
    procedure MergeStepNOValue;
    {* ʹĳStep_no��EditStep_no�����ֶε�ֵ���, ��MoveAOperateStep�����е���}
    procedure SetAOperateEditStep_NOValue(OldKeyValue, NewKeyValue: Integer);
    {* ����Step_no����EditStep_no��ֵ, ��MoveAOperateStep�����е���}
    procedure FillParameterListControls(FillModle: String; AValueListEditor: TValueListEditor);
    {* ���������б���}
  protected
    function  GetFieldValue(Index: integer): Variant;
    {* ��ȡ����Index�ֶε�ֵ}
    procedure SetFieldValue(Index: integer; FieldValue: Variant);
    {* ��������ĳ���ֶε�ֵ}
    function RepairItemValue(OperationCode, ItemName, ItemValue: String): string; virtual;
    {* �����û�����Ĳ���ֵ}
    procedure TestItemValue(OperationCode, ItemName, ItemValue: String); virtual;
    {* ���Բ���ֵ�Ƿ�Ϸ�}
  public
    constructor Create(AOwner: TComponent);
    {* Create}
    destructor Destroy; override;
    {* Destroy}

    function CloseArt: Boolean;
    {* �رչ���}
    function  SaveArtToDataBase: Boolean; virtual;
    {* ���湤�յ����ݿ���}
    function  IsEmpty: Boolean;
    {* �жϱ�׼���������Ƿ�Ϊ��}
    function GetStepOperateCode(Step_NO: Integer): String;
    {* ���ݹ�����ȡ�����Code}
    function GetStepOperateName(Step_NO: Integer): String;
    {* ���ݹ�����ȡ�����Name}
    function  AddAOperateStep(Operate_ID: Integer; Operation_Code: string = ''): Integer;
    {* ׷��һ��������}
    procedure MoveAOperateStep(Step_NO: Integer; OperateOffset: TOperateOffset);
    {* ɾ��һ���������ʹĳ������Ĳ����1��1}
    procedure ClearAllOperateStep;
    {* ������й���}
    function SetAOperateParameterValue(Step_NO :Integer; Item_Name, Item_Value: String): String; virtual;
    {* ����ĳ�������ĳ��������ֵ}
    procedure FillOperationToAListControls(AItem: TStrings);
    {* ��乤�������б���}
    procedure FillAStepToAListControls(Step_NO: Integer; AValueListEditor: TValueListEditor);
    {* ���ָ������������б���}
    procedure FillAItemToAListControls(ItemName: String; AValueListEditor: TValueListEditor);
    {* ������й����ָ���������б���}
    function  GetOperateStepCount: Integer;
    {* ��ȡ��ǰ����Ĳ�����}
    function  GetOperations: String;
    {* ��ȡ��ǰ����������б�(���ŷָ�)}
    procedure ViewArtDtlInNewForm;
    {* ���´����в鿴����}
  published
    property Modify: Boolean read FModify write SetModify;
    {* �����Ƿ��޸�}
    property Active: Boolean read GetActive;
    {* �����Ƿ��}

    property OnAfterEdit:  TNotifyEvent read FOnAfterEdit  write FOnAfterEdit;
    {* ���ձ��༭}
    property OnBeforeSave: TNotifyEvent read FOnBeforeSave write FOnBeforeSave;
    {* ���տ�ʼ����}
    property OnAfterSave:  TNotifyEvent read FOnAfterSave  write FOnAfterSave;
    {* ���ձ���ɹ�}
    property OnAfterOpen:  TNotifyEvent read FOnAfterOpen  write FOnAfterOpen;
    {* ���մ򿪳ɹ�}
    property OnAfterClose: TNotifyEvent read FOnAfterClose write FOnAfterClose;
    {* ���չرճɹ�}
  end;

{TSTDArtDtlInfo}
  TSTDArtDtlInfo=Class(TArtDtlInfo)
  {* ��׼������}
  Private
    FOrgArt_ID: Integer;
    {* ��׼���ձ��, �ñ����������ڴ򿪹���}
    FOrgDepartment: String;
    {* ��׼������������, �ñ����������ڴ򿪹���}
    procedure SetOrgArt_ID(OrgArt_IDValue: Integer);
    {* ���ù���ID}
    procedure SetOrgDepartment(OrgDepartmentValue: String);
    {* ���ñ�ע���ղ���}
  public

    constructor Create(AOwner: TComponent);
    {* �����׼������}
    destructor Destroy; override;
    {* �ͷű�׼������}

    procedure OpenFNSTDArt;
    {* ͨ��GF_ID��GF_NO�򿪹���}
    procedure CheckStdArt(iType:Integer);
    {* ȷ�ϱ�׼����}
    function  SaveArtToDataBase: Boolean; override;
    procedure SaveFeedbackInfo;
    {* ���湤�յ����ݿ�}
    procedure CreateStdArt(OrgGF_ID: Integer; Department, Creator: String);
    {* ������׼����}
    procedure CopyAExistSTDArt(StdArtID: Integer);
    {* ������׼����}
    procedure InitializeDepartmentMenuItem(MenuItem: TMenuItem; ClickEvent: TNotifyEvent);
    {* ��ʹ�����տ�������ѡ��˵�}
    function GetFeedbackInfo: OleVariant;

    function ViewArtDtl(Index: integer): string;
  published
    property OrgArt_ID: Integer read FOrgArt_ID write SetOrgArt_ID;
    {* ���ձ��}
    property OrgDepartment: String read FOrgDepartment write SetOrgDepartment;
    {* ��׼���ղ���}
    property Art_ID             :Variant index 1  read GetFieldValue;
    {* ���ձ��}
    property GF_ID              :Variant index 2  read GetFieldValue;
    property GF_NO              :Variant index 3  read GetFieldValue;
    property FN_Art_NO          :Variant index 4  read GetFieldValue write SetFieldValue;     
    {* �������մ���}
    property FN_Color_Code      :Variant index 5  read GetFieldValue write SetFieldValue;
    {* ��������ɫ����}
    property Shrinkage          :Variant index 6  read GetFieldValue write SetFieldValue;
    {* ��������ˮҪ��}
    property HandFeel           :Variant index 7  read GetFieldValue write SetFieldValue;
    {* �������ָ�Ҫ��}
    property Product_Width       :Variant index 8  read GetFieldValue write SetFieldValue;
    {* �������ŷ�}
    property Material_Quality   :Variant index 9 read GetFieldValue;
    {* ��ǰ���յ���������}
    property Version            :Variant index 10 read GetFieldValue;
    {* ���հ汾}
    property Current_Department :Variant index 11 read GetFieldValue;
    {* ���ս����Ĳ���}
    property Operator           :Variant index 12 read GetFieldValue write SetFieldValue;
    {* ���ս�����}
    property Operate_Time       :Variant index 13 read GetFieldValue;
    {* ���ս���ʱ��}
    property Checker            :Variant index 14 read GetFieldValue;
    {* ����ȷ����}
    property Check_Time         :Variant index 15 read GetFieldValue;
    {* ����ȷ��ʱ��}
    property Remark             :Variant index 16 read GetFieldValue write SetFieldValue;
    {* ���ձ�ע}
    property Is_Active          :Variant index 17 read GetFieldValue write SetFieldValue;
    {* �����Ƿ���Ч}
    property Feedback           :Variant index 18 read GetFieldValue;

    property Feedback_Time      :Variant index 19 read GetFieldValue;

    property PDARemark          :Variant index 20 read GetFieldValue write SetFieldValue;

    property PDMRemark          :Variant index 21 read GetFieldValue write SetFieldValue;

  end;

{TFactArtDtlInfo}
  TFactArtDtlInfo=Class(TArtDtlInfo)
  {* ʵ�ʹ�����}
  Private
    Fcds_JobTraceDtl: TClientDataSet;
    {* ���ȸ�����ϸ���ݼ���}
    FFACT_Art_ID: Integer;
    {* ʵ�ʹ��ձ��}
    FCardList: string;
    {* ʹ�õ�ǰʵ�ʹ��յĿ����б�, ���ŷָ�}
    FInternal_Repair: Boolean;
    {�ڻ���}
    FAsSTDArt: Boolean;
    {�Ƿ���Ϊ��Ʒ�ֵı�׼����}
    FRepairReason: string;

    procedure SetFACT_Art_ID(FACT_Art_IDValue: Integer);
    {* ����ʵ�ʹ��ձ��}
    function GetRepairSteps: String;
    {* ȡ����ӵĹ����б�}
  public
    constructor Create(AOwner: TComponent);
    {* Create}
    destructor Destroy; override;
    {* Destroy}


    procedure OpenFNArt;
    {* ��ʵ�ʹ���}
    function GetJobTraceDtlInfo(SelectCardList: String; SelectStepNO: Integer): Boolean;
    {* ȡ���ȸ�����ϸ��}
    procedure UpdateAStepNO(OldStepNO: Integer; OperateOffset: TOperateOffset);
    {* ���½��ȸ�����ϸ��¼}
    function  SaveArtToDataBase: Boolean; override;
    {* ����ʵ�ʹ��յ����ݿ�}
  published
    property FACT_Art_ID: Integer read FFACT_Art_ID write SetFACT_Art_ID;
    {* ʵ�ʹ��մ���}
    property CardList: String read FCardList write FCardList;
    {* ʹ�õ�ǰʵ�ʹ��յĿ����б�}
    property RepairSteps: String read GetRepairSteps;
    {* ��ǰ���յĻ��޲���}
    property Internal_Repair: Boolean read FInternal_Repair write FInternal_Repair;
    {* }
    property AsSTDArt: Boolean read FAsSTDArt write FAsSTDArt;
    {* }
    property RepairReason: String read FRepairReason write FRepairReason;
    {* }

    property Art_ID             :Variant index 1  read GetFieldValue;
    {* ʵ�ʹ���ID}
    property Fact_Art_Version   :Variant index 2  read GetFieldValue;
    {* ʵ�ʹ��հ汾}
    property GF_ID              :Variant index 3  read GetFieldValue;
    property GF_NO              :Variant index 4  read GetFieldValue;
    property FN_Art_NO          :Variant index 5  read GetFieldValue write SetFieldValue;
    {* �������մ���}
    property STD_Art_ID         :Variant index 6  read GetFieldValue;
    {* ��ǰ���յĸ����յı�׼����}
    property STD_Art_Version    :Variant index 7  read GetFieldValue;
    {* ��ǰ���յĸ����յı�׼���յİ汾}
    property FN_Color_Code      :Variant index 8  read GetFieldValue write SetFieldValue;
    {* ��ǰ���յ���ɫ����}
    property Shrinkage          :Variant index 9  read GetFieldValue write SetFieldValue;
    {* ��������ˮҪ��}
    property HandFeel           :Variant index 10  read GetFieldValue write SetFieldValue;
    {* �������ָ�Ҫ��}
    property Product_Width       :Variant index 11  read GetFieldValue write SetFieldValue;
    {* �������ŷ�}
    property Art_Type           :Variant index 12  read GetFieldValue;
    {* ��ǰ���յ�����}
    property Material_Quality   :Variant index 13 read GetFieldValue;
    {* ��ǰ���յ���������}
    property Operator           :Variant index 14 read GetFieldValue write SetFieldValue;
    {* ��ǰ���յĽ�����}
    property Operate_Time       :Variant index 15 read GetFieldValue;
    {* ��ǰ���յĽ���ʱ��}
    property Remark             :Variant index 16 read GetFieldValue write SetFieldValue;
    {* ���ձ�ע}
    property fact_art_dtl: TClientDataSet read Fcds_ArtDtl;
    {* ʵ�ʹ���}
    property Org_fact_art_dtl: TClientDataSet read Org_Fcds_ArtDtl;
    {* �޸�ǰʵ�ʹ���}
  end;

{TRepairArtDtlInfo}
  TRepairArtDtlInfo=Class(TArtDtlInfo)
  {* ���޹�����}
  Private
    FCardList: string;
    {* ʹ�õ�ǰʵ�ʹ��յĿ����б�, ���ŷָ�}
  public
    procedure SaveRepairArt(var vData: OleVariant; vDataHdr,
  vDataDtl: OleVariant; var sErrorMsg: WideString);
    procedure CreateRepairArt(RepairIden, GF_ID: Integer; SelectCard: string; CurrentDeparment, Operator: String);
    {* �������޹���}
    function SaveArtToDataBase(IsQualityOperator:Boolean;RepairIden :Integer;GF_ID:Integer; Quantity:Double ;Repair_Code,Current_Department,Operator :string) : Boolean;
    {* ������޹��յ����ݿ�}
  published
    property CardList: String read FCardList write FCardList;
    {* ʹ�õ�ǰʵ�ʹ��յĿ����б�}
    property Art_ID              :Variant index 1  read GetFieldValue;
    {* ʵ�ʹ���ID}
    property GF_ID               :Variant index 2  read GetFieldValue;
    {* ���յ�Ʒ������}
    property FN_Art_NO           :Variant index 3  read GetFieldValue write SetFieldValue;
    {* �������մ���}
    property FN_Color_Code       :Variant index 4  read GetFieldValue write SetFieldValue;
    {* ��ǰ���յ���ɫ����}
    property Shrinkage           :Variant index 5  read GetFieldValue write SetFieldValue;
    {* ��������ˮҪ��}
    property HandFeel            :Variant index 6  read GetFieldValue write SetFieldValue;
    {* �������ָ�Ҫ��}
    property Product_Width        :Variant index 7  read GetFieldValue write SetFieldValue;
    {* �������ŷ�}
    property Art_Type            :Variant index 8  read GetFieldValue;
    {* ��ǰ���յ�����,����������������}
    property Material_Quality    :Variant index 9  read GetFieldValue;
    {* ��ǰ���յ���������,�����������ջ��Ǵ�������}
    property Operator            :Variant index 10  read GetFieldValue write SetFieldValue;
    {* ��ǰ���յĽ�����}
    property Operate_Time        :Variant index 11  read GetFieldValue;
    {* ��ǰ���յĽ���ʱ��}
    property Remark              :Variant index 12 read GetFieldValue write SetFieldValue;
    {* ���ձ�ע}
    property Reason_Type         :Variant index 13 read GetFieldValue write SetFieldValue;
    {* ��������}
    property Reason_Info         :Variant index 14 read GetFieldValue write SetFieldValue;
    {* ����ԭ��}

  end;

{THLArtDtlInfo}
  THLArtDtlInfo=Class(TArtDtlInfo)
  {* HL������}
  public
    procedure CreateHLArt(FN_ID, FN_NO, Creator: String);
    {* ����HL����}
    function  SaveArtToDataBase: Boolean; override;
    {* ����HL���յ����ݿ�}
  published
    property FN_ID               :Variant index 1  read GetFieldValue;
    {* HL����ID}
    property FN_NO               :Variant index 2  read GetFieldValue;
    {* HL����ID}
    property Art_ID              :Variant index 3  read GetFieldValue;
    {* HL����ID}
    property FN_Art_NO           :Variant index 4  read GetFieldValue write SetFieldValue;
    {* �������մ���}
    property Art_Type            :Variant index 5  read GetFieldValue;
    {* ��ǰ���յ�����,����������������}
    property Material_Quality    :Variant index 6  read GetFieldValue;
    {* ��ǰ���յ���������}
    property Operator            :Variant index 7  read GetFieldValue write SetFieldValue;
    {* ��ǰ���յĽ�����}
    property Operate_Time        :Variant index 8  read GetFieldValue;
    {* ��ǰ���յĽ���ʱ��}
    property Remark              :Variant index 9  read GetFieldValue write SetFieldValue;
    {* ���ձ�ע}
  end;

procedure GetStdArtIDbyGFNO(GF_KeyValue, Department: String; var Art_ID, GF_ID: Integer);
{*|<PRE>------------------------------------------------------------------------------
   ������Ա: lvzd
   ��������: 2004-12-24 14:40:38
   �����б�: GF_KeyValue, Department: String; var Art_ID, GF_ID: Integer
   ��������: ͨ��Ʒ����Ʒ��IDȡ��Art_ID��GF_ID
   ���ü���:
-------------------------------------------------------------------------------}
procedure GetOnLineCardByGFKeyValue(GFKeyValue, Department: String; CDS: TClientDataSet);
{*|<PRE>------------------------------------------------------------------------------
   ������Ա: lvzd
   ��������: 2004-8-30 ���� 05:57:45
   �����б�:
   ��������: ȡָ��Ʒ��ĳ���ŵ����߿���
   ���ü���:
-------------------------------------------------------------------------------}
procedure GetOnLineCardByOperation(Operation_Code: String; Department: String; CDS: TClientDataSet);
{*|<PRE>------------------------------------------------------------------------------
   ������Ա: lvzd
   ��������: 2004-8-30 ���� 05:57:45
   �����б�:
   ��������: ȡָ������ĳ���ŵ����߿���
   ���ü���:
-------------------------------------------------------------------------------}
procedure FillItemsFromDataSet(cds: TDataSet; FirstField, SecondField, KeyField, LinkSymbol: string; TheItems: TStrings;
          InsertAll: Boolean=false; TrimSpace: Boolean = true; ClearMode: Boolean = true);
{*|<PRE>------------------------------------------------------------------------------
   ������Ա: lvzd
   ��������: 2004-8-30 ���� 05:45:09
   �����б�: cds: ���ݼ�; FirstField: ��һ�ֶ�; SecondField: �ڶ��ֶ�; KeyField: �ؼ����ֶ�,���ֶα���Ϊ�����ֶ�
             LinkSymbol: ��һ�ֶκ͵ڶ��ֶ�֮������ӷ���; TheItems: ��ӵ�Ŀ���ַ����б�;
             InsertAll: �Ƿ�������еļ�¼,ΪTrue����������м�¼,Ĭ��ΪFase,��ͬ�ļ�¼������.
   ��������: ������ݼ��ϵ�ָ����Items��
-------------------------------------------------------------------------------}
procedure FillTreeItemsFromDataSet(cds: TClientDataSet; DisplayField,
          ParentField, SubField, KeyField, RootValue: string; TheNodes: TTreeNodes; RootNode: TTreeNode = nil);
{*|<PRE>------------------------------------------------------------------------------
   ������Ա: lvzd
   ��������: 2004-8-30 ���� 05:41:54
   �����б�: cds: ���ݼ�; DisplayField: ��ʾ�ֶ�; ParentField: ���ֶ�; SubField: ���ֶ�;
             KeyField: �ؼ����ֶ�,���ֶα���Ϊ�����ֶ�; RootValue: ��Ϊ���ڵ���ֶ�ֵ��־;
             TheNodes: ��ӵ�Ŀ��TreeNodes;
     ��ṹ: DisplayField | ParentField | SubField |KeyField
   ��������: ������ݼ��ϵ�ָ����TreeItems��
-------------------------------------------------------------------------------}
procedure FillTreeItemsFromDataSetByClassField(cds: TClientDataSet;
          ValueField, ClassField, KeyField, DescriptionField: string; TheNodes: TTreeNodes);
{*|<PRE>------------------------------------------------------------------------------
   ������Ա: lvzd
   ��������: 2004-10-20 12:18:28
   �����б�: cds: ���ݼ�; ValueField: ֵ�ֶ�; ClassField: �����ֶ�; KeyField: �ؼ����ֶ�; TheNodes: ��ӵ�Ŀ��TreeNodes;
   ��������: ��ClassField,��keyField��䵽TreeNodes��
-------------------------------------------------------------------------------}
procedure FillListItemsFromDataSet(cds: TDataSet; FirstField, KeyField: string;
          FieldStrings: array of String; TheItems: TListItems);
{*|<PRE>------------------------------------------------------------------------------
   ������Ա: lvzd
   ��������: 2004-9-1 9:32:44
   �����б�: cds: ���ݼ�; FirstField: ListItem��Caption, �Ҳ���Ϊ��;
   KeyField: �ؼ����ֶ�,���ֶα���Ϊ�����ֶ�, �����Ҫ���ʸø�ֵ, FieldStrings�������봫��һ���ֶ���
   FieldStrings: ��Ҫ���뵽SubItems�е��ֶ�����;
   TheItems: ��������;
   ����ֵ  : ��
   ��������: ������ݼ��ϵ�ָ����TListItems��
-------------------------------------------------------------------------------}
procedure AddItemToListItems(KeyValue: String; ItemStrings: array of String; TheItems: TListItems);
{*|<PRE>------------------------------------------------------------------------------
   ������Ա: lvzd
   ��������: 2004-11-20 14:37:21
   �����б�: KeyValue: String; ItemStrings: array of String; TheItems: TListItems
   ��������: ��ListItem�����Item,���ظ���KeyValue�����
   ���ü���:
-------------------------------------------------------------------------------}
procedure FillFN_Art_NOListToAComboBox(Code_Class: String; AComboBox: TComboBox);
{*|<PRE>------------------------------------------------------------------------------
   ������Ա: lvzd
   ��������: 2004-12-14 14:28:13
   �����б�: Code_Class: String; AComboBox: TComboBox
   ��������: ���FN_Art_NO�ֵ䵽ComboBox��
   ���ü���:
-------------------------------------------------------------------------------}
procedure FillArt_NOListToAComboBox(ArtType: String; AComboBox: TComboBox);
{*|<PRE>------------------------------------------------------------------------------
   ������Ա: lvzd
   ��������: 2004-12-22 10:55:39
   �����б�: ArtType: String; AComboBox: TComboBox
   ��������: ���Art_NO�ֵ䵽ComboBox��
   ���ü���:
-------------------------------------------------------------------------------}
procedure FillOnLineCardList(GFKeyValue, Department: String; TreeNodes: TTreeNodes);
{*|<PRE> -----------------------------------------------------------------------------
   ������Ա lvzd
   �������� 2005-3-9 17:01:43
   �����б� GFKeyValue, Department: String; TreeNodes: TTreeNodes
   �������� ������߿��ŵ������б���
   ���ü���:
-------------------------------------------------------------------------------}
procedure FillMachineListByOperationCode(Department, Operation_Code: String; AItems: TStrings);
{*|<PRE> -----------------------------------------------------------------------------
   �������� FillMachineListByOperationCode
   ������Ա lvzd
   �������� 2005-4-13 12:02:25
   �����б� Operation_Code: String; AItems: TStrings
   ����ֵ   ��
   �������� 
   ����˵��         
-------------------------------------------------------------------------------}

implementation

{$IFNDEF TERMINAL}
uses frmViewArtDtl;
{$ENDIF}

procedure GetStdArtIDbyGFNO(GF_KeyValue, Department: String; var Art_ID, GF_ID: Integer);
var
  sErrorMsg: WideString;
begin
  if GF_KeyValue = '' then exit;

  FNMServerArtObj.GetCheckGFIDAndSTDArt(GF_KeyValue, Department, GF_ID, Art_ID, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetCheckGFIDAndSTDArt, [sErrorMsg]);

  //Ʒ��������
  if GF_ID = -1 then
    raise ExceptionEx.CreateResFmt(@INV_GFIDorGF_NO, [GF_KeyValue]);
end;

procedure GetOnLineCardByGFKeyValue(GFKeyValue, Department: String; CDS: TClientDataSet);
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  //ˢ�¿����б�
  if GFKeyValue = '' then
    exit;

  FNMServerArtObj.GetOnLineCard('ByGFKeyValue', GFKeyValue, Department, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetOnLineCard, [sErrorMsg]);

  CDS.Data:=vData;
  if CDS.IsEmpty then
    raise Exception.CreateRes(@EMP_OnLineCard);
end;

procedure GetOnLineCardByOperation(Operation_Code: String; Department: String; CDS: TClientDataSet);
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  if CDS = nil then exit;

  FNMServerArtObj.GetOnLineCard('ByOperation', Operation_Code, Department, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetOnLineCard, [sErrorMsg]);

  CDS.Data:=vData;
  if CDS.IsEmpty then
    raise Exception.CreateRes(@EMP_OnLineCard);
end;

procedure FillItemsFromDataSet(cds: TDataSet; FirstField, SecondField, KeyField, LinkSymbol: string; TheItems: TStrings;
  InsertAll: Boolean=false; TrimSpace: Boolean = true; ClearMode: Boolean = true);
var
  ItemValue: String;
  i, KeyValue: Integer;
begin
  if (cds = nil) or (not cds.Active) then Exit;

  try
    TheItems.BeginUpdate;
    if ClearMode then
      TheItems.Clear;
    cds.DisableControls;
    cds.First;
    for i := 0 to cds.RecordCount - 1 do
    begin
      ItemValue:=cds.FieldByName(FirstField).AsString;
      if TrimSpace then
        ItemValue:=Trim(ItemValue);
      //ȥ�����Ļ�̨
      if (SecondField <> '') and (SecondField <> 'Machine_Model_CHN') then
      begin
        ItemValue:=ItemValue+LinkSymbol+cds.FieldByName(SecondField).AsString;
      end;

      if KeyField <> '' then
      begin
        KeyValue:=cds.FieldByName(KeyField).Asinteger;
        if TheItems.IndexOfObject(TObject(KeyValue)) = -1 then
          TheItems.AddObject(ItemValue, TObject(KeyValue))
        else if InsertAll then
          TheItems.AddObject(ItemValue, TObject(KeyValue));
      end
      else
        if TheItems.IndexOf(ItemValue) = -1 then
          TheItems.Add(ItemValue)
        else if InsertAll then
          TheItems.Add(ItemValue);

      cds.Next;
    end;
  finally
    cds.EnableControls;
    TheItems.EndUpdate;
  end;
end;

procedure FillTreeItemsFromDataSet(cds: TClientDataSet; DisplayField, ParentField, SubField, KeyField, RootValue: string;
    TheNodes: TTreeNodes; RootNode: TTreeNode = nil);
var
  i: Integer;
  NewNode: TTreeNode;
  TempCds: TClientDataSet;
  procedure FillChildNodes(ParentValue: string; TheNode: TTreeNode);
  {*|<PRE>------------------------------------------------------------------------------
     ������Ա: lvzd
     ��������: 2004-8-30 ���� 06:13:45
     �����б�: ParentValue: ���ڵ��ParentField��ֵ; TheNode: �ڸýڵ��²���ڵ�
     ����ֵ  : ��
     ��������: �ݹ���������ӽڵ�
     ����˵��: �ú���Ϊ�ݹ麯��
  -------------------------------------------------------------------------------}
  var
    i: Integer;
    OldFilter: String;
  begin
    OldFilter:=TempCds.Filter;
    //�����ӽڵ�
    TempCds.Filter:=SubField +' = '''+ParentValue+'''';
    for i := 0 to TempCds.RecordCount - 1 do
    begin
      //����ӽڵ�
      if KeyField = '' then
        NewNode:=TheNodes.AddChild(TheNode, TempCds.FieldByName(DisplayField).AsString)
      else
        NewNode:=TheNodes.AddChildObject(TheNode, TempCds.FieldByName(DisplayField).AsString, Pointer(TempCds.FieldByName(KeyField).Asinteger));

      //����ӽڵ���ӽڵ�
      FillChildNodes(TempCds.FieldByName(ParentField).AsString, NewNode);
      TempCds.Delete;
    end;
    //���ع�������
    TempCds.Filter:=OldFilter;
  end;
begin
  if (Cds = nil) or Cds.IsEmpty then exit;

  TempCds:=nil;
  try
    //�ȿ�¡���ݼ���
    TempCds:=TClientDataSet.Create(Cds.Owner);
    TempCds.Data:=Cds.Data;
    //���˸��ڵ�.
    TempCds.Filter:=SubField +ifthen(RootValue = '', '= ''''', ' = '''+RootValue+'''') ;
    TempCds.Filtered:=true;
    //��ʼ����ڵ�
    TheNodes.BeginUpdate;
    //ɾ���ɵĽڵ�
    TheNodes.Clear;
    for i := 0 to TempCds.RecordCount - 1 do
    begin
      //��Ӹ��ڵ�
      if KeyField = '' then
        NewNode:=TheNodes.Add(RootNode, TempCds.FieldByName(DisplayField).AsString)
      else
        NewNode:=TheNodes.AddObject(RootNode, TempCds.FieldByName(DisplayField).AsString, Pointer(TempCds.FieldByName(KeyField).Asinteger));

      //����ӽڵ�
      FillChildNodes(TempCds.FieldByName(ParentField).AsString, NewNode);
      TempCds.Delete;
    end;
  finally
    TempCds.Destroy;
    TheNodes.EndUpdate;
  end;
end;

procedure FillTreeItemsFromDataSetByClassField(cds: TClientDataSet; ValueField, ClassField, KeyField, DescriptionField: string; TheNodes: TTreeNodes);
var
  i: Integer;
  NewNode: TTreeNode;
  ChildNodeStrings, NodeText: String;
  TempCds: TClientDataSet;
begin
  if (Cds = nil) or Cds.IsEmpty then exit;

  TempCds:=nil;
  try
    //�ȿ�¡���ݼ���
    TempCds:=TClientDataSet.Create(Cds.Owner);
    TempCds.Data:=Cds.Data;

    TheNodes.BeginUpdate;
    while TempCds.RecordCount <> 0 do
    begin
      NodeText:=TempCds.FieldByName(ClassField).AsString;
//      if DescriptionField <> '' then
//        NodeText:=TempCds.FieldByName(DescriptionField).AsString;//NodeText +

      NewNode:=TheNodes.AddChild(nil, NodeText);
      TempCds.Filter:=Format('%s = ''%s''', [ClassField, TempCds[ClassField]]);
      TempCds.Filtered:=true;

      ChildNodeStrings:='/\';
      for i := 0 to TempCds.RecordCount - 1 do
      begin
        NodeText:=TempCds.FieldByName(ValueField).AsString;
        if DescriptionField <> '' then
          NodeText:=NodeText + TempCds.FieldByName(DescriptionField).AsString;

        if Pos('/\'+NodeText+'/\', ChildNodeStrings) = 0 then
        with TheNodes.AddChild(NewNode, NodeText) do
        begin
          if KeyField <> '' then
            Data:=TObject(TempCds.FieldByName(KeyField).AsInteger);
          ChildNodeStrings:=ChildNodeStrings + Text + '/\';
        end;
        
        TempCds.Delete;
      end;
      TempCds.Filtered:=false;
    end;
  finally
    TempCds.Destroy;
    TheNodes.EndUpdate;
  end;
end;

procedure FillListItemsFromDataSet(cds: TDataSet; FirstField, KeyField: string; FieldStrings: array of String; TheItems: TListItems);
var
  i, j: Integer;
  NewListItem: TListItem;
begin
  if (cds = nil) or (not cds.Active) then Exit;

  try
    TheItems.BeginUpdate;
    TheItems.Clear;
    with cds do
    begin
      DisableControls;
      First;
      for i := 0 to RecordCount - 1 do
      begin
        NewListItem:=TheItems.Add;
        NewListItem.Caption:=Trim(FieldByName(FirstField).AsString);
        for j := 0 to High(FieldStrings) do
          NewListItem.SubItems.Add(Trim(FieldByName(FieldStrings[j]).AsString));

        if (NewListItem.SubItems.Count <> 0) and (KeyField <> '') then
          NewListItem.SubItems.Objects[0]:=TObject(FieldByName(KeyField).AsInteger);

        next;
      end;
    end;
  finally
    cds.EnableControls;
    TheItems.EndUpdate;
  end;
end;

procedure AddItemToListItems(KeyValue: String; ItemStrings: array of String; TheItems: TListItems);
var
  i, j: Integer;
begin
  for i := 0 to TheItems.Count - 1 do
    if TheItems.Item[i].Caption = KeyValue then exit;

  with TheItems.Add do
  begin
    Caption:=KeyValue;
    for j := 0 to High(ItemStrings) do
      SubItems.Add(ItemStrings[j]);
  end
end;

procedure FillFN_Art_NOListToAComboBox(Code_Class: String; AComboBox: TComboBox);
begin
  Dictionary.cds_ArtDescriptionList.Filter:='Code_Class = ''' + Code_Class + '''';
  Dictionary.cds_ArtDescriptionList.Filtered:=true;
  FillItemsFromDataSet(Dictionary.cds_ArtDescriptionList, 'FN_Art_Code', 'Description', 'Iden', ' ', AComboBox.Items, false, false);
  AComboBox.DropDownCount:=AComboBox.Items.Count;
end;

procedure FillArt_NOListToAComboBox(ArtType: String; AComboBox: TComboBox);
begin
  Dictionary.cds_StdArtDtlList.Filter:='Type = ''' + ArtType + '''';
  Dictionary.cds_StdArtDtlList.Filtered:=true;
  FillItemsFromDataSet(Dictionary.cds_StdArtDtlList, 'Art_NO', 'Description', '', ' ', AComboBox.Items, false, false);
  AComboBox.DropDownCount:=AComboBox.Items.Count;
end;

procedure FillOnLineCardList(GFKeyValue, Department: String; TreeNodes: TTreeNodes);
var
  i: Integer;
begin
  //ˢ�¿����б�
  if GFKeyValue = '' then exit;

  GetOnLineCardByGFKeyValue(GFKeyValue, Department, TempClientDataSet);
  if TempClientDataSet.IsEmpty then exit;

  TreeNodes.Clear;
  FillTreeItemsFromDataSetByClassField(TempClientDataSet, 'FN_Card', 'Fact_Art_Step_NO', '', '', TreeNodes);
  with TreeNodes, TreeNodes.Owner do
  if Count > 0 then
  begin
    for i := 0 to Count - 1 do
    begin
      if Item[i].Level = 0 then
        Item[i].StateIndex := 0;
    end;

    FullExpand;
    Selected:=TreeNodes.Item[0];
    Selected.MakeVisible;
    Enabled:=true;
  end;
end;

procedure FillMachineListByOperationCode(Department, Operation_Code: String; AItems: TStrings);
var
  i: Integer;
begin
  AItems.Clear;
  with Dictionary do
  try
    cds_OperationMapMachineModel.Filter:=Format('Operation_Code = ''%s''', [Operation_Code]);
    cds_OperationMapMachineModel.Filtered:=true;
    for i := 0 to cds_OperationMapMachineModel.RecordCount - 1 do
    begin
      cds_FinishMachineList.Filter:=Format('Machine_ID LIKE ''%s%%'' AND Department = ''%s''', [Trim(cds_OperationMapMachineModel['Machine_Model']), Department]);
      cds_FinishMachineList.Filtered:=true;
      FillItemsFromDataSet(cds_FinishMachineList, 'Machine_ID', 'Machine_Model_CHN', '', '-', AItems, False, True, False);
      cds_OperationMapMachineModel.Next;
    end;
  finally
    cds_FinishMachineList.Filtered:=false;
    cds_OperationMapMachineModel.Filtered:=false;
  end;    
end;

{TArtDtlInfo}
constructor TArtDtlInfo.Create(AOwner: TComponent);
begin
  inherited Create;

  Fcds_ArtHdr:=TClientDataSet.Create(AOwner);
  Fcds_ArtDtl:=TClientDataSet.Create(AOwner);
  Org_Fcds_ArtDtl:=TClientDataSet.Create(AOwner);
end;

destructor TArtDtlInfo.Destroy;
begin
  if not CloseArt then exit;

  Fcds_ArtHdr.Destroy;
  Fcds_ArtDtl.Destroy;
  //Org_Fcds_ArtDtl.Destroy;
  inherited Destroy;
end;

function TArtDtlInfo.IsEmpty: Boolean;
begin
  result:=Fcds_ArtHdr.IsEmpty;
end;

procedure TArtDtlInfo.SetModify(ModifyValue: Boolean);
begin
  if FModify = ModifyValue then exit;

  FModify := Active and ModifyValue;
  if Active and Assigned(FOnAfterEdit) then FOnAfterEdit(Self);
end;

function TArtDtlInfo.GetActive: Boolean;
begin
  result:=Fcds_ArtHdr.Active and Fcds_ArtDtl.Active
end;

function TArtDtlInfo.GetOperateStepCount: Integer;
var
  i: Integer;
begin
  result:=0;
  if Fcds_ArtDtl.IsEmpty then exit;
    
  Fcds_ArtDtl.First;
  result:=Fcds_ArtDtl['Step_NO'];
  for i := 0 to Fcds_ArtDtl.RecordCount - 1 do
  begin
    if Fcds_ArtDtl['Step_NO'] > result then
      result:=Fcds_ArtDtl['Step_NO'];
    Fcds_ArtDtl.Next;
  end;    
end;

procedure TArtDtlInfo.ViewArtDtlInNewForm;
begin
{$IFNDEF TERMINAL}
  if Active then
    ViewArtDtl(Fcds_ArtDtl);
{$ENDIF}
end;

function TArtDtlInfo.CloseArt: Boolean;
var
  MessResult: Integer;
begin
  result := True;
  if not Active then
  begin
    Modify:=False;
    exit;
  end;
    
  result := False;
  //�ж��û��Ƿ񱣴����޸����ݣ�û�б���ѯ���û���
  if Modify then
  begin
    MessResult:=MessageBox(Application.Handle, Pchar(GetResourceString(@AskSaveDataStr)),Pchar(Application.Title), MB_YESNOCANCEL+MB_ICONQUESTION);
    if (MessResult = IDYES) and (not SaveArtToDataBase) then
        Raise Exception.Create(GetResourceString(@SaveDataFail));

    if MessResult = IDNO then
    begin
      Fcds_ArtHdr.CancelUpdates;
      Fcds_ArtDtl.CancelUpdates;
      Modify:=false;
    end;

    if MessResult = IDCANCEL then
      exit;
  end;

  Fcds_ArtHdr.Close;
  Fcds_ArtDtl.Close;
  Org_Fcds_ArtDtl.Close;
  if Assigned(OnAfterClose) then OnAfterClose(self);
    
  result := True;
end;

function TArtDtlInfo.SaveArtToDataBase: Boolean;
Begin
  result := True;
end;

function TArtDtlInfo.GetStepOperateCode(Step_NO: Integer): String;
begin
  result:='';
  if not Active then exit;

  if Fcds_ArtDtl.Locate('EditStep_no', IntToStr(Step_NO), []) then
    result:=Fcds_ArtDtl.FieldByName('Operation_Code').AsString;
end;

function TArtDtlInfo.GetStepOperateName(Step_NO: Integer): String;
begin
  result:='';
  if not Active then exit;

  if Fcds_ArtDtl.Locate('EditStep_no', IntToStr(Step_NO), []) then
    result:=Fcds_ArtDtl.FieldByName('Operation_CHN').AsString;
end;

procedure TArtDtlInfo.SetAOperateEditStep_NOValue(OldKeyValue, NewKeyValue: Integer);
var
  i: Integer;
begin
  try
    Fcds_ArtDtl.DisableControls;
    Fcds_ArtDtl.First;
    for i := 0 to Fcds_ArtDtl.RecordCount - 1 do
    begin
      Fcds_ArtDtl.Edit;
      //����-1ɾ��һ������
      if NewKeyValue = -1 then
      begin
        if Fcds_ArtDtl.FieldByName('Step_no').AsInteger > OldKeyValue then
          Fcds_ArtDtl.FieldByName('EditStep_no').AsInteger:=Fcds_ArtDtl.FieldByName('Step_no').AsInteger -1;
        if Fcds_ArtDtl.FieldByName('Step_no').AsInteger = OldKeyValue then
        begin
          Fcds_ArtDtl.Delete;
          Continue;
        end
      end
      else
      begin
        if Fcds_ArtDtl.FieldByName('Step_no').AsInteger = OldKeyValue then
          Fcds_ArtDtl.FieldByName('EditStep_no').AsInteger:=NewKeyValue;
      end;

      Fcds_ArtDtl.Next;
    end
  finally
    Fcds_ArtDtl.EnableControls
  end;
end;

procedure TArtDtlInfo.MergeStepNOValue;
var
  i: Integer;
begin
  try
    Fcds_ArtDtl.DisableControls;
    Fcds_ArtDtl.First;
    for i := 0 to Fcds_ArtDtl.RecordCount - 1 do
    begin
      Fcds_ArtDtl.Edit;
      Fcds_ArtDtl.FieldByName('Step_no').AsInteger:=Fcds_ArtDtl.FieldByName('EditStep_no').AsInteger;
      Fcds_ArtDtl.Next;
    end;
  finally
    Fcds_ArtDtl.EnableControls
  end;
end;

function TArtDtlInfo.AddAOperateStep(Operate_ID: Integer; Operation_Code: string = ''): Integer;
var
  iType,iGFID: Integer;
  vData: Olevariant;
  sCondition,sErrorMsg: widestring;
begin
  if ClassName = 'TSTDArtDtlInfo' then
  begin
    iType := 0;
    iGFID := TSTDArtDtlInfo(Self).GF_ID;
  end;
  if ClassName = 'TFactArtDtlInfo' then
  begin
    iType := 1;
    iGFID := TFactArtDtlInfo(Self).GF_ID;
  end;
  if ClassName = 'THLArtDtlInfo' then
  begin
    iType := 2;
    iGFID := THLArtDtlInfo(Self).FN_ID;
  end;
  if ClassName = 'TRepairArtDtlInfo' then
  begin
    iType := 3;
    iGFID := TRepairArtDtlInfo(Self).GF_ID;
  end;
  //ȡ������һ��Step_noֵ��1����Ϊ�²����Step_NO��ֵ
  result:=GetOperateStepCount + 1;

  sCondition := IntToStr(iGFID)+','+IntToStr(Operate_ID)+','+ QuotedStr(Operation_Code)+','+ IntToStr(iType)+','+ QuotedStr(Login.CurrentDepartment);

  FNMServerObj.GetQueryData(vData,'ARTGetOperation',sCondition,sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  TempClientDataSet.Data:=vData;
  with TempClientDataSet do
  begin
    First;
    while not Eof  do
    begin
      Fcds_ArtDtl.AppendRecord([result, result,
          FieldByName('Operation_Code').AsString,
          FieldByName('Operation_CHN').AsString,
          FieldByName('Item_Name').AsString,
          FieldByName('Item_Value').AsString,'', nil]);
      Next;
    end;
  end;
  Modify:=true;
end;

procedure TArtDtlInfo.MoveAOperateStep(Step_NO: Integer; OperateOffset: TOperateOffset);
begin
  case OperateOffset of
    ooMoveUP:
    begin
      SetAOperateEditStep_NOValue(Step_NO, Step_NO-1); //��ǰ�����Step_NO��ֵ��1
      SetAOperateEditStep_NOValue(Step_NO-1, Step_NO); //�ϸ������Step_NO����Ϊ��ǰ�Ĺ����Step_NO
    end;
    ooMoveDown:
    begin
      SetAOperateEditStep_NOValue(Step_NO, Step_NO+1); //��ǰ�����Step_NO��ֵ��1
      SetAOperateEditStep_NOValue(Step_NO+1, Step_NO); //�¸������Step_NO����Ϊ��ǰ�Ĺ����Step_NO
    end;
    ooDelete:
      SetAOperateEditStep_NOValue(Step_NO, -1);
  end;
  MergeStepNOValue;                                    //ʹStep_NO��EditStep_NO��ֵ��ͬ,ʹ�޸���Ч.
  Modify:=true;
end;

procedure TArtDtlInfo.ClearAllOperateStep;
begin
  if Active then
    Fcds_ArtDtl.EmptyDataSet;
end;

function TArtDtlInfo.RepairItemValue(OperationCode, ItemName,
  ItemValue: String): string;
begin
  Result:=ItemValue;
  if ItemName = '����' then
  begin
    Result:=StringReplace(Result, 'Z', '��', [rfReplaceAll, rfIgnoreCase]);
    Result:=StringReplace(Result, 'F', '��', [rfReplaceAll, rfIgnoreCase]);
  end;
end;

procedure TArtDtlInfo.TestItemValue(OperationCode, ItemName, ItemValue: String);
var
  tempe: Extended;
  tempi: Integer;
  ValueType: String;
begin
  with Dictionary.cds_OperationDtlList do
  begin
    if ItemName = '����' then
    begin
      ItemValue:=StringReplace(ItemValue, '��', '',  [rfReplaceAll]);
      ItemValue:=StringReplace(ItemValue, '��', '',  [rfReplaceAll]);
      if ItemValue <> '' then
        raise Exception.CreateResFmt(@INV_NOItemValue, ['�� Or ��', '�� Or ��']);
    end;

    if Locate('Operation_Code;Item_Name', VarArrayOf([OperationCode, ItemName]), []) then
    begin
      ValueType:=Dictionary.cds_OperationDtlList['Data_Type'];
      if ValueType = 'Boolean' then
      begin
        if (LowerCase(ItemValue) <> 'true') and (LowerCase(ItemValue) <>  'false') then
          raise Exception.CreateResFmt(@INV_NOItemValue, ['True Or False', 'True Or False']);
      end;
      if ValueType = 'int' then
      begin
        if not TryStrToInt(ItemValue, tempi) then
          raise Exception.CreateResFmt(@INV_NOItemValue, ['����', '����']);
      end;
      if ValueType = 'Numeric' then
      begin
        if not TryStrToFloat(ItemValue, tempe) then
          raise Exception.CreateResFmt(@INV_NOItemValue, ['����', '����']);
      end;
    end;
  end;
end;
// DAVID ADD FOR TEST BEGIN {
procedure TRepairArtDtlInfo.SaveRepairArt(var vData: OleVariant; vDataHdr,
  vDataDtl: OleVariant; var sErrorMsg: WideString);
const
 // David Add 2014-10-09 begin, �Զ����ɻ��޹���
 UPDATE_REPAIR_HDR_SQL = 'UPDATE dbo.fnFactArtHdr SET Operator=''%s'' ' +
        'WHERE FN_Card=''%s'''+#13#10;
 DELETE_REPAIR_DTL_SQL = 'DELETE dbo.fnFactArtDtl WHERE Fact_Art_ID=''%s''' +#13#10;
 // David Add 2014-10-09 end, �Զ����ɻ��޹���
 INSERT_REPAIR_HDR_SQL = 'INSERT INTO dbo.fnFactArtHdr (GF_ID, STD_Art_ID, STD_Art_Version, Art_Type, Material_Quality, Operator, Remark) '+
                         'VALUES(''%s'', -1, 0, ''%s'', ''%s'', ''%s'', ''%s'')' +#13#10;
 INSERT_REPAIR_DTL_SQL = 'INSERT INTO dbo.fnFactArtDtl (Fact_Art_ID, Step_NO, Operation_Code, Item_Name, Item_Value, Operator, Operate_Time) '+
                         'VALUES(@Fact_Art_ID, ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'') ' +#13#10;
 INSERT_REPAIROPERATION_SQL0 = 'INSERT INTO dbo.fnRepairOperation (GF_ID,Quantity,FN_Card, Reason_Code, Internal_External, Repair_Operation, Current_Department, Operator, Operate_Time) '+
                              'VALUES(''%s'',''%s'',''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', GETDATE())' +#13#10;
 INSERT_REPAIROPERATION_SQL1 = 'INSERT INTO dbo.fnRepairOperation (GF_ID,Quantity,FN_Card, Reason_Code, Internal_External, Repair_Operation, Current_Department, Operator, Operate_Time, Checker, Check_Time) '+
                              'VALUES(''%s'',''%s'',''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', GETDATE(), ''%s'',GETDATE())' +#13#10;
 UPDATE_REPAIROPERATION_SQL0 = 'UPDATE dbo.fnRepairOperation  SET GF_ID = ''%s'', Quantity = ''%s'',FN_Card = ''%s'', Reason_Code = ''%s'', Internal_External= ''%s'', Repair_Operation= ''%s'', Current_Department= ''%s'','+
                              ' Operator = ''%s'', Operate_Time = GETDATE() '+
                              ' WHERE Check_Time IS NULL AND Iden = ''%s'''+#13#10;
 UPDATE_REPAIROPERATION_SQL1 = 'UPDATE dbo.fnRepairOperation  SET Checker = ''%s'', Check_Time = GETDATE() '+
                              ' WHERE Check_Time IS NULL AND Iden = ''%s'''+#13#10;
var
  i: Integer;
  SqlText, FNCardList: String;
  cds_Art: TClientDataSet;
begin
  SqlText := '';
  //���½��ȸ��ټ�¼
  FNCardList:= vData[0][4];
  while FNCardList[Length(FNCardList)] = ',' do
    System.Delete(FNCardList, Length(FNCardList), 1);
  FNCardList:='(''' + StringReplace(FNCardList, ',', ''',''', [rfReplaceAll]) + ''')';
  
  if vData[0][0] = 1 then //IsQualityOperator
  begin
    if vData[0][1] = 0 then  //new
      SqlText :=  SqlText + Format(INSERT_REPAIROPERATION_SQL0,[vData[0][2],vData[0][3],vData[0][4],vData[0][5],vData[0][6],vData[0][7],vData[0][8],vData[0][9]])
     else  //edit
      SqlText :=  SqlText + Format(UPDATE_REPAIROPERATION_SQL0,[vData[0][2],vData[0][3],vData[0][4],vData[0][5],vData[0][6],vData[0][7],vData[0][8],vData[0][9],vData[0][1]]);
  end else
  begin
    if vData[0][1] = 0 then  //new
      SqlText :=  SqlText + Format(INSERT_REPAIROPERATION_SQL1,[vData[0][2],vData[0][3],vData[0][4],vData[0][5],vData[0][6],vData[0][7],vData[0][8],vData[0][9],vData[0][9]])
     else  //edit
      SqlText :=  SqlText + Format(UPDATE_REPAIROPERATION_SQL1,[vData[0][9],vData[0][1]]);
  end;
  if  vData[0][0] <> 1 then
  begin
    cds_Art:=nil;
    try
      cds_Art:=TClientDataSet.Create(nil);
        cds_Art.Data:=vDataHdr;
        SqlText := SqlText + 'DECLARE @Fact_Art_ID Int '#13#10;
        with cds_Art do
        begin
        // David 2014-10-09 �޸ģ�ĳЩ�������ʹõ���ڴ�ʱ���ɹ��գ���Ҫ�����ж��Ƿ��Ѿ����ɹ���
        // ����42677 �ƶ����޹��գ��ο� usp_fnAutoGenerateRepairParas
        SqlText :=  SqlText + 'SET @Fact_Art_ID=-1' + #13#10;
        SqlText :=  SqlText + FORMAT('SELECT TOP 1 @Fact_Art_ID=Fact_Art_ID FROM dbo.fnRepairCardAutoFactArtID WHERE FN_Card=''%s''', [FNCardList]);
        SqlText :=  SqlText + 'IF @Fact_Art_ID>0' + #13#10;
        SqlText :=  SqlText + 'BEGIN'+ #13#10;
          // ����Ѿ����ɹ��տ�ʼ David
          SqlText :=  SqlText + Format(UPDATE_REPAIR_HDR_SQL, [FieldByName('Operator').AsString, FNCardList]) + #13#10;
          SqlText :=  SqlText + Format(DELETE_REPAIR_DTL_SQL, ['@Fact_Art_ID'])+ #13#10;
          // ����Ѿ����ɹ��ս��� David
        SqlText :=  SqlText + 'END'+ #13#10;
        
        SqlText :=  SqlText + 'ELSE'+ #13#10;
        SqlText :=  SqlText + 'BEGIN'+ #13#10;
          // ���û�����ɹ��� begin, David
          SqlText := SqlText + Format(INSERT_REPAIR_HDR_SQL,[FieldByName('GF_ID').AsString,
                                                             FieldByName('Art_Type').AsString,
                                                             FieldByName('Material_Quality').AsString,
                                                             FieldByName('Operator').AsString,
                                                             FieldByName('Remark').AsString]);

          SqlText := SqlText + 'SET @Fact_Art_ID =IDENT_CURRENT(''fnFactArtHdr'') '+ #13#10;
          // ���û�����ɹ��� end, David
        SqlText :=  SqlText + 'END'+ #13#10;
          

          cds_Art.Data:=vDataDtl;
          for i := 0 to RecordCount - 1 do
          begin
            SqlText:=SqlText + Format(INSERT_REPAIR_DTL_SQL,[FieldByName('Step_NO').AsString,
                                                             FieldByName('Operation_Code').AsString,
                                                             FieldByName('Item_Name').AsString,
                                                             FieldByName('Item_Value').AsString,
                                                             FieldByName('Operator').AsString,
                                                             FieldByName('Operate_Time').AsString]);
            Next;
          end;
          //����ͷ(000)β(999)����
          SqlText:=SqlText + 'EXEC dbo.usp_InsertHeadOperate @Fact_Art_ID ' + #13#10;
        end;
    finally
      FreeAndNil(cds_Art);
    end;
  end;
 

  if vData[0][0] = 1 then //IsQualityOperator    //���ڲ����೤���빤��ʱ������ȡ
    SqlText := SqlText + 'UPDATE dbo.fnJobTraceHdr SET Fact_Art_ID = -999 ' +
                          Format('WHERE FN_Card IN %s '#13#10, [FNCardList])
  else
    SqlText := SqlText + 'UPDATE fnJobTraceHdr SET FACT_Art_ID = @Fact_Art_ID, Step_NO = 1, Operation_Code = dbo.udf_GetOperationCode(@Fact_Art_ID, 1) '+
                          Format('WHERE FN_Card IN %s '#13#10, [FNCardList]);

  //������չ������޹���
  if vData[0][0] <> 1 then
    SqlText := SqlText + ' EXEC dbo.usp_SaveRepairArtEx @Fact_Art_ID ';

end;
// DAVID CAO ADD FOR TEST END!!}
function TArtDtlInfo.SetAOperateParameterValue(Step_NO :Integer; Item_Name, Item_Value: String): String;
var
  sStr, sRemark, sErrorMsg: WideString;
begin
  try
    if Pos('(', Item_Name) >0 then
       Item_Name:=Trim(LeftStr(Item_Name, Pos('(', Item_Name) - 1));

    Fcds_ArtDtl.DisableControls;
    if Fcds_ArtDtl.Locate('Step_NO;Item_Name', VarArrayOf([Step_NO, Item_Name]), []) then
    begin
      if Item_Value <> '' then
      begin
        Item_Value:=RepairItemValue(Fcds_ArtDtl['Operation_Code'], Item_Name, Item_Value);
        TestItemValue(Fcds_ArtDtl['Operation_Code'], Item_Name, Item_Value);
      end;

      //˿�⹤���޸ļ�Ũʱ�����Ƿ�����PDM
      if pos('��Ũ', Item_Name)> 0 then
      begin
        if MessageDlg('�Ƿ����Ѽ�����', mtWarning, mbYesNoCancel,0)= mrYes then
        begin
          sRemark := InputBox('�޸�ԭ��', '������ԭ��:','');
          sStr := QuotedStr(Fcds_ArtHdr['Art_ID'])+ ','
                + VarToStr(Fcds_ArtDtl['Step_NO'])+ ','
                + VarToStr(Fcds_ArtHdr['GF_ID'])+ ','
                + QuotedStr(Fcds_ArtHdr['GF_NO'])+ ','
                + QuotedStr(Fcds_ArtDtl['Operation_Code'])+ ','
                + QuotedStr(VarToStr(Fcds_ArtDtl['Item_Value']))+ ','
                + QuotedStr(VarToStr(Item_Value))+ ','
                + QuotedStr(Login.LoginID)+ ','
                + QuotedStr(sRemark);
          FNMServerArtObj.SaveModifiedArtLog(QuotedStr(sStr), sErrorMsg);
          if sErrorMsg<> '' then
            raise Exception.CreateRes(@DataError);
        end;
      end;

      Fcds_ArtDtl.Edit;
      Fcds_ArtDtl['Item_Value']:=Item_Value;
      Fcds_ArtDtl['Operator']:=Login.LoginID;
      Fcds_ArtDtl['Operate_Time']:= TGlobal.GetServerTime; //Now; cuijf 2008-6-12
    end
    else
    begin
      //cuijf 2008-6-12
      sStr := '����ʵ�ʹ���'+ VarToStr(Fcds_ArtHdr['Art_ID'])+ '�иù���"'+Fcds_ArtDtl['Operation_CHN']+'"�Ƿ���"�ڻ���"����';
      raise Exception.Create(sStr);
      //raise Exception.CreateRes(@DataError);
    end;

    Result:=Item_Value;
    Modify:=true;
  finally
    Fcds_ArtDtl.EnableControls;
  end;
end;

procedure TArtDtlInfo.FillOperationToAListControls(AItem: TStrings);
  function GetAOperateDispText(Step_NO: Integer; OldText: String): String;
  begin
    //Format:=Step_NO+)+Operate_CHN
    result:=IntToStr(Step_NO);
    result := result + StringOfChar(' ', MAX_OPERATE_STEP_NO_LENGTH - Length(result)) + ')' + OldText;

  end;
var
  ItemValue, Operation_Name, Operation_Addr: String;
  i, RecNO, KeyValue: Integer;
begin
  if not Active then exit;
  try
    AItem.BeginUpdate;
    AItem.Clear;
    Fcds_ArtDtl.DisableControls;
    KeyValue:=-1;
    Fcds_ArtDtl.IndexFieldNames:='Step_NO';
    Fcds_ArtDtl.First;
    for i := 0 to Fcds_ArtDtl.RecordCount - 1 do
    begin
      if KeyValue = Fcds_ArtDtl.FieldByName('Step_NO').Asinteger then
      begin
        Fcds_ArtDtl.Next;
        continue;
      end;

      RecNO:=Fcds_ArtDtl.RecNo;
      Operation_Addr:='';
      KeyValue:=Fcds_ArtDtl.FieldByName('Step_NO').Asinteger;
      if Fcds_ArtDtl.Locate('Step_NO;Item_Name', VarArrayOf([KeyValue, '�ӹ��ص�']), []) then
        Operation_Addr:=Format('(%s)', [Fcds_ArtDtl.FieldByName('Item_Value').AsString]);
      Fcds_ArtDtl.RecNo := RecNO;

      Operation_Name:=Fcds_ArtDtl.FieldByName('Operation_CHN').AsString;
      Operation_Name:=Operation_Name + StringOfChar(' ', 10 - Length(Operation_Name));

      ItemValue:=GetAOperateDispText(KeyValue, Operation_Name + Operation_Addr);
      if Fcds_ArtDtl.FieldByName('OrgStep_NO').IsNull then
        ItemValue:=ItemValue + ' *';
      if AItem.IndexOfObject(TObject(KeyValue)) = -1 then
        AItem.AddObject(ItemValue, TObject(KeyValue));

      Fcds_ArtDtl.Next;
    end;
  finally
    Fcds_ArtDtl.IndexFieldNames:='';
    Fcds_ArtDtl.EnableControls;
    AItem.EndUpdate;
  end;
end;

procedure TArtDtlInfo.FillParameterListControls(FillModle: String; AValueListEditor: TValueListEditor);
var
  i, StepNO: Integer;
  Key, Value,Enum_Value,Data_Unit: String;
begin
  AValueListEditor.Strings.Clear;
  with Dictionary.cds_OperationDtlList do
  begin
    Filtered := False;
    i:=0; Fcds_ArtDtl.First;
    while not Fcds_ArtDtl.Eof do
    begin
      //ȡ�ֵ����Ϣ
      if Locate('Operation_Code;Item_Name',
              VarArrayOf([Fcds_ArtDtl.FieldByName('Operation_Code').AsString, Fcds_ArtDtl.FieldByName('Item_Name').AsString]), []) then
      begin
        Key:=Trim(Fcds_ArtDtl.FieldByName('Item_Name').AsString);
        if FillModle = 'Step' then
        begin
          Key:=Key + {����ո�}StringOfChar(' ' , (10 - Length(Key)));
          {���ݵ�λ}
          Data_Unit := FieldByName('Data_Unit').AsString;
          if Data_Unit<>'' then
             Key:=Key + '(' + Data_Unit + ')';
        end;
        if FillModle = 'ItemName' then
          Key:=Key + {����ո�}StringOfChar(' ' , (10 - Length(Key))) + '(' +
            {������}FieldByName('Operation_CHN').AsString + ')';

        Value:=Fcds_ArtDtl['Item_Value'];{����ȡֵ}
        StepNO:=Fcds_ArtDtl['Step_NO'];  {����}

        AValueListEditor.Strings.AddObject(Format('%s=%s', [Key, Value]), TObject(StepNO));

        Enum_Value := FieldByName(Login.CurrentDepartment+'_Enum_Value').AsString;
        //���ñ༭��ʽ
        with AValueListEditor.ItemProps[i] do //�˴�����ʹ��Key, ���Key��ͬ������ɴ���
        if Enum_Value = 'By Function' then
          EditStyle:=esEllipsis
        else
        begin
          if Trim(Fcds_ArtDtl.FieldByName('Item_Name').AsString) = '��̨' then
          begin
            EditStyle:=esPickList;
            FillMachineListByOperationCode(Login.CurrentDepartment, Fcds_ArtDtl.FieldByName('Operation_Code').AsString, PickList);
          end
          else if Length(Enum_Value) <> 0 then
          begin
            EditStyle:=esPickList;
            PickList.Text:=StringReplace(Enum_Value, ',', #13, [rfReplaceAll]);
          end;
        end;
        inc(i);
      end;
      Fcds_ArtDtl.Next;
    end;
  end;
end;

procedure TArtDtlInfo.FillAStepToAListControls(Step_NO: Integer; AValueListEditor: TValueListEditor);
begin
  try
    Fcds_ArtDtl.DisableControls;
    Fcds_ArtDtl.Filter:='Step_NO = '''+ IntToStr(Step_NO)+'''';
    Fcds_ArtDtl.Filtered:=true;

    FillParameterListControls('Step', AValueListEditor);
  finally
    Fcds_ArtDtl.Filtered:=false;
    Fcds_ArtDtl.EnableControls;
  end;
end;

procedure TArtDtlInfo.FillAItemToAListControls(ItemName: String; AValueListEditor: TValueListEditor);
begin
  try
    Fcds_ArtDtl.DisableControls;
    Fcds_ArtDtl.Filter:=Format('Item_Name = ''%s''', [ItemName]);
    Fcds_ArtDtl.Filtered:=true;

    FillParameterListControls('ItemName', AValueListEditor);
  finally
    Fcds_ArtDtl.Filtered:=false;
    Fcds_ArtDtl.EnableControls;
  end;
end;

function TArtDtlInfo.GetFieldValue(Index: integer): Variant;
begin
  result:='';
  if (not Active) or IsEmpty then exit;

  result:=Fcds_ArtHdr.Fields.Fields[Index - 1].Value;
  if Fcds_ArtHdr.Fields.Fields[Index - 1].IsNull then
  begin
    result:='';
  end
end;

procedure TArtDtlInfo.SetFieldValue(Index: integer; FieldValue: Variant);
begin
  if (not Active) or IsEmpty then exit;

  if VarCompareValue(Fcds_ArtHdr.Fields.Fields[Index - 1].Value, FieldValue) <> vrEqual then
  begin
    Fcds_ArtHdr.Edit;
    Fcds_ArtHdr.Fields.Fields[Index - 1].Value := FieldValue;
  end;
  Modify:=true;
end;

function TArtDtlInfo.GetOperations: String;
var
  CurStep, i: Integer;
begin
  result:='';
  if Fcds_ArtDtl.IsEmpty then exit;
    
  Fcds_ArtDtl.First;
  CurStep:=Fcds_ArtDtl['Step_NO'];
  result:=Fcds_ArtDtl['Operation_Code'] + ',';
  for i := 0 to Fcds_ArtDtl.RecordCount - 1 do
  begin
    if Fcds_ArtDtl['Step_NO'] > CurStep then
    begin
      CurStep:=Fcds_ArtDtl['Step_NO'];
      result:=result + Fcds_ArtDtl['Operation_Code'] + ',';
    end;

    Fcds_ArtDtl.Next;
  end;    
end;

{TSTDArtDtlInfo}
procedure TSTDArtDtlInfo.SetOrgDepartment(OrgDepartmentValue: String);
begin
  if FOrgDepartment = OrgDepartmentValue then exit;
    
  if not CloseArt then exit;
  FOrgDepartment:=OrgDepartmentValue;
end;

procedure TSTDArtDtlInfo.SetOrgArt_ID(OrgArt_IDValue: Integer);
begin
  if FOrgArt_ID = OrgArt_IDValue then exit;
    
  FOrgArt_ID:=OrgArt_IDValue;
end;

constructor TSTDArtDtlInfo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FOrgArt_ID:=-1
end;

destructor TSTDArtDtlInfo.Destroy;
begin
  inherited Destroy;
end;

procedure TSTDArtDtlInfo.OpenFNSTDArt;
var
  sCondition,sErrorMsg: WideString;
  vData: OleVariant;
begin
  if not CloseArt then exit;
  if OrgArt_ID = -1 then
    raise Exception.CreateRes(@MSG_InfoDeficiency);
  sCondition := IntToStr(OrgArt_ID)+','+QuotedStr('S');
  FNMServerObj.GetQueryData(vData,'ARTGetArtInfo',sCondition,sErrorMsg);
//  FNMServerArtObj.GetArtDtl(FOrgArt_ID, 'S', vDataHdr, vDataDtl, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetStdArtDtl, [sErrorMsg]);

  Fcds_ArtHdr.Data:=vData[0];
  Fcds_ArtDtl.Data:=vData[1];

  if IsEmpty then
  begin
    CloseArt;
    raise Exception.CreateRes(@EMP_STDArt);
  end;

  if Assigned(FOnAfterOpen) then FOnAfterOpen(Self);

  Modify:=false;
end;

procedure TSTDArtDtlInfo.SaveFeedbackInfo;
var
  sCondition,sErrorMsg: WideString;
begin
  sCondition := IntToStr(GF_ID)+ ','+ QuotedStr(PDARemark) + ','+
                QuotedStr(PDMRemark) + ','+ QuotedStr(Login.LoginName) + ','+
                QuotedStr(Login.CurrentDepartment);
  FNMServerObj.SaveDataBySQL('ARTSaveFeedbackInfo',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveStdArtData, [sErrorMsg]);
  ShowMsgDialog(@MSG_SaveStdArtInfoSuccess, mtInformation);
end;

function TSTDArtDtlInfo.SaveArtToDataBase: Boolean;
var
  sErrorMsg: WideString;
  vDataDtl,vDataParam: OleVariant;
  sOperation_code,sItem_value:string;
  i:Integer;
  sCondition:string;
begin
  result := True;

  //���湤��ʱ��δcheck ��ô��¼�޸��˶��ٴβ��� �汾Ϊ1 ��ʾδcheck��
  if not Fcds_ArtHdr.FieldByName('Art_ID').IsNull then
  begin
      sOperation_code := '';
      sItem_value := '';
      with Fcds_ArtDtl do
      begin
        for i := 0 to RecordCount - 1 do
        begin
          sCondition :=Fcds_ArtHdr.FieldByName('Art_ID').AsString + ',' +
                       QuotedStr(FieldByName('operation_code').AsString) + ',' +
                       QuotedStr(FieldByName('Item_name').AsString) + ',' +
                       QuotedStr(FieldByName('Item_value').AsString) + ',0';
          if (sOperation_code <> QuotedStr(FieldByName('operation_code').AsString))
             and (sItem_value <> QuotedStr(FieldByName('Item_value').AsString)) then
          begin
            FNMServerObj.SaveDataBySQL('SaveParaChange',sCondition,sErrorMsg);

            sOperation_code := QuotedStr(FieldByName('operation_code').AsString);
            sItem_value := QuotedStr(FieldByName('Item_value').AsString);

            if sErrorMsg <> '' then
            begin
              TMsgDialog.ShowMsgDialog('��¼�޸ĳ���!',mtError);
              Exit;
            end;
          end;
          Next;
        end;
      end;
  end;

  if (not Active) or (not Modify) or IsEmpty then exit;
  if Assigned(FOnBeforeSave) then FOnBeforeSave(Self);

  Fcds_ArtHdr.MergeChangeLog;
  Fcds_ArtDtl.MergeChangeLog;
  //��������
  vDataDtl:=Fcds_ArtDtl.Data;
  vDataParam := VarArrayOf([GF_ID,
                            PDARemark,
                            PDMRemark,
                            Login.LoginName,
                            Login.CurrentDepartment]);

  FNMServerArtObj.SaveStdArt(Fcds_ArtHdr.Data, vDataDtl,vDataParam,sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveStdArtData, [sErrorMsg]);

  TempClientDataSet.Data:=vDataDtl;
  if Fcds_ArtHdr.FieldByName('Art_ID').IsNull then
  begin
    Fcds_ArtHdr.Edit;
    Fcds_ArtHdr.FieldByName('Art_ID').Value:=TempClientDataSet.Fields.Fields[0].Value;
    Fcds_ArtHdr.FieldByName('Version').Value:=0;
  end;

  result:=true;
  Modify:=false;
  if Assigned(FOnAfterSave) then FOnAfterSave(Self);
  ShowMsgDialog(@MSG_SaveStdArtInfoSuccess, mtInformation);
end;

procedure TSTDArtDtlInfo.CheckStdArt(iType:Integer);
var
  sCondition,sErrorMsg: WideString;
  vData:OleVariant;
  cdsR:TClientDataSet;
begin
  //�ȱ���!
  if Modify then
    SaveArtToDataBase;

  if (not Active) or IsEmpty then
    raise Exception.CreateRes(@EMP_STDArt);
                           
  //��������
   sCondition :=  QuotedStr(Art_ID)+','+QuotedStr(Version)+','+QuotedStr(Login.LoginName)+','+
                  QuotedStr(Login.CurrentDepartment)+','+ IntToStr(iType);
   FNMServerObj.GetQueryData(vData,'ARTCheckStdArt',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
  begin
      raise ExceptionEx.CreateResFmt(@SaveCheckArtDataError, [sErrorMsg]);
  end;
  cdsR := TClientDataSet.Create(nil);
  cdsR.Data := vData;
  if cdsR.FieldByName('result').AsString = '����Ԥ��б�ͻ�' then
  begin
    TMsgDialog.ShowMsgDialog('����Ԥ��б�ͻ�!', mtWarning);
  end;

  Fcds_ArtHdr.Edit;
  Fcds_ArtHdr.FieldByName('Checker').AsString:=Checker;
  Fcds_ArtHdr.FieldByName('Check_Time').AsDateTime:= TGlobal.GetServerTime; //Now; cuijf 2008-6-12

  Modify:=false;
  if Assigned(FOnAfterSave) then FOnAfterSave(Self);
  ShowMsgDialog(@MSG_SaveStdArtCheckInfoSuccess, mtInformation);
end;

procedure TSTDArtDtlInfo.CreateStdArt(OrgGF_ID: Integer; Department, Creator: String);
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  if not CloseArt then exit;
  try
    //���������ֶ�
    with Fcds_ArtHdr do
    begin
      FieldDefs.Clear;
      FieldDefs.Add('Art_ID',             ftInteger);
      FieldDefs.Add('GF_ID',              ftInteger);
      FieldDefs.Add('GF_NO',              ftString, 20);
      FieldDefs.Add('FN_Art_NO',          ftString, 10);
      FieldDefs.Add('FN_Color_Code',      ftString, 2);
      FieldDefs.Add('Shrinkage',          ftString, 20);
      FieldDefs.Add('HandFeel',           ftString, 100);
      FieldDefs.Add('Product_Width',       ftString, 20);
      FieldDefs.Add('Material_Quality',   ftString, 10);
      FieldDefs.Add('Version',            ftSmallint);
      FieldDefs.Add('Current_Department', ftString, 2);
      FieldDefs.Add('Operator',           ftString, 20);
      FieldDefs.Add('Operate_Time',       ftDateTime);
      FieldDefs.Add('Checker',            ftString, 20);
      FieldDefs.Add('Check_Time',         ftDateTime); 
      FieldDefs.Add('Feedback',           ftString, 20);
      FieldDefs.Add('Feedback_Time',      ftDateTime);
      FieldDefs.Add('PDARemark',          ftString, 300);
      FieldDefs.Add('PDMRemark',          ftString, 300);
      FieldDefs.Add('Remark',             ftString, 150);
      FieldDefs.Add('Is_Active',          ftBoolean);
      CreateDataSet;
      Fcds_ArtHdr.Append;
      Fcds_ArtHdr['GF_ID']:=OrgGF_ID;
      Fcds_ArtHdr['Version']:=-1;
      Fcds_ArtHdr['Current_Department']:=Department;
      Fcds_ArtHdr['Operator']:=Creator;
      Fcds_ArtHdr['Operate_Time']:= TGlobal.GetServerTime; //Now; cuijf 2008-6-12
      Fcds_ArtHdr['Is_Active']:=true;

      //ȡ�Ѿ����ڵ�ͨ�õĹ���Ҫ��
      FNMServerArtObj.GetArtItemInfo(OrgGF_ID, vData, sErrorMsg);
      if sErrorMsg <> '' then
        raise ExceptionEx.CreateResFmt(@ERR_GetArtItemInfo, [sErrorMsg]);

      TempClientDataSet.Data:=vData;
      if not TempClientDataSet.IsEmpty then
      begin
        Fcds_ArtHdr['FN_Art_NO']:=TempClientDataSet['FN_Art_NO'];
        Fcds_ArtHdr['FN_Color_Code']:=TempClientDataSet['FN_Color_Code'];
        Fcds_ArtHdr['Shrinkage']:=TempClientDataSet['Shrinkage'];
        Fcds_ArtHdr['HandFeel']:=TempClientDataSet['HandFeel'];
        Fcds_ArtHdr['Product_Width']:=TempClientDataSet['Product_Width'];
      end
    end;

    //�Զ��������ղ���Ͳ���
    FNMServerArtObj.AutoCreateStdArtDtl(IntToStr(OrgGF_ID), Department, vData, sErrorMsg);
    if sErrorMsg <> '' then
      raise ExceptionEx.CreateResFmt(@ERR_AutoCreateStdArtDtl, [sErrorMsg]);

    Fcds_ArtDtl.Data:=vData;
  except
    on e: Exception do
    begin
      Fcds_ArtHdr.Close;
      Fcds_ArtDtl.Close;
      ShowMessage(sErrorMsg);
    end;
  end;
  if Assigned(FOnAfterOpen) then FOnAfterOpen(Self);
  Modify:=false;
end;

procedure TSTDArtDtlInfo.CopyAExistSTDArt(StdArtID: Integer);
var
  MessResult: Integer;
  sCondition, sErrorMsg: WideString;
  vData:OleVariant;
begin
  //����û�򿪲��ܿ���
  if not Active then
    exit;

  if not Fcds_ArtDtl.IsEmpty then
  begin
    MessResult:= ShowMsgDialog(@MSG_ClearCurOperate, mtConfirmation);
    if MessResult <> mrOk then exit;
  end;
  sCondition := IntToStr(StdArtID)+','+QuotedStr('S');
  FNMServerObj.GetQueryData(vData,'ARTGetArtInfo',sCondition,sErrorMsg);
//  FNMServerArtObj.GetArtDtl(StdArtID, 'S', vDataHdr, vDataDtl, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetStdArtDtl, [sErrorMsg]);

  TempClientDataSet.Data:=vData[0];
  if TempClientDataSet.IsEmpty then
    raise Exception.CreateRes(@EMP_StdArtInfoDtlCantCopy);

  Fcds_ArtHdr.Edit;                                               
  //ֻ�������պ�

{
  Fcds_ArtHdr['FN_Art_NO']:=LeftStr(TempClientDataSet['FN_Art_NO'], 1);
  Fcds_ArtHdr['FN_Color_Code']:=TempClientDataSet['FN_Color_Code'];
  Fcds_ArtHdr['Shrinkage']:=TempClientDataSet['Shrinkage'];
  Fcds_ArtHdr['HandFeel']:=TempClientDataSet['HandFeel'];
  Fcds_ArtHdr['Product_Width']:=TempClientDataSet['Product_Width'];
  Fcds_ArtHdr['Material_Quality']:=TempClientDataSet['Material_Quality'];
}
  Fcds_ArtHdr['Remark']:=TempClientDataSet['Remark'];

  Fcds_ArtDtl.Data:=vData[1];

  if Assigned(FOnAfterOpen) then FOnAfterOpen(Self);
  Modify:=True;
end;

procedure TSTDArtDtlInfo.InitializeDepartmentMenuItem(MenuItem: TMenuItem; ClickEvent: TNotifyEvent);
var
  i: Integer;
  NewMenuItem: TMenuItem;
begin
  with Dictionary.cds_DepartmentList do
  try
    Filter:='Parent_Department = ' + '''FN''';
    Filtered:=true;
    for i := 0 to RecordCount - 1 do
    begin
      NewMenuItem:=TMenuItem.Create(MenuItem.Owner);
      NewMenuItem.Caption:=Trim(FieldByName('Description').AsString)+'����(&'+
                           RightStr(Trim(FieldByName('Department').AsString),1)+')';
      NewMenuItem.Tag:=FieldByName('Iden').AsInteger;
      NewMenuItem.OnClick:=ClickEvent;
      MenuItem.Add(NewMenuItem);
      Next;
    end;
  finally
    Filtered:=false;
  end;
end;

function TSTDArtDtlInfo.GetFeedbackInfo: OleVariant;
var
  sErrorMsg: WideString;
begin
  FNMServerArtObj.GetFeedbackInfo(Result, GF_ID,Current_Department, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetStdArtDtl, [sErrorMsg]);
end;

function TSTDArtDtlInfo.ViewArtDtl(Index: integer): string;
var
  Step_NO,ParamStr: String;
begin
  Step_NO := '';
  ParamStr := '';
  with Fcds_ArtDtl do
  begin
    Filtered := False;
    First;
    while not Eof do
    begin
      if Step_NO <> FieldByName('Step_NO').AsString then
      begin
        if  ParamStr<>'' then
          Result := Result + ParamStr;
        if (Result <> '')  then
          Result := Result + #10#13;
        Step_NO := FieldByName('Step_NO').AsString;
        ParamStr := '';
      end;
      if Trim(FieldByName('Item_Name').AsString) = '�ӹ��ص�' then
      begin
        if StrToInt(Step_NO) < 9 then
          Step_NO := '0' + Step_NO;
         Result := Result + Step_NO + '��'+ FieldByName('Item_Value').AsString+'��'+ FieldByName('Operation_CHN').AsString + ': '
      end else
      begin
        if Index = 0 then
        begin
          if (Trim(FieldByName('Item_Value').AsString)<>'') then
            ParamStr := ParamStr + FieldByName('Item_Name').AsString +':' +FieldByName('Item_Value').AsString +'  ';
        end
        else if Index = 1 then
        begin
          if (Trim(FieldByName('Item_Value').AsString)='') then
            ParamStr := ParamStr + FieldByName('Item_Name').AsString +'  ';
        end
        else
          ParamStr := ParamStr + FieldByName('Item_Name').AsString +':' +FieldByName('Item_Value').AsString +'  ';
      end;
      Next;
    end;
    if  ParamStr<>'' then
      Result := Result + ParamStr;
  end;
end;

{TFactArtDtlInfo}
procedure TFactArtDtlInfo.SetFACT_Art_ID(FACT_Art_IDValue: Integer);
begin
  if FFACT_Art_ID = FACT_Art_IDValue then exit;
    
  if not CloseArt then exit;
  FFACT_Art_ID:=FACT_Art_IDValue;
end;

constructor TFactArtDtlInfo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  
  FInternal_Repair := False;
  FAsSTDArt := False;
  Fcds_JobTraceDtl:=TClientDataSet.Create(AOwner);
end;

destructor TFactArtDtlInfo.Destroy;
begin
  Fcds_JobTraceDtl.Destroy;
  inherited Destroy;
end;

procedure TFactArtDtlInfo.OpenFNArt;
var
  sCondition,sErrorMsg: WideString;
  vData: OleVariant;
begin
  if not CloseArt then exit;
  if FACT_Art_ID = -1 then
    raise Exception.CreateRes(@InvalidFACT_Art_ID);

  FCardList:='';

  sCondition := IntToStr(FACT_Art_ID)+','+QuotedStr('F');
  FNMServerObj.GetQueryData(vData,'ARTGetArtInfo',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetFactArtDtl, [sErrorMsg]);

  Fcds_ArtHdr.Data:=vData[0];
  Fcds_ArtDtl.Data:=vData[1];
  //luwel
  org_Fcds_ArtDtl := Fcds_ArtDtl;

  if Fcds_ArtHdr.IsEmpty then
  begin
    CloseArt;
    raise Exception.CreateRes(@FactArtEmpty);
  end;

  if Assigned(FOnAfterOpen) then FOnAfterOpen(Self);

  Modify:=false;
end;

function TFactArtDtlInfo.SaveArtToDataBase: Boolean;
var
  sJobIden,sJobStepNO, sErrorMsg: WideString;
  vDataParam: Variant;
  i: Integer;
  CurStepNO:Integer;
  OperationListt: string;
begin
  result := True;
  if (not Active) or (not Modify) or IsEmpty then exit;
  if Assigned(FOnBeforeSave) then FOnBeforeSave(Self);
  if FCardList = '' then
    raise Exception.Create('WAR_���տ������ݳ���,����ϵ����Ա');

  if (not Internal_Repair) and (RepairSteps <> '') and (RepairReason = '') then
    raise Exception.Create('WAR_�����Զ����޹���ʱ,��ѡ�����ԭ��');

  OperationListt:='';
  CurStepNO:=1;
  while Fcds_ArtDtl.Locate('Step_NO', CurStepNO, []) do
  begin
    OperationListt:=OperationListt + Fcds_ArtDtl.FieldByName('Operation_Code').AsString + ',';
    Inc(CurStepNO)
  end;

  //�жϹ������Ƿ�Υ������
  FNMServerArtObj.GetCheckSpecialArt(GF_ID, Pos('F', FCardList), OperationListt, Login.CurrentDepartment, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetCheckSpecialArt, [sErrorMsg]);

  //����
  sJobIden :='';
  sJobStepNO := '';
  with Fcds_JobTraceDtl do
  for I := 0 to RecordCount - 1 do
  begin
    sJobIden := sJobIden + Fcds_JobTraceDtl.FieldByName('Iden').AsString + ',';
    sJobStepNO := sJobStepNO + Fcds_JobTraceDtl.FieldByName('Step_NO').AsString + ',';
    next;
  end;
  vDataParam := VarArrayOf([Login.LoginName,
                            CardList,
                            RepairSteps,
                            IfThen(Internal_Repair,'1','0'),
                            RepairReason,
                            sJobIden,
                            sJobStepNO,
                            IfThen(AsStdArt,'1','0')]);
  //���湤��
   FNMServerArtObj.SaveFactArt(Fcds_ArtHdr.Data, Fcds_ArtDtl.Data, vDataParam, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveFactArtData, [sErrorMsg]);

  //�ϲ����ݼ���
  Fcds_ArtHdr.MergeChangeLog;
  Fcds_ArtDtl.MergeChangeLog;

  result:=true;
  FRepairReason:='';
  FInternal_Repair:=False;
  FAsSTDArt := False;
  if Assigned(FOnAfterSave) then FOnAfterSave(Self);
  Modify:=false;
  ShowMsgDialog(@MSG_SaveFactArtDtlInfoSuccess, mtInformation);
end;

function TFactArtDtlInfo.GetJobTraceDtlInfo(SelectCardList: String;
  SelectStepNO: Integer): Boolean;
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  FNMServerArtObj.GetUnFinishJobTraceDtl(SelectCardList, SelectStepNO, vData, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetUnFinishJobTraceDtl, [sErrorMsg]);

  Fcds_JobTraceDtl.Data:= vData;
  result := True;
end;

procedure TFactArtDtlInfo.UpdateAStepNO(OldStepNO: Integer;
  OperateOffset: TOperateOffset);
var
  i: Integer;
begin
  with Fcds_JobTraceDtl do
    if (not Active) or (IsEmpty) then exit;

  with Fcds_JobTraceDtl do
  case OperateOffset of
    ooMoveUP:
    begin
      First;
      for I := 0 to RecordCount - 1 do
      begin
        Edit;
        if Fcds_JobTraceDtl['Step_NO'] = OldStepNO then
        begin
          Edit;
          Fcds_JobTraceDtl['Step_NO'] := OldStepNO - 1;
        end
        else if Fcds_JobTraceDtl['Step_NO'] = OldStepNO - 1 then
        begin
          Edit;
          Fcds_JobTraceDtl['Step_NO'] := OldStepNO;
        end;
        Next;
      end;
    end;

    ooMoveDown:
    begin
      First;
      for I := 0 to RecordCount - 1 do
      begin
        if Fcds_JobTraceDtl['Step_NO'] = OldStepNO then
        begin
          Edit;
          Fcds_JobTraceDtl['Step_NO'] := OldStepNO + 1
        end
        else if Fcds_JobTraceDtl['Step_NO'] = OldStepNO + 1 then
        begin
          Edit;
          Fcds_JobTraceDtl['Step_NO'] := OldStepNO;
        end;
        Next;
      end;
    end;
    
    ooDelete:
    begin
      Last;
      for I := RecordCount - 1 downto 0 do
      begin
        if Fcds_JobTraceDtl['Step_NO'] = OldStepNO then
        begin
          Edit;
          Fcds_JobTraceDtl['Step_NO'] :=  -1;
        end
        else if Fcds_JobTraceDtl['Step_NO'] > OldStepNO then
        begin
          Edit;
          Fcds_JobTraceDtl['Step_NO'] := Fcds_JobTraceDtl['Step_NO'] - 1;
        end;
        Next;
      end
    end;
  end;
  
  Fcds_JobTraceDtl.MergeChangeLog;
end;

function TFactArtDtlInfo.GetRepairSteps: String;
begin
  Result:='';
  Fcds_ArtDtl.Filter:='OrgStep_NO IS NULL AND NOT(Operation_CHN LIKE ''%����'')';
  Fcds_ArtDtl.Filtered:=True;
  try

    if Fcds_ArtDtl.RecordCount <> 0 then
    begin
      Fcds_ArtDtl.Filter:='OrgStep_NO IS NULL';
      Result:=GetOperations;
    end;
  finally
    Fcds_ArtDtl.Filter:='';
    Fcds_ArtDtl.Filtered:=False;
  end;
end;

{TRepairArtDtlInfo}
procedure TRepairArtDtlInfo.CreateRepairArt(RepairIden, GF_ID: Integer; SelectCard: string; CurrentDeparment, Operator: String);
var
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
begin
  if not CloseArt then exit;

  sCondition := IntToStr(RepairIden)+','+IntToStr(GF_ID)+','+ QuotedStr(SelectCard)+','+ QuotedStr(CurrentDeparment)+','+ QuotedStr(Operator);
  FNMServerObj.GetQueryData(vData,'ARTCreateRepairArtInfo',sCondition,sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetStdArtDtl, [sErrorMsg]);

  Fcds_ArtHdr.Data:=vData[0];
  Fcds_ArtDtl.Data:=vData[1];

  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetUnFinishJobTraceDtl, [sErrorMsg]);

  if IsEmpty then
  begin
    CloseArt;
    raise Exception.CreateRes(@EMP_STDArt);
  end;

  CardList:='';
  if Assigned(FOnAfterOpen) then FOnAfterOpen(Self);
  Modify:=false;
end;

function TRepairArtDtlInfo.SaveArtToDataBase(IsQualityOperator:Boolean; RepairIden :Integer; GF_ID:Integer; Quantity: Double; Repair_Code,Current_Department,Operator :string) : Boolean;
var
  vData: OleVariant;
  QualityOperator,CurStepNO: Integer;
  OperationListt,sErrorMsg: WideString;
begin
  result := True;
  if (not Active) or (not Modify) or IsEmpty then exit;
  if Assigned(FOnBeforeSave) then FOnBeforeSave(Self);
  if CardList = '' then exit;
  if Pos(',', CardList) > 0 then
    CardList := Copy(CardList,1,Length(CardList)-1);

  OperationListt:='';
  CurStepNO:=1;
  while Fcds_ArtDtl.Locate('Step_NO', CurStepNO, []) do
  begin
    OperationListt:=OperationListt + Fcds_ArtDtl.FieldByName('Operation_Code').AsString + '/';
    Inc(CurStepNO)
  end;

  //�жϹ������Ƿ�Υ������
  FNMServerArtObj.GetCheckSpecialArt(GF_ID, 1, OperationListt, Login.CurrentDepartment, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_GetCheckSpecialArt, [sErrorMsg]);

  if OperationListt = '' then exit;
  QualityOperator := 0;
  if IsQualityOperator then
    QualityOperator := 1;
  vData := VarArrayCreate([0, 1], VarVariant);
  vData[0] := varArrayOf([QualityOperator,
                          RepairIden,
                          GF_ID,
                          Quantity,
                          CardList,
                          Repair_Code,
                          1,
                          OperationListt,
                          Current_Department,
                          Operator]); 
  Fcds_ArtHdr.MergeChangeLog;
  Fcds_ArtDtl.MergeChangeLog;

  //��������
  FNMServerArtObj.SaveRepairArt(vData,Fcds_ArtHdr.Data, Fcds_ArtDtl.Data, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveRepairArtData, [sErrorMsg]);
  // David Cao add for 42677 �ƶ����޹��� IsQualityOperator ����Ա����������Զ����ɹ���
  if IsQualityOperator then
    FNMServerObj.SaveDataBySQL('AutoGeneRepairParas',QuotedStr(CardList), sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveRepairArtData, [sErrorMsg]);
  if Assigned(FOnAfterSave) then FOnAfterSave(Self);
  result:=true;
  Modify:=false;
  ShowMsgDialog(@MSG_SaveRepairArtDtlSuccess, mtInformation);
end;

{ THLArtDtlInfo }

procedure THLArtDtlInfo.CreateHLArt(FN_ID, FN_NO, Creator: String);
begin
  if not CloseArt then exit;

  //���������ֶ�
  with Fcds_ArtHdr do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('FN_ID',              ftString, 9);
    FieldDefs.Add('FN_NO',              ftString, 9);
    FieldDefs.Add('Art_ID',             ftInteger);
    FieldDefs.Add('FN_Art_NO',          ftString, 10);
    FieldDefs.Add('Art_Type',           ftString, 1);
    FieldDefs.Add('Material_Quality',   ftString, 10);
    FieldDefs.Add('Operator',           ftString, 20);
    FieldDefs.Add('Operate_Time',       ftDateTime);
    FieldDefs.Add('Remark',             ftString, 150);
    CreateDataSet;
    Fcds_ArtHdr.AppendRecord([FN_ID, FN_NO, nil, nil, 'H', '��֯��', Creator, TGlobal.GetServerTime, nil]);
  end;

  //����ӱ��ֶ�
  with Fcds_ArtDtl do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('Step_NO',        ftSmallint);
    FieldDefs.Add('EditStep_NO',    ftSmallint);
    FieldDefs.Add('Operation_Code', ftString, 3);
    FieldDefs.Add('Operation_CHN',  ftString, 20);
    FieldDefs.Add('Item_Name',      ftString, 10);
    FieldDefs.Add('Item_Value',     ftString, 50);
    FieldDefs.Add('Operator',       ftString, 20);
    FieldDefs.Add('Operate_Time',   ftDateTime);
    FieldDefs.Add('OrgStep_NO',     ftSmallint);
    CreateDataSet;
  end;

  if Assigned(FOnAfterOpen) then FOnAfterOpen(Self);
  Modify:=true;
end;

function THLArtDtlInfo.SaveArtToDataBase: Boolean;
var
  vDataDtl: OleVariant;
  sErrorMsg: WideString;
begin
  result := True;
  if (not Active) or (not Modify) or IsEmpty then exit;
  if Assigned(FOnBeforeSave) then FOnBeforeSave(Self);

  Fcds_ArtHdr.MergeChangeLog;
  Fcds_ArtDtl.MergeChangeLog;

  //��������
  vDataDtl:=Fcds_ArtDtl.Data;
  FNMServerArtObj.SaveHLArtInfo(Login.CurrentDepartment, Fcds_ArtHdr.Data, vDataDtl, sErrorMsg);
  if sErrorMsg <> '' then
    raise ExceptionEx.CreateResFmt(@ERR_SaveHLArtInfo, [sErrorMsg]);

  TempClientDataSet.Data:=vDataDtl;
  Fcds_ArtHdr.Edit;
  Fcds_ArtHdr['Art_ID']:=TempClientDataSet['Fact_Art_ID'];
  
  result:=true;
  Modify:=false;
  if Assigned(FOnAfterSave) then FOnAfterSave(Self);
  ShowMsgDialog(@MSG_SaveHLArtInfoSuccess, mtInformation);
end;

end.


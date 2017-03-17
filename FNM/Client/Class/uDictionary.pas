unit uDictionary;
{*|<PRE>*****************************************************************************

       ������� FNM CLIENT MODEL                                               
       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                              
       ��Ԫ���� uDictionary.pas                                                
       �������� 2004-10-23 13:17:32                                            
       ������Ա lvzd                                                           
       �޸���Ա
       �޸�����                                                                
       �޸�ԭ��                                                                
       ��Ӧ����                                                                
       �ֶ�����                                                                
       ������ݿ��                                                            
       ������Ҫ����/SQL����˵��                                                
       �������� �ֵ���൥Ԫ                                                               
                                                                              
******************************************************************************}

interface

uses DBClient, Classes;

const
  DICTIONARY_COUNT= 28;
  //���������е�ֵ����dbo.usp_GetBaseTableInfo�洢����,������洢���̵�ֵ��Ӧ.
  DictionaryName: array[0..DICTIONARY_COUNT] of WideString =
                   ( 'dlRepairReasonList'   ,'dlColorList'                 ,'dlArtDescriptionList'      ,'dlDepartmentList',
                     'dlOperationHdrList'  ,'dlOperationDtlList'          ,'dlPrescriptionHdrList'     ,'dlChemicalList',
                     'dlArtReviewList'     ,'dlPrepareTypeList'           ,'dlFinishMachineList'       ,'dlMaterialFlowList',
                     'dlWorkerStationList' ,'dlSampleItemList'            ,'dlWorkerList'              ,'dlWorkerGroupList',
                     'dlVatList'           ,'dlOperationMapMachineModel'  ,'dlTestItems'               ,'dlStdArtDtlList',
                     'dlShrinkageList'     ,'dlPrescriptionDtlList'       ,'dlSuspendReasonList'       ,'dlOTDReasonList',
                     'dlReceiveBenchMarkList','dlMutexChemicalList','dlCPBStock','dlCPBChemical','dlCPBChemicalGroup');
type
{TFNDictionary}
  TFNDictionary=Class
  {* �ֵ����}
  private
    FDictionary: array [0..DICTIONARY_COUNT] of TClientDataSet;

    function GetFNDictionary(const Index: Integer): TClientDataSet;
    procedure ShowErrorMessage(Index: Integer; OrgErrorString: String = '');
  public
    constructor Create(AOwner: TComponent);
    {* Create}
    destructor Destroy; override;
    {* Destroy}
    procedure CloseAllDataSet;
    function GetItemList(const sCode, sCurrent_Department, sType: WideString):string;
    property cds_RepairReasonList:            TClientDataSet Index 0{dlRepairReasonList           }read GetFNDictionary;
    property cds_ColorList:                   TClientDataSet Index 1{dlColorList                  }read GetFNDictionary;
    property cds_ArtDescriptionList:          TClientDataSet Index 2{dlArtDescriptionList         }read GetFNDictionary;
    property cds_DepartmentList:              TClientDataSet Index 3{dlDepartmentList             }read GetFNDictionary;
    property cds_OperationHdrList:            TClientDataSet Index 4{dlOperationHdrList           }read GetFNDictionary;
    property cds_OperationDtlList:            TClientDataSet Index 5{dlOperationDtlList           }read GetFNDictionary;
    property cds_StdPrescriptionHdrList:      TClientDataSet Index 6{dlPrescriptionHdrList        }read GetFNDictionary;
    property cds_ChemicalList:                TClientDataSet Index 7{dlChemicalList               }read GetFNDictionary;
    property cds_ArtReviewList:               TClientDataSet Index 8{dlArtReviewList              }read GetFNDictionary;
    property cds_PrepareTypeList:             TClientDataSet Index 9{dlPrepareTypeList            }read GetFNDictionary;
    property cds_FinishMachineList:           TClientDataSet Index 10{dlFinishMachineList         }read GetFNDictionary;
    property cds_MaterialFlowList:            TClientDataSet Index 11{dlMaterialFlowList          }read GetFNDictionary;
    property cds_WorkerStationList:           TClientDataSet Index 12{dlWorkerStationList         }read GetFNDictionary;
    property cds_SampleItemList:              TClientDataSet Index 13{dlSampleItemList            }read GetFNDictionary;
    property cds_WorkerList:                  TClientDataSet Index 14{dlWorkerList                }read GetFNDictionary;
    property cds_WorkerGroupList:             TClientDataSet Index 15{dlWorkerGroupList           }read GetFNDictionary;
    property cds_VatList:                     TClientDataSet Index 16{dlVatList                   }read GetFNDictionary;
    property cds_OperationMapMachineModel:    TClientDataSet Index 17{dlOperationMapMachineModel  }read GetFNDictionary;
    property cds_TestItems:                   TClientDataSet Index 18{dlTestItems                 }read GetFNDictionary;
    property cds_StdArtDtlList:               TClientDataSet Index 19{dlStdArtDtlList             }read GetFNDictionary;
    property cds_ShrinkageList:               TClientDataSet Index 20{dlShrinkageList             }read GetFNDictionary;
    property cds_StdPrescriptionDtlList:      TClientDataSet Index 21{dlPrescriptionDtlList       }read GetFNDictionary;
    property cds_SuspendReasonList:           TClientDataSet Index 22{dlSuspendReasonList         }read GetFNDictionary;
    property cds_OTDReasonList:               TClientDataSet Index 23{dlOTDReasonList             }read GetFNDictionary;
    property cds_ReceiveBenchMarkList:        TClientDataSet Index 24{dlReceiveBenchMarkList      }read GetFNDictionary;
    property cds_MutexChemicalList:           TClientDataSet Index 25{dlMutexChemicalList         }read GetFNDictionary;
    property cds_CPBStock:                    TClientDataSet Index 26{dlMutexChemicalList         }read GetFNDictionary;
    property cds_CPBChemical:                 TClientDataSet Index 27{dlMutexChemicalList         }read GetFNDictionary;
    property cds_CPBChemicalGroup:            TClientDataSet Index 28{dlMutexChemicalList         }read GetFNDictionary;
  end;

function Dictionary: TFNDictionary;
{*|<PRE>------------------------------------------------------------------------------
   ������Ա: lvzd
   ��������: 2004-10-22 16:48:28
   �����б�: ��
   ��������: �����ֵ�����ʵ��
-------------------------------------------------------------------------------}
function TempClientDataSet: TClientDataSet;

implementation

uses uFNMResource, uLogin, ServerDllPub, IdGlobal, SysUtils, Dialogs, uShowMessage,
  Controls;

var
  ADictionary: TFNDictionary;
  lTempClientDataSet: TClientDataSet;

{ TFNDictionary }

constructor TFNDictionary.Create(AOwner: TComponent);
var
  i: Integer;
begin
  inherited Create;

  for i := 0 to DICTIONARY_COUNT do
    FDictionary[i] := nil;
end;

destructor TFNDictionary.Destroy;
var
  i: Integer;
begin
  for i := 0 to DICTIONARY_COUNT do
    FreeAndNil(FDictionary[i]);

  inherited;
end;

function TFNDictionary.GetFNDictionary(const Index: Integer): TClientDataSet;
var
  vData: OleVariant;
  sErrorMsg: WideString;
begin
  if Index > DICTIONARY_COUNT then
    Raise Exception.CreateRes(@ERR_PropertyIndex);

  //������Ϊ��ȥ��Delphi�ľ���,�в�����Try..finally..End��ʹ��result
  result:=FDictionary[Index];
  try
    //��Ӧ���ֵ��Ѿ������˳�
    if (FDictionary[Index] <> nil) and FDictionary[Index].Active then exit;

    try
      uFNMResource.ShowStatusMessage(@STA_GetDictionaryMessage, [DictionaryName[Index]]);
      FNMServerObj.GetBaseTableInfo(vData,DictionaryName[Index],sErrorMsg);
      if sErrorMsg <> '' then
      begin
        ShowErrorMessage(Index, sErrorMsg);
        exit;
      end;

      if FDictionary[Index] = nil then FDictionary[Index] := TClientDataSet.Create(nil);

      FDictionary[Index].Data := vData;
          
      if Index = 5{dlOperationDtlList} then
      begin
        //���˵�ǰ����ʹ�õĲ���
        FDictionary[Index].Filter:=Format('Use_Department like ''%s%s%s''', ['%', Login.CurrentDepartment, '%']);
        FDictionary[Index].Filtered:=True;
      end;
    except
      ShowErrorMessage(Index);
    end;
  finally
    uFNMResource.ShowStatusMessage(@STA_Ready, []);
    result:=FDictionary[Index];
  end;
end;

procedure TFNDictionary.ShowErrorMessage(Index: Integer; OrgErrorString: String);
var
  ErrorString: String;
begin
  if Index > DICTIONARY_COUNT then
    raise Exception.Create(GetResourceString(@ERR_PropertyIndex));
    
  ErrorString:=DictionaryName[Index] + '    ' + OrgErrorString;
  ShowCustomMsgDialog(@GetDictionaryListError, [ErrorString], mtError);
end;

procedure TFNDictionary.CloseAllDataSet;
var
  i: Integer;
begin
  for i := 0 to DICTIONARY_COUNT do
  begin
    if FDictionary[i] <> nil then
      FDictionary[i].Active:=false;
  end
end;

function TFNDictionary.GetItemList(const sCode, sCurrent_Department, sType: WideString):string;
var sNoteNOList: OleVariant;
    sErrorMsg: WideString;
begin
  try
    FNMServerObj.GetItemList(sNoteNOList,sCode, sCurrent_Department, sType,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      Exit;
    end;
  except
    raise;
   //
  end;
  Result := sNoteNOList;
end;

function Dictionary: TFNDictionary;
begin
  if ADictionary = nil then
    ADictionary:=TFNDictionary.Create(nil);

  result:=ADictionary;
end;

function TempClientDataSet: TClientDataSet;
begin
  if lTempClientDataSet = nil then
    lTempClientDataSet:=TClientDataSet.Create(nil);

  result:=lTempClientDataSet;
end;

initialization
  ADictionary:=nil;
  lTempClientDataSet:=nil;

finalization
  FreeAndNil(ADictionary);
  FreeAndNil(lTempClientDataSet);

end.



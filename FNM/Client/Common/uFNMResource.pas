unit uFNMResource;
{*|<PRE>*****************************************************************************
                                                                             
       ������� FNM CLIENT MODEL                                               
       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                              
       ��Ԫ���� uFNMResource.pas                                               
       �������� 2004-8-30 ���� 07:11:14                                        
       ������Ա lvzd                                                           
       �޸���Ա                                                                
       �޸�����                                                                
       �޸�ԭ��                                                                
       �������� �ַ�����Դ�ļ�
                                                                              
******************************************************************************}

interface

uses
  uShowMessage, Dialogs, SysUtils, Controls;

Const
  DateTimeFmtStr = 'yyyy-mm-dd 07:00:00';
  {* ʱ���ʽ}
  MAX_OPERATE_STEP_NO_LENGTH = 2;
  {* �����ŵ����λ��}
  MAX_FN_CARD_COUNT = 6;
  {* һ�ſ������ɲ���������}

  //Res Name
  RES_CALCULATE                ='FNM_CALCULATE';
  RES_CLOCK                    ='FNM_CLOCK'     ;
  RES_COMPUTER                 ='FNM_COMPUTER';
  RES_COPY                     ='FNM_COPY';
  RES_CUT                      ='FNM_CUT';
  RES_DELETE                   ='FNM_DELETE';
  RES_DOWN                     ='FNM_DOWN';
  RES_DOWNALL                  ='FNM_DOWNALL';
  RES_EDIT                     ='FNM_EDIT';
  RES_EMAIL                    ='FNM_EMAIL';
  RES_EXIT                     ='FNM_EXIT';
  RES_EXOPRTFILE               ='FNM_EXOPRTFILE';
  RES_HELP                     ='FNM_HELP';
  RES_HELPABOUT                ='FNM_HELPABOUT';
  RES_LEFT                     ='FNM_LEFT';
  RES_LEFTALL                  ='FNM_LEFTALL';
  RES_LOCK                     ='FNM_LOCK';
  RES_MOVEDOWN                 ='FNM_MOVEDOWN';
  RES_MOVEFIRST                ='FNM_MOVEFIRST';
  RES_MOVELAST                 ='FNM_MOVELAST';
  RES_MOVEUP                   ='FNM_MOVEUP';
  RES_NEW                      ='FNM_NEW';
  RES_OPEN                     ='FNM_OPEN';
  RES_PASTE                    ='FNM_PASTE';
  RES_PREVIEW                  ='FNM_PREVIEW';
  RES_PRINT                    ='FNM_PRINT';
  RES_PRINTER                  ='FNM_PRINTER';
  RES_QUERY                    ='FNM_QUERY';
  RES_QUERYSMALL               ='FNM_QUERYSMALL';
  RES_REDO                     ='FNM_REDO';
  RES_REFRESH                  ='FNM_REFRESH';
  RES_RIGHT                    ='FNM_RIGHT';
  RES_RIGHTALL                 ='FNM_RIGHTALL';
  RES_SAVE                     ='FNM_SAVE';
  RES_SCANNER                  ='FNM_SCANNER';
  RES_UNDO                     ='FNM_UNDO';
  RES_UP                       ='FNM_UP';
  RES_UPALL                    ='FNM_UPALL';
  RES_USERS                    ='FNM_USERS';
  RES_WHATTHIS                 ='FNM_WHATTHIS';
  RES_CLOSETABLE               ='FNM_CLOSETABLE';
   // Field Define Example
//  FIELD_Unioner                ='Unioner';                  //�鿨��
//  FIELD_Unit_QTY               ='Unit_QTY';                 //��λ����


resourcestring
  //Data is Empty
  EMP_AccidentInfo=                   'WAR_���ݿ��в����ڸô�����';
  EMP_NoCheckRecipe=                  'WAR_û��δȷ�ϵĻ��ϵ�,���Ժ�����!';
  EMP_ChemicalInDtl=                  'WAR_ָ������û�л����ϵ������Ϣ';
  EMP_ChemicalOutDtl=                 'WAR_ָ������û�л����ϵĳ�����Ϣ';
  EMP_CTFPYDtl=                       'WAR_ָ��Ʒ��:%s,�ŵ�:%s��CT&FPY����ϸ����Ϊ��';
  EMP_FNNOInfo=                       'WAR_��֯�湤����ϢΪ��,����ϵ����Ա!';
  EMP_NoAnalysisData=                 'WAR_����������Ϊ��,���Ժ�����!';
  EMP_NoArtReceiveedHL=               'WAR_û��δ�ƶ����յ���֯����';
  EMP_HLBasicInfo=                    'WAR_��֯�湤����ϢΪ��,���ݳ���,����ϵ����Ա';
  EMP_NoDisposeAccident=              'WAR_��ʱû��δ����Ĵ���,���Ժ�����!';
  EMP_NoFinishFactPrescrip_NO=        'WAR_û��δ�������ϵ���ʵ�ʴ�������,���Ժ�����!';
  EMP_NoFinishRecipe=                 'WAR_û����δ��ɵĻ��ϵ�,���Ժ�����!';
  EMP_NoFinishRecipeBatch=            'WAR_û����δ���ϵĸ���,���Ժ�����!';
  EMP_NOReceiveedHL=                  'WAR_û���ѽ��յ���֯��';
  EMP_NOReceiveHL=                    'WAR_û��δ���յ���֯��';
  EMP_OnLineCard=                     'WAR_û���ҵ����߿���,���Ժ�����';
  EMP_GetNoRecipeSteps=               'WAR_û���ҵ��޻��ϵ�����,���Ժ�����';
  EMP_OnLineCardOfFactPrescription=   'WAR_��ʵ�ʴ�����û�а����κο���,�������ݳ���,����ϵ����Ա';
  EMP_OperationList=                  'WAR_����Ϊ��,���ݳ���,����ϵ����Ա!';
  EMP_Operators=                      'WAR_��������Ϊ��,���ݳ���,����ϵ����Ա!';
  EMP_RepairFNCard=                   'WAR_û�в��ҵ�δ�ƶ��������յĿ���';
  EMP_SampleInfo=                     'WAR_��ʱ��ȡ��,���Ժ�����';
  EMP_SampleList=                     'WAR_ȡ����ϢΪ��!���ݳ���,����ϵ����Ա!';
  EMP_STDPrescription=                'WAR_��׼����������Ϊ��,�������ݴ�,����ϵ����Ա';
  EMP_VatList=                        'WAR_���ϸ׺��б�Ϊ��,����ϵϵͳά����Ա��ʼ�����ϸ��ֵ��!';
  EMP_NOReceiveSendHLList=            'WAR_��ʱû�д�%s��֯��,���Ժ�����!';
  EMP_StdArtInfoDtlCantCopy=          'WAR_��׼���ղ�����!';
  EMP_ArtItemInfo=                    'WAR_ȡ�������׼������Ϣ����!';
  EMP_StdArtInfoCantCreatePrescripton='WAR_��׼����Ϊ��,���ܽ�����׼������!';
  EMP_STDArt=                         'WAR_��ǰƷ���ı�׼����Ϊ��.';
  EMP_HoldList=                       'WAR_û�д����HOLD������.';
  EMP_CADInfo=                        'WAR_��ǰƷ��:%s��CAD��Ϣ';
  EMP_WebInfo=                        'WAR_��ǰƷ��:%s��CAD������Ϣ';
  EMP_PrintFNCardInfo=                'WAR_���򿨵�����Ϊ��';
  ERR_OnLineOperationList=            'WAR_��ǰƷ��%sû�����ڼӹ��Ĺ���';
  EMP_NoPrescripCard=                 'WAR_�޿�ѡ����';
  EMP_ArtReview=                      'WAR_��ǰ�����޹��ջع˺�ʵ�ʹ���,��ȷ�Ͽ����Ƿ����!';
  EMP_SendCardByDateEmpty=            'WAR_ָ���������Ͳ�����,�����Ա������!';
  EMP_GQQueryInfo=                    'WAR_���ڲ�ѯ:%s,ͨ������:%sû�еõ��κ���Ч��¼!���޸��������ѯ';
  
  FactArtEmpty=                       'ʵ�ʹ���Ϊ��,�������ݴ�,����ϵ����Ա';
  GFKeyValueWIPEmpty=                 'ѡ��Ʒ��������WIPΪ��,���Ժ�����!';
  OperationWIPDtEmpty=                '����WIP����ϸ����Ϊ��,���Ժ�����!';
  OperationWIPEmpty=                  '����WIP����Ϊ��,���Ժ�����!';

  //Invalid Input Data
  INV_NOCardSelected=                 'WAR_û��ѡ�񿨺Ż����볤ֻ�͵���0,������ѡ�񿨺�';
  INV_NoChoiceChemicalName=           'WAR_��ѡ��һ����������,����������ȷ��';
  INV_NoChoiceSource=                 'WAR_��ѡ��һ��������Ϊ��Դ';
  INV_NoChoiceDestination=            'WAR_��ѡ��һ��������ΪĿ�겿��';
  INV_ValueIsLessThenZero=            'WAR_%s:��ֵС�ڵ���0,����������һ������0��ֵ';
  INV_OutValueIsMoreThenStockValue=   'WAR_%s:��ֵ���ڿ������,����������һ��С�ڿ���ֵ';
  INV_NoChoiceReasonType=             'WAR_��ѡ��һ���õ����';
  INV_NoChoiceReasonName=             'WAR_��ѡ��һ���õ���';
  INV_GFIDorGF_NO=                    'WAR_��ǰƷ����Ʒ��ID:%s������';
  INV_ResidualVolumeValue=            'WAR_�������С�ڵ���0,������ϸ׵�������,����������';
  INV_GF_NO=                          'WAR_��Ч��Ʒ�����!';
  INV_NOSelectSTDSampleNO=            'WAR_ѡ��ı�׼ȡ�������Ч,������ѡ��!';
  INV_NOSelectTestItem=               'WAR_û�в�����Ŀ��ѡ��,������ѡ��!';
  INV_Operate_ID=                     'WAR_��Ч�Ĺ�����:%s,����ϵ����Ա��';
  INV_NOSelectRepairFabricNO=         'WAR_��Ϊ��ǰ���޹���ѡ������һ������!';
  INV_NOSelectRepairReason=           'WAR_��ѡ�����ԭ��!';
  INV_NOSelectFNCardFoAccident=       'WAR_ѡ��Ϊ����ѡ������һ������!';
  INV_NOSelectFactPrescription=       'WAR_��ѡ��ʵ�ʴ�������!';
  INV_NOOperation=                    'WAR_��ѡ����!';
  INV_NOStdPrescription=              'WAR_��ѡ���׼�䷽��!';
  INV_NOMachineID=                    'WAR_��ѡ���̨!';
  INV_NOInPutGFKeyValue=              'WAR_������Ʒ��!';
  INV_NOItemValue=                    'WAR_�������ͱ�����:%s,����������:%s!';
  INV_GFIDDifferent=                  'WAR_��ѡ����ͬ��Ʒ��';
  INV_IdenDifferent=                  'WAR_������ɫΪ��ɫ�Ŀ�ֻ�ܵ�ѡ,���ܺ������Ŀ������һ��';
  INV_UnionCard=                      'WAR_%s��Ʒ�ֲ��ܴ�,��ȷ��!';
  INV_CardCarNO=                      'WAR_�����뵱ǰ���ŵĳ��ƺ�!';
  INV_ScrapVolume=                    'WAR_�����������С�ڻ������,��ȷ��!';

  InvalidChemical_ID=                 '��Ч�Ļ����ϱ��';
  InvalidFACT_Art_ID=                 '��Ч��ʵ�ʹ��ձ��';
  InvalidMachine=                     '��̨��Ų�ƥ��!';
  InvalidPrescrip_NO=                 '��Ч�Ĵ�������!';

  // Messages

  MSG_SaveNewRecipeVolSuccess=        'INF_���ϵ�����޸ĳɹ�!';
  MSG_SaveDelRecipeSuccess=           'INF_���ϵ�ɾ���ɹ�!';
  MSG_SaveArtControlSuccess=          'INF_���տ�����Ϣ����ɹ�!';
  MSG_SaveReceiveSendSuccess=         'INF_��֯��%s����ɹ�!';
  MSG_SaveAccidentInfoSuccess=        'INF_��������ɹ�!';
  MSG_SaveStdArtCheckInfoSuccess=     'INF_ȷ����Ϣ����ɹ�!';
  MSG_SaveCheckPrescriptionSuccess=   'INF_��׼����ȷ����Ϣ�Ѿ�����!';
  MSG_SaveStdArtInfoSuccess=          'INF_��׼���ձ���ɹ�!';
  MSG_SaveFactArtDtlInfoSuccess=      'INF_ʵ�ʹ��ձ���ɹ�!';
  MSG_SaveRepairArtDtlSuccess=        'INF_���޹��ձ���ɹ�!';
  MSG_SaveHLArtInfoSuccess=           'INF_��֯�湤�ձ���ɹ�!';
  MSG_SaveChemicalInInfoSuccess=      'INF_������������ݱ���ɹ�!';
  MSG_CantChangeChemicalName=         'INF_�����ϵ������뵱ǰ��¼��һ��,����Ӧ���޸�';
  MSG_ChemicalNameAlreadyIn=          'INF_��ͬ���ϵ����Ѱ�����ͬ�Ļ�����.������Ӽ�¼!';
  MSG_ChemicalRatioIsLessThanZero=    'INF_��Ʒ���Ļ��ϱ���ΪС��0����Чֵ.';
  MSG_ChoiceCard=                     'INF_����ѡ�񿨺�!';
  MSG_ChoiceFactPrescrip=             'INF_����ѡ�񲢴�һ��ʵ�ʴ�����!';
  MSG_WillCreateRecipe=               'INF_Ҫ��Ե�ǰ���������ϵ���?';
  MSG_WillCreateStdArt=               'INF_��ǰƷ��û�б�׼����,Ҫ������׼������?';
  MSG_EndRecipe=                      'INF_��OK,%s�ϸ��е��ϻ������.';
  MSG_BeginRecipe=                    'INF_���ϵĻ�����Ϣ�Ѿ�׼�����,ѡYES��ʼ��%s�л�%s��.';
  MSG_VatIsEmpty=                     'INF_��ǰ���ϸ�û�л���.';
  MSG_SaveArtReview=                  'INF_���ջع˱���ɹ�!';
  MSG_InfoDeficiency=                 'INF_�򿪹��յ�������������';
//  MSG_STDPrescriptionDtlSuccess=      'INF_��׼����������ɹ�!';
//  MSG_FactPrescriptionDtlSuccess=     'INF_ʵ�ʴ���������ɹ�!';
  MSG_SaveRecipeSuccess=              'INF_���ϵ�����ɹ�!';
  MSG_ClearCurOperate=                'INF_�����Ѿ�����,��Ҫɾ�����е����й������������?';
  MSG_EnableQuantity=                 'WAR_����޸ĺ���ɿ�����С��0.';
  MSG_IncOutQuantity=                 'WAR_�������ݲ��ܸĴ�ֻ�ܸ�С.';
  MSG_StdPrescriptionNotActive=       'WAR_��ǰ��׼������:%s��Ч.';
  MSG_ChemicalUnitQTYLassThanZero=    'WAR_������%s��λ����С��0,���������0������.';
  MSG_SavePrintFNCardInfoSuccess=     'INF_����Ϣ����ɹ�!����:%s';
  MSG_TheGFKeyValueNoStdArt=          'INF_��ǰƷ��û�б�׼����';

  AskSaveDataStr=                     '�޸ĵ�����û�б���,�Ƿ�Ҫ��������?';
  SaveDataFail=                       '���ݱ���ʧ��!';
  SaveDataSuccess=                    '���ݱ���ɹ�!';
  VatIsEmpty=                         '���ϸ�Ϊ��.';
  VatNotEmpty=                        '���ϸײ�Ϊ��,������ѡ���ϸ�';

  // Error
  ERR_GetNoFinishPrescriptionNOList=  'ERR_��ȡδ��ɵĴ�����ʧ��,����ϵ����Ա!';
  ERR_FactPrescripNotIncludeCard=     'ERR_����2yʵ�ʴ���������������,����ϵ����Ա!';
  ERR_GetAccidentCardList=            'ERR_��ȡ�����Ű����Ŀ��ų���:%s������!';
  ERR_GetAccidentDisposeInfo=         'ERR_��ȡ����������Ϣ����:%s������!';
  ERR_GetAccidentInfo=                'ERR_��ȡ������Ϣ����:%s������!';
  ERR_GetNoCheckRecipe=               'ERR_��ȡδȷ�ϻ��ϵ�����:%s������!';
  ERR_GetCardByFabricList=            'ERR_��ȡָ�����ŵĿ��ų���:%s������!';
  ERR_GetUnFinishJobTraceDtl=         'ERR_��ȡδ�ӹ��Ľ��ȸ�����ϸ����:%s';
  ERR_GetCheckSpecialArt=             'ERR_��⹤���Ƿ�Υ������ʧ��:%s';
  ERR_GetCheckGFIDAndSTDArt=          'ERR_���Ʒ������:%s�����Ի���ϵ����Ա���!';
  ERR_GetCurCardOperationList=        'ERR_ȡ��ǰ���ŵĹ����б����:%s����ϵ����Ա!';
  ERR_GetFactArtDtl=                  'ERR_��ȡʵ�ʹ��ճ���:%s�����Ի���ϵ����Ա���';
  ERR_GetBatchInfo=                   'ERR_��ȡ�׺���Ϣ����:%s������!';
  ERR_GetHLArtArtDtl=                 'ERR_��ȡ��֯�湤�ճ���:%s�����Ի���ϵ����Ա���';
  ERR_GetAnalysisData=                'ERR_ȡ���������ݳ���:%s.������';
  ERR_GetNoDisposeAccident=           'ERR_��ȡδ����Ĵ������ų���:%s������!';
  ERR_GetNoFinishFactPrescrip_NO=     'ERR_��ȡʵ�ʴ������ų���:%s������!';
  ERR_GetNoFinishRecipe=              'ERR_��ȡδ��ɵĻ��ϵ��ų���:%s������!';
  ERR_ExportBatchToCS=                'ERR_�������ϵ����Զ�����ϵͳ����: %s ������!';
  ERR_GetNoFinishBatch=               'ERR_��ȡδ��ɵĻ��ϸ׳���:%s������!';
  ERR_GetBatchSteps=                  'ERR_��ȡ��ȡ�׺ŷֲ�����:%s������!';
  ERR_GetBatchDtlInfo=                'ERR_��ȡ�׺���Ϣ����:%s������!';
  ERR_GetNOReceiveHL=                 'ERR_��ȡδ���յ���֯�����:%s������!';
  ERR_GetNOArtReceiveHL=              'ERR_��ȡδ���յ���֯�����:%s������!';
  ERR_GetHLBasicInfo=                 'ERR_��ȡ��֯�湤����Ϣ����:%s������!';
  ERR_GetOperators=                   'ERR_��ȡ��ǰ����ļӹ���Ա����:%s������!';
  ERR_GetOnLineCard=                  'ERR_��ȡ���߿��ų���:%s������!';
  ERR_GetNoRecipeSteps=               'ERR_��ȡ���䷽�������:%s������!';
  ERR_GetStdPrescriptionDtl=          'ERR_��ȡ��׼�䷽����ϸ���ݳ���:%s������';
  ERR_GetRatio=                       'ERR_��ȡ���ϱ�������:%s������!';
  ERR_GetRecipe=                      'ERR_��ȡ���ϵ���Ϣ����:%s������!';
  ERR_GetFNCardsByRecipeNO=           'ERR_��ȡ���ϵ�ʹ�õĿ���ʧ��:%s������!';
  ERR_GetRepairFNCard=                'ERR_��ȡδ�ƶ��������յĿ����б����:%s������!';
  ERR_GetSampleInfo=                  'ERR_��ȡȡ����Ϣ����:%s������!';
  ERR_GetJobTraceInfo=                'ERR_��ȡ���ȸ�����Ϣ����:%s������!';
  ERR_GetSendCardByDate=              'ERR_��ȡָ�������Ͳ����ų���:%s������!';
  ERR_GetUsedPrescripNOCard=          'ERR_��ȡ�����������Ŀ��ų���:%s������!';
  ERR_GetVatList=                     'ERR_��ȡ���ϸ׺��б����:%s�����Ի���ϵ����Ա���!';
  ERR_SaveDelRecipe=                  'ERR_ɾ�����ϵ�ʧ��:%s������!';
  ERR_SaveSplitRecipe=                'ERR_����ָ���Ϣ����:%s������!';
  ERR_SaveSaveDelABatch=              'ERR_ɾ���ָ���Ϣ����:%s������!';
  ERR_SaveAccidentInfo=               'ERR_���洦������:%s������!';
  ERR_SaveAnalysisQualtityData=       'ERR_�������η�����Ϣ����:%s������!';
  ERR_GetArtReview=                   'ERR_ȡ���ջع˳���:%s������!';
  ERR_SaveNewRecipeVol=               'ERR_���ϵ�����޸�ʧ��:%s������!';
  ERR_SaveArtReview=                  'ERR_���湤�ջع˳���:%s������!';
  ERR_SaveCheckArtData=               'ERR_�����׼������ȷ����Ϣ����:%s������!';
  ERR_SaveChemicalInDtl=              'ERR_���滯���������Ϣ����:%s������';
  ERR_SaveChemicalOutDtl=             'ERR_�ܹ���%d�������ϳ������ݱ������!,������!';
  ERR_SaveDipInfo=                    'ERR_����DIP���ų���:%s������!';
  ERR_SaveDisposeAccident=            'ERR_���洦��������Ϣ����:%s������!';
  ERR_SaveFactArtData=                'ERR_����ʵ�ʹ������ݳ���:%s������!';
  ERR_SaveFactPrescription=           'ERR_����ʵ�ʴ���������:%s������!';
  ERR_SaveReceiveSample=               'ERR_����ȡ�����ݳ���:%s������!';
  ERR_SaveRecipe=                     'ERR_���滯�ϵ�����:%s������!';
  ERR_SaveRecipeTraceInfo=            'ERR_���滯�Ͻ��ȸ�����Ϣ����:%s������!';
  ERR_SaveRepairArtData=              'ERR_������޹������ݳ���:%s������!';
  ERR_SaveHLArtInfo=                  'ERR_������֯�湤�����ݳ���:%s������!';
  ERR_SaveStdArtData=                 'ERR_�����׼�������ݳ���:%s������!';
  ERR_SaveUserDefindSample=           'ERR_����ȡ�����ݳ���:%s������!';
  ERR_SystemData=                     'ERR_ϵͳ���ݳ���:%s�����Ի���ϵ����Ա���!';
  ERR_SaveHLReceiveInfo=              'ERR_������֯��������ݳ���:%s������!';
  ERR_SaveHLReceiveSendInfo=          'ERR_������֯��%s���ݳ���:%s������!';
  ERR_GetNOReceiveSendHLList=         'ERR_ȡ��֯���%s���ݳ���:%s������!';
  ERR_GetChemicalInDtl=               'ERR_ȡ������������ݳ���:%s';
  ERR_GetChemicalOutDtl=              'ERR_ȡ�����ϳ������ݳ���:%s';
  ERR_SaveAssiPrescription=           'ERR_�����׼���������ݳ���:%s, ������!';
  ERR_GETCT_FPY=                      'ERR_ȡָ��ʱ��ε�CT&FPY���ݳ���:%s, ������!';
  ERR_GETCT_FPYDTL=                   'ERR_ȡָ��Ʒ���ŵ������ݳ���:%s, ������!';
  ERR_GetStdArtDtl=                   'ERR_ȡ��׼���ճ���:%s������!';
  ERR_FillNOCheckArtGFNOList=         'ERR_��׼���ս���,Ʒ���б�����������';
  ERR_GetArtItemInfo=                 'ERR_ȡ�������׼������Ϣ����:%s,������!';
  ERR_AutoCreateStdArtDtl=            'ERR_�Զ�����:%s �Ĺ��ղ���Ͳ�������,������!';
  ERR_GetNoPrescripCard=              'ERR_��ȡ��ѡ���ų���:%s,������!';
  ERR_SaveChemicalSotckEdit=          'ERR_���滯���Ͽ����Ϣ����:%s';
  ERR_GetPrintFNCardInfo=             'ERR_��ȡ�������ݳ���:%s,�����Ի���ϵ����Ա���!';
  ERR_SaveSavePrintFNCardInfo=        'ERR_��������ݳ���:%s,������!';
  ERR_GetOnLineOperationList=         'ERR_��ȡƷ��:%s���ڼӹ��Ĺ������:%s,������!';
  ERR_SaveStdPrescription=            'ERR_�����׼��������:%s,������!';
  ERR_GetOnlineStdPrescripNO=         'ERR_��ȡ���߻����ϴ��ų���:%s,������!';
  ERR_GetQyDictionary=                'ERR_��ȡ�ֵ��:%s����:%s';
  ERR_GetQyMaster=                    'ERR_��ȡ��������:%s����:%s';
  ERR_GetDetailQuery=                 'ERR_��ȡ�Ӳ�ѯ����:%s';
  ERR_GetQyText=                      'ERR_��ȡ��ѯ������:%s';
  ERR_PropertyIndex=                  'ERR_���Ա�Ŵ���';
  ERR_LocateDataSet=                  'ERR_�޷������ݼ��ж�λ����';

  ERR_GetMONMachinePar=                  'ERR_ȡ������������:%s';
  ERR_GetMONMachineParLog=                  'ERR_ȡ����������־����:%s';

  SaveDataError=                      '���ݱ������!������!';
  ArtReviewDataError=                 '�ع����ݳ���';
  DataError=                          '���ݳ���,����ϵ����Ա.';
  GetArtDescriptionListError=         '�������մ����ֵ��ȡʧ��!';
  GetArtReviewListError=              '�ع������ֵ��ȡʧ��!';
  GetAssiPrescriptionError=           '��ȡ��׼��������Ϣ����:%s������!';
  GetCADInfoError=                    '��ȡCAD��Ϣ����:%s������!';
  GetColorListError=                  '��������ֵ��ȡʧ��!';
  GetDepartmentListError=             '������ֳ��ֵ��ȡʧ��!';
  GetDictionaryListError=             '��ȡ�ֵ������ʧ��: %s';
  GetDipCardError=                    '��ȡ���տ������߿���ʧ��,������!';
  GetGFKeyValueWIPError=              '��ȡѡ��Ʒ��������WIP����,������';
  GetOnLineGFNOError=                 '��ȡ������Ʒ������,������!';
  GetOperationListError=              '��������ֵ��ȡʧ��!';
  GetOperationWIPDtlError=            '��ȡ����WIP����ϸ���ݳ���,������!';
  GetOperationWIPError=               '��ȡ����WIP���ݳ���,������!';
  GetStdPrescriptionListError=        '�������׼�䷽�ֵ��ȡʧ��!';
  GetWebInfoError=                    '��ȡƷ��ͼ�γ���:%s������!';
  NoOpenRecipe=                       '���ȴ�һ�����ϵ����ϸ�';
  NoSelectVat=                        '����ѡ��һ���ϸ�';
  RecipeFinished=                     '��ǰ���ϵ��Ѿ���������';
  SaveCheckArtDataError=              '��������ȷ��ʧ��:%s������ȷ��,�򱣴浽�����ļ���';

  //TextCaption
//  Caption_ChemicalInDtl=              '%s���������ϸ:';

  //Status Message
  STA_GetMessage=                     '���ڻ�ȡ:%s,���Ժ�...';
  STA_GetDictionaryMessage=           '���ڻ�ȡ�ֵ��:%s���Ժ�...';
  STA_SaveMessage=                    '���ڱ���:%s,���Ժ�...';
  STA_Ready=                          '����';

  STA_WebInfo=                        'Ʒ����ͼ����Ϣ';
  STA_CADInfo=                        'Ʒ����CAD��Ϣ';

  STA_GetCTFPY=                       '���ڻ�ȡCT&FPY,���Ժ�...';
  STA_GetCTFPYDtl=                    '���ڻ�ȡCT&FPY����ϸ,���Ժ�...';
  STA_GetGFKeyValueWIP=               '���ڻ�ȡѡ��Ʒ��������WIP,���Ժ�...';
  STA_GetOnLineGFNO=                  '���ڻ�ȡ��������Ʒ��,���Ժ�...';
  STA_GetOperationWIP=                '���ڻ�ȡ����WIP������,���Ժ�...';
  STA_GetOperationWIPDtlWIP=          '���ڻ�ȡ����WIP����ϸ����,���Ժ�...';
  STA_LoginTime=                      '����¼ʱ�䡿';


type
  ExceptionEx = class(Exception)
  public
    constructor CreateResFmt(ResStringRec: PResStringRec; const Args: array of const); overload;
  end;

function GetResourceString(const ResString: Pointer): string;
{*|<PRE>------------------------------------------------------------------------------
   ������Ա: lvzd
   ��������: 2004-8-30 ���� 07:11:58
   �����б�: const ResString: Pointer
   ����ֵ  : string
   ��������: �����ַ�����Դ
   ����˵��:
���÷���:
TMsgDialog.ShowMsgDialog(GetResourceString(@SaveArtHdrDataError),2500);
-------------------------------------------------------------------------------}
procedure ShowStatusMessage(const ResString: Pointer; FieldStrings: array of const);
{*|<PRE> -----------------------------------------------------------------------------
   ������Ա: lvzd
   ��������: 2005-2-17 10:56:20
   �����б�: const ResString, FieldStrings: array of const
   ����ֵ  : None
   ��������: ��״̬������ʾ��Ϣ
-------------------------------------------------------------------------------}
function ShowMsgDialog(const ResString: Pointer; msgType: TMsgDlgType): Integer;
{*|<PRE>------------------------------------------------------------------------------
   ������Ա: lvzd
   ��������: 2004-9-24 9:46:46
   �����б�: const ResString: Pointer; msgType: TMsgDlgType
   ����ֵ  : Integer
   ��������: ͬ��,����resourcestring��ʾMessageDlg
-------------------------------------------------------------------------------}
function ShowCustomMsgDialog(const ResString: Pointer; FieldStrings: array of const; msgType: TMsgDlgType): Integer;
{*|<PRE>------------------------------------------------------------------------------
   ������Ա: lvzd
   ��������: 2004-9-22 16:06:12
   �����б�: const ResString: Pointer; FieldStrings: array of String; msgType: TMsgDlgType
   ����ֵ  : Integer
   ��������: ����resourcestring��ʾMessageDlg
-------------------------------------------------------------------------------}

implementation

function GetResourceString(const ResString: Pointer): string;
begin
  Result := LoadResString(PResStringRec(ResString));
  if Result[4] = '_' then
    System.Delete(Result, 1, 4);
end;

procedure ShowStatusMessage(const ResString: Pointer; FieldStrings: array of const);
var
  MesssageString: String;
  Cursor: TCursor;
begin
  MesssageString:=GetResourceString(ResString);
  if high(FieldStrings) <> -1 then
    MesssageString:=Format(MesssageString, FieldStrings);

  if ResString <> @STA_Ready then
    Cursor:=crHourGlass
  else
    Cursor:=crDefault;

  uShowMessage.ShowStatusMessage(MesssageString, Cursor);
end;

function ShowCustomMsgDialog(const ResString: Pointer; FieldStrings: array of const; msgType: TMsgDlgType): Integer;
var
  MesssageString: String;
begin
  MesssageString:=GetResourceString(ResString);
  if high(FieldStrings) <> -1 then
    MesssageString:=Format(MesssageString, FieldStrings);

  result:=TMsgDialog.ShowMsgDialog(MesssageString, msgType);
end;

function ShowMsgDialog(const ResString: Pointer; msgType: TMsgDlgType): Integer;
begin
  result:=ShowCustomMsgDialog(ResString, [], msgType);
end;

{ ExceptionEx }

constructor ExceptionEx.CreateResFmt(ResStringRec: PResStringRec;
  const Args: array of const);
var
  ResStr: String;
begin
  ResStr:=StringReplace(LoadResString(ResStringRec), '%s', #13#10 + '%s' + #13#10, [rfReplaceAll, rfIgnoreCase]);
  Create(Format(ResStr, Args));
end;

end.


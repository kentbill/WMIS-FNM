unit uFNMResource;
{*|<PRE>*****************************************************************************
                                                                             
       软件名称 FNM CLIENT MODEL                                               
       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                              
       单元名称 uFNMResource.pas                                               
       创建日期 2004-8-30 下午 07:11:14                                        
       创建人员 lvzd                                                           
       修改人员                                                                
       修改日期                                                                
       修改原因                                                                
       功能描述 字符串资源文件
                                                                              
******************************************************************************}

interface

uses
  uShowMessage, Dialogs, SysUtils, Controls;

Const
  DateTimeFmtStr = 'yyyy-mm-dd 07:00:00';
  {* 时间格式}
  MAX_OPERATE_STEP_NO_LENGTH = 2;
  {* 工序编号的最大位数}
  MAX_FN_CARD_COUNT = 6;
  {* 一张卡能容纳布的最多段数}

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
//  FIELD_Unioner                ='Unioner';                  //组卡人
//  FIELD_Unit_QTY               ='Unit_QTY';                 //单位用量


resourcestring
  //Data is Empty
  EMP_AccidentInfo=                   'WAR_数据库中不存在该处方单';
  EMP_NoCheckRecipe=                  'WAR_没有未确认的化料单,请稍候再试!';
  EMP_ChemicalInDtl=                  'WAR_指定日期没有化工料的入库信息';
  EMP_ChemicalOutDtl=                 'WAR_指定日期没有化工料的出库信息';
  EMP_CTFPYDtl=                       'WAR_指定品名:%s,排单:%s的CT&FPY的明细数据为空';
  EMP_FNNOInfo=                       'WAR_手织版工艺信息为空,请联系程序员!';
  EMP_NoAnalysisData=                 'WAR_待分析数据为空,请稍后再试!';
  EMP_NoArtReceiveedHL=               'WAR_没有未制定工艺的手织版了';
  EMP_HLBasicInfo=                    'WAR_手织版工艺信息为空,数据出错,请联系程序员';
  EMP_NoDisposeAccident=              'WAR_暂时没有未处理的处理单,请稍后再试!';
  EMP_NoFinishFactPrescrip_NO=        'WAR_没有未建立化料单的实际处方单了,请稍后再试!';
  EMP_NoFinishRecipe=                 'WAR_没有尚未完成的化料单,请稍后再试!';
  EMP_NoFinishRecipeBatch=            'WAR_没有尚未化料的缸了,请稍后再试!';
  EMP_NOReceiveedHL=                  'WAR_没有已接收的收织版';
  EMP_NOReceiveHL=                    'WAR_没有未接收的收织版';
  EMP_OnLineCard=                     'WAR_没有找到在线卡号,请稍后再试';
  EMP_GetNoRecipeSteps=               'WAR_没有找到无化料单工序,请稍后再试';
  EMP_OnLineCardOfFactPrescription=   'WAR_该实际处方单没有包含任何卡号,可能数据出错,请联系程序员';
  EMP_OperationList=                  'WAR_工序为空,数据出错,请联系程序员!';
  EMP_Operators=                      'WAR_工人数据为空,数据出错,请联系程序员!';
  EMP_RepairFNCard=                   'WAR_没有查找到未制订返工工艺的卡号';
  EMP_SampleInfo=                     'WAR_暂时无取样,请稍后再试';
  EMP_SampleList=                     'WAR_取样信息为空!数据出错,请联系程序员!';
  EMP_STDPrescription=                'WAR_标准处方单内容为空,可能数据错,请联系程序员';
  EMP_VatList=                        'WAR_化料缸号列表为空,请联系系统维护人员初始化化料缸字典表!';
  EMP_NOReceiveSendHLList=            'WAR_暂时没有待%s手织版,请稍后再试!';
  EMP_StdArtInfoDtlCantCopy=          'WAR_标准工艺不存在!';
  EMP_ArtItemInfo=                    'WAR_取后整理标准工艺信息出错!';
  EMP_StdArtInfoCantCreatePrescripton='WAR_标准工艺为空,不能建立标准处方单!';
  EMP_STDArt=                         'WAR_当前品名的标准工艺为空.';
  EMP_HoldList=                       'WAR_没有待解除HOLD的数据.';
  EMP_CADInfo=                        'WAR_当前品名:%s无CAD信息';
  EMP_WebInfo=                        'WAR_当前品名:%s无CAD花形信息';
  EMP_PrintFNCardInfo=                'WAR_待打卡的数据为空';
  ERR_OnLineOperationList=            'WAR_当前品名%s没有正在加工的工序';
  EMP_NoPrescripCard=                 'WAR_无可选卡号';
  EMP_ArtReview=                      'WAR_当前卡号无工艺回顾和实际工艺,请确认卡号是否存在!';
  EMP_SendCardByDateEmpty=            'WAR_指定日期无送布卡号,请重试别的日期!';
  EMP_GQQueryInfo=                    'WAR_对于查询:%s,通过条件:%s没有得到任何有效记录!请修改条件后查询';
  
  FactArtEmpty=                       '实际工艺为空,可能数据错,请联系程序员';
  GFKeyValueWIPEmpty=                 '选定品名的在线WIP为空,请稍后再试!';
  OperationWIPDtEmpty=                '工序WIP的明细数据为空,请稍后再试!';
  OperationWIPEmpty=                  '工序WIP数据为空,请稍后再试!';

  //Invalid Input Data
  INV_NOCardSelected=                 'WAR_没有选择卡号或总码长只和等于0,请重新选择卡号';
  INV_NoChoiceChemicalName=           'WAR_请选择一个化工料名,或化料名不正确。';
  INV_NoChoiceSource=                 'WAR_请选择一个部门作为来源';
  INV_NoChoiceDestination=            'WAR_请选择一个部门作为目标部门';
  INV_ValueIsLessThenZero=            'WAR_%s:数值小于等于0,请重新输入一个大于0的值';
  INV_OutValueIsMoreThenStockValue=   'WAR_%s:数值大于库存数据,请重新输入一个小于库存的值';
  INV_NoChoiceReasonType=             'WAR_请选择一个疵点分类';
  INV_NoChoiceReasonName=             'WAR_请选择一个疵点名';
  INV_GFIDorGF_NO=                    'WAR_当前品名或品名ID:%s不存在';
  INV_ResidualVolumeValue=            'WAR_化料体积小于等于0,或大于料缸的最大体积,请重新输入';
  INV_GF_NO=                          'WAR_无效的品名编号!';
  INV_NOSelectSTDSampleNO=            'WAR_选择的标准取样编号无效,请重新选择!';
  INV_NOSelectTestItem=               'WAR_没有测试项目被选择,请重新选择!';
  INV_Operate_ID=                     'WAR_无效的工序编号:%s,请联系程序员。';
  INV_NOSelectRepairFabricNO=         'WAR_请为当前回修工艺选择至少一个卡号!';
  INV_NOSelectRepairReason=           'WAR_请选择回修原因!';
  INV_NOSelectFNCardFoAccident=       'WAR_选择为处理单选择至少一个卡号!';
  INV_NOSelectFactPrescription=       'WAR_请选择实际处方单号!';
  INV_NOOperation=                    'WAR_请选择工序!';
  INV_NOStdPrescription=              'WAR_请选择标准配方号!';
  INV_NOMachineID=                    'WAR_请选择机台!';
  INV_NOInPutGFKeyValue=              'WAR_请输入品名!';
  INV_NOItemValue=                    'WAR_数据类型必须是:%s,请重新输入:%s!';
  INV_GFIDDifferent=                  'WAR_请选择相同的品名';
  INV_IdenDifferent=                  'WAR_字体颜色为蓝色的卡只能单选,不能和其他的卡组合在一起';
  INV_UnionCard=                      'WAR_%s的品种不能打卡,请确认!';
  INV_CardCarNO=                      'WAR_请输入当前卡号的车牌号!';
  INV_ScrapVolume=                    'WAR_废料体积必须小于化料体积,请确认!';

  InvalidChemical_ID=                 '无效的化工料编号';
  InvalidFACT_Art_ID=                 '无效的实际工艺编号';
  InvalidMachine=                     '机台编号不匹配!';
  InvalidPrescrip_NO=                 '无效的处方单号!';

  // Messages

  MSG_SaveNewRecipeVolSuccess=        'INF_化料单体积修改成功!';
  MSG_SaveDelRecipeSuccess=           'INF_化料单删除成功!';
  MSG_SaveArtControlSuccess=          'INF_工艺控制信息保存成功!';
  MSG_SaveReceiveSendSuccess=         'INF_手织版%s保存成功!';
  MSG_SaveAccidentInfoSuccess=        'INF_处理单保存成功!';
  MSG_SaveStdArtCheckInfoSuccess=     'INF_确认信息保存成功!';
  MSG_SaveCheckPrescriptionSuccess=   'INF_标准处方确认信息已经保存!';
  MSG_SaveStdArtInfoSuccess=          'INF_标准工艺保存成功!';
  MSG_SaveFactArtDtlInfoSuccess=      'INF_实际工艺保存成功!';
  MSG_SaveRepairArtDtlSuccess=        'INF_回修工艺保存成功!';
  MSG_SaveHLArtInfoSuccess=           'INF_手织版工艺保存成功!';
  MSG_SaveChemicalInInfoSuccess=      'INF_化工料入库数据保存成功!';
  MSG_CantChangeChemicalName=         'INF_化工料的名称与当前记录不一致,不能应用修改';
  MSG_ChemicalNameAlreadyIn=          'INF_相同领料单中已包含相同的化工料.不能添加记录!';
  MSG_ChemicalRatioIsLessThanZero=    'INF_该品名的化料比例为小于0的无效值.';
  MSG_ChoiceCard=                     'INF_请先选择卡号!';
  MSG_ChoiceFactPrescrip=             'INF_请先选择并打开一个实际处方单!';
  MSG_WillCreateRecipe=               'INF_要针对当前工序建立化料单吗?';
  MSG_WillCreateStdArt=               'INF_当前品名没有标准工艺,要建立标准工艺吗?';
  MSG_EndRecipe=                      'INF_按OK,%s料缸中的料化料完毕.';
  MSG_BeginRecipe=                    'INF_化料的基本信息已经准备完毕,选YES开始在%s中化%s料.';
  MSG_VatIsEmpty=                     'INF_当前化料缸没有化料.';
  MSG_SaveArtReview=                  'INF_工艺回顾保存成功!';
  MSG_InfoDeficiency=                 'INF_打开工艺的条件不足或错误';
//  MSG_STDPrescriptionDtlSuccess=      'INF_标准处方单保存成功!';
//  MSG_FactPrescriptionDtlSuccess=     'INF_实际处方单保存成功!';
  MSG_SaveRecipeSuccess=              'INF_化料单保存成功!';
  MSG_ClearCurOperate=                'INF_工序已经存在,需要删除现有的所有工序重新添加吗?';
  MSG_EnableQuantity=                 'WAR_库存修改后造成可用量小于0.';
  MSG_IncOutQuantity=                 'WAR_出库数据不能改大只能改小.';
  MSG_StdPrescriptionNotActive=       'WAR_当前标准处方单:%s无效.';
  MSG_ChemicalUnitQTYLassThanZero=    'WAR_化工料%s单位用量小于0,请输入大于0的数据.';
  MSG_SavePrintFNCardInfoSuccess=     'INF_打卡信息保存成功!卡号:%s';
  MSG_TheGFKeyValueNoStdArt=          'INF_当前品名没有标准工艺';

  AskSaveDataStr=                     '修改的数还没有保存,是否要保存数据?';
  SaveDataFail=                       '数据保存失败!';
  SaveDataSuccess=                    '数据保存成功!';
  VatIsEmpty=                         '化料缸为空.';
  VatNotEmpty=                        '化料缸不为空,请重新选择化料缸';

  // Error
  ERR_GetNoFinishPrescriptionNOList=  'ERR_获取未完成的处方单失败,请联系程序员!';
  ERR_FactPrescripNotIncludeCard=     'ERR_非试2y实际处方单不包含卡号,请联系程序员!';
  ERR_GetAccidentCardList=            'ERR_获取处理单号包含的卡号出错:%s请重试!';
  ERR_GetAccidentDisposeInfo=         'ERR_获取处理单处理信息出错:%s请重试!';
  ERR_GetAccidentInfo=                'ERR_获取处理单信息出错:%s请重试!';
  ERR_GetNoCheckRecipe=               'ERR_获取未确认化料单出错:%s请重试!';
  ERR_GetCardByFabricList=            'ERR_获取指定布号的卡号出错:%s请重试!';
  ERR_GetUnFinishJobTraceDtl=         'ERR_获取未加工的进度跟踪明细出错:%s';
  ERR_GetCheckSpecialArt=             'ERR_检测工序是否违反禁忌失败:%s';
  ERR_GetCheckGFIDAndSTDArt=          'ERR_检测品名出错:%s请重试或联系程序员解决!';
  ERR_GetCurCardOperationList=        'ERR_取当前卡号的工序列表出错:%s请联系程序员!';
  ERR_GetFactArtDtl=                  'ERR_获取实际工艺出错:%s请重试或联系程序员解决';
  ERR_GetBatchInfo=                   'ERR_获取缸号信息出错:%s请重试!';
  ERR_GetHLArtArtDtl=                 'ERR_获取手织版工艺出错:%s请重试或联系程序员解决';
  ERR_GetAnalysisData=                'ERR_取待分析数据出错:%s.请重试';
  ERR_GetNoDisposeAccident=           'ERR_获取未处理的待处理单号出错:%s请重试!';
  ERR_GetNoFinishFactPrescrip_NO=     'ERR_获取实际处方单号出错:%s请重试!';
  ERR_GetNoFinishRecipe=              'ERR_获取未完成的化料单号出错:%s请重试!';
  ERR_ExportBatchToCS=                'ERR_导出华料单到自动化料系统出错: %s 请重试!';
  ERR_GetNoFinishBatch=               'ERR_获取未完成的化料缸出错:%s请重试!';
  ERR_GetBatchSteps=                  'ERR_获取获取缸号分步出错:%s请重试!';
  ERR_GetBatchDtlInfo=                'ERR_获取缸号信息出错:%s请重试!';
  ERR_GetNOReceiveHL=                 'ERR_获取未接收的手织版出错:%s请重试!';
  ERR_GetNOArtReceiveHL=              'ERR_获取未接收的手织版出错:%s请重试!';
  ERR_GetHLBasicInfo=                 'ERR_获取手织版工艺信息出错:%s请重试!';
  ERR_GetOperators=                   'ERR_获取当前工序的加工人员出错:%s请重试!';
  ERR_GetOnLineCard=                  'ERR_获取在线卡号出错:%s请重试!';
  ERR_GetNoRecipeSteps=               'ERR_获取无配方工序出错:%s请重试!';
  ERR_GetStdPrescriptionDtl=          'ERR_获取标准配方单明细数据出错:%s请重试';
  ERR_GetRatio=                       'ERR_获取化料比例出错:%s请重试!';
  ERR_GetRecipe=                      'ERR_获取化料单信息出错:%s请重试!';
  ERR_GetFNCardsByRecipeNO=           'ERR_获取化料单使用的卡号失败:%s请重试!';
  ERR_GetRepairFNCard=                'ERR_获取未制订返工工艺的卡号列表出错:%s请重试!';
  ERR_GetSampleInfo=                  'ERR_获取取样信息出错:%s请重试!';
  ERR_GetJobTraceInfo=                'ERR_获取进度跟踪信息出错:%s请重试!';
  ERR_GetSendCardByDate=              'ERR_获取指定日期送布卡号出错:%s请重试!';
  ERR_GetUsedPrescripNOCard=          'ERR_获取处方单包含的卡号出错:%s请重试!';
  ERR_GetVatList=                     'ERR_获取化料缸号列表出错:%s请重试或联系程序员解决!';
  ERR_SaveDelRecipe=                  'ERR_删除化料单失败:%s请重试!';
  ERR_SaveSplitRecipe=                'ERR_保存分缸信息出错:%s请重试!';
  ERR_SaveSaveDelABatch=              'ERR_删除分缸信息出错:%s请重试!';
  ERR_SaveAccidentInfo=               'ERR_保存处理单出错:%s请重试!';
  ERR_SaveAnalysisQualtityData=       'ERR_保存责任分析信息出错:%s请重试!';
  ERR_GetArtReview=                   'ERR_取工艺回顾出错:%s请重试!';
  ERR_SaveNewRecipeVol=               'ERR_化料单体积修改失败:%s请重试!';
  ERR_SaveArtReview=                  'ERR_保存工艺回顾出错:%s请重试!';
  ERR_SaveCheckArtData=               'ERR_保存标准处方单确认信息出错:%s请重试!';
  ERR_SaveChemicalInDtl=              'ERR_保存化工料入库信息出错:%s请重试';
  ERR_SaveChemicalOutDtl=             'ERR_总共有%d条化工料出库数据保存出错!,请重试!';
  ERR_SaveDipInfo=                    'ERR_保存DIP卡号出错:%s请重试!';
  ERR_SaveDisposeAccident=            'ERR_保存处理单处理信息出错:%s请重试!';
  ERR_SaveFactArtData=                'ERR_保存实际工艺数据出错:%s请重试!';
  ERR_SaveFactPrescription=           'ERR_保存实际处方单出错:%s请重试!';
  ERR_SaveReceiveSample=               'ERR_保存取样数据出错:%s请重试!';
  ERR_SaveRecipe=                     'ERR_保存化料单出错:%s请重试!';
  ERR_SaveRecipeTraceInfo=            'ERR_保存化料进度跟踪信息出错:%s请重试!';
  ERR_SaveRepairArtData=              'ERR_保存回修工艺数据出错:%s请重试!';
  ERR_SaveHLArtInfo=                  'ERR_保存手织版工艺数据出错:%s请重试!';
  ERR_SaveStdArtData=                 'ERR_保存标准工艺数据出错:%s请重试!';
  ERR_SaveUserDefindSample=           'ERR_保存取样数据出错:%s请重试!';
  ERR_SystemData=                     'ERR_系统数据出错:%s请重试或联系程序员解决!';
  ERR_SaveHLReceiveInfo=              'ERR_保存手织版接收数据出错:%s请重试!';
  ERR_SaveHLReceiveSendInfo=          'ERR_保存手织版%s数据出错:%s请重试!';
  ERR_GetNOReceiveSendHLList=         'ERR_取手织版待%s数据出错:%s请重试!';
  ERR_GetChemicalInDtl=               'ERR_取化工料入库数据出错:%s';
  ERR_GetChemicalOutDtl=              'ERR_取化工料出库数据出错:%s';
  ERR_SaveAssiPrescription=           'ERR_保存标准处方单数据出错:%s, 请重试!';
  ERR_GETCT_FPY=                      'ERR_取指定时间段的CT&FPY数据出错:%s, 请重试!';
  ERR_GETCT_FPYDTL=                   'ERR_取指定品名排单的数据出错:%s, 请重试!';
  ERR_GetStdArtDtl=                   'ERR_取标准工艺出错:%s请重试!';
  ERR_FillNOCheckArtGFNOList=         'ERR_标准工艺界面,品名列表数据填充出错';
  ERR_GetArtItemInfo=                 'ERR_取后整理标准工艺信息出错:%s,请重试!';
  ERR_AutoCreateStdArtDtl=            'ERR_自动创建:%s 的工艺步骤和参数出错,请重试!';
  ERR_GetNoPrescripCard=              'ERR_获取备选卡号出错:%s,请重试!';
  ERR_SaveChemicalSotckEdit=          'ERR_保存化工料库存信息出错:%s';
  ERR_GetPrintFNCardInfo=             'ERR_获取带打卡数据出错:%s,请重试或联系程序员解决!';
  ERR_SaveSavePrintFNCardInfo=        'ERR_保存打卡数据出错:%s,请重试!';
  ERR_GetOnLineOperationList=         'ERR_获取品名:%s正在加工的工序出错:%s,请重试!';
  ERR_SaveStdPrescription=            'ERR_保存标准处方出错:%s,请重试!';
  ERR_GetOnlineStdPrescripNO=         'ERR_获取在线化工料代号出错:%s,请重试!';
  ERR_GetQyDictionary=                'ERR_获取字典表:%s出错:%s';
  ERR_GetQyMaster=                    'ERR_获取主表数据:%s出错:%s';
  ERR_GetDetailQuery=                 'ERR_获取子查询出错:%s';
  ERR_GetQyText=                      'ERR_获取查询语句出错:%s';
  ERR_PropertyIndex=                  'ERR_属性标号错误';
  ERR_LocateDataSet=                  'ERR_无法在数据集中定位数据';

  ERR_GetMONMachinePar=                  'ERR_取机器参数出错:%s';
  ERR_GetMONMachineParLog=                  'ERR_取机器参数日志出错:%s';

  SaveDataError=                      '数据保存出错!请重试!';
  ArtReviewDataError=                 '回顾数据出错';
  DataError=                          '数据出错,请联系程序员.';
  GetArtDescriptionListError=         '后整理工艺代号字典获取失败!';
  GetArtReviewListError=              '回顾数据字典获取失败!';
  GetAssiPrescriptionError=           '获取标准处方单信息出错:%s请重试!';
  GetCADInfoError=                    '获取CAD信息出错:%s请重试!';
  GetColorListError=                  '工序参数字典获取失败!';
  GetDepartmentListError=             '后整理分厂字典获取失败!';
  GetDictionaryListError=             '获取字典表数据失败: %s';
  GetDipCardError=                    '获取工艺控制在线卡号失败,请重试!';
  GetGFKeyValueWIPError=              '获取选定品名的在线WIP出错,请重试';
  GetOnLineGFNOError=                 '获取再在线品名出错,请重试!';
  GetOperationListError=              '工序参数字典获取失败!';
  GetOperationWIPDtlError=            '获取工序WIP的明细数据出错,请重试!';
  GetOperationWIPError=               '获取工序WIP数据出错,请重试!';
  GetStdPrescriptionListError=        '后整理标准配方字典获取失败!';
  GetWebInfoError=                    '获取品名图形出错:%s请重试!';
  NoOpenRecipe=                       '请先打开一个化料单或料缸';
  NoSelectVat=                        '请先选择一个料缸';
  RecipeFinished=                     '当前化料单已经化完料了';
  SaveCheckArtDataError=              '工艺数据确认失败:%s请重新确认,或保存到本地文件中';

  //TextCaption
//  Caption_ChemicalInDtl=              '%s所有入库明细:';

  //Status Message
  STA_GetMessage=                     '正在获取:%s,请稍后...';
  STA_GetDictionaryMessage=           '正在获取字典表:%s请稍后...';
  STA_SaveMessage=                    '正在保存:%s,请稍后...';
  STA_Ready=                          '就绪';

  STA_WebInfo=                        '品名的图像信息';
  STA_CADInfo=                        '品名的CAD信息';

  STA_GetCTFPY=                       '正在获取CT&FPY,请稍后...';
  STA_GetCTFPYDtl=                    '正在获取CT&FPY的明细,请稍后...';
  STA_GetGFKeyValueWIP=               '正在获取选定品名的在线WIP,请稍后...';
  STA_GetOnLineGFNO=                  '正在获取所有在线品名,请稍后...';
  STA_GetOperationWIP=                '正在获取工序WIP的数据,请稍后...';
  STA_GetOperationWIPDtlWIP=          '正在获取工序WIP的明细数据,请稍后...';
  STA_LoginTime=                      '【登录时间】';


type
  ExceptionEx = class(Exception)
  public
    constructor CreateResFmt(ResStringRec: PResStringRec; const Args: array of const); overload;
  end;

function GetResourceString(const ResString: Pointer): string;
{*|<PRE>------------------------------------------------------------------------------
   创建人员: lvzd
   创建日期: 2004-8-30 下午 07:11:58
   参数列表: const ResString: Pointer
   返回值  : string
   功能描述: 返回字符串资源
   附加说明:
调用方法:
TMsgDialog.ShowMsgDialog(GetResourceString(@SaveArtHdrDataError),2500);
-------------------------------------------------------------------------------}
procedure ShowStatusMessage(const ResString: Pointer; FieldStrings: array of const);
{*|<PRE> -----------------------------------------------------------------------------
   创建人员: lvzd
   创建日期: 2005-2-17 10:56:20
   参数列表: const ResString, FieldStrings: array of const
   返回值  : None
   功能描述: 在状态栏中显示信息
-------------------------------------------------------------------------------}
function ShowMsgDialog(const ResString: Pointer; msgType: TMsgDlgType): Integer;
{*|<PRE>------------------------------------------------------------------------------
   创建人员: lvzd
   创建日期: 2004-9-24 9:46:46
   参数列表: const ResString: Pointer; msgType: TMsgDlgType
   返回值  : Integer
   功能描述: 同下,利用resourcestring显示MessageDlg
-------------------------------------------------------------------------------}
function ShowCustomMsgDialog(const ResString: Pointer; FieldStrings: array of const; msgType: TMsgDlgType): Integer;
{*|<PRE>------------------------------------------------------------------------------
   创建人员: lvzd
   创建日期: 2004-9-22 16:06:12
   参数列表: const ResString: Pointer; FieldStrings: array of String; msgType: TMsgDlgType
   返回值  : Integer
   功能描述: 利用resourcestring显示MessageDlg
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


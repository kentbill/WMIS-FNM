unit FNMFacade_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : $Revision:   1.130.1.0.1.0.1.6  $
// File generated on 2010-9-23 15:30:03 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\wMIS\Code\FNM\Server\FNMFacade.tlb (1)
// LIBID: {7AD9BB85-0435-43C0-999C-646BF46427D6}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINDOWS\system32\stdvcl40.dll)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  FNMFacadeMajorVersion = 1;
  FNMFacadeMinorVersion = 0;

  LIBID_FNMFacade: TGUID = '{7AD9BB85-0435-43C0-999C-646BF46427D6}';

  IID_IFNMFacadeLib: TGUID = '{C07AB601-C57E-4111-A4CE-9C48218F3EDC}';
  CLASS_FNMFacadeLib: TGUID = '{1DCB5204-2D64-4461-BFDC-9B48B9CC61C9}';
  IID_IFNMArtFacadeLib: TGUID = '{FF8C452C-7228-4D1F-9A62-64F0C8E1D5A2}';
  CLASS_FNMArtFacadeLib: TGUID = '{BD136E68-6167-485D-B971-908D497C87F1}';
  IID_IThirdFacade: TGUID = '{D70D8CB4-4753-401D-9837-26C863185635}';
  CLASS_ThirdFacade: TGUID = '{921A1918-AECD-443E-89EB-0DB9F6EE4676}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IFNMFacadeLib = interface;
  IFNMFacadeLibDisp = dispinterface;
  IFNMArtFacadeLib = interface;
  IFNMArtFacadeLibDisp = dispinterface;
  IThirdFacade = interface;
  IThirdFacadeDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  FNMFacadeLib = IFNMFacadeLib;
  FNMArtFacadeLib = IFNMArtFacadeLib;
  ThirdFacade = IThirdFacade;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PWideString1 = ^WideString; {*}
  POleVariant1 = ^OleVariant; {*}


// *********************************************************************//
// Interface: IFNMFacadeLib
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C07AB601-C57E-4111-A4CE-9C48218F3EDC}
// *********************************************************************//
  IFNMFacadeLib = interface(IDispatch)
    ['{C07AB601-C57E-4111-A4CE-9C48218F3EDC}']
    procedure ServerTime(var currTime: OleVariant); safecall;
    procedure SaveReceiveInfo(const sNote_NO: WideString; const sCurrent_Department: WideString; 
                              const sOperator: WideString; const sType: WideString; 
                              var sErrorMsg: WideString); safecall;
    procedure GetReceiveInfo(var vData: OleVariant; const sNote_NO: WideString; 
                             const sCurrent_Department: WideString; const sType: WideString; 
                             var sErrorMsg: WideString); safecall;
    procedure GetStockInfo(var vData: OleVariant; const sCondition: WideString; 
                           var sErrorMsg: WideString); safecall;
    procedure CancelFabricInfo(const sNote_NO: WideString; const sOperator: WideString; 
                               const sType: WideString; var sErrorMsg: WideString); safecall;
    procedure GetSendInfo(var vData0: OleVariant; var vData1: OleVariant; var vData2: OleVariant; 
                          const sNote_NO: WideString; const sCurrent_Department: WideString; 
                          iType: Integer; var sErrorMsg: WideString); safecall;
    procedure SaveSendInfo(const sFNCardList: WideString; const sDestination: WideString; 
                           const sCurrent_Department: WideString; const sOperator: WideString; 
                           iType: Integer; var sNote_NO: WideString; var sErrorMsg: WideString); safecall;
    procedure GetPrintFNCardInfo(const sCurrent_Department: WideString; 
                                 const sCondition: WideString; iType: Integer; 
                                 var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure SavePrintFNCardInfo(const sFabric_NO_List: WideString; const sCar_NO: WideString; 
                                  bIs_CutCloth: Integer; bIs_RepairCard: Integer; 
                                  const sOperator: WideString; var sFN_Card: WideString; 
                                  var sErrorMsg: WideString); safecall;
    procedure SaveSplitFabricInfo(const sFabric_NO: WideString; dSplit_Quantity: Double; 
                                  const sCurrent_Department: WideString; 
                                  const sOperator: WideString; var sNew_Fabric_NO: WideString; 
                                  var sErrorMsg: WideString); safecall;
    procedure GetSplitFabricInfo(var vData: OleVariant; const sFabric_NO: WideString; 
                                 const sCurrent_Department: WideString; var sErrorMsg: WideString); safecall;
    procedure GetReportInfo(const sNote_NO: WideString; iType: Integer; 
                            const sCurrent_Department: WideString; const sPrinter: WideString; 
                            var vData0: OleVariant; var vData1: OleVariant; var vData2: OleVariant; 
                            var sErrorMsg: WideString); safecall;
    procedure SaveUnionFNCardInfo(const sFabric_NO_List: WideString; const sFN_Card: WideString; 
                                  const sCar_NO: WideString; iType: Integer; 
                                  const sReason: WideString; const sCurrent_Department: WideString; 
                                  const sOperator: WideString; var sNew_FN_Card: WideString; 
                                  var sErrorMsg: WideString); safecall;
    procedure GetUnionFNCardInfo(var vData: OleVariant; const sFN_Card: WideString; 
                                 const sCurrent_Department: WideString; iType: Integer; 
                                 var sErrorMsg: WideString); safecall;
    procedure GetBaseTableInfo(var vData: OleVariant; const sTableName: WideString; 
                               var sErrorMsg: WideString); safecall;
    procedure SaveBaseTableInfo(var vData: OleVariant; const sTableName: WideString; 
                                const sKeyField: WideString; var sErrorMsg: WideString); safecall;
    procedure SaveWorkerStationInfo(const sWorkerList: WideString; const sMachine_ID: WideString; 
                                    const sCurrent_Department: WideString; 
                                    const sOperator: WideString; var sErrorMsg: WideString); safecall;
    procedure SaveHoldInfo(bIs_Hold: Integer; iUnHoldiden: Integer; const iGFKeyValue: WideString; 
                           const sOperationCode: WideString; const sFnCard: WideString; 
                           bIseffectReair: Integer; const sReason: WideString; 
                           const sOperator: WideString; var sErrorMsg: WideString); safecall;
    procedure SaveGIRepairInfo(const sFabric_NO_List: WideString; 
                               const sCurrent_Department: WideString; var sErrorMsg: WideString); safecall;
    procedure GetGIRepairInfo(var vData: OleVariant; const sCurrent_Department: WideString; 
                              var sErrorMsg: WideString); safecall;
    procedure GetMachineTaskInfo(var vData: OleVariant; const sMachine_ID: WideString; 
                                 const sCurrent_Department: WideString; var sErrorMsg: WideString); safecall;
    procedure SetMachineOperation(const sFN_Card: WideString; iStep_NO: Integer; 
                                  const sMachine_ID: WideString; const sCar_NO: WideString; 
                                  dSpeed: Double; dWidth: Double; const sOperate_Time: WideString; 
                                  const sWorkerList: WideString; 
                                  const sCurrent_Department: WideString; iType: Integer; 
                                  var sErrorMsg: WideString); safecall;
    procedure GetJobTraceInfo(var vData: OleVariant; const sFN_Card: WideString; 
                              const sCurrent_Department: WideString; iType: Integer; 
                              var sErrorMsg: WideString); safecall;
    procedure GetWIPInfo(var vData0: OleVariant; var vData1: OleVariant; var vData2: OleVariant; 
                         const sCurrent_Department: WideString; var sErrorMsg: WideString); safecall;
    procedure GetPlanInfo(var vData0: OleVariant; var vData1: OleVariant; var vData2: OleVariant; 
                          const sOperation_Code: WideString; const sCurrent_Department: WideString; 
                          iType: Integer; var sErrorMsg: WideString); safecall;
    procedure GetChemicalIn_OutDtl(const sDataClass: WideString; dDate: TDateTime; 
                                   const sCurrent_Department: WideString; var vData: OleVariant; 
                                   var sErrorMsg: WideString); safecall;
    procedure GetTheMatterFabric(const sCurrent_Department: WideString; dDate: TDateTime; 
                                 out vData0: OleVariant; out vData1: OleVariant; 
                                 out sErrorMsg: WideString); safecall;
    procedure GetSampleList(const sFN_Card: WideString; const sSample_Code: WideString; 
                            out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure SaveChemicalInDtl(vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure SaveChemicalOutDtl(vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure GetOTDInfo(var vData: OleVariant; const sBegin_Time: WideString; 
                         const sEnd_Time: WideString; const sQuery_Type: WideString; 
                         const sCurrent_Department: WideString; iType: Integer; 
                         var sErrorMsg: WideString); safecall;
    procedure GetWorkerPrizeOrErrorInfo(var vData: OleVariant; const sQuery_Date: WideString; 
                                        const sCurrent_Department: WideString; iType: Integer; 
                                        var sErrorMsg: WideString); safecall;
    procedure GetSCInfo(var vData0: OleVariant; var vData1: OleVariant; var vData2: OleVariant; 
                        const sContract_NO: WideString; const sCurrent_Department: WideString; 
                        var sErrorMsg: WideString); safecall;
    procedure SaveSCInfo(const sContract_NO: WideString; const sFNCardList: WideString; 
                         const sCurrent_Department: WideString; const sOperator: WideString; 
                         var sErrorMsg: WideString); safecall;
    procedure GetFabricReportInfo(var vData: OleVariant; const sBegin_Time: WideString; 
                                  const sEnd_Time: WideString; 
                                  const sCurrent_Department: WideString; iType: Integer; 
                                  var sErrorMsg: WideString); safecall;
    procedure AutoArrangePlan(const sOperation_Code: WideString; 
                              const sCurrent_Department: WideString; var sErrorMsg: WideString); safecall;
    procedure SaveChemicalStockEdit(const sDataType: WideString; vData: OleVariant; 
                                    const sOperator: WideString; out sErrorMsg: WideString); safecall;
    procedure CancelPrintFNCardInfo(const sFN_Card: WideString; 
                                    const sCurrent_Department: WideString; 
                                    const sOperator: WideString; var sErrorMsg: WideString); safecall;
    procedure GetGIInfo(const sSource: WideString; const sCurrent_Department: WideString; 
                        iType: Integer; var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure SaveGIInfo(const sFabricNOList: WideString; const sSource: WideString; 
                         const sCurrent_Department: WideString; const sOperator: WideString; 
                         var sErrorMsg: WideString); safecall;
    procedure GetItemList(var sNoteNOList: OleVariant; const sCode: WideString; 
                          const sCurrent_Department: WideString; const sType: WideString; 
                          var sErrorMsg: WideString); safecall;
    procedure ChangeGFNO(const sCode: WideString; const sGFKey: WideString; 
                         const sJob_NO: WideString; const sReason: WideString; 
                         const sChanger: WideString; const sCurrent_Department: WideString; 
                         iType: Integer; var sErrorMsg: WideString); safecall;
    procedure SaveDistributeInfo(vData: OleVariant; const sFabricNOStr: WideString; 
                                 const sMachine_ID: WideString; 
                                 const sCurrent_Department: WideString; var sErrorMsg: WideString); safecall;
    procedure SaveSuspendInfo(const sMachine_ID: WideString; const sSuspend_Code: WideString; 
                              const sBegin_Time: WideString; const sEnd_Time: WideString; 
                              const sCurrent_Department: WideString; const sRemark: WideString; 
                              var sErrorMsg: WideString); safecall;
    procedure GetQyDictionary(const sQyDicName: WideString; out vData: OleVariant; 
                              out sErrorMsg: WideString); safecall;
    procedure GetQyMaster(iQueryIden: Integer; const sPreDeclareVars: WideString; 
                          const sCondition: WideString; out vData: OleVariant; 
                          out sErrorMsg: WideString); safecall;
    procedure GetQyDetail(iQueryIden: Integer; vCondition: OleVariant; out vData: OleVariant; 
                          out sErrorMsg: WideString); safecall;
    procedure AdjustJobTraceDtlInfo(vData: OleVariant; const sIdenList: WideString; 
                                    const sOperator: WideString; 
                                    const sCurrent_Department: WideString; var sErrorMsg: WideString); safecall;
    procedure GetJobTraceDtlInfo(var vData: OleVariant; const sParam: WideString; 
                                 const sBegin_Time: WideString; const sEnd_Time: WideString; 
                                 const sCurrent_Department: WideString; iType: Integer; 
                                 var sErrorMsg: WideString); safecall;
    procedure TerminalQuery(var vData: OleVariant; const sParam: WideString; 
                            const sBegin_Time: WideString; const sEnd_Time: WideString; 
                            const sCurrent_Department: WideString; iType: Integer; 
                            var sErrorMsg: WideString); safecall;
    procedure SaveOTDInfo(var vData: OleVariant; iType: Integer; var sErrorMsg: WideString); safecall;
    procedure SaveCarInfo(const sFnCard: WideString; const sNewCarNO: WideString; 
                          const sOperator: WideString; const sAppName: WideString; 
                          const sComputerName: WideString; out sErrorMsg: WideString); safecall;
    procedure GetShrinkageAnalysisInfo(var vData: OleVariant; const sBegin_Date: WideString; 
                                       const sEnd_Date: WideString; 
                                       const sCurrent_Department: WideString; 
                                       var sErrorMsg: WideString); safecall;
    procedure SaveShrinkageAnalysisInfo(var vData: OleVariant; const sOperator: WideString; 
                                        var sErrorMsg: WideString); safecall;
    procedure ChangeMaterialType(const sCode: WideString; const sMaterial_Type: WideString; 
                                 const sDuty_Department: WideString; const sReason: WideString; 
                                 const sChanger: WideString; const sCurrent_Department: WideString; 
                                 iType: Integer; var sErrorMsg: WideString); safecall;
    procedure CreateOTDInfo(iType: Integer; var sErrorMsg: WideString); safecall;
    procedure CancelFIInfo(const sNote_NO: WideString; const sFabric_NO_List: WideString; 
                           const sOperator: WideString; var sErrorMsg: WideString); safecall;
    procedure GetChemicalData(iType: Integer; const sCurrent_Department: WideString; 
                              dQueryDarte: TDateTime; var vData: OleVariant; 
                              var sErrorMsg: WideString); safecall;
    procedure SaveChemicalData(iType: Integer; var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure GetArtAnalysisData(var vData: OleVariant; dQueryDate: TDateTime; 
                                 const sCurrent_Department: WideString; iType: Integer; 
                                 var sErrorMsg: WideString); safecall;
    procedure SaveArtAnalysisData(var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure GetUrgentPpoInfo(var vData: OleVariant; const sGF_NO: WideString; 
                               var sErrorMsg: WideString); safecall;
    procedure SaveUrgentPpoInfo(var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure SaveRepairReason(var vData: OleVariant; iType: Integer; var sErrorMsg: WideString); safecall;
    procedure DeleteRepairReason(const sReason_Code: WideString; const sItem_Name: WideString; 
                                 iType: Integer; var sErrorMsg: WideString); safecall;
    procedure SaveOTDReason(var vData: OleVariant; iType: Integer; var sErrorMsg: WideString); safecall;
    procedure SaveReceiveBenchMark(var vData: OleVariant; iCount: Integer; var sErrorMsg: WideString); safecall;
    procedure SaveMutexChemical(var vData: OleVariant; iCount: Integer; var sErrorMsg: WideString); safecall;
    procedure GetInnerRepairInfo(const sCurrent_Department: WideString; 
                                 const sDatetime: WideString; var vData: OleVariant; 
                                 var sErrorMsg: WideString); safecall;
    procedure SaveIgnoredInnerRepairInfo(vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure GetRecipeChemical(const sBatchNO: WideString; var vData: OleVariant; 
                                var sErrorMsg: WideString); safecall;
    procedure SaveData(const sType: WideString; vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure GetQueryData(var vData: OleVariant; const sType: WideString; 
                           const sCondition: WideString; var sErrorMsg: WideString); safecall;
    procedure GetMultiData(var vData0: OleVariant; var vData1: OleVariant; var vData2: OleVariant; 
                           const sType: WideString; const sSQLText: WideString; 
                           var sErrorMsg: WideString); safecall;
    procedure SaveDataBySQL(const sType: WideString; const sCondition: WideString; 
                            var sErrorMsg: WideString); safecall;
    procedure SaveSDTraceInfo(var vData: OleVariant; iType: Integer; var sErrorMsg: WideString); safecall;
    procedure SaveRSTraceInfo(var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure SaveDataBySQLEx(const sType: WideString; const sCondition: WideString; 
                              var Result: WideString; var sErrorMsg: WideString); safecall;
    procedure SaveSampleInfo(var vParam: OleVariant; var sErrorMsg: WideString); safecall;
    procedure SaveMultiData(const sTable1: WideString; const sTable2: WideString; 
                            var vData1: OleVariant; var vData2: OleVariant; 
                            const sSQLText_Before: WideString; const sSQLText_After: WideString; 
                            const sKey1: WideString; const sKey2: WideString; 
                            var sErrorMsg: WideString); safecall;
    procedure SaveSQLData(const sSQL: WideString; var sErrMsg: WideString); safecall;
    procedure GetQueryBySQL(var vData: OleVariant; const sSQL: WideString; var sErrMsg: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IFNMFacadeLibDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C07AB601-C57E-4111-A4CE-9C48218F3EDC}
// *********************************************************************//
  IFNMFacadeLibDisp = dispinterface
    ['{C07AB601-C57E-4111-A4CE-9C48218F3EDC}']
    procedure ServerTime(var currTime: OleVariant); dispid 1;
    procedure SaveReceiveInfo(const sNote_NO: WideString; const sCurrent_Department: WideString; 
                              const sOperator: WideString; const sType: WideString; 
                              var sErrorMsg: WideString); dispid 2;
    procedure GetReceiveInfo(var vData: OleVariant; const sNote_NO: WideString; 
                             const sCurrent_Department: WideString; const sType: WideString; 
                             var sErrorMsg: WideString); dispid 3;
    procedure GetStockInfo(var vData: OleVariant; const sCondition: WideString; 
                           var sErrorMsg: WideString); dispid 4;
    procedure CancelFabricInfo(const sNote_NO: WideString; const sOperator: WideString; 
                               const sType: WideString; var sErrorMsg: WideString); dispid 7;
    procedure GetSendInfo(var vData0: OleVariant; var vData1: OleVariant; var vData2: OleVariant; 
                          const sNote_NO: WideString; const sCurrent_Department: WideString; 
                          iType: Integer; var sErrorMsg: WideString); dispid 5;
    procedure SaveSendInfo(const sFNCardList: WideString; const sDestination: WideString; 
                           const sCurrent_Department: WideString; const sOperator: WideString; 
                           iType: Integer; var sNote_NO: WideString; var sErrorMsg: WideString); dispid 9;
    procedure GetPrintFNCardInfo(const sCurrent_Department: WideString; 
                                 const sCondition: WideString; iType: Integer; 
                                 var vData: OleVariant; var sErrorMsg: WideString); dispid 11;
    procedure SavePrintFNCardInfo(const sFabric_NO_List: WideString; const sCar_NO: WideString; 
                                  bIs_CutCloth: Integer; bIs_RepairCard: Integer; 
                                  const sOperator: WideString; var sFN_Card: WideString; 
                                  var sErrorMsg: WideString); dispid 12;
    procedure SaveSplitFabricInfo(const sFabric_NO: WideString; dSplit_Quantity: Double; 
                                  const sCurrent_Department: WideString; 
                                  const sOperator: WideString; var sNew_Fabric_NO: WideString; 
                                  var sErrorMsg: WideString); dispid 13;
    procedure GetSplitFabricInfo(var vData: OleVariant; const sFabric_NO: WideString; 
                                 const sCurrent_Department: WideString; var sErrorMsg: WideString); dispid 14;
    procedure GetReportInfo(const sNote_NO: WideString; iType: Integer; 
                            const sCurrent_Department: WideString; const sPrinter: WideString; 
                            var vData0: OleVariant; var vData1: OleVariant; var vData2: OleVariant; 
                            var sErrorMsg: WideString); dispid 15;
    procedure SaveUnionFNCardInfo(const sFabric_NO_List: WideString; const sFN_Card: WideString; 
                                  const sCar_NO: WideString; iType: Integer; 
                                  const sReason: WideString; const sCurrent_Department: WideString; 
                                  const sOperator: WideString; var sNew_FN_Card: WideString; 
                                  var sErrorMsg: WideString); dispid 16;
    procedure GetUnionFNCardInfo(var vData: OleVariant; const sFN_Card: WideString; 
                                 const sCurrent_Department: WideString; iType: Integer; 
                                 var sErrorMsg: WideString); dispid 19;
    procedure GetBaseTableInfo(var vData: OleVariant; const sTableName: WideString; 
                               var sErrorMsg: WideString); dispid 20;
    procedure SaveBaseTableInfo(var vData: OleVariant; const sTableName: WideString; 
                                const sKeyField: WideString; var sErrorMsg: WideString); dispid 17;
    procedure SaveWorkerStationInfo(const sWorkerList: WideString; const sMachine_ID: WideString; 
                                    const sCurrent_Department: WideString; 
                                    const sOperator: WideString; var sErrorMsg: WideString); dispid 22;
    procedure SaveHoldInfo(bIs_Hold: Integer; iUnHoldiden: Integer; const iGFKeyValue: WideString; 
                           const sOperationCode: WideString; const sFnCard: WideString; 
                           bIseffectReair: Integer; const sReason: WideString; 
                           const sOperator: WideString; var sErrorMsg: WideString); dispid 24;
    procedure SaveGIRepairInfo(const sFabric_NO_List: WideString; 
                               const sCurrent_Department: WideString; var sErrorMsg: WideString); dispid 26;
    procedure GetGIRepairInfo(var vData: OleVariant; const sCurrent_Department: WideString; 
                              var sErrorMsg: WideString); dispid 27;
    procedure GetMachineTaskInfo(var vData: OleVariant; const sMachine_ID: WideString; 
                                 const sCurrent_Department: WideString; var sErrorMsg: WideString); dispid 28;
    procedure SetMachineOperation(const sFN_Card: WideString; iStep_NO: Integer; 
                                  const sMachine_ID: WideString; const sCar_NO: WideString; 
                                  dSpeed: Double; dWidth: Double; const sOperate_Time: WideString; 
                                  const sWorkerList: WideString; 
                                  const sCurrent_Department: WideString; iType: Integer; 
                                  var sErrorMsg: WideString); dispid 29;
    procedure GetJobTraceInfo(var vData: OleVariant; const sFN_Card: WideString; 
                              const sCurrent_Department: WideString; iType: Integer; 
                              var sErrorMsg: WideString); dispid 30;
    procedure GetWIPInfo(var vData0: OleVariant; var vData1: OleVariant; var vData2: OleVariant; 
                         const sCurrent_Department: WideString; var sErrorMsg: WideString); dispid 33;
    procedure GetPlanInfo(var vData0: OleVariant; var vData1: OleVariant; var vData2: OleVariant; 
                          const sOperation_Code: WideString; const sCurrent_Department: WideString; 
                          iType: Integer; var sErrorMsg: WideString); dispid 35;
    procedure GetChemicalIn_OutDtl(const sDataClass: WideString; dDate: TDateTime; 
                                   const sCurrent_Department: WideString; var vData: OleVariant; 
                                   var sErrorMsg: WideString); dispid 36;
    procedure GetTheMatterFabric(const sCurrent_Department: WideString; dDate: TDateTime; 
                                 out vData0: OleVariant; out vData1: OleVariant; 
                                 out sErrorMsg: WideString); dispid 18;
    procedure GetSampleList(const sFN_Card: WideString; const sSample_Code: WideString; 
                            out vData: OleVariant; out sErrorMsg: WideString); dispid 31;
    procedure SaveChemicalInDtl(vData: OleVariant; out sErrorMsg: WideString); dispid 34;
    procedure SaveChemicalOutDtl(vData: OleVariant; out sErrorMsg: WideString); dispid 32;
    procedure GetOTDInfo(var vData: OleVariant; const sBegin_Time: WideString; 
                         const sEnd_Time: WideString; const sQuery_Type: WideString; 
                         const sCurrent_Department: WideString; iType: Integer; 
                         var sErrorMsg: WideString); dispid 6;
    procedure GetWorkerPrizeOrErrorInfo(var vData: OleVariant; const sQuery_Date: WideString; 
                                        const sCurrent_Department: WideString; iType: Integer; 
                                        var sErrorMsg: WideString); dispid 8;
    procedure GetSCInfo(var vData0: OleVariant; var vData1: OleVariant; var vData2: OleVariant; 
                        const sContract_NO: WideString; const sCurrent_Department: WideString; 
                        var sErrorMsg: WideString); dispid 21;
    procedure SaveSCInfo(const sContract_NO: WideString; const sFNCardList: WideString; 
                         const sCurrent_Department: WideString; const sOperator: WideString; 
                         var sErrorMsg: WideString); dispid 23;
    procedure GetFabricReportInfo(var vData: OleVariant; const sBegin_Time: WideString; 
                                  const sEnd_Time: WideString; 
                                  const sCurrent_Department: WideString; iType: Integer; 
                                  var sErrorMsg: WideString); dispid 40;
    procedure AutoArrangePlan(const sOperation_Code: WideString; 
                              const sCurrent_Department: WideString; var sErrorMsg: WideString); dispid 41;
    procedure SaveChemicalStockEdit(const sDataType: WideString; vData: OleVariant; 
                                    const sOperator: WideString; out sErrorMsg: WideString); dispid 42;
    procedure CancelPrintFNCardInfo(const sFN_Card: WideString; 
                                    const sCurrent_Department: WideString; 
                                    const sOperator: WideString; var sErrorMsg: WideString); dispid 43;
    procedure GetGIInfo(const sSource: WideString; const sCurrent_Department: WideString; 
                        iType: Integer; var vData: OleVariant; var sErrorMsg: WideString); dispid 10;
    procedure SaveGIInfo(const sFabricNOList: WideString; const sSource: WideString; 
                         const sCurrent_Department: WideString; const sOperator: WideString; 
                         var sErrorMsg: WideString); dispid 44;
    procedure GetItemList(var sNoteNOList: OleVariant; const sCode: WideString; 
                          const sCurrent_Department: WideString; const sType: WideString; 
                          var sErrorMsg: WideString); dispid 25;
    procedure ChangeGFNO(const sCode: WideString; const sGFKey: WideString; 
                         const sJob_NO: WideString; const sReason: WideString; 
                         const sChanger: WideString; const sCurrent_Department: WideString; 
                         iType: Integer; var sErrorMsg: WideString); dispid 45;
    procedure SaveDistributeInfo(vData: OleVariant; const sFabricNOStr: WideString; 
                                 const sMachine_ID: WideString; 
                                 const sCurrent_Department: WideString; var sErrorMsg: WideString); dispid 46;
    procedure SaveSuspendInfo(const sMachine_ID: WideString; const sSuspend_Code: WideString; 
                              const sBegin_Time: WideString; const sEnd_Time: WideString; 
                              const sCurrent_Department: WideString; const sRemark: WideString; 
                              var sErrorMsg: WideString); dispid 47;
    procedure GetQyDictionary(const sQyDicName: WideString; out vData: OleVariant; 
                              out sErrorMsg: WideString); dispid 48;
    procedure GetQyMaster(iQueryIden: Integer; const sPreDeclareVars: WideString; 
                          const sCondition: WideString; out vData: OleVariant; 
                          out sErrorMsg: WideString); dispid 49;
    procedure GetQyDetail(iQueryIden: Integer; vCondition: OleVariant; out vData: OleVariant; 
                          out sErrorMsg: WideString); dispid 50;
    procedure AdjustJobTraceDtlInfo(vData: OleVariant; const sIdenList: WideString; 
                                    const sOperator: WideString; 
                                    const sCurrent_Department: WideString; var sErrorMsg: WideString); dispid 51;
    procedure GetJobTraceDtlInfo(var vData: OleVariant; const sParam: WideString; 
                                 const sBegin_Time: WideString; const sEnd_Time: WideString; 
                                 const sCurrent_Department: WideString; iType: Integer; 
                                 var sErrorMsg: WideString); dispid 37;
    procedure TerminalQuery(var vData: OleVariant; const sParam: WideString; 
                            const sBegin_Time: WideString; const sEnd_Time: WideString; 
                            const sCurrent_Department: WideString; iType: Integer; 
                            var sErrorMsg: WideString); dispid 38;
    procedure SaveOTDInfo(var vData: OleVariant; iType: Integer; var sErrorMsg: WideString); dispid 39;
    procedure SaveCarInfo(const sFnCard: WideString; const sNewCarNO: WideString; 
                          const sOperator: WideString; const sAppName: WideString; 
                          const sComputerName: WideString; out sErrorMsg: WideString); dispid 52;
    procedure GetShrinkageAnalysisInfo(var vData: OleVariant; const sBegin_Date: WideString; 
                                       const sEnd_Date: WideString; 
                                       const sCurrent_Department: WideString; 
                                       var sErrorMsg: WideString); dispid 53;
    procedure SaveShrinkageAnalysisInfo(var vData: OleVariant; const sOperator: WideString; 
                                        var sErrorMsg: WideString); dispid 54;
    procedure ChangeMaterialType(const sCode: WideString; const sMaterial_Type: WideString; 
                                 const sDuty_Department: WideString; const sReason: WideString; 
                                 const sChanger: WideString; const sCurrent_Department: WideString; 
                                 iType: Integer; var sErrorMsg: WideString); dispid 55;
    procedure CreateOTDInfo(iType: Integer; var sErrorMsg: WideString); dispid 56;
    procedure CancelFIInfo(const sNote_NO: WideString; const sFabric_NO_List: WideString; 
                           const sOperator: WideString; var sErrorMsg: WideString); dispid 57;
    procedure GetChemicalData(iType: Integer; const sCurrent_Department: WideString; 
                              dQueryDarte: TDateTime; var vData: OleVariant; 
                              var sErrorMsg: WideString); dispid 58;
    procedure SaveChemicalData(iType: Integer; var vData: OleVariant; var sErrorMsg: WideString); dispid 59;
    procedure GetArtAnalysisData(var vData: OleVariant; dQueryDate: TDateTime; 
                                 const sCurrent_Department: WideString; iType: Integer; 
                                 var sErrorMsg: WideString); dispid 60;
    procedure SaveArtAnalysisData(var vData: OleVariant; var sErrorMsg: WideString); dispid 61;
    procedure GetUrgentPpoInfo(var vData: OleVariant; const sGF_NO: WideString; 
                               var sErrorMsg: WideString); dispid 62;
    procedure SaveUrgentPpoInfo(var vData: OleVariant; var sErrorMsg: WideString); dispid 63;
    procedure SaveRepairReason(var vData: OleVariant; iType: Integer; var sErrorMsg: WideString); dispid 64;
    procedure DeleteRepairReason(const sReason_Code: WideString; const sItem_Name: WideString; 
                                 iType: Integer; var sErrorMsg: WideString); dispid 65;
    procedure SaveOTDReason(var vData: OleVariant; iType: Integer; var sErrorMsg: WideString); dispid 66;
    procedure SaveReceiveBenchMark(var vData: OleVariant; iCount: Integer; var sErrorMsg: WideString); dispid 67;
    procedure SaveMutexChemical(var vData: OleVariant; iCount: Integer; var sErrorMsg: WideString); dispid 68;
    procedure GetInnerRepairInfo(const sCurrent_Department: WideString; 
                                 const sDatetime: WideString; var vData: OleVariant; 
                                 var sErrorMsg: WideString); dispid 69;
    procedure SaveIgnoredInnerRepairInfo(vData: OleVariant; var sErrorMsg: WideString); dispid 70;
    procedure GetRecipeChemical(const sBatchNO: WideString; var vData: OleVariant; 
                                var sErrorMsg: WideString); dispid 71;
    procedure SaveData(const sType: WideString; vData: OleVariant; var sErrorMsg: WideString); dispid 72;
    procedure GetQueryData(var vData: OleVariant; const sType: WideString; 
                           const sCondition: WideString; var sErrorMsg: WideString); dispid 73;
    procedure GetMultiData(var vData0: OleVariant; var vData1: OleVariant; var vData2: OleVariant; 
                           const sType: WideString; const sSQLText: WideString; 
                           var sErrorMsg: WideString); dispid 74;
    procedure SaveDataBySQL(const sType: WideString; const sCondition: WideString; 
                            var sErrorMsg: WideString); dispid 75;
    procedure SaveSDTraceInfo(var vData: OleVariant; iType: Integer; var sErrorMsg: WideString); dispid 77;
    procedure SaveRSTraceInfo(var vData: OleVariant; var sErrorMsg: WideString); dispid 76;
    procedure SaveDataBySQLEx(const sType: WideString; const sCondition: WideString; 
                              var Result: WideString; var sErrorMsg: WideString); dispid 78;
    procedure SaveSampleInfo(var vParam: OleVariant; var sErrorMsg: WideString); dispid 79;
    procedure SaveMultiData(const sTable1: WideString; const sTable2: WideString; 
                            var vData1: OleVariant; var vData2: OleVariant; 
                            const sSQLText_Before: WideString; const sSQLText_After: WideString; 
                            const sKey1: WideString; const sKey2: WideString; 
                            var sErrorMsg: WideString); dispid 80;
    procedure SaveSQLData(const sSQL: WideString; var sErrMsg: WideString); dispid 81;
    procedure GetQueryBySQL(var vData: OleVariant; const sSQL: WideString; var sErrMsg: WideString); dispid 82;
  end;

// *********************************************************************//
// Interface: IFNMArtFacadeLib
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FF8C452C-7228-4D1F-9A62-64F0C8E1D5A2}
// *********************************************************************//
  IFNMArtFacadeLib = interface(IDispatch)
    ['{FF8C452C-7228-4D1F-9A62-64F0C8E1D5A2}']
    procedure GetCADInfo(out vData: OleVariant; const sGF_KeyValue: WideString; iType: Integer; 
                         out sErrorMsg: WideString); safecall;
    procedure GetNoCheckGFNO(const sDept: WideString; out vData: OleVariant; 
                             out sErrorMsg: WideString); safecall;
    procedure SaveStdArt(vDataHdr: OleVariant; var vDataDtl: OleVariant; vDataParam: OleVariant; 
                         var sErrorMsg: WideString); safecall;
    procedure GetArtDtl(iArtID: Integer; const sArtType: WideString; out vData1: OleVariant; 
                        out vData2: OleVariant; out sErrorMsg: WideString); safecall;
    procedure GetNoArtRepairCard(const sDepartment: WideString; var vData: OleVariant; 
                                 var sErrorMsg: WideString); safecall;
    procedure GetPrescriptionInfo(iPrescripType: Integer; const sPrescrip_NO: WideString; 
                                  out vDataHdr: OleVariant; out vDataDtl: OleVariant; 
                                  out vDataCard: OleVariant; out sErrorMsg: WideString); safecall;
    procedure GetAssiPrescriptionNO(const sGF_KeyValue: WideString; out vData: OleVariant; 
                                    out sErrorMsg: WideString); safecall;
    procedure GetNoFinishPrescriptionNOList(var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure GetNoFinishFactPrescrip_NO(out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure GetChemicalByPrescrip_NO(const sPrescrip_NO: WideString; bIsStdPrescrip_NO: WordBool; 
                                       var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure SaveFactArt(vDataHdr: OleVariant; vDataDtl: OleVariant; vDataParam: OleVariant; 
                          var sErrorMsg: WideString); safecall;
    procedure SaveRepairArt(var vData: OleVariant; vDataHdr: OleVariant; vDataDtl: OleVariant; 
                            var sErrorMsg: WideString); safecall;
    procedure SaveAssiPrescription(const sCardList: WideString; vDataHdr: OleVariant; 
                                   var vDataDtl: OleVariant; var sErrorMsg: WideString); safecall;
    procedure GetNoCheckAssiPrescription(const sDeparement: WideString; out vData: OleVariant; 
                                         out sErrorMsg: WideString); safecall;
    procedure GetSendCardByDate(sDate: TDateTime; var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure SaveCardArtReview(const sCard: WideString; const sOperator: WideString; 
                                vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure SaveDipCardList(const sOperationCode: WideString; const sCardList: WideString; 
                              const sGFIDList: WideString; const sOperator: WideString; 
                              var sErrorMsg: WideString); safecall;
    procedure SaveFactAssiPrescription(iUpdateMode: Integer; const sPrescrip_NO: WideString; 
                                       vDataHdr: OleVariant; var vDataDtl: OleVariant; 
                                       var sErrorMsg: WideString); safecall;
    procedure GetAccidentInfo(const sAccident_NO: WideString; var vDataHdr: OleVariant; 
                              var vDataDtl: OleVariant; var vDataCard: OleVariant; 
                              var sErrorMsg: WideString); safecall;
    procedure SaveAccidentInfo(const sCardList: WideString; var vDataHdr: OleVariant; 
                               vDataDtl: OleVariant; const sDeparement: WideString; 
                               const sOperator: WideString; var sErrorMsg: WideString); safecall;
    procedure GetAccidentNOList(const sDataClass: WideString; const sDepartment: WideString; 
                                var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure GetAccidentCardList(const sAccident_NO: WideString; out vData: OleVariant; 
                                  out sErrorMsg: WideString); safecall;
    procedure GetAccidentDisposeInfo(const sAccident_NO: WideString; out vData: OleVariant; 
                                     out sErrorMsg: WideString); safecall;
    procedure SaveDisposeInfo(const sAccident_NO: WideString; const sQualityOperation: WideString; 
                              const sDisposeInfo: WideString; const sReasonCode: WideString; 
                              const sRepairCardList: WideString; 
                              const sRepairOperation: WideString; 
                              const sUnHoldCardList: WideString; const sOperator: WideString; 
                              var sErrorMsg: WideString); safecall;
    procedure GetNoFinishRecipe(const sDepartment: WideString; var vData: OleVariant; 
                                var sErrorMsg: WideString); safecall;
    procedure SaveRecipe(iUpdateMode: Integer; const sRecipe_NO: WideString; sBase_Volume: Integer; 
                         const sMachine_ID: WideString; const sOperator: WideString; 
                         const sCardList: WideString; var sErrorMsg: WideString); safecall;
    procedure GetOnLineCard(const sCLassName: WideString; const sParam1: WideString; 
                            const sParam2: WideString; out vData: OleVariant; 
                            out sErrorMsg: WideString); safecall;
    procedure GetSampleInfo(out vData: OleVariant; const sFN_Card: WideString; 
                            out sErrorMsg: WideString); safecall;
    procedure GetOperationListByFN_Card(const sFN_Card: WideString; out vData: OleVariant; 
                                        out sErrorMsg: WideString); safecall;
    procedure GetDefectAnalysisWorker(iStepNO: Integer; iOperationTimes: Integer; 
                                      const sFnCard: WideString; const sMachine_ID: WideString; 
                                      const sOperate_Time: WideString; 
                                      const sCurrent_Department: WideString; out vData: OleVariant; 
                                      out sErrorMsg: WideString); safecall;
    procedure SaveCheckStdArt(const sSTD_Art_ID: WideString; const sVersion: WideString; 
                              const sCurrent_Department: WideString; const sChecker: WideString; 
                              iType: Integer; out sErrorMsg: WideString); safecall;
    procedure SaveCheckAssistantPrescription(const sChecker: WideString; 
                                             const sAssistant_Prescrip_NO: WideString; 
                                             out sErrorMsg: WideString); safecall;
    procedure GetUsedPrescripNOCard(const sGF_KeyValue: WideString; 
                                    const sOperation_Code: WideString; 
                                    const sPrescrip_NO: WideString; const sDepartment: WideString; 
                                    out vData1: OleVariant; out vData2: OleVariant; 
                                    out sErrorMsg: WideString); safecall;
    procedure GetCheckGFIDAndSTDArt(const sGF_KeyValue: WideString; const sDepartment: WideString; 
                                    out iGF_ID: Integer; out iSTD_Art_ID: Integer; 
                                    out sErrorMsg: WideString); safecall;
    procedure SaveRecipeTraceInfo(const sOperateClass: WideString; const sVatCode: WideString; 
                                  const sRecipe_NO: WideString; sScrapVolume: Single; 
                                  const sOperator: WideString; out sErrorMsg: WideString); safecall;
    procedure GetFNCardsByRecipeNO(const sRecipeNO: WideString; out vData: OleVariant; 
                                   out sErrorMsg: WideString); safecall;
    procedure SaveReceiveSample(const sIdenList: WideString; const sOperator: WideString; 
                                out sErrorMsg: WideString); safecall;
    procedure SaveAnalysisQualtityData(vDataHdr: OleVariant; vDataDtl: OleVariant; 
                                       sDate: TDateTime; const sDepartment: WideString; 
                                       out sErrorMsg: WideString); safecall;
    procedure GetFNNOList(iGetType: Integer; out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure GetCheckSpecialArt(iGF_ID: Integer; iIsNormal: Integer; 
                                 const sOperationStr: WideString; 
                                 const sCurrentDepartment: WideString; out sErrorMsg: WideString); safecall;
    procedure GetCardByFabricList(const sFabricList: WideString; out vData: OleVariant; 
                                  out sErrorMsg: WideString); safecall;
    procedure SaveUserDefindSample(const sTestItem: WideString; const sOperator: WideString; 
                                   out sFactSampleNO: WideString; out sErrorMsg: WideString); safecall;
    procedure SaveHLReceiveSendInfo(const sType: WideString; const sFN_NOs: WideString; 
                                    const sOperator: WideString; out sErrorMsg: WideString); safecall;
    procedure GetFNNOInfo(const sFN_NO: WideString; out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure SaveHLArtInfo(const Department: WideString; vDataHdr: OleVariant; 
                            var vDataDtl: OleVariant; var sErrorMsg: WideString); safecall;
    procedure GetArtItemInfo(iGF_ID: Integer; out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure SaveNewRecipe(const sPrescripNO: WideString; const sFNCards: WideString; 
                            const sOperationCode: WideString; const sMachineID: WideString; 
                            const sBaseVolume: WideString; const sDepartment: WideString; 
                            const sOperator: WideString; out sErrorMsg: WideString); safecall;
    procedure GetNoPrescripCard(const sGFKey_Value: WideString; const sDepartment: WideString; 
                                const sOperation_Code: WideString; out vData: OleVariant; 
                                out sErrorMsg: WideString); safecall;
    procedure GetUnFinishJobTraceDtl(const sFNCards: WideString; iStepNO: Integer; 
                                     out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure GetStdPrescriptionDtl(const sPrescrip_NO: WideString; out vData: OleVariant; 
                                    out sErrorMsg: WideString); safecall;
    procedure SaveStdPrescription(var vDataParam: OleVariant; var sPrescriptionNO: WideString; 
                                  out sErrorMsg: WideString); safecall;
    procedure GetArtReview(const sFN_Card: WideString; out vData: OleVariant; 
                           out sErrorMsg: WideString); safecall;
    procedure GetConStr(out sConStr: WideString); safecall;
    procedure GetOnlineStdPrescripNO(const sOperationCode: WideString; 
                                     const sDepartment: WideString; 
                                     out sStdPrescripNOs: OleVariant; out sErrorMsg: WideString); safecall;
    procedure GetFactArtDtl(iFactArtID: Integer; out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure GetAccidentInfoByFNCard(const sFN_Card: WideString; var vData: OleVariant; 
                                      var sErrorMsg: WideString); safecall;
    procedure SaveCheckRepairArt(iFactArtID: Integer; const sOperator: WideString; 
                                 out sErrorMsg: WideString); safecall;
    procedure GetRecipeInfo(const sRecipeNO: WideString; out vDataHdr: OleVariant; 
                            out vDataDtl: OleVariant; out vDataCard: OleVariant; 
                            out sErrorMsg: WideString); safecall;
    procedure SaveHandRecipe(const sCardList: WideString; vDataHdr: OleVariant; 
                             vDataDtl: OleVariant; out sErrorMsg: WideString); safecall;
    procedure GetNoCheckRecipe(const sDeparement: WideString; out vData: OleVariant; 
                               out sErrorMsg: WideString); safecall;
    procedure SaveCheckRecipe(const sChecker: WideString; const sRecipeNO: WideString; 
                              out sErrorMsg: WideString); safecall;
    procedure SaveBatchTraceInfo(const sOperateType: WideString; const sBatchNO: WideString; 
                                 sScrapVolume: Integer; const sOperator: WideString; 
                                 var sErrorMsg: WideString); safecall;
    procedure GetNoRecipeCards(const sGFKeyValue: WideString; const sCurrentDepartment: WideString; 
                               out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure GetNoFinishRecipeBatch(const sVatStudio: WideString; out vData: OleVariant; 
                                     out sErrorMsg: WideString); safecall;
    procedure SaveSplitRecipe(const sRecipeNO: WideString; const sVatCode: WideString; 
                              const sUserVol: WideString; const sOperator: WideString; 
                              out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure SaveDelABatch(const sBatchNO: WideString; out sErrorMsg: WideString); safecall;
    procedure GetBatchDtlInfo(const sBatchNO: WideString; out vData: OleVariant; 
                              out sErrorMsg: WideString); safecall;
    procedure SaveDelRecipe(const sRecipeNO: WideString; const sUserType: WideString; 
                            out sErrorMsg: WideString); safecall;
    procedure SaveNewRecipeVol(const sRecipeNO: WideString; const sOffsetVol: WideString; 
                               out sErrorMsg: WideString); safecall;
    procedure GetMachineRecipeBatch(const sDepartment: WideString; const sMachineID: WideString; 
                                    out vData: OleVariant; out sErrorMsg: WideString); safecall;
    procedure GetNoRecipeSteps(const sOperationCode: WideString; const sDepartment: WideString; 
                               const sMachineID: WideString; const sBeginTime: WideString; 
                               const sEndTime: WideString; out vData: OleVariant; 
                               out sErrorMsg: WideString); safecall;
    procedure SaveSupplyRecipe(const sTracIdens: WideString; const sOperationCode: WideString; 
                               const sPrescripNO: WideString; const sMachineID: WideString; 
                               const sDepartment: WideString; const sOperator: WideString; 
                               out sErrorMsg: WideString); safecall;
    procedure GetDiluteRecipeInfo(var vData0: OleVariant; var vData1: OleVariant; 
                                  var vData2: OleVariant; const sBatch_NO: WideString; 
                                  var sErrorMsg: WideString); safecall;
    procedure SaveDiluteRecipeInfo(IsNew: Integer; var vData0: OleVariant; var vData1: OleVariant; 
                                   var sErrorMsg: WideString); safecall;
    procedure DeleteInnerRepairInfo(iAnalysisIden: Integer; const sOperator: WideString; 
                                    var sErrorMsg: WideString); safecall;
    procedure CheckNeedRoll(const sGFIDList: WideString; var NeedRoll: WideString; 
                            var sErrorMsg: WideString); safecall;
    procedure ModifyProductWidth(const sGF_Key: WideString; iWidth: Single; 
                                 const sReason: WideString; const sOperator: WideString; 
                                 var sErrorMsg: WideString); safecall;
    procedure CreateRepairArtInfo(Iden: Integer; GF_ID: Integer; const sCardList: WideString; 
                                  const sCurrent_Department: WideString; 
                                  const sOperator: WideString; var vData0: OleVariant; 
                                  var vData1: OleVariant; var sErrorMsg: WideString); safecall;
    procedure GetEditCardLists(const sGF_NO: WideString; const sCurrent_Department: WideString; 
                               var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure ChangeVatCode(const sBatchNO: WideString; const sNewVatCode: WideString; 
                            var sErrorMsg: WideString); safecall;
    procedure AutoCreateStdArtDtl(const sGFNO: WideString; const sCurrentDepartment: WideString; 
                                  var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure SaveModifiedArtLog(const sStr: WideString; var sErrorMsg: WideString); safecall;
    procedure GetFeedbackInfo(var vData: OleVariant; iGF_ID: Integer; 
                              const sCurrent_Department: WideString; var sErrorMsg: WideString); safecall;
    procedure SaveFeedbackInfo(var vDataParam: OleVariant; var sErrorMsg: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IFNMArtFacadeLibDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FF8C452C-7228-4D1F-9A62-64F0C8E1D5A2}
// *********************************************************************//
  IFNMArtFacadeLibDisp = dispinterface
    ['{FF8C452C-7228-4D1F-9A62-64F0C8E1D5A2}']
    procedure GetCADInfo(out vData: OleVariant; const sGF_KeyValue: WideString; iType: Integer; 
                         out sErrorMsg: WideString); dispid 2;
    procedure GetNoCheckGFNO(const sDept: WideString; out vData: OleVariant; 
                             out sErrorMsg: WideString); dispid 4;
    procedure SaveStdArt(vDataHdr: OleVariant; var vDataDtl: OleVariant; vDataParam: OleVariant; 
                         var sErrorMsg: WideString); dispid 5;
    procedure GetArtDtl(iArtID: Integer; const sArtType: WideString; out vData1: OleVariant; 
                        out vData2: OleVariant; out sErrorMsg: WideString); dispid 11;
    procedure GetNoArtRepairCard(const sDepartment: WideString; var vData: OleVariant; 
                                 var sErrorMsg: WideString); dispid 13;
    procedure GetPrescriptionInfo(iPrescripType: Integer; const sPrescrip_NO: WideString; 
                                  out vDataHdr: OleVariant; out vDataDtl: OleVariant; 
                                  out vDataCard: OleVariant; out sErrorMsg: WideString); dispid 14;
    procedure GetAssiPrescriptionNO(const sGF_KeyValue: WideString; out vData: OleVariant; 
                                    out sErrorMsg: WideString); dispid 15;
    procedure GetNoFinishPrescriptionNOList(var vData: OleVariant; var sErrorMsg: WideString); dispid 8;
    procedure GetNoFinishFactPrescrip_NO(out vData: OleVariant; out sErrorMsg: WideString); dispid 9;
    procedure GetChemicalByPrescrip_NO(const sPrescrip_NO: WideString; bIsStdPrescrip_NO: WordBool; 
                                       var vData: OleVariant; var sErrorMsg: WideString); dispid 19;
    procedure SaveFactArt(vDataHdr: OleVariant; vDataDtl: OleVariant; vDataParam: OleVariant; 
                          var sErrorMsg: WideString); dispid 20;
    procedure SaveRepairArt(var vData: OleVariant; vDataHdr: OleVariant; vDataDtl: OleVariant; 
                            var sErrorMsg: WideString); dispid 21;
    procedure SaveAssiPrescription(const sCardList: WideString; vDataHdr: OleVariant; 
                                   var vDataDtl: OleVariant; var sErrorMsg: WideString); dispid 6;
    procedure GetNoCheckAssiPrescription(const sDeparement: WideString; out vData: OleVariant; 
                                         out sErrorMsg: WideString); dispid 3;
    procedure GetSendCardByDate(sDate: TDateTime; var vData: OleVariant; var sErrorMsg: WideString); dispid 18;
    procedure SaveCardArtReview(const sCard: WideString; const sOperator: WideString; 
                                vData: OleVariant; var sErrorMsg: WideString); dispid 22;
    procedure SaveDipCardList(const sOperationCode: WideString; const sCardList: WideString; 
                              const sGFIDList: WideString; const sOperator: WideString; 
                              var sErrorMsg: WideString); dispid 23;
    procedure SaveFactAssiPrescription(iUpdateMode: Integer; const sPrescrip_NO: WideString; 
                                       vDataHdr: OleVariant; var vDataDtl: OleVariant; 
                                       var sErrorMsg: WideString); dispid 24;
    procedure GetAccidentInfo(const sAccident_NO: WideString; var vDataHdr: OleVariant; 
                              var vDataDtl: OleVariant; var vDataCard: OleVariant; 
                              var sErrorMsg: WideString); dispid 25;
    procedure SaveAccidentInfo(const sCardList: WideString; var vDataHdr: OleVariant; 
                               vDataDtl: OleVariant; const sDeparement: WideString; 
                               const sOperator: WideString; var sErrorMsg: WideString); dispid 26;
    procedure GetAccidentNOList(const sDataClass: WideString; const sDepartment: WideString; 
                                var vData: OleVariant; var sErrorMsg: WideString); dispid 27;
    procedure GetAccidentCardList(const sAccident_NO: WideString; out vData: OleVariant; 
                                  out sErrorMsg: WideString); dispid 28;
    procedure GetAccidentDisposeInfo(const sAccident_NO: WideString; out vData: OleVariant; 
                                     out sErrorMsg: WideString); dispid 29;
    procedure SaveDisposeInfo(const sAccident_NO: WideString; const sQualityOperation: WideString; 
                              const sDisposeInfo: WideString; const sReasonCode: WideString; 
                              const sRepairCardList: WideString; 
                              const sRepairOperation: WideString; 
                              const sUnHoldCardList: WideString; const sOperator: WideString; 
                              var sErrorMsg: WideString); dispid 30;
    procedure GetNoFinishRecipe(const sDepartment: WideString; var vData: OleVariant; 
                                var sErrorMsg: WideString); dispid 32;
    procedure SaveRecipe(iUpdateMode: Integer; const sRecipe_NO: WideString; sBase_Volume: Integer; 
                         const sMachine_ID: WideString; const sOperator: WideString; 
                         const sCardList: WideString; var sErrorMsg: WideString); dispid 35;
    procedure GetOnLineCard(const sCLassName: WideString; const sParam1: WideString; 
                            const sParam2: WideString; out vData: OleVariant; 
                            out sErrorMsg: WideString); dispid 38;
    procedure GetSampleInfo(out vData: OleVariant; const sFN_Card: WideString; 
                            out sErrorMsg: WideString); dispid 7;
    procedure GetOperationListByFN_Card(const sFN_Card: WideString; out vData: OleVariant; 
                                        out sErrorMsg: WideString); dispid 10;
    procedure GetDefectAnalysisWorker(iStepNO: Integer; iOperationTimes: Integer; 
                                      const sFnCard: WideString; const sMachine_ID: WideString; 
                                      const sOperate_Time: WideString; 
                                      const sCurrent_Department: WideString; out vData: OleVariant; 
                                      out sErrorMsg: WideString); dispid 12;
    procedure SaveCheckStdArt(const sSTD_Art_ID: WideString; const sVersion: WideString; 
                              const sCurrent_Department: WideString; const sChecker: WideString; 
                              iType: Integer; out sErrorMsg: WideString); dispid 17;
    procedure SaveCheckAssistantPrescription(const sChecker: WideString; 
                                             const sAssistant_Prescrip_NO: WideString; 
                                             out sErrorMsg: WideString); dispid 39;
    procedure GetUsedPrescripNOCard(const sGF_KeyValue: WideString; 
                                    const sOperation_Code: WideString; 
                                    const sPrescrip_NO: WideString; const sDepartment: WideString; 
                                    out vData1: OleVariant; out vData2: OleVariant; 
                                    out sErrorMsg: WideString); dispid 40;
    procedure GetCheckGFIDAndSTDArt(const sGF_KeyValue: WideString; const sDepartment: WideString; 
                                    out iGF_ID: Integer; out iSTD_Art_ID: Integer; 
                                    out sErrorMsg: WideString); dispid 41;
    procedure SaveRecipeTraceInfo(const sOperateClass: WideString; const sVatCode: WideString; 
                                  const sRecipe_NO: WideString; sScrapVolume: Single; 
                                  const sOperator: WideString; out sErrorMsg: WideString); dispid 42;
    procedure GetFNCardsByRecipeNO(const sRecipeNO: WideString; out vData: OleVariant; 
                                   out sErrorMsg: WideString); dispid 43;
    procedure SaveReceiveSample(const sIdenList: WideString; const sOperator: WideString; 
                                out sErrorMsg: WideString); dispid 31;
    procedure SaveAnalysisQualtityData(vDataHdr: OleVariant; vDataDtl: OleVariant; 
                                       sDate: TDateTime; const sDepartment: WideString; 
                                       out sErrorMsg: WideString); dispid 44;
    procedure GetFNNOList(iGetType: Integer; out vData: OleVariant; out sErrorMsg: WideString); dispid 45;
    procedure GetCheckSpecialArt(iGF_ID: Integer; iIsNormal: Integer; 
                                 const sOperationStr: WideString; 
                                 const sCurrentDepartment: WideString; out sErrorMsg: WideString); dispid 46;
    procedure GetCardByFabricList(const sFabricList: WideString; out vData: OleVariant; 
                                  out sErrorMsg: WideString); dispid 47;
    procedure SaveUserDefindSample(const sTestItem: WideString; const sOperator: WideString; 
                                   out sFactSampleNO: WideString; out sErrorMsg: WideString); dispid 48;
    procedure SaveHLReceiveSendInfo(const sType: WideString; const sFN_NOs: WideString; 
                                    const sOperator: WideString; out sErrorMsg: WideString); dispid 16;
    procedure GetFNNOInfo(const sFN_NO: WideString; out vData: OleVariant; out sErrorMsg: WideString); dispid 36;
    procedure SaveHLArtInfo(const Department: WideString; vDataHdr: OleVariant; 
                            var vDataDtl: OleVariant; var sErrorMsg: WideString); dispid 49;
    procedure GetArtItemInfo(iGF_ID: Integer; out vData: OleVariant; out sErrorMsg: WideString); dispid 1;
    procedure SaveNewRecipe(const sPrescripNO: WideString; const sFNCards: WideString; 
                            const sOperationCode: WideString; const sMachineID: WideString; 
                            const sBaseVolume: WideString; const sDepartment: WideString; 
                            const sOperator: WideString; out sErrorMsg: WideString); dispid 51;
    procedure GetNoPrescripCard(const sGFKey_Value: WideString; const sDepartment: WideString; 
                                const sOperation_Code: WideString; out vData: OleVariant; 
                                out sErrorMsg: WideString); dispid 52;
    procedure GetUnFinishJobTraceDtl(const sFNCards: WideString; iStepNO: Integer; 
                                     out vData: OleVariant; out sErrorMsg: WideString); dispid 37;
    procedure GetStdPrescriptionDtl(const sPrescrip_NO: WideString; out vData: OleVariant; 
                                    out sErrorMsg: WideString); dispid 33;
    procedure SaveStdPrescription(var vDataParam: OleVariant; var sPrescriptionNO: WideString; 
                                  out sErrorMsg: WideString); dispid 34;
    procedure GetArtReview(const sFN_Card: WideString; out vData: OleVariant; 
                           out sErrorMsg: WideString); dispid 54;
    procedure GetConStr(out sConStr: WideString); dispid 55;
    procedure GetOnlineStdPrescripNO(const sOperationCode: WideString; 
                                     const sDepartment: WideString; 
                                     out sStdPrescripNOs: OleVariant; out sErrorMsg: WideString); dispid 50;
    procedure GetFactArtDtl(iFactArtID: Integer; out vData: OleVariant; out sErrorMsg: WideString); dispid 57;
    procedure GetAccidentInfoByFNCard(const sFN_Card: WideString; var vData: OleVariant; 
                                      var sErrorMsg: WideString); dispid 58;
    procedure SaveCheckRepairArt(iFactArtID: Integer; const sOperator: WideString; 
                                 out sErrorMsg: WideString); dispid 59;
    procedure GetRecipeInfo(const sRecipeNO: WideString; out vDataHdr: OleVariant; 
                            out vDataDtl: OleVariant; out vDataCard: OleVariant; 
                            out sErrorMsg: WideString); dispid 60;
    procedure SaveHandRecipe(const sCardList: WideString; vDataHdr: OleVariant; 
                             vDataDtl: OleVariant; out sErrorMsg: WideString); dispid 62;
    procedure GetNoCheckRecipe(const sDeparement: WideString; out vData: OleVariant; 
                               out sErrorMsg: WideString); dispid 63;
    procedure SaveCheckRecipe(const sChecker: WideString; const sRecipeNO: WideString; 
                              out sErrorMsg: WideString); dispid 64;
    procedure SaveBatchTraceInfo(const sOperateType: WideString; const sBatchNO: WideString; 
                                 sScrapVolume: Integer; const sOperator: WideString; 
                                 var sErrorMsg: WideString); dispid 65;
    procedure GetNoRecipeCards(const sGFKeyValue: WideString; const sCurrentDepartment: WideString; 
                               out vData: OleVariant; out sErrorMsg: WideString); dispid 53;
    procedure GetNoFinishRecipeBatch(const sVatStudio: WideString; out vData: OleVariant; 
                                     out sErrorMsg: WideString); dispid 67;
    procedure SaveSplitRecipe(const sRecipeNO: WideString; const sVatCode: WideString; 
                              const sUserVol: WideString; const sOperator: WideString; 
                              out vData: OleVariant; out sErrorMsg: WideString); dispid 68;
    procedure SaveDelABatch(const sBatchNO: WideString; out sErrorMsg: WideString); dispid 69;
    procedure GetBatchDtlInfo(const sBatchNO: WideString; out vData: OleVariant; 
                              out sErrorMsg: WideString); dispid 70;
    procedure SaveDelRecipe(const sRecipeNO: WideString; const sUserType: WideString; 
                            out sErrorMsg: WideString); dispid 71;
    procedure SaveNewRecipeVol(const sRecipeNO: WideString; const sOffsetVol: WideString; 
                               out sErrorMsg: WideString); dispid 72;
    procedure GetMachineRecipeBatch(const sDepartment: WideString; const sMachineID: WideString; 
                                    out vData: OleVariant; out sErrorMsg: WideString); dispid 61;
    procedure GetNoRecipeSteps(const sOperationCode: WideString; const sDepartment: WideString; 
                               const sMachineID: WideString; const sBeginTime: WideString; 
                               const sEndTime: WideString; out vData: OleVariant; 
                               out sErrorMsg: WideString); dispid 66;
    procedure SaveSupplyRecipe(const sTracIdens: WideString; const sOperationCode: WideString; 
                               const sPrescripNO: WideString; const sMachineID: WideString; 
                               const sDepartment: WideString; const sOperator: WideString; 
                               out sErrorMsg: WideString); dispid 73;
    procedure GetDiluteRecipeInfo(var vData0: OleVariant; var vData1: OleVariant; 
                                  var vData2: OleVariant; const sBatch_NO: WideString; 
                                  var sErrorMsg: WideString); dispid 74;
    procedure SaveDiluteRecipeInfo(IsNew: Integer; var vData0: OleVariant; var vData1: OleVariant; 
                                   var sErrorMsg: WideString); dispid 75;
    procedure DeleteInnerRepairInfo(iAnalysisIden: Integer; const sOperator: WideString; 
                                    var sErrorMsg: WideString); dispid 76;
    procedure CheckNeedRoll(const sGFIDList: WideString; var NeedRoll: WideString; 
                            var sErrorMsg: WideString); dispid 77;
    procedure ModifyProductWidth(const sGF_Key: WideString; iWidth: Single; 
                                 const sReason: WideString; const sOperator: WideString; 
                                 var sErrorMsg: WideString); dispid 78;
    procedure CreateRepairArtInfo(Iden: Integer; GF_ID: Integer; const sCardList: WideString; 
                                  const sCurrent_Department: WideString; 
                                  const sOperator: WideString; var vData0: OleVariant; 
                                  var vData1: OleVariant; var sErrorMsg: WideString); dispid 79;
    procedure GetEditCardLists(const sGF_NO: WideString; const sCurrent_Department: WideString; 
                               var vData: OleVariant; var sErrorMsg: WideString); dispid 80;
    procedure ChangeVatCode(const sBatchNO: WideString; const sNewVatCode: WideString; 
                            var sErrorMsg: WideString); dispid 81;
    procedure AutoCreateStdArtDtl(const sGFNO: WideString; const sCurrentDepartment: WideString; 
                                  var vData: OleVariant; var sErrorMsg: WideString); dispid 82;
    procedure SaveModifiedArtLog(const sStr: WideString; var sErrorMsg: WideString); dispid 83;
    procedure GetFeedbackInfo(var vData: OleVariant; iGF_ID: Integer; 
                              const sCurrent_Department: WideString; var sErrorMsg: WideString); dispid 84;
    procedure SaveFeedbackInfo(var vDataParam: OleVariant; var sErrorMsg: WideString); dispid 85;
  end;

// *********************************************************************//
// Interface: IThirdFacade
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D70D8CB4-4753-401D-9837-26C863185635}
// *********************************************************************//
  IThirdFacade = interface(IDispatch)
    ['{D70D8CB4-4753-401D-9837-26C863185635}']
    procedure GetMONMachineEfficiency(const Machine: WideString; const sBeginTime: WideString; 
                                      const sEndTime: WideString; var vData: OleVariant; 
                                      var sErrorMsg: WideString); safecall;
    procedure GetMONMachineParamterList(var vData: OleVariant; var sErrorMsg: WideString); safecall;
    procedure ExportRecipeToCS(const sBatchNO: WideString; var sErrorMsg: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IThirdFacadeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D70D8CB4-4753-401D-9837-26C863185635}
// *********************************************************************//
  IThirdFacadeDisp = dispinterface
    ['{D70D8CB4-4753-401D-9837-26C863185635}']
    procedure GetMONMachineEfficiency(const Machine: WideString; const sBeginTime: WideString; 
                                      const sEndTime: WideString; var vData: OleVariant; 
                                      var sErrorMsg: WideString); dispid 1;
    procedure GetMONMachineParamterList(var vData: OleVariant; var sErrorMsg: WideString); dispid 2;
    procedure ExportRecipeToCS(const sBatchNO: WideString; var sErrorMsg: WideString); dispid 3;
  end;

// *********************************************************************//
// The Class CoFNMFacadeLib provides a Create and CreateRemote method to          
// create instances of the default interface IFNMFacadeLib exposed by              
// the CoClass FNMFacadeLib. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoFNMFacadeLib = class
    class function Create: IFNMFacadeLib;
    class function CreateRemote(const MachineName: string): IFNMFacadeLib;
  end;

// *********************************************************************//
// The Class CoFNMArtFacadeLib provides a Create and CreateRemote method to          
// create instances of the default interface IFNMArtFacadeLib exposed by              
// the CoClass FNMArtFacadeLib. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoFNMArtFacadeLib = class
    class function Create: IFNMArtFacadeLib;
    class function CreateRemote(const MachineName: string): IFNMArtFacadeLib;
  end;

// *********************************************************************//
// The Class CoThirdFacade provides a Create and CreateRemote method to          
// create instances of the default interface IThirdFacade exposed by              
// the CoClass ThirdFacade. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoThirdFacade = class
    class function Create: IThirdFacade;
    class function CreateRemote(const MachineName: string): IThirdFacade;
  end;

implementation

uses ComObj;

class function CoFNMFacadeLib.Create: IFNMFacadeLib;
begin
  Result := CreateComObject(CLASS_FNMFacadeLib) as IFNMFacadeLib;
end;

class function CoFNMFacadeLib.CreateRemote(const MachineName: string): IFNMFacadeLib;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FNMFacadeLib) as IFNMFacadeLib;
end;

class function CoFNMArtFacadeLib.Create: IFNMArtFacadeLib;
begin
  Result := CreateComObject(CLASS_FNMArtFacadeLib) as IFNMArtFacadeLib;
end;

class function CoFNMArtFacadeLib.CreateRemote(const MachineName: string): IFNMArtFacadeLib;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FNMArtFacadeLib) as IFNMArtFacadeLib;
end;

class function CoThirdFacade.Create: IThirdFacade;
begin
  Result := CreateComObject(CLASS_ThirdFacade) as IThirdFacade;
end;

class function CoThirdFacade.CreateRemote(const MachineName: string): IThirdFacade;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ThirdFacade) as IThirdFacade;
end;

end.

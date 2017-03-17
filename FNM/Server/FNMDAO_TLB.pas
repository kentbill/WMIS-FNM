unit FNMDAO_TLB;

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
// File generated on 2009-9-10 13:58:58 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\wMIS\Code\FNM\Server\FNMDAO.tlb (1)
// LIBID: {FCBF5F03-A600-432C-85AC-B06E0246DB60}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v1.0 Midas, (C:\WINDOWS\system32\midas.dll)
//   (2) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
//   (3) v4.0 StdVCL, (C:\WINDOWS\system32\stdvcl40.dll)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, Midas, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  FNMDAOMajorVersion = 1;
  FNMDAOMinorVersion = 0;

  LIBID_FNMDAO: TGUID = '{FCBF5F03-A600-432C-85AC-B06E0246DB60}';

  IID_IFNMDaoInfo: TGUID = '{C1A6F0C0-C60C-4911-9C9E-005D49FF3C34}';
  CLASS_FNMDaoInfo: TGUID = '{E94660FD-CE4A-4595-AACC-7679284E5D37}';
  IID_IFNMDaoUpt: TGUID = '{4627A048-00C4-4289-A3A7-48965B2EDD7B}';
  CLASS_FNMDaoUpt: TGUID = '{3219DC19-2902-48B9-8382-DDA8641EB8CD}';
  IID_IThirdDAOInfo: TGUID = '{B4FF69A2-C0B6-4419-BE24-DC097735A6E8}';
  CLASS_ThirdDAOInfo: TGUID = '{11A6FCEF-8712-4336-AB3D-EFD4674B9690}';
  IID_IThirdDAOUpt: TGUID = '{CD926818-E729-476D-95B6-E1D60871BA29}';
  CLASS_ThirdDAOUpt: TGUID = '{8D67B7D3-9526-4177-BB82-718AFC5114D3}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IFNMDaoInfo = interface;
  IFNMDaoInfoDisp = dispinterface;
  IFNMDaoUpt = interface;
  IFNMDaoUptDisp = dispinterface;
  IThirdDAOInfo = interface;
  IThirdDAOInfoDisp = dispinterface;
  IThirdDAOUpt = interface;
  IThirdDAOUptDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  FNMDaoInfo = IFNMDaoInfo;
  FNMDaoUpt = IFNMDaoUpt;
  ThirdDAOInfo = IThirdDAOInfo;
  ThirdDAOUpt = IThirdDAOUpt;


// *********************************************************************//
// Interface: IFNMDaoInfo
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C1A6F0C0-C60C-4911-9C9E-005D49FF3C34}
// *********************************************************************//
  IFNMDaoInfo = interface(IAppServer)
    ['{C1A6F0C0-C60C-4911-9C9E-005D49FF3C34}']
    procedure GetCommonDataSet(var vData: OleVariant; const sqlText: WideString; 
                               var sErrorMsg: WideString); safecall;
    procedure GetCommonFieldValue(var vFieldValue: OleVariant; const sSqlText: WideString; 
                                  var sErrorMsg: WideString); safecall;
    procedure GetMultiDataSet(const sSqlText: WideString; var vData0: OleVariant; 
                              var vData1: OleVariant; var vData2: OleVariant; 
                              var sErrorMsg: WideString); safecall;
    procedure GetCommonData(var vData: OleVariant; const sqlText: WideString; 
                            var sErrorMsg: WideString); safecall;
    procedure ExeCommonSql(const sSqlText: WideString; var sErrorMsg: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IFNMDaoInfoDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C1A6F0C0-C60C-4911-9C9E-005D49FF3C34}
// *********************************************************************//
  IFNMDaoInfoDisp = dispinterface
    ['{C1A6F0C0-C60C-4911-9C9E-005D49FF3C34}']
    procedure GetCommonDataSet(var vData: OleVariant; const sqlText: WideString; 
                               var sErrorMsg: WideString); dispid 1;
    procedure GetCommonFieldValue(var vFieldValue: OleVariant; const sSqlText: WideString; 
                                  var sErrorMsg: WideString); dispid 2;
    procedure GetMultiDataSet(const sSqlText: WideString; var vData0: OleVariant; 
                              var vData1: OleVariant; var vData2: OleVariant; 
                              var sErrorMsg: WideString); dispid 3;
    procedure GetCommonData(var vData: OleVariant; const sqlText: WideString; 
                            var sErrorMsg: WideString); dispid 4;
    procedure ExeCommonSql(const sSqlText: WideString; var sErrorMsg: WideString); dispid 5;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; MaxErrors: Integer; 
                             out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer; out RecsOut: Integer; 
                           Options: Integer; const CommandText: WideString; var Params: OleVariant; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function AS_GetProviderNames: OleVariant; dispid 20000003;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: Integer; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString; 
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// Interface: IFNMDaoUpt
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4627A048-00C4-4289-A3A7-48965B2EDD7B}
// *********************************************************************//
  IFNMDaoUpt = interface(IAppServer)
    ['{4627A048-00C4-4289-A3A7-48965B2EDD7B}']
    procedure SaveDataset(vData: OleVariant; const sSqlText: WideString; var sErrorMsg: WideString; 
                          bResolveToDataSet: WordBool); safecall;
    procedure SaveCommonDataSet(vData: OleVariant; const sqlForDelphi: WideString; 
                                const sqlForADO: WideString; var sErrorMsg: WideString); safecall;
    procedure ExeCommonSqlWithResult(const sSqlText: WideString; const sFieldName: WideString; 
                                     var sResult: WideString; var sErrorMsg: WideString); safecall;
    procedure ExeCommonSql(const sSqlText: WideString; var sErrorMsg: WideString); safecall;
    procedure SaveMultiDataSet(var vData: OleVariant; const sSqlText: WideString; 
                               const sKeyField: WideString; const sUpdateSqlText: WideString; 
                               var sErrorMsg: WideString; bResolveToDataSet: WordBool); safecall;
    procedure ExeCommonSqlWithResultData(const sSqlText: WideString; out vData: OleVariant; 
                                         out sErrorMsg: WideString); safecall;
    procedure SaveMultiData(vData1: OleVariant; vData2: OleVariant; const sSQLText1: WideString; 
                            const sSQLText2: WideString; const sSQLText_Before: WideString; 
                            const sSQLText_After: WideString; const sKey1: WideString; 
                            const sKey2: WideString; var sErrorMsg: WideString); safecall;
    procedure SaveDatasetByKey(vData: OleVariant; const sSqlText: WideString; 
                               const sKeyField: WideString; bResolveToDataSet: WordBool; 
                               var sErrorMsg: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IFNMDaoUptDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4627A048-00C4-4289-A3A7-48965B2EDD7B}
// *********************************************************************//
  IFNMDaoUptDisp = dispinterface
    ['{4627A048-00C4-4289-A3A7-48965B2EDD7B}']
    procedure SaveDataset(vData: OleVariant; const sSqlText: WideString; var sErrorMsg: WideString; 
                          bResolveToDataSet: WordBool); dispid 1;
    procedure SaveCommonDataSet(vData: OleVariant; const sqlForDelphi: WideString; 
                                const sqlForADO: WideString; var sErrorMsg: WideString); dispid 2;
    procedure ExeCommonSqlWithResult(const sSqlText: WideString; const sFieldName: WideString; 
                                     var sResult: WideString; var sErrorMsg: WideString); dispid 4;
    procedure ExeCommonSql(const sSqlText: WideString; var sErrorMsg: WideString); dispid 3;
    procedure SaveMultiDataSet(var vData: OleVariant; const sSqlText: WideString; 
                               const sKeyField: WideString; const sUpdateSqlText: WideString; 
                               var sErrorMsg: WideString; bResolveToDataSet: WordBool); dispid 7;
    procedure ExeCommonSqlWithResultData(const sSqlText: WideString; out vData: OleVariant; 
                                         out sErrorMsg: WideString); dispid 5;
    procedure SaveMultiData(vData1: OleVariant; vData2: OleVariant; const sSQLText1: WideString; 
                            const sSQLText2: WideString; const sSQLText_Before: WideString; 
                            const sSQLText_After: WideString; const sKey1: WideString; 
                            const sKey2: WideString; var sErrorMsg: WideString); dispid 6;
    procedure SaveDatasetByKey(vData: OleVariant; const sSqlText: WideString; 
                               const sKeyField: WideString; bResolveToDataSet: WordBool; 
                               var sErrorMsg: WideString); dispid 8;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; MaxErrors: Integer; 
                             out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer; out RecsOut: Integer; 
                           Options: Integer; const CommandText: WideString; var Params: OleVariant; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function AS_GetProviderNames: OleVariant; dispid 20000003;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: Integer; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString; 
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// Interface: IThirdDAOInfo
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B4FF69A2-C0B6-4419-BE24-DC097735A6E8}
// *********************************************************************//
  IThirdDAOInfo = interface(IAppServer)
    ['{B4FF69A2-C0B6-4419-BE24-DC097735A6E8}']
    procedure GetCommonDataSet(const sServerTag: WideString; const sSqlText: WideString; 
                               var vData: OleVariant; var sErrorMsg: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IThirdDAOInfoDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B4FF69A2-C0B6-4419-BE24-DC097735A6E8}
// *********************************************************************//
  IThirdDAOInfoDisp = dispinterface
    ['{B4FF69A2-C0B6-4419-BE24-DC097735A6E8}']
    procedure GetCommonDataSet(const sServerTag: WideString; const sSqlText: WideString; 
                               var vData: OleVariant; var sErrorMsg: WideString); dispid 1;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; MaxErrors: Integer; 
                             out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer; out RecsOut: Integer; 
                           Options: Integer; const CommandText: WideString; var Params: OleVariant; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function AS_GetProviderNames: OleVariant; dispid 20000003;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: Integer; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString; 
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// Interface: IThirdDAOUpt
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CD926818-E729-476D-95B6-E1D60871BA29}
// *********************************************************************//
  IThirdDAOUpt = interface(IAppServer)
    ['{CD926818-E729-476D-95B6-E1D60871BA29}']
    procedure ExeCommonSql(const sServerTag: WideString; const sSqlText: WideString; 
                           var sErrorMsg: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IThirdDAOUptDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CD926818-E729-476D-95B6-E1D60871BA29}
// *********************************************************************//
  IThirdDAOUptDisp = dispinterface
    ['{CD926818-E729-476D-95B6-E1D60871BA29}']
    procedure ExeCommonSql(const sServerTag: WideString; const sSqlText: WideString; 
                           var sErrorMsg: WideString); dispid 3;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; MaxErrors: Integer; 
                             out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer; out RecsOut: Integer; 
                           Options: Integer; const CommandText: WideString; var Params: OleVariant; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function AS_GetProviderNames: OleVariant; dispid 20000003;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: Integer; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString; 
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// The Class CoFNMDaoInfo provides a Create and CreateRemote method to          
// create instances of the default interface IFNMDaoInfo exposed by              
// the CoClass FNMDaoInfo. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoFNMDaoInfo = class
    class function Create: IFNMDaoInfo;
    class function CreateRemote(const MachineName: string): IFNMDaoInfo;
  end;

// *********************************************************************//
// The Class CoFNMDaoUpt provides a Create and CreateRemote method to          
// create instances of the default interface IFNMDaoUpt exposed by              
// the CoClass FNMDaoUpt. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoFNMDaoUpt = class
    class function Create: IFNMDaoUpt;
    class function CreateRemote(const MachineName: string): IFNMDaoUpt;
  end;

// *********************************************************************//
// The Class CoThirdDAOInfo provides a Create and CreateRemote method to          
// create instances of the default interface IThirdDAOInfo exposed by              
// the CoClass ThirdDAOInfo. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoThirdDAOInfo = class
    class function Create: IThirdDAOInfo;
    class function CreateRemote(const MachineName: string): IThirdDAOInfo;
  end;

// *********************************************************************//
// The Class CoThirdDAOUpt provides a Create and CreateRemote method to          
// create instances of the default interface IThirdDAOUpt exposed by              
// the CoClass ThirdDAOUpt. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoThirdDAOUpt = class
    class function Create: IThirdDAOUpt;
    class function CreateRemote(const MachineName: string): IThirdDAOUpt;
  end;

implementation

uses ComObj;

class function CoFNMDaoInfo.Create: IFNMDaoInfo;
begin
  Result := CreateComObject(CLASS_FNMDaoInfo) as IFNMDaoInfo;
end;

class function CoFNMDaoInfo.CreateRemote(const MachineName: string): IFNMDaoInfo;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FNMDaoInfo) as IFNMDaoInfo;
end;

class function CoFNMDaoUpt.Create: IFNMDaoUpt;
begin
  Result := CreateComObject(CLASS_FNMDaoUpt) as IFNMDaoUpt;
end;

class function CoFNMDaoUpt.CreateRemote(const MachineName: string): IFNMDaoUpt;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FNMDaoUpt) as IFNMDaoUpt;
end;

class function CoThirdDAOInfo.Create: IThirdDAOInfo;
begin
  Result := CreateComObject(CLASS_ThirdDAOInfo) as IThirdDAOInfo;
end;

class function CoThirdDAOInfo.CreateRemote(const MachineName: string): IThirdDAOInfo;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ThirdDAOInfo) as IThirdDAOInfo;
end;

class function CoThirdDAOUpt.Create: IThirdDAOUpt;
begin
  Result := CreateComObject(CLASS_ThirdDAOUpt) as IThirdDAOUpt;
end;

class function CoThirdDAOUpt.CreateRemote(const MachineName: string): IThirdDAOUpt;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ThirdDAOUpt) as IThirdDAOUpt;
end;

end.

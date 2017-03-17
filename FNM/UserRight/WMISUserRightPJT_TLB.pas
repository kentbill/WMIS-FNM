unit WMISUserRightPJT_TLB;

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
// File generated on 2008-3-7 9:31:00 from Type Library described below.

// ************************************************************************  //
// Type Lib: E:\W.MIS(SERVER)\Code\FNM\UserRight\WMISUserRightPJT.tlb (1)
// LIBID: {493FE3CC-971A-4348-BDAB-A026086E4DE6}
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
  WMISUserRightPJTMajorVersion = 1;
  WMISUserRightPJTMinorVersion = 0;

  LIBID_WMISUserRightPJT: TGUID = '{493FE3CC-971A-4348-BDAB-A026086E4DE6}';

  IID_IWMISUserRight: TGUID = '{EE107BC5-408C-4A6D-86E7-FF3AFF53AFCC}';
  CLASS_WMISUserRight: TGUID = '{B6F29840-6011-4C8B-8296-8E608EDEE9D6}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IWMISUserRight = interface;
  IWMISUserRightDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  WMISUserRight = IWMISUserRight;


// *********************************************************************//
// Interface: IWMISUserRight
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EE107BC5-408C-4A6D-86E7-FF3AFF53AFCC}
// *********************************************************************//
  IWMISUserRight = interface(IAppServer)
    ['{EE107BC5-408C-4A6D-86E7-FF3AFF53AFCC}']
    procedure Login(vSystem_ID: Integer; const vComputer_Name: WideString; 
                    var vUser_ID: WideString; var vUser_Name: WideString; 
                    var vMenuList: WideString; var vMsg: WideString); safecall;
    procedure Logoff(vSystem_ID: Integer; const vUser_ID: WideString; 
                     const vComputer_Name: WideString); safecall;
    procedure IsTerminal(const vComputer_Name: WideString; var vTerminal: WordBool); safecall;
    procedure GetUserLevel(vSystem_ID: Integer; const vComputer_Name: WideString; 
                           var vLevelList: WideString); safecall;
    procedure GetSystemInfo(const SysName: WideString; var SysId: Integer; 
                            var SysFullName: WideString; var UpdatePath: WideString; 
                            var Mail: WideString); safecall;
    procedure GetUserDepartmentList(const sUserID: WideString; var sDepartmentList: WideString; 
                                    var sErrMsg: WideString); safecall;
    procedure GetDefaultDepartment(const sUserID: WideString; var sDefaultDepartment: WideString; 
                                   var sErrMsg: WideString); safecall;
    procedure GetMenuInfo(const sUserID: WideString; iSysID: Integer; var vData: OleVariant; 
                          var sErrMs: WideString); safecall;
    procedure GetUserDepartments(const sUserID: WideString; iSysID: Integer; var vData: OleVariant; 
                                 var sErrMsg: WideString); safecall;
    procedure GetUserLevelByUserid(vSysID: Integer; const vUserID: WideString; 
                                   var vLevelList: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IWMISUserRightDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EE107BC5-408C-4A6D-86E7-FF3AFF53AFCC}
// *********************************************************************//
  IWMISUserRightDisp = dispinterface
    ['{EE107BC5-408C-4A6D-86E7-FF3AFF53AFCC}']
    procedure Login(vSystem_ID: Integer; const vComputer_Name: WideString; 
                    var vUser_ID: WideString; var vUser_Name: WideString; 
                    var vMenuList: WideString; var vMsg: WideString); dispid 1;
    procedure Logoff(vSystem_ID: Integer; const vUser_ID: WideString; 
                     const vComputer_Name: WideString); dispid 2;
    procedure IsTerminal(const vComputer_Name: WideString; var vTerminal: WordBool); dispid 3;
    procedure GetUserLevel(vSystem_ID: Integer; const vComputer_Name: WideString; 
                           var vLevelList: WideString); dispid 4;
    procedure GetSystemInfo(const SysName: WideString; var SysId: Integer; 
                            var SysFullName: WideString; var UpdatePath: WideString; 
                            var Mail: WideString); dispid 5;
    procedure GetUserDepartmentList(const sUserID: WideString; var sDepartmentList: WideString; 
                                    var sErrMsg: WideString); dispid 6;
    procedure GetDefaultDepartment(const sUserID: WideString; var sDefaultDepartment: WideString; 
                                   var sErrMsg: WideString); dispid 7;
    procedure GetMenuInfo(const sUserID: WideString; iSysID: Integer; var vData: OleVariant; 
                          var sErrMs: WideString); dispid 8;
    procedure GetUserDepartments(const sUserID: WideString; iSysID: Integer; var vData: OleVariant; 
                                 var sErrMsg: WideString); dispid 9;
    procedure GetUserLevelByUserid(vSysID: Integer; const vUserID: WideString; 
                                   var vLevelList: WideString); dispid 10;
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
// The Class CoWMISUserRight provides a Create and CreateRemote method to          
// create instances of the default interface IWMISUserRight exposed by              
// the CoClass WMISUserRight. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoWMISUserRight = class
    class function Create: IWMISUserRight;
    class function CreateRemote(const MachineName: string): IWMISUserRight;
  end;

implementation

uses ComObj;

class function CoWMISUserRight.Create: IWMISUserRight;
begin
  Result := CreateComObject(CLASS_WMISUserRight) as IWMISUserRight;
end;

class function CoWMISUserRight.CreateRemote(const MachineName: string): IWMISUserRight;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_WMISUserRight) as IWMISUserRight;
end;

end.

library FNMFacade;

uses
  ComServ,
  FNMFacade_TLB in 'FNMFacade_TLB.pas',
  UFNMFacade in 'UFNMFacade.pas' {FNMFacadeLib: CoClass},
  ComDllPub in 'ComDllPub.pas',
  UFNMArtFacade in 'UFNMArtFacade.pas' {FNMArtFacadeLib: CoClass},
  UThirdFacade in 'UThirdFacade.pas' {ThirdFacade: CoClass};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
end.

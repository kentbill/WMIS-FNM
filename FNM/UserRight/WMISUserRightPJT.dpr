library WMISUserRightPJT;

uses
  ComServ,
  WMISUserRightPJT_TLB in 'WMISUserRightPJT_TLB.pas',
  uWMISUserRight in 'uWMISUserRight.pas' {WMISUserRight: TMtsDataModule} {WMISUserRight: CoClass};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
end.

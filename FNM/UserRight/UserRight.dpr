library UserRight;

uses
  ComServ,
  UserRight_TLB in 'UserRight_TLB.pas',
  UserRightMDL in 'UserRightMDL.pas' {CoUserRight: TMtsDataModule} {CoUserRight: CoClass};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
end.

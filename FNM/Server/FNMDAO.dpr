library FNMDAO;

uses
  ComServ,
  FNMDAO_TLB in 'FNMDAO_TLB.pas',
  UFNMDAOInfo in 'UFNMDAOInfo.pas' {FNMDaoInfo: TMtsDataModule} {FNMDaoInfo: CoClass},
  UFNMDAOUpt in 'UFNMDAOUpt.pas' {FNMDaoUpt: TMtsDataModule} {FNMDaoUpt: CoClass},
  DA in 'DA.pas',
  UThirdDAOInfo in 'UThirdDAOInfo.pas' {ThirdDAOInfo: TMtsDataModule} {ThirdDAOInfo: CoClass},
  UThirdDAOUpt in 'UThirdDAOUpt.pas' {ThirdDAOUpt: TMtsDataModule} {ThirdDAOUpt: CoClass};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
end.

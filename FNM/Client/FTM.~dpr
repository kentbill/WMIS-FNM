program FTM;

{$I Terminal.inc}
{$IFNDEF TERMINAL}
  {$MESSAGE ERROR '请修改Terminal.inc中取消对行:$DEFINE TERMINAL的注释'}
{$ENDIF}

{%File 'Terminal.inc'}

uses
  Forms,
  uTerminal in 'Common\uTerminal.pas',
  frmRecipeTerminal in 'Form\frmRecipeTerminal.pas' {RecipeTerminalForm},
  frmDistributeTerminal in 'Form\frmDistributeTerminal.pas' {DistributeTerminalForm},
  frmMachineTerminal in 'Form\frmMachineTerminal.pas' {MachineTerminalForm},
  frmMachinesample in 'Form\frmMachineSample.pas' {MachineSampleForm},
  frmTerminalWelcome in 'Form\frmTerminalWelcome.pas' {FNMTerminalWelcome},
  frmAccident in 'Form\frmAccident.pas' {AccidentForm},
  uFNMResource in 'Common\uFNMResource.pas',
  UOutLookMail in 'Common\uOutLookMail.pas',
  ServerDllPub in 'Common\ServerDllPub.pas',
  uGlobal in 'Common\uGlobal.pas',
  frmSuspend in 'Form\frmSuspend.pas' {SuspendForm},
  frmViewArtDtl in 'Form\frmViewArtDtl.pas' {ViewArtDtlForm},
  frmModifyCarNO in 'Form\frmModifyCarNO.pas' {ModifyCarNOForm},
  frmMachineSelect in 'Form\frmMachineSelect.pas' {MachineSelectForm},
  frmInput in 'Form\frmInput.pas' {InputForm},
  frmSOPDefect in 'Form\frmSOPDefect.pas' {SOPDefectForm},
  frmLocateCar in 'Form\frmLocateCar.pas' {LocateCarForm},
  frmCheckArt in 'Form\frmCheckArt.pas' {CheckArtForm};

{$R *.res}
//应用程序图标资源文件
{$R FNMBitMap.RES}

{$Message '开发人员提示维护人员:窗体上的某些控件是可以没有名称的'}
{$Message '但是必须保证窗体上同一种控件必须有一个有名称.'}
{$Message '如果运行时发生某种控件无法创键,请检查该窗体的该类控件是否是都没有名称'}

var
  TerminalClass: String;
  
begin
  Application.Initialize;
  Application.OnException:=TGlobal.OnException;
  TerminalClass:= LoginTerminal;

  if TerminalClass = '' then exit;
    
  if TerminalClass = '机台终端' then
    Application.CreateForm(TMachineTerminalForm, MachineTerminalForm);
  if TerminalClass = '分布终端' then
    Application.CreateForm(TDistributeTerminalForm, DistributeTerminalForm);
  if TerminalClass = '化料终端' then
    Application.CreateForm(TRecipeTerminalForm, RecipeTerminalForm);
  Application.CreateForm(TFNMTerminalWelcome, FNMTerminalWelcome);
  Application.Run;
end.

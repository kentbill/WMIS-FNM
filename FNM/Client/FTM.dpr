program FTM;

{$I Terminal.inc}
{$IFNDEF TERMINAL}
  {$MESSAGE ERROR '���޸�Terminal.inc��ȡ������:$DEFINE TERMINAL��ע��'}
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
//Ӧ�ó���ͼ����Դ�ļ�
{$R FNMBitMap.RES}

{$Message '������Ա��ʾά����Ա:�����ϵ�ĳЩ�ؼ��ǿ���û�����Ƶ�'}
{$Message '���Ǳ��뱣֤������ͬһ�ֿؼ�������һ��������.'}
{$Message '�������ʱ����ĳ�ֿؼ��޷�����,����ô���ĸ���ؼ��Ƿ��Ƕ�û������'}

var
  TerminalClass: String;
  
begin
  Application.Initialize;
  Application.OnException:=TGlobal.OnException;
  TerminalClass:= LoginTerminal;

  if TerminalClass = '' then exit;
    
  if TerminalClass = '��̨�ն�' then
    Application.CreateForm(TMachineTerminalForm, MachineTerminalForm);
  if TerminalClass = '�ֲ��ն�' then
    Application.CreateForm(TDistributeTerminalForm, DistributeTerminalForm);
  if TerminalClass = '�����ն�' then
    Application.CreateForm(TRecipeTerminalForm, RecipeTerminalForm);
  Application.CreateForm(TFNMTerminalWelcome, FNMTerminalWelcome);
  Application.Run;
end.

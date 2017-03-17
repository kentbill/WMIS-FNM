{*******************************************************}
{                                                       }
{       ������� W.MIS CLIENT MODEL                     }
{       ��Ȩ���� (C) 2003, 2004 Esquel.IT               }
{       ��Ԫ���� frmWellcome.pas                        }
{       �������� 2004-8-3 10:58:42                      }
{       ������Ա wuwj                                   }
{                                                       }
{*******************************************************}

unit frmTerminalWelcome;
{* ��ӭ���嵥Ԫ }

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, DB, DBClient;

type
  TFNMTerminalWelcome = class(TForm)
    ImageWellcome: TImage;
    pnlButtom: TPanel;
    btnCancel: TButton;
    btnOK: TButton;
    cmbComPlusServers: TComboBox;
    lbMessage: TLabel;
    txt1: TStaticText;
    cbb_TerminalList: TComboBox;
    txt2: TStaticText;
    edt1: TEdit;
    txt3: TStaticText;
    txt4: TStaticText;
    txt_Machine: TStaticText;
    cbb_Machine: TComboBox;
    cbb_Department: TComboBox;
    cdsCheck: TClientDataSet;
    tmrCheckVersion: TTimer;
    procedure cbb_TerminalListSelect(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AComboBoxDropDown(Sender: TObject);
    procedure cbb_TerminalListEnter(Sender: TObject);
    procedure cmbComPlusServersKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbb_TerminalListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbb_DepartmentKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbb_MachineKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmrCheckVersionTimer(Sender: TObject);

  public
    procedure ShowProcessMessage(msg: string);

    function GetVersion(FileName: string):string;
    procedure CheckVersion;
  end;

function LoginTerminal: String;

var
  FNMTerminalWelcome: TFNMTerminalWelcome;

implementation

uses
  StrUtils, UAppOption, uLogin, uDictionary, uFNMArtInfo,
  frmMachineTerminal, uTerminal, uGridDecorator, ServerDllPub;

{$R *.DFM}

function LoginTerminal: String;
var
  OptionFile: string;
begin
  result:='';
  OptionFile:= GetEnvironmentVariable('APPDATA')+'\'+ExtractFileName(Application.ExeName);
  AppOption.InitiFileName:= ChangeFileExt(OptionFile, '.Config');
  AppOption.InitiOption;

  if FNMTerminalWelcome = nil then
    FNMTerminalWelcome:=TFNMTerminalWelcome.Create(Application);
  FNMTerminalWelcome.ShowModal;

  if FNMTerminalWelcome.ModalResult <> mrOK then
    exit;

  if not (HiWord(GetKeyState(VK_CONTROL)) <> 0)then
    FNMTerminalWelcome.CheckVersion;
//TODO -oPublic: ����û�ѡ���ComServer�Ƿ����
//  //����û�ȷ��,����Է������Ƿ����,����������û�ѡ��. �û�ȡ��ʱResult��ΪFalse
//  if result then
//    if not TestComServer then
//    begin
//      Show Message The Chose ComServer is Invalid
//      goto ChoseComServer;
//    end;

  Login.GetSystemInfo;
  GridDecorator.LoadFieldInfoFromFile(Login.UpdatePath + SYSTEMNAME +'.xml');
  result:=FNMTerminalWelcome.cbb_TerminalList.Text;
end;

procedure TFNMTerminalWelcome.ShowProcessMessage(msg: string);
var
  BeginTick: DWORD;
begin
  BeginTick:=GetTickCount;
  lbMessage.Caption:=msg;
  lbMessage.Refresh;
end;

procedure TFNMTerminalWelcome.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caNone;
  if Self.ModalResult = mrOk  then
  begin
    if Login.ComPlusServer = '' then
      Login.ComPlusServer:=cmbComPlusServers.Text;
    Login.CurrentDepartment:=LeftStr(cbb_Department.Text, 2);
    case cbb_TerminalList.ItemIndex of
      0: //��̨�ն�
        MachineName:=cbb_Machine.Text;
      1: //�����ն�
        RecipeVatStudio:=cbb_Machine.Text;
    end;
  end;
  Action:=caFree;
end;

procedure TFNMTerminalWelcome.cbb_TerminalListSelect(Sender: TObject);
begin
  cbb_Machine.Items.Clear;
  case cbb_TerminalList.ItemIndex of
    0: //��̨�ն�
      txt_Machine.Caption:='��̨:';
    1: //�����ն�
      txt_Machine.Caption:='�Ϸ�:';
  end;
end;

procedure TFNMTerminalWelcome.AComboBoxDropDown(Sender: TObject);
begin
  if FNMTerminalWelcome.cmbComPlusServers.Text = '' then
    raise Exception.Create('��ѡ�������!');

  Login.ComPlusServer:=FNMTerminalWelcome.cmbComPlusServers.Text;
  cmbComPlusServers.Enabled:=false;
  cmbComPlusServers.Color:=clBtnFace;
  if Sender = cbb_Machine then
  begin
    if cbb_Department.ItemIndex = -1 then
      raise Exception.Create('����ѡ����!');

    with Dictionary do
    case cbb_TerminalList.ItemIndex of
      0: //��̨�ն�
        FillAllOperationToItems(LeftStr(cbb_Department.Text, 2), cbb_Machine.Items);
      1: //�����ն�
      begin
        try
          cds_VatList.Filter:=format('Vat_Studio like ''%s%%''', [LeftStr(cbb_Department.Text, 2)]);
          cds_VatList.Filtered:=True;
          FillItemsFromDataSet(cds_VatList, 'Vat_Studio', '', '', '', cbb_Machine.Items);
        finally
          cds_VatList.Filtered:=false;
        end;
      end
    end;
  end;
end;

procedure TFNMTerminalWelcome.cbb_TerminalListEnter(Sender: TObject);
begin
  (Sender as TComboBox).DroppedDown:=true;
end;

procedure TFNMTerminalWelcome.cmbComPlusServersKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    cbb_TerminalList.SetFocus;
end;

procedure TFNMTerminalWelcome.cbb_TerminalListKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    if Key = VK_RETURN then
    cbb_Department.SetFocus;
end;

procedure TFNMTerminalWelcome.cbb_DepartmentKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    cbb_Machine.SetFocus;
end;

procedure TFNMTerminalWelcome.cbb_MachineKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edt1.SetFocus;
end;

procedure TFNMTerminalWelcome.edt1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnOK.SetFocus;
end;

procedure TFNMTerminalWelcome.CheckVersion;
var
  LocalVersion:String;
  ServerPath,ServerVersion:string;
  vData: OleVariant;
  sCondition,sErrorMsg: WideString;
//  vData:OleVariant;
//  sSQL, sErrMsg:WideString;
//  FormHandle: THandle;
begin
  LocalVersion := GetVersion(ParamStr(0));
  sCondition := QuotedStr('1');
  FNMServerObj.GetQueryData(vData,'GetSystemPath',sCondition,sErrorMsg);
   if sErrorMsg <> '' then
  begin
    //TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  TempClientDataSet.Data:=vData;
  ServerPath := TempClientDataSet.FieldByName('full_path').AsString;
  //ServerPath:='\\GETNAS\MIS\W.MIS\Update\FNM\FTM.exe';
  ServerVersion := GetVersion(ServerPath);
  if ServerVersion<>LocalVersion then
  begin
    raise Exception.Create('�����������°汾,�����������°汾,лл����!');
    Application.Terminate;
  end;
//  sSQL := QuotedStr('FTM.exe')+ ','+ QuotedStr(sVersion);
//  FNMServerObj.GetQueryData(vData,'fnCheckVersion',sSQL, sErrMsg);
//  if sErrMsg <> '' then
//  begin
//    raise Exception.Create(sErrMsg);
//    Application.Terminate;
//  end;
//  cdsCheck.Data := vData;
//  if not cdsCheck.IsEmpty then
//  begin
//    sErrMsg := cdsCheck.FieldByName('Msg').AsString;
//    if pos('��������',sErrMsg)>0 then
//    begin
//      FormHandle := GetActiveWindow;
//      PostMessage(FormHandle,WM_CLOSE,WM_NULL,SW_HIDE);
//      raise Exception.Create(sErrMsg);
//      Application.Terminate;
//    end;  
//  end;
end;
function TFNMTerminalWelcome.GetVersion(FileName: string): string;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(FileName), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(FileName), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    Result := IntToStr(dwFileVersionMS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionMS and $FFFF);
    Result := Result + '.' + IntToStr(dwFileVersionLS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionLS and $FFFF);
  end;
  FreeMem(VerInfo, VerInfoSize);
end;

procedure TFNMTerminalWelcome.tmrCheckVersionTimer(Sender: TObject);
begin
  CheckVersion;
end;

end.

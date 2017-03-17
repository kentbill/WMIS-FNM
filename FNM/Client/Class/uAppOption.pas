{*******************************************************}
{                                                       }
{       软件名称 W.MIS CLIENT MODEL                     }
{       版权所有 (C) 2003, 2004 Esquel.IT               }
{       单元名称 UAppOption.pas                         }
{       创建日期 2004-8-3 11:01:18                      }
{       创建人员 wuwj                                   }
{                                                       }
{*******************************************************}

unit UAppOption;
{* 应用程序选项设置类单元 }

interface
uses Classes, StdCtrls, SysUtils, Dialogs, StrUtils, Windows;

type

  TOption = class (TComponent)
  public
    procedure LoadFromFile(filePath:string); virtual;
    procedure SaveToFile(filePath:string); virtual;
  end;

  TAppOption = class (TOption)
  private
    FInitiFileName: String;
    FQueryShowCHN: Boolean;
    FShowStatusBar: Boolean;
    FShowToolBar: Boolean;
    FSkinFile: string;
    FSkinFilePath: string;
    FSkinList: string;
    FUseXPStyle: Boolean;
    FCurrent_Department: string;
    {* 当前部门}

    function GetSkinFileFullName: string;
    function GetUseXPStyle: Boolean;
    procedure SetQueryShowCHN(Value: Boolean);
    procedure setShowStatusBar(Value: Boolean);
    procedure SetShowToolBar(Value: Boolean);
    procedure SetSkinFile(Value: string);
    procedure SetSkinFilePath(const Value: string);
    procedure SetSkinList(Value: string);
    procedure SetUseXPStyle(Value: Boolean);

  public
    procedure InitiOption;
    procedure SaveOption;
    property SkinFileFullName: string read GetSkinFileFullName;
  published
    property IFQueryShowCHN: Boolean read FQueryShowCHN write SetQueryShowCHN;
    property InitiFileName: string read FInitiFileName write FInitiFileName;
    property ShowStatusBar:Boolean read FShowStatusBar write setShowStatusBar;
    property ShowToolBar:Boolean read FShowToolBar write SetShowToolBar;
    property SkinFile: string read FSkinFile write SetSkinFile;
    property SkinFilePath: string read FSkinFilePath write SetSkinFilePath;
    property SkinList: string read FSkinList write SetSkinList;
    property UseXPStyle: Boolean read GetUseXPStyle write SetUseXPStyle default false;
    property Current_Department: string read FCurrent_Department write FCurrent_Department;
  end;



function AppOption:TAppOption;

implementation

var
  FAppOption:TAppOption;

{ TAppOption }

procedure TAppOption.InitiOption;
begin
  LoadFromFile(InitiFileName);
end;

procedure TAppOption.SaveOption;
begin
  SaveToFile(InitiFileName);
end;

function TAppOption.GetSkinFileFullName: string;
begin
  if RightStr(FSkinFilePath,1)<>'\' then
     Result:=FSkinFilePath+'\'+FSkinFile
  else
     Result:=FSkinFilePath+FSkinFile;
end;

function TAppOption.GetUseXPStyle: Boolean;
begin
  result:=FUseXPStyle and (Win32Platform = VER_PLATFORM_WIN32_NT)
end;

procedure TAppOption.SetSkinFile(Value: string);
begin
  FSkinFile:=Value;
end;

procedure TAppOption.SetSkinFilePath(const Value: string);
begin
  if FSkinFilePath <> Value then
    FSkinFilePath := Value;
end;

procedure TAppOption.SetSkinList(Value: string);
begin
  FSkinList:=value;
end;

procedure TAppOption.SetUseXPStyle(Value: Boolean);
begin
  FUseXPStyle:=value;
end;

procedure TAPPOption.SetQueryShowCHN(Value: Boolean);
begin
  FQueryShowCHN :=value;
  // TODO -cMM: TOption.SetQueryShowCHN default body inserted
end;

procedure TAppOption.setShowStatusBar(Value: Boolean);
begin
  FShowStatusBar := Value;
end;

procedure TAppOption.SetShowToolBar(Value: Boolean);
begin
  FShowToolBar := Value;
end;

function AppOption:TAppOption;
begin
  if FAppOption=nil then
  begin
    FAppOption:=TAppOption.Create(nil);
    FAppOption.ShowToolBar:=true;
    FAppOption.ShowStatusBar:=true;
  end;
  Result:=FAppOption;
end;

{ TOption }

procedure TOption.LoadFromFile(filePath:string);
var
  Fs: TFileStream;
begin
  if not FileExists(FilePath) then
    AppOption.SaveToFile(FilePath);

  try
    Fs:=Tfilestream.Create(Filepath, Fmopenread);
    try
      Classes.RegisterClass(TAppOption);
      Fs.Readcomponent(Appoption);
    finally
      Fs.Free;
    end;
  except
    AppOption.SaveToFile(FilePath);
  end;
end;

procedure TOption.SaveToFile(filePath:string);
var
  fs: TFileStream;
begin
  Classes.RegisterClass(TAppOption);
  Fs:=Tfilestream.Create(Filepath,Fmcreate);
  try
    fs.WriteComponent(AppOption);
  finally
    fs.Free;
  end;
end;

initialization
  FAppOption:=nil;

finalization
  FAppOption.Free;

end.

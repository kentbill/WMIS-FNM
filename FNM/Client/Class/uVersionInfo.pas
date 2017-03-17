{*******************************************************}
{                                                       }
{       软件名称 W.MIS CLIENT MODEL                     }
{       版权所有 (C) 2003, 2004 Esquel.IT               }
{       单元名称 UVersionInfo.pas                       }
{       创建日期 2004-8-3 14:36:40                      }
{       创建人员 wuwj                                   }
{                                                       }
{*******************************************************}

unit UVersionInfo;
{* 获取应用程序版本类单元 }

interface

uses
  Windows, Types, SysUtils, Dialogs, uShowMessage;

type
  TExeVersionInfo = class(TObject)
  private
    FProductName: string;
    FProductVersion: string;
    FFileDescription: string;
    FLegalCopyright: string;
    FFileVersion: string;
    FCompanyName: string;
    FLegalTradeMarks: string;
    FInternalName: string;
    FOriginalFileName: string;
    FExeFullName: string;
  protected
    procedure GetVersionInfo;
  public
    Constructor Create(AExeFullName:string);

    property ProductName: string read FProductName;
    property ProductVersion: string read FProductVersion;
    property FileDescription: string read FFileDescription;
    property LegalCopyright: string read FLegalCopyright;
    property FileVersion: string read FFileVersion;
    property CompanyName: string read FCompanyName;
    property LegalTradeMarks: string read FLegalTradeMarks;
    property InternalName: string read FInternalName;
    property OriginalFileName: string read FOriginalFileName;
  end;

implementation

constructor TExeVersionInfo.Create(AExeFullName:string);
begin
  FExeFullName:=AExeFullName;
  GetVersionInfo;
end;

procedure TExeVersionInfo.GetVersionInfo;
const
  InfoNum = 9;
  InfoStr: array[1..InfoNum] of string = (
      'ProductName',
      'ProductVersion',
      'FileDescription',
      'LegalCopyright',
      'FileVersion',
      'CompanyName',
      'LegalTradeMarks',
      'InternalName',
      'OriginalFileName');
var
  S: string;
  BufSize, Len: DWORD;
  Buf: PChar;
  Value: PChar;
begin
  S := FExeFullName;
  BufSize := GetFileVersionInfoSize(PChar(S), BufSize);
  if BufSize > 0 then
  begin
    Buf := AllocMem(BufSize);
    GetFileVersionInfo(PChar(S), 0, BufSize, Buf);
    if VerQueryValue(Buf, PChar('StringFileInfo\080403A8\' + InfoStr[1]), Pointer(Value), Len) then
       FProductName := Value;
    if VerQueryValue(Buf, PChar('StringFileInfo\080403A8\' + InfoStr[2]), Pointer(Value), Len) then
       FProductVersion := Value;
    if VerQueryValue(Buf, PChar('StringFileInfo\080403A8\' + InfoStr[3]), Pointer(Value), Len) then
       FFileDescription := Value;
    if VerQueryValue(Buf, PChar('StringFileInfo\080403A8\' + InfoStr[4]), Pointer(Value), Len) then
       FLegalCopyright := Value;
    if VerQueryValue(Buf, PChar('StringFileInfo\080403A8\' + InfoStr[5]), Pointer(Value), Len) then
       FFileVersion := Value;
    if VerQueryValue(Buf, PChar('StringFileInfo\080403A8\' + InfoStr[6]), Pointer(Value), Len) then
       FCompanyName := Value;
    if VerQueryValue(Buf, PChar('StringFileInfo\080403A8\' + InfoStr[7]), Pointer(Value), Len) then
       FLegalTrademarks := Value;
    if VerQueryValue(Buf, PChar('StringFileInfo\080403A8\' + InfoStr[8]), Pointer(Value), Len) then
       FInternalName := Value;
    if VerQueryValue(Buf, PChar('StringFileInfo\080403A8\' + InfoStr[9]), Pointer(Value), Len) then
       FOriginalFilename := Value;
    FreeMem(Buf, BufSize);
  end
  else
  begin
    TMsgDialog.ShowMsgDialog('获取产品信息时遇到错误，请检查工程文件的选项设置是否包含了版本信息！。', mtError);
  end;
end;

end.

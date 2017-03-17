unit uPrinterOption;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Dialogs, Printers;

  type
    TPrinterOption = class(TObject)
  private
    GDefPrintIndex : Integer;
    GPList : TStrings;
    procedure GetPrinterInfo;
    procedure CheckPrinter;
  public
    constructor Create;
    destructor Destroy;
    function GetPrinters : TStrings;
    function GetDefaultPrinterIndex : Integer;
    function GetDefaultPrinterName : String;
    procedure SetDefaultPrinter(index : integer);
    function GetAppointPrinterIndex(aPrinterName : String) : Integer;
    function GetAppointPrinterName(index : Integer) : String;
    procedure Refurbish;
  end;

implementation

{ TPrinterOption }

constructor TPrinterOption.Create;
begin
  GPList := TStringList.Create;
  GetPrinterInfo;
end;

destructor TPrinterOption.Destroy;
begin
  if Assigned(GPList) then
  begin
    GPList.Clear;
    FreeAndNil(GPList);
  end;//if
end;

procedure TPrinterOption.GetPrinterInfo;
begin
  GPList.Clear;
  GPList := Printer.Printers;
  GDefPrintIndex := Printer.PrinterIndex;
end;

procedure TPrinterOption.CheckPrinter;
begin
  if GPList.Count = 0 then
    GetPrinterInfo;
end;

function TPrinterOption.GetDefaultPrinterIndex: Integer;
begin
  Result := GDefPrintIndex;
end;

function TPrinterOption.GetDefaultPrinterName: String;
begin
  Result := GPList.Strings[GDefPrintIndex];
end;

function TPrinterOption.GetPrinters: TStrings;
begin
  Result := GPList;
end;

procedure TPrinterOption.SetDefaultPrinter(index: integer);
var
  poHandle  : THandle;
  poDevice, poDriver, poPort: array [0..255] of Char;
begin
  CheckPrinter;

  if GPList.Count > 0 then
  begin
    if index < 0 then
      index := 0;

    if index >= GPList.Count then
      index := GPList.Count - 1;

    Printer.PrinterIndex := index;
    Printer.GetPrinter(poDevice, poDriver, poPort, poHandle);//��ȡ��ӡ�����
    WriteProfileString('WINDOWS', 'DEVICE', poDevice);       //����Ĭ�ϴ�ӡ��
  end else
  begin
    raise Exception.Create('δ����κδ�ӡ����Ϣ����ȷ���Ѱ�װ��ӡ��');
  end;//else
end;

function TPrinterOption.GetAppointPrinterIndex(aPrinterName: String): Integer;
var
  index : Integer;
begin
  Result := -1;
  CheckPrinter;
  if Trim(aPrinterName) = '' then
    raise Exception.Create('��ȷ�ϴ�ӡ�����Ƶ���ȷ');

  index := GPList.IndexOf(aPrinterName);

  if index < 0 then
  begin
    GetPrinterInfo;
    index := GPList.IndexOf(aPrinterName);
  end;//if
  Result := index;
end;

function TPrinterOption.GetAppointPrinterName(index: Integer): String;
var
  name : String;
begin
  Result := '';
  CheckPrinter;
  if (index < 0) or (index >= GPList.Count) then
    raise Exception.Create('��ȷ�ϴ�ӡ��������ֵ��ȷ');

  name := GPList.Strings[index];

  if Trim(name) = '' then
  begin
    GetPrinterInfo;
    name := GPList.Strings[index];
  end;//if
  Result := Trim(name);
end;

procedure TPrinterOption.Refurbish;
begin
  GetPrinterInfo;
end;

end.


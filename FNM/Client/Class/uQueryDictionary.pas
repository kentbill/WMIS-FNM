unit uQueryDictionary;

interface

uses DB, DBClient, Classes;

const
  DICTIONARY_COUNT= 4;
  //下面数组中的值传入dbo.usp_GetBaseTableInfo存储过程,必须与存储过程的值对应.
  DICTIONARYNAME: array[0..DICTIONARY_COUNT] of WideString =
                   ('dlQueryClass' ,'dlQueryList', 'dlQueryProperty', 'dlQueryMaster', 'dlQueryDetail');
type
{TDictionary}
  TQyDictionary=Class
  {* 字典表类}
  private
    FQyDictionary: array [0..DICTIONARY_COUNT] of TDataSet;

    function GetQyDictionary(const Index: Integer): TDataSet;
    procedure GetFieldText(Sender: TField; var Text: String; DisplayText: Boolean);
  public
    constructor Create(AOwner: TComponent);
    {* Create}
    destructor Destroy; override;
    {* Destroy}
    procedure CloseAllDataSet;
    property cds_QueryClass:     TDataSet Index 0{dlQueryClass    }read GetQyDictionary;
    property cds_QueryList:      TDataSet Index 1{dlQueryList     }read GetQyDictionary;
    property cds_QueryProperty:  TDataSet Index 2{dlQueryProperty }read GetQyDictionary;
    property cds_QueryMaster:    TDataSet Index 3{dlQueryMaster   }read GetQyDictionary;
    property cds_QueryDetail:    TDataSet Index 4{dlQueryDetail   }read GetQyDictionary;
  end;

function QyDictionary: TQyDictionary;

implementation

uses
  SysUtils, Dialogs, Controls, IdGlobal, ServerDllPub, uFNMResource, uLogin;

var
  lDictionary: TQyDictionary;

function QyDictionary: TQyDictionary;
begin
  if lDictionary = nil then
    lDictionary:=TQyDictionary.Create(nil);
  result:=lDictionary;
end;

{ TFNDictionary }

constructor TQyDictionary.Create(AOwner: TComponent);
var
  i: Integer;
begin
  inherited Create;

  for i := 0 to DICTIONARY_COUNT do
    FQyDictionary[i] := nil;
end;

destructor TQyDictionary.Destroy;
var
  i: Integer;
begin
  for i := 0 to DICTIONARY_COUNT do
    FreeAndNil(FQyDictionary[i]);

  inherited;
end;

procedure TQyDictionary.CloseAllDataSet;
var
  i: Integer;
begin
  for i := 0 to DICTIONARY_COUNT do
  begin
    if FQyDictionary[i] <> nil then
      FQyDictionary[i].Active:=false;
  end
end;

function TQyDictionary.GeTQyDictionary(const Index: Integer): TDataSet;
var
  i: Integer;
  vDataSet: OleVariant;
  sErrorMsg: WideString;
begin
  if Index > DICTIONARY_COUNT then
    raise Exception.CreateRes(@ERR_PropertyIndex);

  //本句是为了去掉Delphi的警告,切不可在Try..finally..End中使用result
  result:=FQyDictionary[Index];
  try
    //相应的字典已经打开则退出
    if (FQyDictionary[Index] <> nil) and FQyDictionary[Index].Active then exit;

    ShowStatusMessage(@STA_GetDictionaryMessage, [DictionaryName[Index]]);
    FNMServerObj.GetQyDictionary(DictionaryName[Index], vDataSet, sErrorMsg);
    if sErrorMsg <> '' then
      raise Exception.CreateResFmt(@ERR_GetQyDictionary, [DictionaryName[Index], sErrorMsg]);

    if FQyDictionary[Index] = nil then FQyDictionary[Index] := TClientDataSet.Create(nil);
    (FQyDictionary[Index] as TClientDataSet).Data := vDataSet;

    if DICTIONARYNAME[index] = 'dlQueryMaster' then
    with FQyDictionary[Index] as TClientDataSet do
        FieldByName('Default_Value').OnGetText:=GetFieldText;
  finally
    ShowStatusMessage(@STA_Ready, []);
    result:=FQyDictionary[Index];
  end;
end;

procedure TQyDictionary.GetFieldText(Sender: TField; var Text: String; DisplayText: Boolean);
begin
  Text:=Sender.AsString;
  if Text = '@Current_Department' then
    Text:=Login.CurrentDepartment;
end;

initialization
  lDictionary:=nil;

finalization
  FreeAndNil(lDictionary);

end.


